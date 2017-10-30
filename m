Received: from eggs.gnu.org ([2001:4830:134:3::10]:41796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9Ec1-0001yY-8q
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9Ebx-000154-9a
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:16:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 15:14:59 -0300
Message-Id: <20171030181459.1951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

examples configuring with '--enable-kvm --disable-tcg'

- before

  $ qemu-system-x86_64 -accel help
  Possible accelerators: kvm, xen, hax, tcg

  $ qemu-system-x86_64 -accel tcg
  qemu-system-x86_64: -machine accel=tcg: No accelerator found

  # qemu-system-x86_64 -accel hax
  qemu-system-x86_64: -machine accel=hax: No accelerator found

- after

  $ qemu-system-x86_64 -accel help
  Possible accelerators:
    xen
    kvm

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
since RFC:
  - use much cleaner object_class_get_list(TYPE_ACCEL, false)

 vl.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index ec299099ff..0f13641715 100644
--- a/vl.c
+++ b/vl.c
@@ -2764,6 +2764,39 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
     exit(!name || !is_help_option(name));
 }
 
+static void accel_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    const char *typename = object_class_get_name(oc);
+    int len;
+
+    if (!qtest_driver() && !g_strcmp0(typename, ACCEL_CLASS_NAME("qtest"))) {
+        return; /* used by test cases */
+    }
+
+    len = strlen(typename) - strlen("-" TYPE_ACCEL);
+    if (len > 0) {
+        error_printf("  %.*s\n", len, typename);
+    }
+}
+
+static void accel_parse(const char *name, QemuOpts *accel_opts)
+{
+    const char *optarg = qemu_opt_get(accel_opts, "accel");
+    GSList *list;
+
+    if (!is_help_option(optarg)) {
+        return;
+    }
+
+    list = object_class_get_list(TYPE_ACCEL, false);
+    error_printf("Possible accelerators:\n");
+    g_slist_foreach(list, accel_list_entry, NULL);
+    g_slist_free(list);
+
+    exit(0);
+}
+
 void qemu_add_exit_notifier(Notifier *notify)
 {
     notifier_list_add(&exit_notifiers, notify);
@@ -3881,11 +3914,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_accel:
                 accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
                                                      optarg, true);
-                optarg = qemu_opt_get(accel_opts, "accel");
-                if (!optarg || is_help_option(optarg)) {
-                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
-                    exit(0);
-                }
+                accel_parse(optarg, accel_opts);
                 opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
                                         false, &error_abort);
                 qemu_opt_set(opts, "accel", optarg, &error_abort);
-- 
2.15.0.rc2
