Received: from eggs.gnu.org ([2001:4830:134:3::10]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8n7S-0005pX-V5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8n7O-0007Sa-So
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:22:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8n7O-0007SD-KI
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:22:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4A2F7267A
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:22:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 11 May 2017 20:22:36 +0800
Message-Id: <1494505358-15287-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1494505358-15287-1-git-send-email-peterx@redhat.com>
References: <1494505358-15287-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 2/4] utils: provide size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Moving the algorithm from print_type_size() into size_to_str() so that
other component can also leverage it. With that, refactor
print_type_size().

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu-common.h        |  1 +
 qapi/string-output-visitor.c | 22 ++++++----------------
 util/cutils.c                | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index d218821..d7d0448 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -145,6 +145,7 @@ void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
 int parse_debug_env(const char *name, int max, int initial);
 
 const char *qemu_ether_ntoa(const MACAddr *mac);
+char *size_to_str(double val);
 void page_size_init(void);
 
 /* returns non-zero if dump is in progress, otherwise zero is
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 94ac821..53c2175 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -211,10 +211,8 @@ static void print_type_size(Visitor *v, const char *name, uint64_t *obj,
                             Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
-    static const char suffixes[] = { 'B', 'K', 'M', 'G', 'T', 'P', 'E' };
-    uint64_t div, val;
-    char *out;
-    int i;
+    uint64_t val;
+    char *out, *psize;
 
     if (!sov->human) {
         out = g_strdup_printf("%"PRIu64, *obj);
@@ -223,19 +221,11 @@ static void print_type_size(Visitor *v, const char *name, uint64_t *obj,
     }
 
     val = *obj;
-
-    /* The exponent (returned in i) minus one gives us
-     * floor(log2(val * 1024 / 1000).  The correction makes us
-     * switch to the higher power when the integer part is >= 1000.
-     */
-    frexp(val / (1000.0 / 1024.0), &i);
-    i = (i - 1) / 10;
-    assert(i < ARRAY_SIZE(suffixes));
-    div = 1ULL << (i * 10);
-
-    out = g_strdup_printf("%"PRIu64" (%0.3g %c%s)", val,
-                          (double)val/div, suffixes[i], i ? "iB" : "");
+    psize = size_to_str(val);
+    out = g_strdup_printf("%"PRIu64" (%s)", val, psize);
     string_output_set(sov, out);
+
+    g_free(psize);
 }
 
 static void print_type_bool(Visitor *v, const char *name, bool *obj,
diff --git a/util/cutils.c b/util/cutils.c
index 50ad179..fa5ddec 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -619,3 +619,29 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
 
     return ret;
 }
+
+/*
+ * Return human readable string for size @val.
+ * @val must be between (-1000Eib, 1000EiB), exclusively.
+ * Use IEC binary units like KiB, MiB, and so forth.
+ * Caller is responsible for passing it to g_free().
+ */
+char *size_to_str(double val)
+{
+    static const char *suffixes[] = { "", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei" };
+    unsigned long div;
+    int i;
+
+    /*
+     * The exponent (returned in i) minus one gives us
+     * floor(log2(val * 1024 / 1000).  The correction makes us
+     * switch to the higher power when the integer part is >= 1000.
+     * (see e41b509d68afb1f for more info)
+     */
+    frexp(val / (1000.0 / 1024.0), &i);
+    i = (i - 1) / 10;
+    assert(i < ARRAY_SIZE(suffixes));
+    div = 1ULL << (i * 10);
+
+    return g_strdup_printf("%0.3g %sB", val / div, suffixes[i]);
+}
-- 
2.7.4
