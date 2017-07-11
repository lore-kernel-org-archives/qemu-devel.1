Received: from eggs.gnu.org ([2001:4830:134:3::10]:40289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dUwCZ-0000ra-BO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dUwCU-0003mp-E2
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:31:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dUwCU-0003ln-4k
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:31:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BETM6s109914
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:31:39 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bmb3fdmeq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:31:38 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 10:31:37 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 10:31:33 -0400
Message-Id: <1499783493-15911-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] specs: Describe the TPM support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lersek@redhat.com
Cc: qemu-devel@nongnu.org, javierm@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This patch adds a description of the current TPM support in QEMU
to the specs.

Several public specs are referenced via their landing page on the
trustedcomputinggroup.org website.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

---

v1->v2:
  - fixed typos
  - added command line for starting an x86_64 VM with TPM passthrough device
  - added command lines for checks inside the VM
---
 docs/specs/tpm.txt | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 docs/specs/tpm.txt

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
new file mode 100644
index 0000000..1e968a2
--- /dev/null
+++ b/docs/specs/tpm.txt
@@ -0,0 +1,124 @@
+
+QEMU TPM Device
+===============
+
+= Guest-side Hardware Interface =
+
+The QEMU TPM emulation implements a TPM TIS hardware interface following
+the Trusted Computing Group's specification "TCG PC Client Specific TPM
+Interface Specification (TIS)", Specifcation Version 1.3, 21 March 2013.
+This specification, or a later version of it, can be accessed from the
+following URL:
+
+https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
+
+The TIS interface makes a memory mapped IO region in the area 0xfed40000 -
+0xfed44fff available to the guest operating system.
+
+
+QEMU files related to TPM TIS interface:
+ - hw/tpm/tpm_tis.c
+ - hw/tpm/tpm_tis.h
+
+
+= ACPI Interface =
+
+The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and passes
+it into the guest through the fw_cfg device. The device description contains
+the base address of the TIS interface 0xfed40000 and the size of the MMIO area
+(0x5000). In case a TPM2 is used by QEMU, a TPM2 ACPI table is also provided.
+The device is described to be used in polling mode rather than interrupt mode
+primarily because no unused IRQ could be found.
+
+To support measurement logs to be written by the firmware, e.g. SeaBIOS, a TCPA
+table is implemented. This table provides a 64kb buffer where the firmware can
+write its log into. For TPM 2 only a more recent version of the TPM2 table
+provides support for measurements logs and a TCPA table does not need to be
+created.
+
+The TCPA and TPM2 ACPI tables follow the Trusted Computing Group specification
+"TCG ACPI Specification" Family "1.2" and "2.0", Level 00 Revision 00.37. This
+specification, or a later version of it, can be accessed from the following
+URL:
+
+https://trustedcomputinggroup.org/tcg-acpi-specification/
+
+
+QEMU files related to TPM ACPI tables:
+ - hw/i386/acpi-build.c
+ - include/hw/acpi/tpm.h
+
+
+= TPM backend devices =
+
+The TPM implementation is split into two parts, frontend and backend. The
+frontend part is the hardware interface, such as the TPM TIS interface described
+earlier, and the other part is the TPM backend interface. The backend interfaces
+implement the interaction with a TPM device, which may be a physical or an
+emulated device. The split between the front- and backend devices allows a
+frontend to be connected with any available backend. This enables the TIS
+interface to be used with the passthrough backend or the (future) swtpm backend.
+
+
+QEMU files related to TPM backends:
+ - backends/tpm.c
+ - include/sysemu/tpm_backend.h
+ - include/sysemu/tpm_backend_int.h
+
+
+== The QEMU TPM passthrough device ==
+
+In case QEMU is run on Linux as the host operating system it is possible to
+make the hardware TPM device available to a single QEMU guest. In this case the
+user must make sure that no other program is using the device, e.g., /dev/tpm0,
+before trying to start QEMU with it.
+
+The passthrough driver uses the host's TPM device for sending TPM commands
+and receiving responses from. Besides that it accesses the TPM device's sysfs
+entry for support of command cancellation. Since none of the state of a hardware
+TPM can be migrated between hosts, virtual machine migration is disabled when
+the TPM passthrough driver is used.
+
+Since the host's TPM device will already be initialized by the host's firmware,
+certain commands, e.g. TPM_Startup(), sent by the virtual firmware for device
+initialization, will fail. In this case the firmware should not use the TPM.
+
+Sharing the device with the host is generally not a recommended usage scenario
+for a TPM device. The primary reason for this is that two operating systems can
+then access the device's single set of resources, such as platform configuration
+registers (PCRs). Applications or kernel security subsystems, such as the
+Linux Integrity Measurement Architecture (IMA), are not expecting to share PCRs.
+
+
+QEMU files related to the TPM passthrough device:
+ - hw/tpm/tpm_passthrough.c
+ - hw/tpm/tpm_util.c
+ - hw/tpm/tpm_util.h
+
+
+Command line to start QEMU with the TPM passthrough device using the host's
+hardware TPM /dev/tpm0:
+
+qemu-system-x86_64 -display sdl -enable-kvm \
+  -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
+  -tpmdev passthrough,id=tpm0,path=/dev/tpm0 \
+  -device tpm-tis,tpmdev=tpm0 test.img
+
+The following command should result in similar output inside the VM with a
+Linux kernel that either has the TPM TIS driver built-in or available as a
+module:
+
+#> dmesg | grep -i tpm
+[    0.711310] tpm_tis 00:06: 1.2 TPM (device=id 0x1, rev-id 1)
+
+#> dmesg | grep TCPA
+[    0.000000] ACPI: TCP 0x0000000003FFD191C 000032 (v02 BOCHS  \
+    BXPCTCPA 0000001 BXPC 00000001)
+
+#> ls -l /dev/tpm*
+crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
+
+#> find /sys/devices/ | grep pcrs$ | xargs cat
+PCR-00: 35 4E 3B CE 23 9F 38 59 ...
+...
+PCR-23: 00 00 00 00 00 00 00 00 ...
-- 
2.5.5
