Received: from eggs.gnu.org ([2001:4830:134:3::10]:38051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fMPMr-0006y1-GQ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fMPMo-0001bh-DU
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fMPMo-0001bN-0y
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4Q2s2Ba007594
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:55:36 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j6uy953by-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:55:36 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 25 May 2018 22:55:35 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 22:55:19 -0400
In-Reply-To: <20180526025520.3298441-1-stefanb@linux.vnet.ibm.com>
References: <20180526025520.3298441-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180526025520.3298441-4-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v4 3/4] docs: tpm: add VM save/restore example
 and troubleshooting guide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the docs related to TPM with specs related to VM save and
restore and a troubleshooting guide for TPM migration.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/specs/tpm.txt | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index d1d71571e9..c230c4c93e 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -200,3 +200,109 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
 PCR-00: 35 4E 3B CE 23 9F 38 59 ...
 ...
 PCR-23: 00 00 00 00 00 00 00 00 ...
+
+
+=== Migration with the TPM emulator ===
+
+The TPM emulator supports the following types of virtual machine migration:
+
+- VM save / restore (migration into a file)
+- Network migration
+- Snapshotting (migration into storage like QoW2 or QED)
+
+The following command sequences can be used to test VM save / restore.
+
+
+In a 1st terminal start an instance of a swtpm using the following command:
+
+mkdir /tmp/mytpm1
+swtpm socket --tpmstate dir=/tmp/mytpm1 \
+  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
+  --log level=20 --tpm2
+
+In a 2nd terminal start the VM:
+
+qemu-system-x86_64 -display sdl -enable-kvm \
+  -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
+  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+  -tpmdev emulator,id=tpm0,chardev=chrtpm \
+  -device tpm-tis,tpmdev=tpm0 \
+  -monitor stdio \
+  test.img
+
+Verify that the attached TPM is working as expected using applications inside
+the VM.
+
+To store the state of the VM use the following command in the QEMU monitor in
+the 2nd terminal:
+
+(qemu) migrate "exec:cat > testvm.bin"
+(qemu) quit
+
+At this point a file called 'testvm.bin' should exists and the swtpm and QEMU
+processes should have ended.
+
+To test 'VM restore' you have to start the swtpm with the same parameters
+as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must now be
+passed again on the command line.
+
+In the 1st terminal restart the swtpm with the same command line as before:
+
+swtpm socket --tpmstate dir=/tmp/mytpm1 \
+  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
+  --log level=20 --tpm2
+
+In the 2nd terminal restore the state of the VM using the additonal
+'-incoming' option.
+
+qemu-system-x86_64 -display sdl -enable-kvm \
+  -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
+  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+  -tpmdev emulator,id=tpm0,chardev=chrtpm \
+  -device tpm-tis,tpmdev=tpm0 \
+  -incoming "exec:cat < testvm.bin" \
+  test.img
+
+
+Troubleshooting migration:
+
+There are several reasons why migration may fail. In case of problems,
+please ensure that the command lines adhere to the following rules and,
+if possible, that identical versions of QEMU and swtpm are used at all
+times.
+
+VM save and restore:
+ - QEMU command line parameters should be identical apart from the
+   '-incoming' option on VM restore
+ - swtpm command line parameters should be identical
+
+VM migration to 'localhost':
+ - QEMU command line parameters should be identical apart from the
+   '-incoming' option on the destination side
+ - swtpm command line parameters should point to two different
+   directories on the source and destination swtpm (--tpmstate dir=...)
+   (especially if different versions of libtpms were to be used on the
+   same machine).
+
+VM migration across the network:
+ - QEMU command line parameters should be identical apart from the
+   '-incoming' option on the destination side
+ - swtpm command line parameters should be identical
+
+VM Snapshotting:
+ - QEMU command line parameters should be identical
+ - swtpm command line parameters should be identical
+
+
+Besides that, migration failure reasons on the swtpm level may include
+the following:
+
+ - the versions of the swtpm on the source and destination sides are
+   incompatible
+   - downgrading of TPM state may not be supported
+   - the source and destination libtpms were compiled with different
+     compile-time options and the destination side refuses to accept the
+     state
+ - different migration keys are used on the source and destination side
+   and the destination side cannot decrypt the migrated state
+   (swtpm ... --migration-key ... )
-- 
2.14.3
