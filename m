Received: from eggs.gnu.org ([2001:4830:134:3::10]:42431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkOm5-0000Qh-Oa
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkOm4-0000UI-BR
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:04:21 -0400
From: Thomas Huth <thuth@redhat.com>
References: <20170822214343.31385-1-f4bug@amsat.org>
	<20170823014025-mutt-send-email-mst@kernel.org>
	<6661274e-c797-1aac-14b9-43dcf4c2f336@amsat.org>
	<887ee497-5518-f6bc-56ec-2c2626cdf1f2@redhat.com>
Message-ID: <9d8a8efa-8d32-57ea-d13f-65a7952448c3@redhat.com>
Date: Wed, 23 Aug 2017 08:04:06 +0200
MIME-Version: 1.0
In-Reply-To: <887ee497-5518-f6bc-56ec-2c2626cdf1f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10-rc4?] acpi: pcihp: fix
 use-after-free for machines previous pc-1.7 compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 23.08.2017 07:40, Thomas Huth wrote:
> On 23.08.2017 02:10, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 08/22/2017 07:42 PM, Michael S. Tsirkin wrote:
>>> On Tue, Aug 22, 2017 at 06:43:43PM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>> 9e047b982452 "piix4: add acpi pci hotplug support" introduced a new
>>>> property
>>>> 'use_acpi_pci_hotplug' for pc-1.7 and older machines.
>>>> c24d5e0b91d1 "convert ACPI PCI hotplug to use hotplug-handler API"
>>>> added the
>>>> qbus hotplug handlers but forgot to check for the 'use_acpi_pci_hotp=
lug'
>>>> property.
>>>>
>>>> Check for use_acpi_pci_hotplug before calling
>>>> acpi_pcihp_device_[un]plug_cb().
> [...]
>>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>>> Message-Id: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>
>>> Looks like this is a very old bug, isn't it?
>>> Objections to merging this after the release?
>>
>> Yes, I'm also inclined to delay it so we can release 2.10, I tagged
>> "2.10-rc4" since Thomas sent it as a bug within the 2.10 window so I'l=
l
>> let him decide if it is worth crying wolf :) It's very likely no-one b=
ut
>> him used pre-pc-i440fx-1.7 the last 3 years, not even thinking about h=
ot
>> plugging AHCI devices :D
>=20
> I'm fine if this gets included in 2.11 - it's quite unlikely that a use=
r
> tries hot-plug ahci on such an old machine type, I think. But we maybe
> should include this in the 2.10.1 stable release, so I'm putting
> qemu-stable on CC now.
>=20
> Anyway, your patch seems to fix the issue for me, thanks!
>=20
> Tested-by: Thomas Huth <thuth@redhat.com>

... No, I was too fast here. I'm afraid, it still crashes with mips64el:

$ valgrind mips64el-softmmu/qemu-system-mips64el -S -nographic -M malta,a=
ccel=3Dqtest
=3D=3D17935=3D=3D Memcheck, a memory error detector
=3D=3D17935=3D=3D Copyright (C) 2002-2015, and GNU GPL'd, by Julian Sewar=
d et al.
=3D=3D17935=3D=3D Using Valgrind-3.12.0 and LibVEX; rerun with -h for cop=
yright info
=3D=3D17935=3D=3D Command: mips64el-softmmu/qemu-system-mips64el -S -nogr=
aphic -M malta,accel=3Dqtest
=3D=3D17935=3D=3D=20
QEMU 2.9.93 monitor - type 'help' for more information
(qemu) device_add ich9-ahci
=3D=3D17935=3D=3D Invalid read of size 8
=3D=3D17935=3D=3D    at 0x5F6F10: object_unparent (object.c:445)
=3D=3D17935=3D=3D    by 0x4BB2C8: device_unparent (qdev.c:1095)
=3D=3D17935=3D=3D    by 0x5F77C4: object_finalize_child_property (object.=
c:1396)
=3D=3D17935=3D=3D    by 0x5F6706: object_property_del_child.isra.7 (objec=
t.c:427)
=3D=3D17935=3D=3D    by 0x448BC8: qdev_device_add (qdev-monitor.c:634)
=3D=3D17935=3D=3D    by 0x449122: qmp_device_add (qdev-monitor.c:807)
=3D=3D17935=3D=3D    by 0x462B29: hmp_device_add (hmp.c:1925)
=3D=3D17935=3D=3D    by 0x370F83: handle_hmp_command (monitor.c:3119)
=3D=3D17935=3D=3D    by 0x371E59: monitor_command_cb (monitor.c:3922)
=3D=3D17935=3D=3D    by 0x6D3187: readline_handle_byte (readline.c:393)
=3D=3D17935=3D=3D    by 0x371211: monitor_read (monitor.c:3905)
=3D=3D17935=3D=3D    by 0x6699D3: mux_chr_read (char-mux.c:216)
=3D=3D17935=3D=3D  Address 0x21c549d8 is 30,328 bytes inside a block of s=
ize 36,288 free'd
=3D=3D17935=3D=3D    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
=3D=3D17935=3D=3D    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0=
.5000.3)
=3D=3D17935=3D=3D    by 0x4FB94E: pci_ich9_uninit (ich.c:161)
=3D=3D17935=3D=3D    by 0x5350FB: pci_qdev_unrealize (pci.c:1083)
=3D=3D17935=3D=3D    by 0x4BCD39: device_set_realized (qdev.c:988)
=3D=3D17935=3D=3D    by 0x5F622D: property_set_bool (object.c:1886)
=3D=3D17935=3D=3D    by 0x5FA31E: object_property_set_qobject (qom-qobjec=
t.c:27)
=3D=3D17935=3D=3D    by 0x5F7FCF: object_property_set_bool (object.c:1162=
)
=3D=3D17935=3D=3D    by 0x448B93: qdev_device_add (qdev-monitor.c:630)
=3D=3D17935=3D=3D    by 0x449122: qmp_device_add (qdev-monitor.c:807)
=3D=3D17935=3D=3D    by 0x462B29: hmp_device_add (hmp.c:1925)
=3D=3D17935=3D=3D    by 0x370F83: handle_hmp_command (monitor.c:3119)
=3D=3D17935=3D=3D  Block was alloc'd at
=3D=3D17935=3D=3D    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
=3D=3D17935=3D=3D    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.s=
o.0.5000.3)
=3D=3D17935=3D=3D    by 0x4FB28F: ahci_realize (ahci.c:1468)
=3D=3D17935=3D=3D    by 0x4FB9D8: pci_ich9_ahci_realize (ich.c:115)
=3D=3D17935=3D=3D    by 0x5366BD: pci_qdev_realize (pci.c:2002)
=3D=3D17935=3D=3D    by 0x4BCCB9: device_set_realized (qdev.c:914)
=3D=3D17935=3D=3D    by 0x5F622D: property_set_bool (object.c:1886)
=3D=3D17935=3D=3D    by 0x5FA31E: object_property_set_qobject (qom-qobjec=
t.c:27)
=3D=3D17935=3D=3D    by 0x5F7FCF: object_property_set_bool (object.c:1162=
)
=3D=3D17935=3D=3D    by 0x448B93: qdev_device_add (qdev-monitor.c:630)
=3D=3D17935=3D=3D    by 0x449122: qmp_device_add (qdev-monitor.c:807)
=3D=3D17935=3D=3D    by 0x462B29: hmp_device_add (hmp.c:1925)

Do you've got an idea how to fix that, too?

 Thomas
