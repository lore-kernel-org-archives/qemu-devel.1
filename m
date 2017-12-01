Received: from eggs.gnu.org ([2001:4830:134:3::10]:44494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKufn-0007Lv-Mv
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKufm-0004Cf-Fy
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:24:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Dec 2017 17:24:28 -0600
Message-Id: <20171201232433.25193-3-eblake@redhat.com>
In-Reply-To: <20171201232433.25193-1-eblake@redhat.com>
References: <20171201232433.25193-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/7] mips: Tweak location of ';' in macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-trivial@nongnu.org, pbonzini@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

It is more typical to provide the ';' by the caller of a macro
than to embed it in the macro itself; this is because syntax
highlight engines can get confused if a macro is called without
a semicolon before the closing '}'.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/mips/msa_helper.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index f167a42655..8fb7a369ca 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -682,13 +682,13 @@ static inline int64_t msa_mod_u_df(uint32_t df, int=
64_t arg1, int64_t arg2)
     do {                                \
         e =3D SIGNED_EVEN(a, df);         \
         o =3D SIGNED_ODD(a, df);          \
-    } while (0);
+    } while (0)

 #define UNSIGNED_EXTRACT(e, o, a, df)   \
     do {                                \
         e =3D UNSIGNED_EVEN(a, df);       \
         o =3D UNSIGNED_ODD(a, df);        \
-    } while (0);
+    } while (0)

 static inline int64_t msa_dotp_s_df(uint32_t df, int64_t arg1, int64_t a=
rg2)
 {
@@ -1120,9 +1120,11 @@ void helper_msa_splat_df(CPUMIPSState *env, uint32=
_t df, uint32_t wd,
 #define MSA_LOOP_COND_D MSA_LOOP_COND(DF_DOUBLE)

 #define MSA_LOOP(DF) \
+    do { \
         for (i =3D 0; i < (MSA_LOOP_COND_ ## DF) ; i++) { \
-            MSA_DO_ ## DF \
-        }
+            MSA_DO_ ## DF; \
+        } \
+    } while (0)

 #define MSA_FN_DF(FUNC)                                             \
 void helper_msa_##FUNC(CPUMIPSState *env, uint32_t df, uint32_t wd, \
@@ -1135,17 +1137,17 @@ void helper_msa_##FUNC(CPUMIPSState *env, uint32_=
t df, uint32_t wd, \
     uint32_t i;                                                     \
     switch (df) {                                                   \
     case DF_BYTE:                                                   \
-        MSA_LOOP_B                                                  \
+        MSA_LOOP_B;                                                 \
         break;                                                      \
     case DF_HALF:                                                   \
-        MSA_LOOP_H                                                  \
+        MSA_LOOP_H;                                                 \
         break;                                                      \
     case DF_WORD:                                                   \
-        MSA_LOOP_W                                                  \
+        MSA_LOOP_W;                                                 \
         break;                                                      \
     case DF_DOUBLE:                                                 \
-        MSA_LOOP_D                                                  \
-       break;                                                       \
+        MSA_LOOP_D;                                                 \
+        break;                                                      \
     default:                                                        \
         assert(0);                                                  \
     }                                                               \
@@ -1168,7 +1170,7 @@ void helper_msa_##FUNC(CPUMIPSState *env, uint32_t =
df, uint32_t wd, \
     do {                                \
         R##DF(pwx, i) =3D pwt->DF[2*i];   \
         L##DF(pwx, i) =3D pws->DF[2*i];   \
-    } while (0);
+    } while (0)
 MSA_FN_DF(pckev_df)
 #undef MSA_DO

@@ -1176,7 +1178,7 @@ MSA_FN_DF(pckev_df)
     do {                                \
         R##DF(pwx, i) =3D pwt->DF[2*i+1]; \
         L##DF(pwx, i) =3D pws->DF[2*i+1]; \
-    } while (0);
+    } while (0)
 MSA_FN_DF(pckod_df)
 #undef MSA_DO

@@ -1184,7 +1186,7 @@ MSA_FN_DF(pckod_df)
     do {                                \
         pwx->DF[2*i]   =3D L##DF(pwt, i); \
         pwx->DF[2*i+1] =3D L##DF(pws, i); \
-    } while (0);
+    } while (0)
 MSA_FN_DF(ilvl_df)
 #undef MSA_DO

@@ -1192,7 +1194,7 @@ MSA_FN_DF(ilvl_df)
     do {                                \
         pwx->DF[2*i]   =3D R##DF(pwt, i); \
         pwx->DF[2*i+1] =3D R##DF(pws, i); \
-    } while (0);
+    } while (0)
 MSA_FN_DF(ilvr_df)
 #undef MSA_DO

@@ -1200,7 +1202,7 @@ MSA_FN_DF(ilvr_df)
     do {                                \
         pwx->DF[2*i]   =3D pwt->DF[2*i];  \
         pwx->DF[2*i+1] =3D pws->DF[2*i];  \
-    } while (0);
+    } while (0)
 MSA_FN_DF(ilvev_df)
 #undef MSA_DO

@@ -1208,7 +1210,7 @@ MSA_FN_DF(ilvev_df)
     do {                                    \
         pwx->DF[2*i]   =3D pwt->DF[2*i+1];    \
         pwx->DF[2*i+1] =3D pws->DF[2*i+1];    \
-    } while (0);
+    } while (0)
 MSA_FN_DF(ilvod_df)
 #undef MSA_DO
 #undef MSA_LOOP_COND
@@ -1222,7 +1224,7 @@ MSA_FN_DF(ilvod_df)
         uint32_t k =3D (pwd->DF[i] & 0x3f) % (2 * n);                   =
      \
         pwx->DF[i] =3D                                                  =
      \
             (pwd->DF[i] & 0xc0) ? 0 : k < n ? pwt->DF[k] : pws->DF[k - n=
];  \
-    } while (0);
+    } while (0)
 MSA_FN_DF(vshf_df)
 #undef MSA_DO
 #undef MSA_LOOP_COND
--=20
2.14.3
