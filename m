Received: from eggs.gnu.org ([209.51.188.92]:56238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gu4pi-0002TK-2w
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gu4fE-0007PD-F7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:14:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gu4fE-0007Nu-6Z
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:14:04 -0500
References: <cae4cdd7-2693-275b-5a54-e419e914d0a2@redhat.com>
	<49268e92-0abf-a2d3-a523-2c14e009e9cd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ede1a038-6cb7-f528-ebb4-a25e34db8425@redhat.com>
Date: Thu, 14 Feb 2019 01:13:53 +0100
MIME-Version: 1.0
In-Reply-To: <49268e92-0abf-a2d3-a523-2c14e009e9cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] nonzero LUN on USB Bulk Only Transfer fails
 with QEMU+edk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Ray Ni <ray.ni@intel.com>
Cc: edk2-devel-01 <edk2-devel@lists.01.org>, qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 02/13/19 18:00, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/13/19 9:37 AM, Laszlo Ersek wrote:
>>
>> using QEMU, when I specify a nonzero LUN for the hard disk that sits o=
n
>> the "SCSI bus" that embodies the USB Bulk Only Transfer device, then
>> UsbMassStorageDxe fails to recognize the hard disk.
>>
>> (1) Consider the following QEMU command line snippet:
>>
>>   -drive id=3Ddisk1,if=3Dnone,format=3Draw,readonly,file=3D$APPDISK \
>>   -device qemu-xhci,id=3Dxhci1,p3=3D15,addr=3D02.0 \
>>   -device usb-bot,bus=3Dxhci1.0,port=3D3,id=3Dbot1 \
>=20
> Do you have a specific need to use the 'usb-bot' device?

Nothing beyond <https://bugzilla.redhat.com/show_bug.cgi?id=3D917702>.

>>   -device scsi-hd,drive=3Ddisk1,bus=3Dbot1.0,lun=3D0,bootindex=3D1 \

[...]

>> In this case, edk2 recognizes the disk and things work fine.
>>
>> (In fact, for lun=3D0, the QemuBootOrderLib pattern matching / transla=
tion
>> works fine as well -- verifying which was my original goal, before I r=
an
>> into the issues below, for nonzero LUNs. But, I digress.)
>>
>>
>> (2) If I change the cmdline to "lun=3D5", then the exchange is:
>=20
> From qemu/docs/usb-storage.txt:
>=20
>   The LUN numbers must be continuous, i.e. for three devices you must
>   use 0+1+2. The 0+1+5 numbering from the "usb-uas" example isn't going
>   to work with "usb-bot".
>=20
> A failure is expected :/

OK, that explains the issue in (2). Wrong config. Thanks!

[...]

>> (3) Starting again from the original command line, if I change "lun=3D=
0"
>> to "lun=3D1" (rather than to "lun=3D5"), then OVMF even hangs, with th=
e
>> following log:

[...]

>>> ASSERT MdeModulePkg/Bus/Pci/XhciDxe/XhciSched.c(1915): TrsRing !=3D (=
(void *) 0)
>>
>> In this case, edk2 seems to recognize that a nonzero LUN is available =
on
>> the target, but the initialization never completes, and then an
>> assertion fails, apparently in the lower-level XHCI transport code.
>=20
> Can you try using the 'usb-uas' device instead of the 'usb-bot'?

Thanks, but no, thanks. :)

For USB storage options, I prefer the absolute minimum. I thought that
usb-storage was the end of the story -- it works perfectly fine; please
see the scope in:
- https://bugzilla.redhat.com/show_bug.cgi?id=3D1458192
- https://github.com/tianocore/edk2/commit/f9c59fa44ae2

Due to <https://bugzilla.redhat.com/show_bug.cgi?id=3D917702>, usb-bot no=
w
looks relevant as well. I'm trying to see how that maps to the existent
usb-storage support code, and what extensions if any are needed.

"usb-uas" remains totally out of scope though.

--*--

Anyway, now I realize that my test (3) was invalid too, because, by
*changing* lun0 to lun1 (rather than adding lun1 after lun0), I again
created a discontiguous LUN space.

(4) Unfortunately, the same assertion failure hits in edk2, even if I
add *both* lun0 and lun1:

  -drive id=3Ddisk1,if=3Dnone,format=3Draw,readonly,file=3D$APPDISK \
  -drive id=3Ddisk2,if=3Dnone,format=3Draw,readonly,file=3D$APPDISK \
  -device qemu-xhci,id=3Dxhci1,p3=3D15,addr=3D02.0 \
  -device usb-bot,bus=3Dxhci1.0,port=3D4,id=3Dbot1 \
  -device scsi-hd,drive=3Ddisk1,bus=3Dbot1.0,lun=3D0,bootindex=3D1 \
  -device scsi-hd,drive=3Ddisk2,bus=3Dbot1.0,lun=3D1,bootindex=3D2 \

Based on the last paragraphs in "docs/usb-storage.txt" (specifically
step (2b)), I'd expect this to work -- do you agree?

Thank you!
Laszlo
