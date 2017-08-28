Received: from eggs.gnu.org ([2001:4830:134:3::10]:59246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmO0w-0003Ns-FC
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmO0t-0005O7-Bh
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:39:54 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 28 Aug 2017 19:39:45 +0200
Message-Id: <1503941985-25657-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] tests/bios-tables: Silence some
 messages with V=1, print them with V=2 only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org

When running "make check-qtest-x86_64 V=1", the output is currently flooded
with "Looking for expected file ..." and "Using expected file ..." messages.
None of the other tests is doing that with V=1, so this is a little bit
annoying. Let's only print these debug messages when we're running the test
with V=2 or higher.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/bios-tables-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45..289ee45 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -40,6 +40,7 @@ typedef struct {
     int required_struct_types_len;
 } test_data;
 
+static bool really_verbose;
 static char disk[] = "tests/acpi-test-disk-XXXXXX";
 static const char *data_dir = "tests/acpi-test-data";
 #ifdef CONFIG_IASL
@@ -395,7 +396,7 @@ static GArray *load_expected_aml(test_data *data)
 try_again:
         aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
                                    (gchar *)&signature, ext);
-        if (getenv("V")) {
+        if (really_verbose) {
             fprintf(stderr, "\nLooking for expected file '%s'\n", aml_file);
         }
         if (g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
@@ -407,7 +408,7 @@ try_again:
             goto try_again;
         }
         g_assert(exp_sdt.aml_file);
-        if (getenv("V")) {
+        if (really_verbose) {
             fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);
         }
         ret = g_file_get_contents(aml_file, &exp_sdt.aml,
@@ -812,6 +813,11 @@ int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
     int ret;
+    const char *v_env = getenv("V");
+
+    if (v_env && *v_env >= '2') {
+        really_verbose = true;
+    }
 
     ret = boot_sector_init(disk);
     if(ret)
-- 
1.8.3.1
