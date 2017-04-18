Received: from eggs.gnu.org ([2001:4830:134:3::10]:50444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=27457243e=anshul.makkar@citrix.com>)
	id 1d0X8s-0007AG-G0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=27457243e=anshul.makkar@citrix.com>)
	id 1d0X8p-0004oC-BZ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:42:18 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:14436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=27457243e=anshul.makkar@citrix.com>)
	id 1d0X8o-0004no-Vu
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:42:15 -0400
From: anshul makkar <anshul.makkar@citrix.com>
Message-ID: <152817b5-89cf-14fe-d83a-bb5c8d748c90@citrix.com>
Date: Tue, 18 Apr 2017 18:42:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] CUSE-TPM : Win 10 reports TPM device doesn't have
 sufficient resources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@us.ibm.com

Hi,


I am using CUSE-TPM based on

https://github.com/stefanberger/qemu-tpmbranch: 2.4.1+tpm


https://github.com/stefanberger/swtpm


https://github.com/ts468/seabios-tpm


I am facing an issue where WIndows 10 guest device manager reports TPM 
status as @

The device status is "The device cannot find enough free resources it can use (Code 12)"#

On browsing I found this page 
  @https://bugzilla.redhat.com/show_bug.cgi?id=1281413" that reports 
exactly the same problem and the resolution patch @ 
https://bugzilla.redhat.com/attachment.cgi?id=1137166​ .


I applied the patch on the code and verified with debug trace that the 
patch code does executes.


But, I am still observingthe sameissue on Win 10 guest and on using 
ACPIdump utility in Windows guest I canstill see"IRQ5 and IRQNoFlags" in 
the ssdt.dsl code.

  Device (ISA.TPM)
{
Name (_HID, EisaId ("PNP0C31"))  // _HID: Hardware ID
Name (_STA, 0x0F)  // _STA: Status
Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
{
Memory32Fixed (ReadWrite,
0xFED40000,         // Address Base
0x00005000,         // Address Length
)
IRQNoFlags ()
{5}
})



I am bit confused, from my understanding, its the QEMU that builds the 
SSDT table and I can also verify it from the logs. But somehow guest is 
getting the old ACPI values for TPM which is not acceptable to Windows.

Just to be sure, I also verified the SeaBIOS code and couldn't find any 
link to this table.


Here is the patch that I applied based on the link above:


if (misc->tpm_version != TPM_VERSION_UNSPEC) {
          ACPI_BUILD_DPRINTF("TPM: add MMIO\n");
          dev = aml_device("TPM");
          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
          aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
          crs = aml_resource_template();
          aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
                     TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
          aml_append(dev, aml_name_decl("_CRS", crs));
          aml_append(sb_scope, dev);
      }
aml_append(ssdt, sb_scope);

logs once I start qemu:

CPI_BUILD: init ACPI tables
ACPI_BUILD: TPM: add MMIO
ACPI_BUILD: init ACPI tables
ACPI_BUILD: TPM: add MMIO

tpm_tis:  read.4(00000f00) = 00011014
tpm_tis: write.1(00000008) = 00000000
tpm_tis:  read.1(00000000) = 00000081

Commands to start vTPM:
swtpm_cuse -M 260 -m 1 -n vtpm0

qemu-system-x86_64 -enable-kvm -m 1024 -boot d -bios bios.bin -boot 
menu=on -tpmdev cuse-tpm,id=tpm0,path=/dev/vtpm0 -device 
tpm-tis,tpmdev=tpm0 win.img

Please suggest if I am missing anything .

Thanks
Anshul Makkar
