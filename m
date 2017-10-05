Received: from eggs.gnu.org ([2001:4830:134:3::10]:58924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09JG-0005Yd-6M
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09JB-0000eV-2Y
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:47:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39100
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e09JA-0000dg-QZ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:47:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95GivYu040670
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 12:47:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ddqw6jabd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:47:33 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 12:47:32 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  5 Oct 2017 12:47:27 -0400
Message-Id: <1507222047-20115-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] specs: Extend TPM spec with TPM emulator
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Following the recent extension of QEMU with a TPM emulator device,
update the specs describing for how to interact with the device.

The results of commands run inside a Linux VM are expected to be
similar to those when the TPM passthrough device is used, so we
just reuse that.

Fix a typo on the way.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 docs/specs/tpm.txt | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 914daac..9bef8b3 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -121,3 +121,82 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
 PCR-00: 35 4E 3B CE 23 9F 38 59 ...
 ...
 PCR-23: 00 00 00 00 00 00 00 00 ...
+
+
+== The QEMU TPM emulator device ==
+
+The TPM emulator device uses an external TPM emulator called 'swtpm' for
+sending TPM commands to and receiving responses from. The swtpm program
+must have been started before trying to access it through the TPM emulator
+with QEMU.
+
+The TPM emulator implements a command channel for transferring TPM commands
+and responses as well as a control channel over which control commands can
+be sent. The specification for the control channel can be found here:
+
+https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.pod
+
+
+The control channel serves the purpose of resetting, initializing, and
+migrating the TPM state, among other things.
+
+The swtpm program behaves like a hardware TPM and therefore needs to be
+initialized by the firmware running inside the QEMU virtual machine.
+One necessary step for initializing the device is to send the TPM_Startup
+command to it. SeaBIOS, for example, has been instrumented to initialize
+a TPM 1.2 or TPM 2 device using this command.
+
+
+QEMU files related to the TPM emulator device:
+ - hw/tpm/tpm_emulator.c
+ - hw/tpm/tpm_util.c
+ - hw/tpm/tpm_util.h
+
+
+The following commands start the swtpm with a UnixIO control channel over
+a socket interface. They do not need to be run as root.
+
+mkdir /tmp/mytpm1
+swtpm socket --tpmstate dir=/tmp/mytpm1 \
+  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
+  --log level=20
+
+Command line to start QEMU with the TPM emulator device using the host's
+hardware TPM /dev/tpm0:
+
+qemu-system-x86_64 -display sdl -enable-kvm \
+  -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
+  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+  -tpmdev emulator,id=tpm0,chardev=chrtpm \
+  -device tpm-tis,tpmdev=tpm0 test.img
+
+
+In case SeaBIOS is used as firmware, it should show the TPM menu item
+after entering the menu with 'ESC'.
+
+Select boot device:
+1. DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
+[...]
+5. Legacy option rom
+
+t. TPM Configuration
+
+
+The following commands should result in similar output inside the VM with a
+Linux kernel that either has the TPM TIS driver built-in or available as a
+module:
+
+#> dmesg | grep -i tpm
+[    0.711310] tpm_tis 00:06: 1.2 TPM (device=id 0x1, rev-id 1)
+
+#> dmesg | grep TCPA
+[    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
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
