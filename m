Received: from eggs.gnu.org ([209.51.188.92]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gycaL-0005CO-57
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gycaJ-0006up-0U
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:49 -0500
Received: from relay.sw.ru ([185.231.240.75]:43584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1gycaI-0006tE-F9
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:46 -0500
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Tue, 26 Feb 2019 16:15:35 +0300
Message-Id: <20190226131535.30361-4-dplotnikov@virtuozzo.com>
In-Reply-To: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
References: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/3] migration: add zstd compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, qemu-devel@nongnu.org

zstd allows to migrate with less cpu consumption maintaining the
the same level of data compression as qzip (zlib).

Compression level for zstd is set with migration parameter "compress-level"
in the range 1 - 22. 1 - the best speed, 22 - the best compression.

Levels in the range of 20-22 should be used with care because they lead
to significant growth of CPU and memory usage.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 configure             | 26 ++++++++++++
 migration/migration.c |  5 ++-
 migration/qemu-file.h |  1 +
 migration/ram.c       | 95 +++++++++++++++++++++++++++++++++++++++++++
 qapi/migration.json   |  6 +--
 5 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index f8176b3c40..9dd1c18650 100755
--- a/configure
+++ b/configure
@@ -432,6 +432,7 @@ opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt=""
 zlib="yes"
+zstd="yes"
 capstone=""
 lzo=""
 snappy=""
@@ -1301,6 +1302,8 @@ for opt do
   ;;
   --disable-zlib-test) zlib="no"
   ;;
+  --disable-zstd-test) zstd="no"
+  ;;
   --disable-lzo) lzo="no"
   ;;
   --enable-lzo) lzo="yes"
@@ -3586,6 +3589,29 @@ EOF
     fi
 fi
 
+#########################################
+# zstd check
+
+if test "$zstd" != "no" ; then
+    if $pkg_config --exists libzstd; then
+        zstd_cflags=$($pkg_config --cflags libzstd)
+        zstd_libs=$($pkg_config --libs libzstd)
+        QEMU_CFLAGS="$zstd_cflags $QEMU_CFLAGS"
+        LIBS="$zstd_libs $LIBS"
+    else
+        cat > $TMPC << EOF
+#include <zstd.h>
+int main(void) { ZSTD_versionNumber(); return 0; }
+EOF
+        if compile_prog "" "-lzstd" ; then
+            LIBS="$LIBS -lzstd"
+        else
+            error_exit "zstd check failed" \
+                "Make sure to have the zstd libs and headers installed."
+        fi
+    fi
+fi
+
 ##########################################
 # SHA command probe for modules
 if test "$modules" = yes; then
diff --git a/migration/migration.c b/migration/migration.c
index 10cecb0eeb..a7875bbb47 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1036,9 +1036,12 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
         case COMPRESSION_TYPE_ZLIB:
             max_compress_level = 9;
             break;
