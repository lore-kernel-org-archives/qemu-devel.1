Received: from eggs.gnu.org ([2001:4830:134:3::10]:49545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e89Cm-0006rz-3U
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e89Ch-0003ot-5C
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:18:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51510
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e89Cg-0003nf-VY
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:17:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RIFTWk127160
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 14:17:54 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv9strjd8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 14:17:54 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 12:17:53 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 16:17:40 -0200
Message-Id: <20171027181740.32165-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] scripts/device-crash-test: vmcoreinfo in
 error_whitelist for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, ehabkost@redhat.com

The device vmcoreinfo depends on the fw_cfg device to work, a device
that isn't available in most ppc64 machines. This makes device-crash-test
spams the following error when running with qemu-system-ppc64:

"INFO: log: qemu-system-ppc64: -device vmcoreinfo: vmcoreinfo device
requires fw_cfg with DMA"

To fix it, this patch adds the following ppc64 machines into the
error_whitelist for the vmcoreinfo device:

- pseries.*
- 40p
- bamboo
- g3beige
- mac99
- mpc8544ds
- powernv
- ppce500
- prep
- virtex-ml507

After this patch, the only ppc64 machine that reports error on the
vmcoreinfo device is the 'none' type.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 scripts/device-crash-test | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 043b24a4aa..fb8a43d679 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -163,6 +163,18 @@ ERROR_WHITELIST = [
     # "spapr-cpu-core needs a pseries machine"
     {'machine':'(?!pseries).*', 'device':'.*-spapr-cpu-core', 'expected':True},
 
+    # vmcoreinfo requires a fw_cfg device and will fail in these ppc64 machines
+    {'machine':'pseries.*', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'40p', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'bamboo', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'g3beige', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'mac99', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'mpc8544ds', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'powernv', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'ppce500', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'prep', 'device':'vmcoreinfo', 'expected':True},
+    {'machine':'virtex-ml507', 'device':'vmcoreinfo', 'expected':True},
+
     # KVM-specific devices shouldn't be tried without accel=kvm:
     {'accel':'(?!kvm).*', 'device':'kvmclock', 'expected':True},
     {'accel':'(?!kvm).*', 'device':'kvm-pci-assign', 'expected':True},
-- 
2.13.6
