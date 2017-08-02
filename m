Received: from eggs.gnu.org ([2001:4830:134:3::10]:37455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcuvo-00085Z-PB
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcuvl-0002y6-KE
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:47:28 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:33473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcuvl-0002xZ-DQ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:47:25 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9E56B44FCD
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 16:47:23 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 02 Aug 2017 16:47:14 +0200
Message-ID: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Building QEMU on fedora26 with the latest gcc package fails:

  CC      ppc64-softmmu/target/ppc/kvm.o
In file included from include/sysemu/hw_accel.h:16:0,
                 from target/ppc/kvm.c:31:
target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=80=
=99:
include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may be =
used uninitialized
 in this function [-Werror=3Dmaybe-uninitialized]
             cap.args[i] =3D args_tmp[i];                               \
                                   ^
target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may be =
used uninitialized
 in this function [-Werror=3Dmaybe-uninitialized]
cc1: all warnings being treated as errors

$ rpm -q gcc
gcc-7.1.1-3.fc26.ppc64le

Testing the size of args_tmp seems to be enough to prevent the warning
to pop up.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/sysemu/kvm.h |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 91fc07ee9afe..41fc1005a9ea 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -429,9 +429,11 @@ int kvm_vm_check_extension(KVMState *s, unsigned int=
 extension);
         };                                                           \
         uint64_t args_tmp[] =3D { __VA_ARGS__ };                       \
         int i;                                                       \
-        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                 \
+        if (sizeof(args_tmp)) {                                      \
+            for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&             \
                      i < ARRAY_SIZE(cap.args); i++) {                \
-            cap.args[i] =3D args_tmp[i];                               \
+                cap.args[i] =3D args_tmp[i];                           \
+            }                                                        \
         }                                                            \
         kvm_vm_ioctl(s, KVM_ENABLE_CAP, &cap);                       \
     })
@@ -444,9 +446,11 @@ int kvm_vm_check_extension(KVMState *s, unsigned int=
 extension);
         };                                                           \
         uint64_t args_tmp[] =3D { __VA_ARGS__ };                       \
         int i;                                                       \
-        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                 \
+        if (sizeof(args_tmp)) {                                      \
+            for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&             \
                      i < ARRAY_SIZE(cap.args); i++) {                \
-            cap.args[i] =3D args_tmp[i];                               \
+                cap.args[i] =3D args_tmp[i];                           \
+            }                                                        \
         }                                                            \
         kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \
     })
