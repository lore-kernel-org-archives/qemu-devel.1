Received: from eggs.gnu.org ([209.51.188.92]:43387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hJpmp-0007af-Qn
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 21:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hJpmo-0006tv-NM
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 21:36:23 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:53374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hJpmo-0006tI-Ic
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 21:36:22 -0400
Received: by mail-it1-x141.google.com with SMTP id z4so3326275itc.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 18:36:22 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <ca6e7733-9ed7-a332-887b-ac04bb28f54f@redhat.com>
Date: Thu, 25 Apr 2019 21:36:16 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <66EE0F7C-A52D-45A6-8ED5-ADAAAAB08758@gmail.com>
References: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
	<20190415095400.GD29134@stefanha-x1.localdomain>
	<97D57A26-6DB4-45AA-BC68-27BBEDEEBE74@gmail.com>
	<ca6e7733-9ed7-a332-887b-ac04bb28f54f@redhat.com>
Subject: Re: [Qemu-devel] Booting from a Bootcamp partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>


> On Apr 15, 2019, at 2:35 PM, John Snow <jsnow@redhat.com> wrote:
>=20
>=20
>=20
> On 4/15/19 6:23 AM, Programmingkid wrote:
>>=20
>>> On Apr 15, 2019, at 5:54 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>>=20
>>> On Sun, Apr 14, 2019 at 07:33:17PM -0400, Programmingkid wrote:
>>>> Hi I was wondering if anyone has been able to boot from a bootcamp =
partition inside of QEMU. I know this partition can be used in QEMU but =
my own attempts at booting Windows 7 on my bootcamp partition did not =
work. I always see "A disk read error occurred". Has anyone else been =
successful at this?=20
>>>=20
>>> Hi,
>>> It's difficult to help without more information:
>>> 1. What is your QEMU command-line?
>>=20
>> sudo qemu-system-x86_64 -name "Windows 7" -hda "/dev/disk0s4" -boot =
"c" -m 3000=20
>>=20
>>> 2. What is the partition table on the disk?
>>=20
>> The bootcamp partition is this: /dev/disk0s4
>>=20
>=20
> (Are you trying to boot a partition as an entire block device ...?)

I am trying to boot a partition.

>=20
>>> General problems with booting Windows are usually caused by a guest
>>> configuration that doesn't match the hardware configuration that =
Windows
>>> was installed under.  Can you check that the AHCI bus address of the
>>> disk and partition numbering matches what Windows expected?
>>=20
>> How would someone do this?
>>=20
>>> It may also be useful to enable tracing (see docs/devel/tracing.txt) =
to
>>> see what the ahci_* trace event log says.  I have CCed John Snow, =
one of
>>> the few people who can read this log :).
>>=20
>> I'm guessing you believe the problem is the partition can't be read =
in QEMU. I know for sure it can. I attached this partition to another =
QEMU VM and was able to see it on the Desktop.=20
>>=20
>=20
> Well, we don't know what the problem is. =46rom the command line above =
it
> looks like it'd be using the legacy IDE emulation instead of the newer
> SATA emulation, though. I'd wager that the Windows boot loader here is
> not expecting to use IDE.
>=20
> "disk read error" could mean a lot of things from the POV of a guest,
> but having disk emulation tracing would show us what the guest is =
trying
> to do, at least.

How do I enable this tracing?

>=20
>> My guess is the computer is using an EFI firmware and QEMU uses the =
traditional BIOS firmware (SeaBIOS).  So I think trying UEFI in QEMU =
might work.
>>=20
>=20
> Try using -M q35 which will engage SATA and AHCI emulation, and try
> using UEFI, yes.

I tried using a OVMF firmware file I found online. It will not work when =
I use "-M accel=3Dhvf --cpu host". The screen just stays small and black =
instead of a screen with the firmware info. This test was done with git =
revision 3284aa128153750f14a61e8a96fd085e6f2999b6 of QEMU.=20

The only way to make the OVMF work is to not use the accelerator:=20
sudo qemu-system-x86_64 -name "Windows 7" -boot "c" -m 4000 -pflash =
OVMF.fd=20

I did have success with booting a Windows 7 HD image file and was able =
to view the bootcamp partition as another drive. I used seaBIOS instead =
of OVMF. Windows 7 did crash a lot. The error was always =
DRIVER_IRQL_NOT_LESS_OR_EQUAL. I also saw this error printed by QEMU: =
Unimplemented handler (fffff80002705050) for 0 (f c3)

This is the command-line I was using:=20
sudo qemu-system-x86_64 -name "Windows 7" -hda "Windows 7 HD.qcow2" -hdb =
"/dev/disk0s4" -boot "c" -netdev user,id=3Dmynet0 -device =
rtl8139,netdev=3Dmynet0 -m 4000 -usb -device usb-audio -M accel=3Dhvf =
--cpu host=20

I just realized that the Bootcamp partition is formatted as NTFS. This =
is probably why it does not work with SeaBIOS. Thank you everyone who =
tried to help.=
