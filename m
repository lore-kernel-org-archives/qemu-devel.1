Received: from eggs.gnu.org ([2001:4830:134:3::10]:59456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fVCRp-0005bC-0Q
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fVCRl-0003tz-3M
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:57:09 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 19 Jun 2018 18:56:31 +1000
Message-Id: <20180619085631.2859-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH qemu] xics-kvm: Fix compile warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This fixes uninitialized variable warning:

/home/aik/p/qemu/hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_sta=
te=E2=80=99:
/home/aik/p/qemu/hw/intc/xics_kvm.c:281:20: warning: =E2=80=98ret=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]
             return ret;
                    ^~~

Discovered with gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0 from Ubuntu 18.04.

Fixes: bf358b541b8 "xics_kvm: use KVM helpers"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/intc/xics_kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 8bdf6af..48efbce 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -273,8 +273,8 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
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
             error_report("Unable to restore KVM interrupt controller sta=
te"
                     " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);
--=20
2.11.0
