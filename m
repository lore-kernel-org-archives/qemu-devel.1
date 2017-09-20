Received: from eggs.gnu.org ([2001:4830:134:3::10]:56856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dugxp-0000N6-Aj
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dugxj-00088s-4D
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dugxi-00086y-BR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:30:54 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 20 Sep 2017 17:30:15 +0200
Message-Id: <20170920153016.3858-3-david@redhat.com>
In-Reply-To: <20170920153016.3858-1-david@redhat.com>
References: <20170920153016.3858-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/3] s390x/tcg: move wrap_address() to
 internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

We want to use it in another file.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/internal.h   | 14 ++++++++++++++
 target/s390x/mem_helper.c | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index bc8f83129a..70d2b87e55 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -162,6 +162,20 @@ static inline uint8_t get_per_atmid(CPUS390XState *e=
nv)
            ((env->psw.mask & PSW_ASC_ACCREG) ?    (1 << 2) : 0);
 }
=20
+static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
+{
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        if (!(env->psw.mask & PSW_MASK_32)) {
+            /* 24-Bit mode */
+            a &=3D 0x00ffffff;
+        } else {
+            /* 31-Bit mode */
+            a &=3D 0x7fffffff;
+        }
+    }
+    return a;
+}
+
 /* CC optimization */
=20
 /* Instead of computing the condition codes after each x86 instruction,
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index ec4760e390..a254613dc2 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -122,20 +122,6 @@ static inline void cpu_stsize_data_ra(CPUS390XState =
*env, uint64_t addr,
     }
 }
=20
-static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
-{
-    if (!(env->psw.mask & PSW_MASK_64)) {
-        if (!(env->psw.mask & PSW_MASK_32)) {
-            /* 24-Bit mode */
-            a &=3D 0x00ffffff;
-        } else {
-            /* 31-Bit mode */
-            a &=3D 0x7fffffff;
-        }
-    }
-    return a;
-}
-
 static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
                         uint32_t l, uintptr_t ra)
 {
--=20
2.13.5
