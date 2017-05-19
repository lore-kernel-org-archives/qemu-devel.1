Received: from eggs.gnu.org ([2001:4830:134:3::10]:60804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anonym@riseup.net>) id 1dBnnS-0007id-Lb
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anonym@riseup.net>) id 1dBnnO-00063i-Mp
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:42:46 -0400
Received: from mx1.riseup.net ([198.252.153.129]:55906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anonym@riseup.net>) id 1dBnnO-00063R-Fb
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:42:42 -0400
From: anonym <anonym@riseup.net>
Message-ID: <65de474b-ab36-727a-4d3a-dadb8ad22f9b@riseup.net>
Date: Fri, 19 May 2017 19:42:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] xhci: bump the link TRB cycle detection
 limit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Gentle ping! :)

I've lost the Message-IDs of my previous posts on this topic but its abou=
t this patch submission:

* https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03433.html
* https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03434.html

Cheers!

> Hi, list!
>=20
> I guess you can take this as a ping for this patch submission. We'd ver=
y much=20
> like this to be dealt with soon, so the fix can land into Debian Stretc=
h before=20
> it is released, otherwise some of us will have to work around this issu=
e for=20
> the next two years. :/
>=20
> Hi, Gerd!
>=20
> You are the author of QEMU commit 05f43d4 which fixed CVE-2016-8576, wh=
ich I=20
> believe introduced the regression described below. Do you think my patc=
h's=20
> approach is safe and makes sense?
>=20
> At the moment this issue is causing trouble for Tails [1] since its ins=
taller=20
> hits this bug, which affects both users of QEMU + Tails, and our automa=
ted QA=20
> infrastructure, which uses QEMU.
>=20
> Cheers!
>=20
> [1] https://tails.boum.org/
>=20
> address@hidden:
>> From: anonym <address@hidden>
>>=20
>> While formatting partitions (on virtual USB drives and the nec-xhci
>> virtual USB controller) to EXT4, I have observed errors like these:
>>=20
>>     kernel: sd 8:0:0:0: [sda] tag#0 FAILED Result: hostbyte=3DDID_ABOR=
T
>>     driverbyte=3DDRIVER_OK
>>     kernel: sd 8:0:0:0: [sda] tag#0 CDB: Write(10) 2a 00 00 66 49 86
>>     00 08 00 00
>>     kernel: blk_update_request: I/O error, dev sda, sector 6703494
>>     kernel: Buffer I/O error on dev dm-0, logical block 1573254, lost
>>     async page write
>>=20
>> Raising TRB_LINK_LIMIT fixes the limit, but the new value was
>> admittedly arbitrarily chosen.
>>=20
>> Regarding cycle detection in general, allowing at most 4 levels of
>> links seems pretty low. This bump should be safe: a high number only
>> means that we get a performance hit when encountering cycles but then
>> we should have a fatal error any way; a low number instead means that
>> we'll incorrectly identify cycles and abort operations that otherwise
>> would succeed, like in the case above.
>>=20
>> Signed-off-by: anonym <address@hidden>
>> ---
>>  hw/usb/hcd-xhci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index 4acf0c6dd8..d14ce126a2 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -53,7 +53,7 @@
>>   * to the specs when it gets them */
>>  #define ER_FULL_HACK
>> =20
>> -#define TRB_LINK_LIMIT  4
>> +#define TRB_LINK_LIMIT  32
>> =20
>>  #define LEN_CAP         0x40
>>  #define LEN_OPER        (0x400 + 0x10 * MAXPORTS)
