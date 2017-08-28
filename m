Received: from eggs.gnu.org ([2001:4830:134:3::10]:47551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dmJaz-0004VC-VI
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dmJaw-0000un-2J
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:56:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1dmJav-0000uT-PX
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:56:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7SCt165002299
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 08:56:44 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmg3tmvu9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 08:56:44 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 22:56:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v7SCtNsR31588532
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 22:55:23 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v7SCtFaL026641
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 22:55:15 +1000
From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 18:25:17 +0530
Message-Id: <1503924917-12687-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] qemu crashes when a negative number used
 for 'maxcpus'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: s1seetee@linux.vnet.ibm.com

---Steps to Reproduce---

When passed a negative number to 'maxcpus' parameter, Qemu aborts
with a core dump.

Run the following command with maxcpus argument as negative number

ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
pseries,accel=kvm,kvm-type=HV -m size=200g -device virtio-blk-pci,
drive=rootdisk -drive file=/home/images/pegas-1.0-ppc64le.qcow2,
if=none,cache=none,id=rootdisk,format=qcow2 -monitor telnet
:127.0.0.1:1234,server,nowait -net nic,model=virtio -net
user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=1,
threads=1,maxcpus=-12

(process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
 18446744073709550568 bytes

Trace/breakpoint trap

Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 vl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/vl.c b/vl.c
index 8e247cc..042714f 100644
--- a/vl.c
+++ b/vl.c
@@ -1244,6 +1244,11 @@ static void smp_parse(QemuOpts *opts)
         }
 
         max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
+
+	if (max_cpus < 0) {
+		error_report("Invalid max_cpus : %d", max_cpus);
+		exit(1);
+	}
 
         if (max_cpus < cpus) {
             error_report("maxcpus must be equal to or greater than smp");
-- 
1.8.3.1
