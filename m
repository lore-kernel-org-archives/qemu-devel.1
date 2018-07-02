Received: from eggs.gnu.org ([2001:4830:134:3::10]:58168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fZucJ-0006c1-3I
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fZucE-0000ke-6J
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:55:27 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:39043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fZucD-0000gx-Vx
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:55:22 -0400
Received: from player697.ha.ovh.net (unknown [10.109.108.62])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 09D2BD6755
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 10:55:11 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 02 Jul 2018 10:54:56 +0200
Message-ID: <153052169663.619548.17452930454532662595.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] spapr: compute default value of
 "hpt-max-page-size" later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

It is currently not possible to run a pseries-2.12 or older machine
with HV KVM. QEMU prints the following and exits right away.

qemu-system-ppc64: KVM doesn't support for base page shift 34

The "hpt-max-page-size" capability was recently added to spapr to hide
host configuration details from HPT mode guests. Its default value for
newer machine types is 64k.

For backwards compatibility, pseries-2.12 and older machine types need
a different value. This is handled as usual in a class init function.
The default value is 16G, ie, all page sizes supported by POWER7 and
newer CPUs, but HV KVM requires guest pages to be hpa contiguous as
well as gpa contiguous. The default value is the page size used to
back the guest RAM in this case.

Unfortunately kvmppc_hpt_needs_host_contiguous_pages()->kvm_enabled() is
called way before KVM init and returns false, even if the user requested
KVM. We thus end up selecting 16G, which isn't supported by HV KVM. The
default value must be set during machine init, because we can safely
assume that KVM is initialized at this point.

We fix this by moving the logic to default_caps_with_cpu(). Since the
user cannot pass cap-hpt-max-page-size=0, we set the default to 0 in
the pseries-2.12 class init function and use that as a flag to do the
real work.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v3: - moved logic to default_caps_with_cpu()

v2: - moved logic under spapr_caps_init()
---
 hw/ppc/spapr.c      |   13 ++++++-------
 hw/ppc/spapr_caps.c |   13 +++++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b2baec026ff4..062d9dc346d4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4095,17 +4095,16 @@ static void spapr_machine_2_12_instance_options(MachineState *machine)
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    uint8_t mps;
 
     spapr_machine_3_0_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
 
-    if (kvmppc_hpt_needs_host_contiguous_pages()) {
-        mps = ctz64(qemu_getrampagesize());
-    } else {
-        mps = 34; /* allow everything up to 16GiB, i.e. everything */
-    }
-    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = mps;
+    /* We depend on kvm_enabled() to choose a default value for the
+     * hpt-max-page-size capability. Of course we can't do it here
+     * because this is too early and the HW accelerator isn't initialzed
+     * yet. Postpone this to machine init (see default_caps_with_cpu()).
+     */
+    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 0;
 }
 
 DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 62663ebdf51a..aa605cea9108 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -465,6 +465,19 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
         caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     }
 
+    /* This is for pseries-2.12 and older */
+    if (smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] == 0) {
+        uint8_t mps;
+
+        if (kvmppc_hpt_needs_host_contiguous_pages()) {
+            mps = ctz64(qemu_getrampagesize());
+        } else {
+            mps = 34; /* allow everything up to 16GiB, i.e. everything */
+        }
+
+        caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = mps;
+    }
+
     return caps;
 }
 
