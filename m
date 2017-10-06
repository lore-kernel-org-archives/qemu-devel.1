Received: from eggs.gnu.org ([2001:4830:134:3::10]:58554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQW-0005X3-Ug
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQV-0007ED-Gb
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PQV-0007Dp-Bt
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:15 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:25 +0200
Message-Id: <20171006095956.27534-3-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/33] s390x/tcg: move wrap_address() to
 internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We want to use it in another file.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170920153016.3858-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
2.13.6