+        case COMPRESSION_TYPE_ZSTD:
+            max_compress_level = 22;
+            break;
         default:
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_type",
-                       "values: 0 - gzip");
+                       "values: 0 - gzip, 1 - zstd");
             return false;
         }
     }
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 24cf0d7e25..7cd054f73e 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -117,6 +117,7 @@ typedef struct QEMUFileHooks {
 
 typedef enum CompressionType {
     COMPRESSION_TYPE_ZLIB = 0,
+    COMPRESSION_TYPE_ZSTD = 1,
 } CompressionType;
 
 struct Compression {
diff --git a/migration/ram.c b/migration/ram.c
index 9ff154ed7b..4be5d100df 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -57,6 +57,7 @@
 #include "qemu/uuid.h"
 #include "savevm.h"
 #include "qemu/iov.h"
+#include <zstd.h>
 
 /***********************************************************/
 /* ram save/restore */
@@ -446,6 +447,59 @@ static int zlib_decompress(Compression *comp, uint8_t *dest, size_t dest_len,
     return stream->total_out;
 }
 
+static int zstd_compress(Compression *comp, uint8_t *dest, size_t dest_len,
+                         const uint8_t *source, size_t source_len)
+{
+    int res;
+    ZSTD_inBuffer input = {source, source_len, 0};
+    ZSTD_outBuffer output = {dest, dest_len, 0};
+
+    res = ZSTD_initCStream(comp->stream, migrate_compress_level());
+
+    if (ZSTD_isError(res)) {
+        error_report("zstd: compression stream initialization error: %s",
+                     ZSTD_getErrorName(res));
+        return -1;
+    }
+
+    res = ZSTD_compressStream(comp->stream, &output, &input);
+
+    if (ZSTD_isError(res)) {
+        error_report("zstd: compression error: %s",
+                     ZSTD_getErrorName(res));
+        return -1;
+    }
+
+    res = ZSTD_endStream(comp->stream, &output);
+
+    if (ZSTD_isError(res)) {
+        error_report("zstd: end stream error: %s",
+                     ZSTD_getErrorName(res));
+        return -1;
+    }
+
+    return output.pos;
+}
+
+static int zstd_decompress(Compression *comp, uint8_t *dest, size_t dest_len,
+                         const uint8_t *source, size_t source_len)
+{
+    int res;
+    ZSTD_inBuffer input = {source, source_len, 0};
+    ZSTD_outBuffer output = {dest, dest_len, 0};
+
+    res = ZSTD_decompressStream(comp->stream, &output, &input);
+
+    if (ZSTD_isError(res)) {
+        error_report("zstd: decompression error: %s",
+                      ZSTD_getErrorName(res));
+         return -1;
+    }
+
+    return output.pos;
+}
+
+
 static int init_compression(Compression *comp, CompressionType type,
                             bool is_decompression)
 {
@@ -474,6 +528,40 @@ static int init_compression(Compression *comp, CompressionType type,
 
         comp->get_bound = compressBound;
         break;
+    case COMPRESSION_TYPE_ZSTD:
+        if (is_decompression) {
+            int res;
+
+            comp->stream = ZSTD_createDStream();
+
+            if (comp->stream == NULL) {
+                error_report("zstd: can't create decompression stream");
+                return 1;
+            }
+
+            res = ZSTD_initDStream(comp->stream);
+
+            if (ZSTD_isError(res)) {
+                error_report("zstd: can't initialzie decompression: %s",
+                             ZSTD_getErrorName(res));
+                ZSTD_freeDStream(comp->stream);
+                return 1;
+            }
+
+            comp->process = zstd_decompress;
+        } else {
+            comp->stream = ZSTD_createCStream();
+
+            if (comp->stream == NULL) {
+                error_report("zstd: can't create compression stream");
+                return 1;
+            }
+
+            comp->process = zstd_compress;
+        }
+
+        comp->get_bound = ZSTD_compressBound;
+        break;
     default:
         return 1;
     }
@@ -496,6 +584,13 @@ static void destroy_compression(Compression *comp)
         }
         g_free(comp->stream);
         break;
+    case COMPRESSION_TYPE_ZSTD:
+        if (comp->is_decompression) {
+            ZSTD_freeDStream(comp->stream);
+        } else {
+            ZSTD_freeCStream(comp->stream);
+        }
+        break;
     default:
         assert(false);
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index 9a3110e383..c0d48d21d4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -482,10 +482,10 @@
 #
 # @compress-type: Set the compression type to be used in live migration,
 #          the compression type is an integer from the list:
-#          0 - gzip
+#          0 - gzip, 1 -zstd
 #
 # @compress-level: Set the compression level to be used in live migration,
-#          the compression level is an integer between 0 and 9,
+#          the compression level is an integer between 0 and gzip:9, zstd:22
 #          where 0 means no compression, 1 means the best compression speed,
 #          and the highest value depending on the compression type means
 #          the best compression ratio which will consume more CPU.
@@ -578,7 +578,7 @@
 # @MigrateSetParameters:
 #
 # @compress-type: Compression type is used for migration.
-#                 Available types:  0 - gzip
+#                 Available types:  0 - gzip, 1 - zstd
 #
 # @compress-level: compression level
 #
-- 
2.17.0
