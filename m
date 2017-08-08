Received: from eggs.gnu.org ([2001:4830:134:3::10]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S4-00016x-Jh
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S3-0006eo-Bz
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1df6S3-0006eL-3a
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:47 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  8 Aug 2017 17:29:35 +0200
Message-Id: <20170808152941.11247-4-pbonzini@redhat.com>
In-Reply-To: <20170808152941.11247-1-pbonzini@redhat.com>
References: <20170808152941.11247-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] kvm: workaround build break on gcc-7.1.1 /
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
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

Building QEMU on fedora26 with the latest gcc package fails:

  CC      ppc64-softmmu/target/ppc/kvm.o
In file included from include/sysemu/hw_accel.h:16:0,
                 from target/ppc/kvm.c:31:
target/ppc/kvm.c: In function =C3=A2=E2=82=AC=CB=9Ckvmppc_booke_watchdog_=
enable=C3=A2=E2=82=AC=E2=84=A2:
include/sysemu/kvm.h:449:35: error: =C3=A2=E2=82=AC=CB=9Cargs_tmp[i]=C3=A2=
=E2=82=AC=E2=84=A2 may be used uninitialized
 in this function [-Werror=3Dmaybe-uninitialized]
             cap.args[i] =3D args_tmp[i];                               \
                                   ^
target/ppc/kvm.c: In function =C3=A2=E2=82=AC=CB=9Ckvmppc_set_papr=C3=A2=E2=
=82=AC=E2=84=A2:
include/sysemu/kvm.h:449:35: error: =C3=A2=E2=82=AC=CB=9Cargs_tmp[i]=C3=A2=
=E2=82=AC=E2=84=A2 may be used uninitialized
 in this function [-Werror=3Dmaybe-uninitialized]
cc1: all warnings being treated as errors

$ rpm -q gcc
gcc-7.1.1-3.fc26.ppc64le

The compiler should obviously optimize this code away when no extra
agument is passed to kvm_vm_enable_cap() and kvm_vcpu_enable_cap(),
but it doesn't. This bug should be fixed one day in gcc, but we can
also change our code pattern so that we don't hit the issue anymore.
We workaround this, by using memcpy() instead of open-coding the copy.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <150210580404.1343.7325713896658799315.stgit@bahia.lan>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 91fc07ee9a..3a458f50e9 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -428,11 +428,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned int=
 extension);
             .flags =3D cap_flags,                                      \
         };                                                           \
         uint64_t args_tmp[] =3D { __VA_ARGS__ };                       \
-        int i;                                                       \
-        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                 \
-                     i < ARRAY_SIZE(cap.args); i++) {                \
-            cap.args[i] =3D args_tmp[i];                               \
-        }                                                            \
+        size_t n =3D MIN(ARRAY_SIZE(args_tmp), ARRAY_SIZE(cap.args));  \
+        memcpy(cap.args, args_tmp, n * sizeof(cap.args[0]));         \
         kvm_vm_ioctl(s, KVM_ENABLE_CAP, &cap);                       \
     })
=20
@@ -443,11 +440,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned int=
 extension);
             .flags =3D cap_flags,                                      \
         };                                                           \
         uint64_t args_tmp[] =3D { __VA_ARGS__ };                       \
-        int i;                                                       \
-        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                 \
-                     i < ARRAY_SIZE(cap.args); i++) {                \
-            cap.args[i] =3D args_tmp[i];                               \
-        }                                                            \
+        size_t n =3D MIN(ARRAY_SIZE(args_tmp), ARRAY_SIZE(cap.args));  \
+        memcpy(cap.args, args_tmp, n * sizeof(cap.args[0]));         \
         kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \
     })
=20
--=20
2.13.3
