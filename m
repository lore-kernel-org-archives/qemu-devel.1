Received: from eggs.gnu.org ([2001:4830:134:3::10]:50920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etxNj-0003H9-CM
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etxNi-0003cJ-7s
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:22:59 -0500
References: <20180307225732.155835-1-eblake@redhat.com>
	<1651749911.5944222.1520491852256.JavaMail.zimbra@redhat.com>
	<8b5bee3a-c30b-38da-b861-bceebad9b57e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c316b5e0-932f-6de0-ac19-41d12730201c@redhat.com>
Date: Thu, 8 Mar 2018 16:22:47 +0100
MIME-Version: 1.0
In-Reply-To: <8b5bee3a-c30b-38da-b861-bceebad9b57e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Honor FUA request on
 NBD_CMD_TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com, kwolf@redhat.com

On 08/03/2018 15:45, Eric Blake wrote:
> On 03/08/2018 12:50 AM, Paolo Bonzini wrote:
>>> The NBD spec states that since trim requests can affect disk contents=
,
>>> then they should allow for FUA semantics just like writes for ensurin=
g
>>> the disk has settled before returning.=C2=A0 As bdrv_[co_]pdiscard() =
does
>>> not (yet?) support a flags argument, we can't pass FUA down the block
>>> layer stack, and must therefore emulate it with a flush at the NBD
>>> layer.
>>
>> TRIM requests should not need FUA since they're just advisory.
>=20
> Still, while you argue that TRIM is advisory (which I agree), if it doe=
s
> nothing, then you've (implicitly) honored FUA (that transaction didn't
> affect persistent storage, so you didn't have to wait any longer for
> anything to land); but if it DOES change the disk contents, then waitin=
g
> for that change to land IS worth supporting, hence why the NBD protocol
> requires the FUA flag to be honored on trim.

But if power fails, after restart you cannot see the difference between
a TRIM command that chose to did nothing, and one that chose to change
the disk contents but failed to persist the changes.  This is why I
thought there is no need for FUA in my opinion.

I suppose in principle you could detect the change by reading the
TRIMmed sectors and writing to another disk.  So TRIM would have to be a
Schroedinger command that is persistent once you read the sectors, and
that makes little sense.  The problem is, SCSI doesn't have a FUA flag
either...

Paolo
