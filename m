Received: from eggs.gnu.org ([2001:4830:134:3::10]:40650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCLTX-0005vv-5b
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCLTU-0000RW-2D
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:12:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  8 Nov 2017 19:12:30 +1100
Message-Id: <20171108081232.28322-2-david@gibson.dropbear.id.au>
In-Reply-To: <20171108081232.28322-1-david@gibson.dropbear.id.au>
References: <20171108081232.28322-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/3] ppc: fix setting of compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

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
2.13.6
