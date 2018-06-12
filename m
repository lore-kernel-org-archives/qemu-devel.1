Received: from eggs.gnu.org ([2001:4830:134:3::10]:40769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSgEm-0000aa-CC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSgEh-0000cq-Ij
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:09:16 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:35977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSgEh-0000cU-CT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:09:11 -0400
Received: from player750.ha.ovh.net (unknown [10.109.120.18])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id E68F6E749F
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 12:09:09 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 12 Jun 2018 12:08:57 +0200
Message-Id: <20180612100857.23093-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] xics_kvm: fix a build break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On CentOS 7.5, gcc-4.8.5-28.el7_5.1.ppc64le fails to build QEMU due to :

  hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_state=E2=80=99:
  hw/intc/xics_kvm.c:281:13: error: =E2=80=98ret=E2=80=99 may be used uni=
nitialized in this
    function [-Werror=3Dmaybe-uninitialized]
             return ret;

Fix the breakage and also remove the extra error reporting as
kvm_device_access() already provides a substantial error message.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Greg, can you please test ? RHEL7.5 does not catch the issue with the
 same compiler level :/ I don't understand why.=20
=20
 hw/intc/xics_kvm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 8bdf6afe82a0..2113b6987a45 100644
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
+            error_report_err(err);
             return ret;
         }
     }
--=20
2.13.6
