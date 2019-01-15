Received: from eggs.gnu.org ([209.51.188.92]:33957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR27-0001ia-P1
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR26-0006XH-SU
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjR26-0006Ub-MQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:42 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 Jan 2019 16:41:02 +0100
Message-Id: <1547566866-129386-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 10/14] tests: acpi: ignore SMBIOS tests when
 UEFI firmware is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

once FW provides a pointer to SMBIOS entry point like it does for
RSDP it should be possible to enable this one the same way.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d9efe59..a64d0c2 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -562,8 +562,11 @@ static void test_acpi_one(const char *params, test_data *data)
         }
     }
 
-    test_smbios_entry_point(data);
-    test_smbios_structs(data);
+    /* TODO: make SMBIOS tests work with UEFI firmware */
+    if (!use_uefi) {
+        test_smbios_entry_point(data);
+        test_smbios_structs(data);
+    }
 
     assert(!global_qtest);
     qtest_quit(data->qts);
-- 
2.7.4
