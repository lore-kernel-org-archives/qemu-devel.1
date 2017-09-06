Received: from eggs.gnu.org ([2001:4830:134:3::10]:39891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeG-0005Nm-9j
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeF-00009k-5B
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:48 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:34347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpbeE-00009P-Vn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:47 -0400
Received: by mail-pg0-x22a.google.com with SMTP id 63so6541097pgc.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:49:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 07:49:28 -0700
Message-Id: <20170906144940.30880-3-richard.henderson@linaro.org>
In-Reply-To: <20170906144940.30880-1-richard.henderson@linaro.org>
References: <20170906144940.30880-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 02/14] tcg: Add tcg target default memory
 ordering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Pranith Kumar <bobby.prani@gmail.com>

From: Pranith Kumar <bobby.prani@gmail.com>

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Message-Id: <20170829063313.10237-3-bobby.prani@gmail.com>
[rth: Dropped ia64 hunk]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h | 2 ++
 tcg/arm/tcg-target.h     | 2 ++
 tcg/mips/tcg-target.h    | 2 ++
 tcg/ppc/tcg-target.h     | 2 ++
 tcg/s390/tcg-target.h    | 2 ++
 tcg/sparc/tcg-target.h   | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 55a46ac825..b41a248bee 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -117,4 +117,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     __builtin___clear_cache((char *)start, (char *)stop);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 5ef1086710..a38be15a39 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -134,4 +134,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     __builtin___clear_cache((char *) start, (char *) stop);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d75cb63ed3..e9558d15bc 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -206,4 +206,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     cacheflush ((void *)start, stop-start, ICACHE);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 5f4a40a5b4..5a092b038a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -125,4 +125,6 @@ extern bool have_isa_3_00;
 
 void flush_icache_range(uintptr_t start, uintptr_t stop);
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 957f0c0afe..dc0e59193c 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -133,6 +133,8 @@ extern uint64_t s390_facilities;
 
 #define TCG_TARGET_EXTEND_ARGS 1
 
+#define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
 enum {
     TCG_AREG0 = TCG_REG_R10,
 };
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 854a0afd70..4515c9ab48 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -162,6 +162,8 @@ extern bool use_vis3_instructions;
 
 #define TCG_AREG0 TCG_REG_I0
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
     uintptr_t p;
-- 
2.13.5
