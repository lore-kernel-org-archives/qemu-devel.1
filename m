Received: from eggs.gnu.org ([2001:4830:134:3::10]:41986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZC-0007ry-5E
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZA-0005sQ-GO
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:10 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZA-0005rp-6j
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:08 -0500
Received: by mail-wr0-x244.google.com with SMTP id p6so5053842wrd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:05 +0100
Message-Id: <1515756676-3860-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 41/52] mips: Tweak location of ';' in macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

It is more typical to provide the ';' by the caller of a macro
than to embed it in the macro itself; this is because syntax
highlight engines can get confused if a macro is called without
a semicolon before the closing '}'.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20171201232433.25193-3-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/mips/msa_helper.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index f167a42..8fb7a36 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -682,13 +682,13 @@ static inline int64_t msa_mod_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     do {                                \
         e = SIGNED_EVEN(a, df);         \
         o = SIGNED_ODD(a, df);          \
-    } while (0);
+    } while (0)
 
 #define UNSIGNED_EXTRACT(e, o, a, df)   \
     do {                                \
         e = UNSIGNED_EVEN(a, df);       \
         o = UNSIGNED_ODD(a, df);        \
-    } while (0);
+    } while (0)
 
 static inline int64_t msa_dotp_s_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
@@ -1120,9 +1120,11 @@ void helper_msa_splat_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 #define MSA_LOOP_COND_D MSA_LOOP_COND(DF_DOUBLE)
 
 #define MSA_LOOP(DF) \
+    do { \
         for (i = 0; i < (MSA_LOOP_COND_ ## DF) ; i++) { \
-            MSA_DO_ ## DF \
-        }
+            MSA_DO_ ## DF; \
+        } \
+    } while (0)
 
 #define MSA_FN_DF(FUNC)                                             \
 void helper_msa_##FUNC(CPUMIPSState *env, uint32_t df, uint32_t wd, \
@@ -1135,17 +1137,17 @@ void helper_msa_##FUNC(CPUMIPSState *env, uint32_t df, uint32_t wd, \
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
@@ -1168,7 +1170,7 @@ void helper_msa_##FUNC(CPUMIPSState *env, uint32_t df, uint32_t wd, \
     do {                                \
         R##DF(pwx, i) = pwt->DF[2*i];   \
         L##DF(pwx, i) = pws->DF[2*i];   \
-    } while (0);
+    } while (0)
 MSA_FN_DF(pckev_df)
 #undef MSA_DO
 
@@ -1176,7 +1178,7 @@ MSA_FN_DF(pckev_df)
     do {                                \
         R##DF(pwx, i) = pwt->DF[2*i+1]; \
         L##DF(pwx, i) = pws->DF[2*i+1]; \
-    } while (0);
+    } while (0)
 MSA_FN_DF(pckod_df)
 #undef MSA_DO
 
@@ -1184,7 +1186,7 @@ MSA_FN_DF(pckod_df)
     do {                                \
         pwx->DF[2*i]   = L##DF(pwt, i); \
         pwx->DF[2*i+1] = L##DF(pws, i); \
-    } while (0);
+    } while (0)
 MSA_FN_DF(ilvl_df)
 #undef MSA_DO
 
@@ -1192,7 +1194,7 @@ MSA_FN_DF(ilvl_df)
     do {                                \
         pwx->DF[2*i]   = R##DF(pwt, i); \
         pwx->DF[2*i+1] = R##DF(pws, i); \
-    } while (0);
+    } while (0)
 MSA_FN_DF(ilvr_df)
 #undef MSA_DO
 
@@ -1200,7 +1202,7 @@ MSA_FN_DF(ilvr_df)
     do {                                \
         pwx->DF[2*i]   = pwt->DF[2*i];  \
         pwx->DF[2*i+1] = pws->DF[2*i];  \
-    } while (0);
+    } while (0)
 MSA_FN_DF(ilvev_df)
 #undef MSA_DO
 
@@ -1208,7 +1210,7 @@ MSA_FN_DF(ilvev_df)
     do {                                    \
         pwx->DF[2*i]   = pwt->DF[2*i+1];    \
         pwx->DF[2*i+1] = pws->DF[2*i+1];    \
-    } while (0);
+    } while (0)
 MSA_FN_DF(ilvod_df)
 #undef MSA_DO
 #undef MSA_LOOP_COND
@@ -1222,7 +1224,7 @@ MSA_FN_DF(ilvod_df)
         uint32_t k = (pwd->DF[i] & 0x3f) % (2 * n);                         \
         pwx->DF[i] =                                                        \
             (pwd->DF[i] & 0xc0) ? 0 : k < n ? pwt->DF[k] : pws->DF[k - n];  \
-    } while (0);
+    } while (0)
 MSA_FN_DF(vshf_df)
 #undef MSA_DO
 #undef MSA_LOOP_COND
-- 
1.8.3.1
