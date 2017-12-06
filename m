Received: from eggs.gnu.org ([2001:4830:134:3::10]:48450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMht6-0007xz-U6
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMht5-0007P8-CM
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:09:56 -0500
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1511196664-85304-3-git-send-email-anton.nefedov@virtuozzo.com>
	<w51po7t5hgh.fsf@maestria.local.igalia.com>
	<1a1334cc-8fae-03bc-b0be-70ee4b8c4ac0@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <beeaf694-b8d2-bac7-a94d-da7f57cc1748@redhat.com>
Date: Wed, 6 Dec 2017 17:09:46 -0500
MIME-Version: 1.0
In-Reply-To: <1a1334cc-8fae-03bc-b0be-70ee4b8c4ac0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] ide: account UNMAP (TRIM)
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com



On 12/05/2017 12:14 PM, Anton Nefedov wrote:
>=20
>=20
> On 5/12/2017 6:21 PM, Alberto Garcia wrote:
>> On Mon 20 Nov 2017 05:50:59 PM CET, Anton Nefedov wrote:
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 hw/ide/core.c | 12 ++++++++++++
>>> =C2=A0 1 file changed, 12 insertions(+)
>>>
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index 471d0c9..2e4dea7 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -389,6 +389,7 @@ typedef struct TrimAIOCB {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockAIOCB *aiocb;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, j;
>>> +=C2=A0=C2=A0=C2=A0 BlockAcctCookie acct;
>>> =C2=A0 } TrimAIOCB;
>>> =C2=A0 =C2=A0 static void trim_aio_cancel(BlockAIOCB *acb)
>>> @@ -426,6 +427,14 @@ static void ide_trim_bh_cb(void *opaque)
>>> =C2=A0 static void ide_issue_trim_cb(void *opaque, int ret)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TrimAIOCB *iocb =3D opaque;
>>> +=C2=A0=C2=A0=C2=A0 if (iocb->i >=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret >=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
lock_acct_done(blk_get_stats(iocb->blk), &iocb->acct);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
lock_acct_failed(blk_get_stats(iocb->blk), &iocb->acct);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> This part looks fine, but don't you also need to account for invalid
>> requests (in ide_dma_cb() or somewhere else) ?
>>

not ide_dma_cb this time, because the command does not use ATA registers
as input, see below :(

>> Berto
>>
>=20
> Good point; in fact, the TRIM sector range is never checked.
> (well it should be, down at the block layer, and then counted as error)=
.
>=20
> The motivation was:
>=20
> =C2=A0=C2=A0=C2=A0 commit d66168ed687325aa6d338ce3a3cff18ce3098ed6
> =C2=A0=C2=A0=C2=A0 Author: Michael Tokarev <mjt@tls.msk.ru>
> =C2=A0=C2=A0=C2=A0 Date:=C2=A0=C2=A0 Wed Aug 13 11:23:31 2014 +0400
>=20
> =C2=A0=C2=A0=C2=A0 ide: only constrain read/write requests to drive siz=
e, not other types
>=20
> =C2=A0=C2=A0=C2=A0 Commit 58ac321135a introduced a check to ide dma pro=
cessing which
> =C2=A0=C2=A0=C2=A0 constrains all requests to drive size.=C2=A0 However=
, apparently, some
> =C2=A0=C2=A0=C2=A0 valid requests (like TRIM) does not fit in this cons=
traint, and
> =C2=A0=C2=A0=C2=A0 fails in 2.1.=C2=A0 So check the range only for read=
s and writes.
>=20

I wound up at the same commit. The problem here is that the TRIM command
does not issue contiguous LBA+count requests in the same way using the
ATA registers like DMA R/W functions do, but instead works a bit more
like DMA commands in that it transmits a list of regions separately.

Kevin pointed this out in 2014:

https://lists.gnu.org/archive/html/qemu-devel/2014-08/msg02012.html

"I can't give you a clear answer, but it all depends on the value of
sector_num. This is the contents of the LBA registers and unused for
TRIM (spec says it's reserved, so we shouldn't be looking at it)."

He's right! This means the LBA/Count registers are undefined when we're
using TRIM in ide_dma_cb.

So, you have two things you can do:

(1) Modify ide_sector_start_dma to start accounting for TRIM early, and
then continue to mark it failed/complete where you do, but you'll need
to add in a new error case in ide_issue_trim_cb to check the range and
abort the job. We do not need to preprocess the entire "list" of TRIM
regions upfront as we are within our rights to process some of them
before aborting.

(2) Continue to start accounting where you do, per-region, which keeps
trim requests "per chunk", but add the error range checking almost
immediately after, if this is useful for statistical purposes. It will
look a little funny to start accounting and then immediately and
synchronously mark it invalid, but that's probably the most accurate thin=
g.

I'm basing this off of the ATA8-AC3 spec, which defines the command
"DATA SET MANAGEMENT - 06h, DMA":

> If the Trim bit is set to one and:
> a) the device detects an invalid LBA Range Entry; or
> b) count is greater than IDENTIFY DEVICE data word 105 (see 7.16.7.55),
> then the device shall return command aborted.
> A device may trim one or more LBA Range Entries before it returns
command aborted. See table 209.

ATA8-ACS3 section  seems pretty clear to me that we *may* abort the
command if we detect an "invalid LBA Range Entry" which is defined in
3.1.40 as:

"3.1.40 Invalid LBA Range: A range of LBAs that contains one or more
invalid LBAs."

which references 3.1.39:

3.1.39 Invalid LBA: An LBA that is greater than or equal to the largest
value reported in IDENTIFY
DEVICE data words 60..61 (see 7.16.7.22), IDENTIFY DEVICE data words
100..103
(see 7.16.7.53), or IDENTIFY DEVICE data words 230..233 (see 7.16.7.88).

Of course, we only know if a range could possibly be invalid by the time
we actually process it in ide_issue_trim_cb.

>=20
> It seems like the removed check was at the wrong place (trim request ha=
s
> to be parsed first to get offset and nbytes).
> Probably it should be put to ide_issue_trim_cb() instead.
>=20
> cc John (should have done it earlier)
>=20

Hi!

> /Anton
>=20
