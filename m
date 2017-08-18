Received: from eggs.gnu.org ([2001:4830:134:3::10]:49342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhT-00028n-8e
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhS-0007Fi-6v
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhR-0007F8-Ty
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:26 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:44 +0200
Message-Id: <20170818114353.13455-10-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 for-2.11 09/18] target/s390x: move cc_name()
 to helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

While at it, move the translations into the function and properly pass
enum cc_op as parameter. We can't move it to cc_helper.c as this would
break --disable-tcg.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h    | 48 +--------------------------------------------=
---
 target/s390x/helper.c | 48 +++++++++++++++++++++++++++++++++++++++++++++=
+++
 2 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index c40d70d..10208ec 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -742,53 +742,7 @@ enum cc_op {
     CC_OP_MAX
 };
=20
-static const char *cc_names[] =3D {
-    [CC_OP_CONST0]    =3D "CC_OP_CONST0",
-    [CC_OP_CONST1]    =3D "CC_OP_CONST1",
-    [CC_OP_CONST2]    =3D "CC_OP_CONST2",
-    [CC_OP_CONST3]    =3D "CC_OP_CONST3",
-    [CC_OP_DYNAMIC]   =3D "CC_OP_DYNAMIC",
-    [CC_OP_STATIC]    =3D "CC_OP_STATIC",
-    [CC_OP_NZ]        =3D "CC_OP_NZ",
-    [CC_OP_LTGT_32]   =3D "CC_OP_LTGT_32",
-    [CC_OP_LTGT_64]   =3D "CC_OP_LTGT_64",
-    [CC_OP_LTUGTU_32] =3D "CC_OP_LTUGTU_32",
-    [CC_OP_LTUGTU_64] =3D "CC_OP_LTUGTU_64",
-    [CC_OP_LTGT0_32]  =3D "CC_OP_LTGT0_32",
-    [CC_OP_LTGT0_64]  =3D "CC_OP_LTGT0_64",
-    [CC_OP_ADD_64]    =3D "CC_OP_ADD_64",
-    [CC_OP_ADDU_64]   =3D "CC_OP_ADDU_64",
-    [CC_OP_ADDC_64]   =3D "CC_OP_ADDC_64",
-    [CC_OP_SUB_64]    =3D "CC_OP_SUB_64",
-    [CC_OP_SUBU_64]   =3D "CC_OP_SUBU_64",
-    [CC_OP_SUBB_64]   =3D "CC_OP_SUBB_64",
-    [CC_OP_ABS_64]    =3D "CC_OP_ABS_64",
-    [CC_OP_NABS_64]   =3D "CC_OP_NABS_64",
-    [CC_OP_ADD_32]    =3D "CC_OP_ADD_32",
-    [CC_OP_ADDU_32]   =3D "CC_OP_ADDU_32",
-    [CC_OP_ADDC_32]   =3D "CC_OP_ADDC_32",
-    [CC_OP_SUB_32]    =3D "CC_OP_SUB_32",
-    [CC_OP_SUBU_32]   =3D "CC_OP_SUBU_32",
-    [CC_OP_SUBB_32]   =3D "CC_OP_SUBB_32",
-    [CC_OP_ABS_32]    =3D "CC_OP_ABS_32",
-    [CC_OP_NABS_32]   =3D "CC_OP_NABS_32",
-    [CC_OP_COMP_32]   =3D "CC_OP_COMP_32",
-    [CC_OP_COMP_64]   =3D "CC_OP_COMP_64",
-    [CC_OP_TM_32]     =3D "CC_OP_TM_32",
-    [CC_OP_TM_64]     =3D "CC_OP_TM_64",
-    [CC_OP_NZ_F32]    =3D "CC_OP_NZ_F32",
-    [CC_OP_NZ_F64]    =3D "CC_OP_NZ_F64",
-    [CC_OP_NZ_F128]   =3D "CC_OP_NZ_F128",
-    [CC_OP_ICM]       =3D "CC_OP_ICM",
-    [CC_OP_SLA_32]    =3D "CC_OP_SLA_32",
-    [CC_OP_SLA_64]    =3D "CC_OP_SLA_64",
-    [CC_OP_FLOGR]     =3D "CC_OP_FLOGR",
-};
-
-static inline const char *cc_name(int cc_op)
-{
-    return cc_names[cc_op];
-}
+const char *cc_name(enum cc_op cc_op);
=20
 static inline void setcc(S390CPU *cpu, uint64_t cc)
 {
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 0c989b1..e31d3e5 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -352,3 +352,51 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
=20
     cpu_fprintf(f, "\n");
 }
