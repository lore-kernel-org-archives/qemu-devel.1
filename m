Received: from eggs.gnu.org ([2001:4830:134:3::10]:49511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCU-0000js-FT
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCQ-0000iu-Ty
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCQ-0000hQ-Ly
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE5Jr043770
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:41 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmpw5eb7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:41 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:40 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:27 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-35-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 34/55] ppc: fix setting of compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

While trying to make KVM PR usable again, commit 5dfaa532ae introduced a
regression: the current compat_pvr value is passed to KVM instead of the
new one. This means that we always pass 0 instead of the max-cpu-compat
PVR during the initial machine reset. And at CAS time, we either pass
the PVR from the command line or even don't call kvmppc_set_compat() at
all, ie, the PCR will not be set as expected.

For example if we start a big endian fedora26 guest in power7 compat
mode on a POWER8 host, we get this in the guest:

$ cat /proc/cpuinfo
processor       : 0
cpu             : POWER7 (architected), altivec supported
clock           : 4024.000000MHz
revision        : 2.0 (pvr 004d 0200)

timebase        : 512000000
platform        : pSeries
model           : IBM pSeries (emulated by qemu)
machine         : CHRP IBM pSeries (emulated by qemu)
MMU             : Hash

but the guest can still execute POWER8 instructions, and the following
program succeeds:

int main()
{
        asm("vncipher 0,0,0"); // ISA 2.07 instruction
}

Let's pass the new compat_pvr to kvmppc_set_compat() and the program fails
with SIGILL as expected.

Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit e4f0c6bb1a9f72ad9e32c3171d36bae17ea1cd67)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index f8729fe46d..ad8f93c064 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -141,7 +141,7 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
     cpu_synchronize_state(CPU(cpu));
 
     if (kvm_enabled() && cpu->compat_pvr != compat_pvr) {
-        int ret = kvmppc_set_compat(cpu, cpu->compat_pvr);
+        int ret = kvmppc_set_compat(cpu, compat_pvr);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "Unable to set CPU compatibility mode in KVM");
-- 
2.11.0
