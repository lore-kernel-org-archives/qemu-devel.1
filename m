Received: from eggs.gnu.org ([2001:4830:134:3::10]:51294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG6r-0008IE-Vz
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG6q-0005Fj-Vv
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:28:57 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:48542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG6q-0005Fc-RZ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:28:56 -0500
Received: by mail-qt0-x242.google.com with SMTP id f8so1622771qta.5
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 18:28:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  7 Nov 2017 23:28:23 -0300
Message-Id: <20171108022828.7242-2-f4bug@amsat.org>
In-Reply-To: <20171108022828.7242-1-f4bug@amsat.org>
References: <20171108022828.7242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/6] machine: add a deprecated_reason
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

If a machine has the deprecated_reason property set:
- it won't get listed anymore by the "-M help" command,
- a warning will be displayed if the machine is used.

Example:
  $ ppc-softmmu/qemu-system-ppc -M prep
  qemu-system-ppc: -M prep: warning: The PowerPC PREP platform machine is deprecated (Obsoleted by the "40p" machine)
  [machine starting ...]

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/boards.h | 1 +
 vl.c                | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 191a5b3cd8..4d5c180968 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -182,6 +182,7 @@ struct MachineClass {
     const char *default_boot_order;
     const char *default_display;
     GArray *compat_props;
+    const char *deprecated_reason;
     const char *hw_version;
     ram_addr_t default_ram_size;
     const char *default_cpu_type;
diff --git a/vl.c b/vl.c
index ec299099ff..9ed4648af2 100644
--- a/vl.c
+++ b/vl.c
@@ -2742,6 +2742,10 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
     }
     if (mc) {
         g_slist_free(machines);
+        if (mc->deprecated_reason) {
+            warn_report("The %s machine is deprecated (%s)",
+                        mc->desc, mc->deprecated_reason);
+        }
         return mc;
     }
     if (name && !is_help_option(name)) {
@@ -2752,6 +2756,9 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
         machines = g_slist_sort(machines, machine_class_cmp);
         for (el = machines; el; el = el->next) {
             MachineClass *mc = el->data;
+            if (mc->deprecated_reason) {
+                continue;
+            }
             if (mc->alias) {
                 printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
             }
-- 
2.15.0
