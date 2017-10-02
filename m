Received: from eggs.gnu.org ([2001:4830:134:3::10]:46820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiC-0001wo-P3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywi8-0005wI-NN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywi8-0005vk-HO
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:24 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:43 +0200
Message-Id: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 01/38] qom: add helper type_init_from_array()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, ehabkost@redhat.com
List-ID: <qemu-devel.nongnu.org>

it will help to remove code duplication in places
that currently open code registration of several
types.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
I'm going to use it for CPU types in followup patches

CC: ehabkost@redhat.com
---
 include/qemu/module.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 56dd218..29f9089 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -52,6 +52,16 @@ typedef enum {
 #define type_init(function) module_init(function, MODULE_INIT_QOM)
 #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
 
+#define type_init_from_array(array)                                        \
+static void do_qemu_init_ ## array(void)                                   \
+{                                                                          \
+    int i;                                                                 \
+    for (i = 0; i < ARRAY_SIZE(array); i++) {                              \
+        type_register_static(&array[i]);                                   \
+    }                                                                      \
+}                                                                          \
+module_init(do_qemu_init_ ## array, MODULE_INIT_QOM)
+
 #define block_module_load_one(lib) module_load_one("block-", lib)
 
 void register_module_init(void (*fn)(void), module_init_type type);
-- 
2.7.4
