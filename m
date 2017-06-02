Received: from eggs.gnu.org ([2001:4830:134:3::10]:48561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGolb-0008Jr-Sf
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGolW-0007fq-Tb
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:45:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGolW-0007cY-LR
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:45:30 -0400
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
Date: Fri, 2 Jun 2017 17:45:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] allocation zone extensions for the firmware
 linker/loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS devel list <SeaBIOS@seabios.org>, qemu devel list <qemu-devel@nongnu.org>, edk2-devel-ml01 <edk2-devel@ml01.01.org>
Cc: Kevin O'Connor <kevin@koconnor.net>, "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

Hi,

this message is cross-posted to three lists (qemu, seabios, edk2). I'll
follow up with three patch series, one series for each project. I'll
cross-post all of the patches as well, but I'll add the project name in
the "bag of tags" in the subject lines.

The QEMU series introduces two extensions to the ALLOCATE firmware
linker/loader command.

One extension is a new allocation zone, with value 3, for allowing the
firmware to allocate the fw_cfg blobs in 64-bit address space.

The other extension is a repurposing of the most significant bit (bit 7)
in the zone field. This bit becomes orthogonal to the rest of the zone
field. If the bit is set, it means that QEMU promises the firmware that
the blob referenced by the ALLOCATE command contains no ACPI tables at all.

After introducing these, the QEMU series puts them to use, covering all
of the currently generated ALLOCATE commands, as appropriate. Among the
benefits we can mention
- the removal of the OVMF ACPI SDT Header Probe suppressor from VMGENID
(and from any similar future devices),
- and the fact that the "virt" machine type (and maybe other machine
types) of the arm/aarch64 target will no longer require RAM under 4GB
for ACPI to work.

Both of these extensions are irrelevant for SeaBIOS, therefore the
SeaBIOS patches simply mask out bit 7 (for ignoring the "no ACPI
content" hint), and fall back to the HIGH zone (= 32-bit address space)
when the 64-bit zone is permitted.

In other words, SeaBIOS needs some patches to recognize the new zone
values, but beyond that, the behavior is unchanged.

Both extensions are important for virtual UEFI firmware (OVMF in x86
guests and ArmVirtQemu in aarch64 guests). The edk2 patches add support
to OvmfPkg/AcpiPlatformDxe for the extensions. Please see the commit
messages for details (all the extensions are explained in detail in the
relevant patches for all of the projects).

The patches can cause linker/loader breakage when old firmware is booted
on new QEMU. However, that's no problem (it's nothing new), the next
release of QEMU should bundle the new firmware binaries as always.

New firmware will continue running on old QEMU without issues.

(In case you have sent me emails about this in the last few tens of
hours, please know that I'm not ignoring them, I just haven't seen /
read them. Reading emails every five minutes makes focused work
impossible, so when I'm busy, I tend to read email once per day.)

Thanks
Laszlo
