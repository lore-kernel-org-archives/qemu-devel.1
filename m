Received: from eggs.gnu.org ([2001:4830:134:3::10]:54097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e4Xrp-0007dB-GU
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 15:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e4Xrm-00064F-Ci
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 15:49:33 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:36089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e4Xrm-000633-76
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 15:49:30 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BCC18135E67
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 21:49:27 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 17 Oct 2017 21:49:14 +0200
Message-ID: <150826975484.20019.5107463804719679762.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ppc: fix setting of compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

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
---

Cc'ing qemu-stable because the regression is present in 2.10.1... :-\
---
 target/ppc/compat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index f8729fe46d61..ad8f93c0644e 100644
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
