Received: from eggs.gnu.org ([2001:4830:134:3::10]:34634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dmKUB-0004Qq-3B
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1dmKU5-0006ZF-6r
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:53:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1dmKU4-0006Yn-UH
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:53:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7SDrNsN011012
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 09:53:43 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmef8p01x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 09:53:43 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 23:53:40 +1000
From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:23:25 +0530
Message-Id: <1503928405-19960-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3] qemu crashes when a negative number used
 for 'maxcpus'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, famz@redhat.com, pbonzini@redhat.com
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
 vl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 8e247cc..fb45b6d 100644
--- a/vl.c
+++ b/vl.c
@@ -1244,7 +1244,10 @@ static void smp_parse(QemuOpts *opts)
         }
 
         max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
-
+        if (max_cpus <= 0) {
+            error_report("Invalid max_cpus : %d", max_cpus);
+            exit(1);
+        }
         if (max_cpus < cpus) {
             error_report("maxcpus must be equal to or greater than smp");
             exit(1);
-- 
1.8.3.1
