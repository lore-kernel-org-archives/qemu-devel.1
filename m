Received: from eggs.gnu.org ([2001:4830:134:3::10]:49854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEb-0005Os-U2
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEa-000434-5X
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:08 +1000
Message-Id: <20180618035324.19907-13-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/28] xics_kvm: fix a build break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

On CentOS 7.5, gcc-4.8.5-28.el7_5.1.ppc64le fails to build QEMU due to :

  hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_state=E2=80=99:
  hw/intc/xics_kvm.c:281:13: error: =E2=80=98ret=E2=80=99 may be used uni=
nitialized in this
    function [-Werror=3Dmaybe-uninitialized]
             return ret;

Fix the breakage and also remove the extra error reporting as
kvm_device_access() already provides a substantial error message.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 8bdf6afe82..8dba2f84e7 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -186,8 +186,7 @@ static void ics_get_kvm_state(ICSState *ics)
         kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
                           i + ics->offset, &state, false, &local_err);
         if (local_err) {
-            error_report("Unable to retrieve KVM interrupt controller st=
ate"
-                    " for IRQ %d: %s", i + ics->offset, strerror(errno))=
;
+            error_report_err(local_err);
             exit(1);
         }
=20
@@ -273,11 +272,10 @@ static int ics_set_kvm_state(ICSState *ics, int ver=
sion_id)
                 state |=3D KVM_XICS_QUEUED;
         }
=20
-        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
-                          i + ics->offset, &state, true, &local_err);
+        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURC=
ES,
+                                i + ics->offset, &state, true, &local_er=
r);
         if (local_err) {
-            error_report("Unable to restore KVM interrupt controller sta=
te"
-                    " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);
+            error_report_err(local_err);
             return ret;
         }
     }
--=20
2.17.1
