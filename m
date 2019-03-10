Received: from eggs.gnu.org ([209.51.188.92]:42584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnw-0000m1-EI
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tns-0001AR-PN
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:14 +1100
Message-Id: <20190310082703.1245-12-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/60] target/ppc/tcg: make spapr_caps apply
 cap-[cfpc/sbbc/ibs] non-fatal for tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spapr_caps cap-cfpc, cap-sbbc and cap-ibs are used to control the
availability of certain mitigations to the guest. These haven't been
implemented under TCG, it is unlikely they ever will be, and it is unclea=
r
as to whether they even need to be.

As such, make failure to apply these capabilities under TCG non-fatal.
Instead we print a warning message to the user but still allow the guest
to continue.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-Id: <20190301044609.9626-2-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f03f2f64e7..b68d767d63 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -239,17 +239,22 @@ sPAPRCapPossible cap_cfpc_possible =3D {
 static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
+    Error *local_err =3D NULL;
     uint8_t kvm_val =3D  kvmppc_get_cap_safe_cache();
=20
     if (tcg_enabled() && val) {
-        /* TODO - for now only allow broken for TCG */
-        error_setg(errp,
-"Requested safe cache capability level not supported by tcg, try a diffe=
rent value for cap-cfpc");
+        /* TCG only supports broken, allow other values and print a warn=
ing */
+        error_setg(&local_err,
+                   "TCG doesn't support requested feature, cap-cfpc=3D%s=
",
+                   cap_cfpc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe cache capability level not supported by kvm, try cap-cfp=
c=3D%s",
                    cap_cfpc_possible.vals[kvm_val]);
     }
+
+    if (local_err !=3D NULL)
+        warn_report_err(local_err);
 }
=20
 sPAPRCapPossible cap_sbbc_possible =3D {
@@ -262,17 +267,22 @@ sPAPRCapPossible cap_sbbc_possible =3D {
 static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_=
t val,
                                         Error **errp)
 {
+    Error *local_err =3D NULL;
     uint8_t kvm_val =3D  kvmppc_get_cap_safe_bounds_check();
=20
     if (tcg_enabled() && val) {
-        /* TODO - for now only allow broken for TCG */
-        error_setg(errp,
-"Requested safe bounds check capability level not supported by tcg, try =
a different value for cap-sbbc");
+        /* TCG only supports broken, allow other values and print a warn=
ing */
+        error_setg(&local_err,
+                   "TCG doesn't support requested feature, cap-sbbc=3D%s=
",
+                   cap_sbbc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe bounds check capability level not supported by kvm, try =
cap-sbbc=3D%s",
                    cap_sbbc_possible.vals[kvm_val]);
     }
+
+    if (local_err !=3D NULL)
+        warn_report_err(local_err);
 }
=20
 sPAPRCapPossible cap_ibs_possible =3D {
@@ -288,17 +298,22 @@ sPAPRCapPossible cap_ibs_possible =3D {
 static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
                                            uint8_t val, Error **errp)
 {
+    Error *local_err =3D NULL;
     uint8_t kvm_val =3D kvmppc_get_cap_safe_indirect_branch();
=20
     if (tcg_enabled() && val) {
-        /* TODO - for now only allow broken for TCG */
-        error_setg(errp,
-"Requested safe indirect branch capability level not supported by tcg, t=
ry a different value for cap-ibs");
+        /* TCG only supports broken, allow other values and print a warn=
ing */
+        error_setg(&local_err,
+                   "TCG doesn't support requested feature, cap-ibs=3D%s"=
,
+                   cap_ibs_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe indirect branch capability level not supported by kvm, t=
ry cap-ibs=3D%s",
                    cap_ibs_possible.vals[kvm_val]);
     }
+
+    if (local_err !=3D NULL)
+        warn_report_err(local_err);
 }
=20
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
--=20
2.20.1
