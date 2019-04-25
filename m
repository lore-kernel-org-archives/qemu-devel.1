Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX39-0003hD-Qu
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX2P-0000We-D6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:35:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJX2O-0000Ut-H4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:35:13 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 25 Apr 2019 07:34:49 +0200
Message-Id: <1556170489-131927-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/13] tests: acpi: print error unable to
 dump ACPI table during rebuild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

Instead of just asserting print the error that lead to assert first.
While at it move assert into rebuild branch, which removes reduntant
check done in case of !rebuild branch is taken (the later is taken
care of by g_assert_no_error).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index f117461..5a5d036 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -199,11 +199,14 @@ static void dump_aml_files(test_data *data, bool rebuild)
                                        sdt->aml, ext);
             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
+            if (fd < 0) {
+                perror(aml_file);
+            }
+            g_assert(fd >= 0);
         } else {
             fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
             g_assert_no_error(error);
         }
-        g_assert(fd >= 0);
 
         ret = qemu_write_full(fd, sdt->aml, sdt->aml_len);
         g_assert(ret == sdt->aml_len);
-- 
2.7.4