+
+const char *cc_name(enum cc_op cc_op)
+{
+    static const char * const cc_names[] =3D {
+        [CC_OP_CONST0]    =3D "CC_OP_CONST0",
+        [CC_OP_CONST1]    =3D "CC_OP_CONST1",
+        [CC_OP_CONST2]    =3D "CC_OP_CONST2",
+        [CC_OP_CONST3]    =3D "CC_OP_CONST3",
+        [CC_OP_DYNAMIC]   =3D "CC_OP_DYNAMIC",
+        [CC_OP_STATIC]    =3D "CC_OP_STATIC",
+        [CC_OP_NZ]        =3D "CC_OP_NZ",
+        [CC_OP_LTGT_32]   =3D "CC_OP_LTGT_32",
+        [CC_OP_LTGT_64]   =3D "CC_OP_LTGT_64",
+        [CC_OP_LTUGTU_32] =3D "CC_OP_LTUGTU_32",
+        [CC_OP_LTUGTU_64] =3D "CC_OP_LTUGTU_64",
+        [CC_OP_LTGT0_32]  =3D "CC_OP_LTGT0_32",
+        [CC_OP_LTGT0_64]  =3D "CC_OP_LTGT0_64",
+        [CC_OP_ADD_64]    =3D "CC_OP_ADD_64",
+        [CC_OP_ADDU_64]   =3D "CC_OP_ADDU_64",
+        [CC_OP_ADDC_64]   =3D "CC_OP_ADDC_64",
+        [CC_OP_SUB_64]    =3D "CC_OP_SUB_64",
+        [CC_OP_SUBU_64]   =3D "CC_OP_SUBU_64",
+        [CC_OP_SUBB_64]   =3D "CC_OP_SUBB_64",
+        [CC_OP_ABS_64]    =3D "CC_OP_ABS_64",
+        [CC_OP_NABS_64]   =3D "CC_OP_NABS_64",
+        [CC_OP_ADD_32]    =3D "CC_OP_ADD_32",
+        [CC_OP_ADDU_32]   =3D "CC_OP_ADDU_32",
+        [CC_OP_ADDC_32]   =3D "CC_OP_ADDC_32",
+        [CC_OP_SUB_32]    =3D "CC_OP_SUB_32",
+        [CC_OP_SUBU_32]   =3D "CC_OP_SUBU_32",
+        [CC_OP_SUBB_32]   =3D "CC_OP_SUBB_32",
+        [CC_OP_ABS_32]    =3D "CC_OP_ABS_32",
+        [CC_OP_NABS_32]   =3D "CC_OP_NABS_32",
+        [CC_OP_COMP_32]   =3D "CC_OP_COMP_32",
+        [CC_OP_COMP_64]   =3D "CC_OP_COMP_64",
+        [CC_OP_TM_32]     =3D "CC_OP_TM_32",
+        [CC_OP_TM_64]     =3D "CC_OP_TM_64",
+        [CC_OP_NZ_F32]    =3D "CC_OP_NZ_F32",
+        [CC_OP_NZ_F64]    =3D "CC_OP_NZ_F64",
+        [CC_OP_NZ_F128]   =3D "CC_OP_NZ_F128",
+        [CC_OP_ICM]       =3D "CC_OP_ICM",
+        [CC_OP_SLA_32]    =3D "CC_OP_SLA_32",
+        [CC_OP_SLA_64]    =3D "CC_OP_SLA_64",
+        [CC_OP_FLOGR]     =3D "CC_OP_FLOGR",
+    };
+
+    return cc_names[cc_op];
+}
--=20
2.9.4
