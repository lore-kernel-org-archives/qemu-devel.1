Received: from eggs.gnu.org ([2001:4830:134:3::10]:54704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du42q-0002VA-S9
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 17:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du42m-0007qi-OE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 17:57:36 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du42m-0007qV-JZ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 17:57:32 -0400
Received: by mail-qk0-x241.google.com with SMTP id r66so1176452qke.4
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 14:57:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Sep 2017 18:57:19 -0300
Message-Id: <20170918215719.16415-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] vl.c: add is_system_on_chip flag to force
 board default cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

add a property to restrict the CPU for SoCs once on machine creation and avoid
duplicate code in each board.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: 1505318697-77161-6-git-send-email-imammedo@redhat.com

 include/hw/boards.h |  3 +++
 vl.c                | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6b67adaef6..20dc0a0ab9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -129,6 +129,8 @@ typedef struct {
  *    specifies default CPU_TYPE, which will be used for parsing target
  *    specific features and for creating CPUs if CPU name wasn't provided
  *    explicitly at CLI
+ * @is_system_on_chip:
+ *    If true, board does not support other CPUs than default_cpu_type.
  * @minimum_page_bits:
  *    If non-zero, the board promises never to create a CPU with a page size
  *    smaller than this, so QEMU can use a more efficient larger page
@@ -182,6 +184,7 @@ struct MachineClass {
     const char *hw_version;
     ram_addr_t default_ram_size;
     const char *default_cpu_type;
+    bool is_system_on_chip;
     bool option_rom_has_mr;
     bool rom_file_has_mr;
     int minimum_page_bits;
diff --git a/vl.c b/vl.c
index fb6a700e55..6e59ffa856 100644
--- a/vl.c
+++ b/vl.c
@@ -4717,10 +4717,21 @@ int main(int argc, char **argv, char **envp)
     current_machine->cpu_model = cpu_model;
 
 
+    if (machine_class->is_system_on_chip && !machine_class->default_cpu_type) {
+        error_report("System-on-Chip must have a default CPU type");
+        exit(1);
+    }
     /* parse features once if machine provides default cpu_type */
     if (machine_class->default_cpu_type) {
         current_machine->cpu_type = machine_class->default_cpu_type;
         if (cpu_model) {
+            if (machine_class->is_system_on_chip) {
+                if (strcmp(cpu_model, machine_class->default_cpu_type) != 0) {
+                    error_report("This board can only be used with CPU %s",
+                                 machine_class->default_cpu_type);
+                    exit(1);
+                }
+            }
             current_machine->cpu_type =
                 cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
         }
-- 
2.14.1
