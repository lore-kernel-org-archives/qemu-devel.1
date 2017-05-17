Received: from eggs.gnu.org ([2001:4830:134:3::10]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB3Mh-0006EZ-FZ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB3Mf-0002EI-He
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:08:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dB3Mf-0002DN-7o
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:08:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EEAC80C08
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 18:08:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 17 May 2017 19:07:53 +0100
Message-Id: <20170517180754.20456-3-dgilbert@redhat.com>
In-Reply-To: <20170517180754.20456-1-dgilbert@redhat.com>
References: <20170517180754.20456-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] utils: provide size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

Moving the algorithm from print_type_size() into size_to_str() so that
other component can also leverage it. With that, refactor
print_type_size().

The assert() in that logic is removed though, since even UINT64_MAX
would not overflow.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1494562661-9063-3-git-send-email-peterx@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu-common.h        |  1 +
 qapi/string-output-visitor.c | 22 ++++++----------------
 util/cutils.c                | 25 +++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index d218821c14..387ef520bf 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -145,6 +145,7 @@ void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
 int parse_debug_env(const char *name, int max, int initial);
 
 const char *qemu_ether_ntoa(const MACAddr *mac);
+char *size_to_str(uint64_t val);
 void page_size_init(void);
 
 /* returns non-zero if dump is in progress, otherwise zero is
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 94ac8211d1..53c2175d81 100644
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
index 50ad179dc5..1534682083 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -619,3 +619,28 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
 
     return ret;
 }
+
+/*
+ * Return human readable string for size @val.
+ * @val can be anything that uint64_t allows (no more than "16 EiB").
+ * Use IEC binary units like KiB, MiB, and so forth.
+ * Caller is responsible for passing it to g_free().
+ */
+char *size_to_str(uint64_t val)
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
+    div = 1ULL << (i * 10);
+
+    return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
+}
-- 
2.13.0
