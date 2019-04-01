Received: from eggs.gnu.org ([209.51.188.92]:40799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvj-0005NI-FQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvi-0004F8-Gz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hAsvi-0004Ee-9c
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:34 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  1 Apr 2019 11:08:26 +0200
Message-Id: <20190401090827.20793-5-armbru@redhat.com>
In-Reply-To: <20190401090827.20793-1-armbru@redhat.com>
References: <20190401090827.20793-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] vl: Document dependencies hiding in
 global and compat props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, kwolf@redhat.com, imammedo@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index e4d7ad6b85..8c6d06b01d 100644
--- a/vl.c
+++ b/vl.c
@@ -4285,16 +4285,36 @@ int main(int argc, char **argv, char **envp)
     current_machine->maxram_size = maxram_size;
     current_machine->ram_slots = ram_slots;
 
+    /*
+     * Note: uses machine properties such as kernel-irqchip, must run
+     * after machine_set_property().
+     */
     configure_accelerator(current_machine, argv[0]);
 
+    /*
+     * Beware, QOM objects created before this point miss global and
+     * compat properties.
+     *
+     * Global properties get set up by qdev_prop_register_global(),
+     * called from user_register_global_props(), and certain option
+     * desugaring.  Also in CPU feature desugaring (buried in
+     * parse_cpu_model()), which happens below this point, but may
+     * only target the CPU type, which can only be created after
+     * parse_cpu_model() returned the type.
+     *
+     * Machine compat properties: object_set_machine_compat_props().
+     * Accelerator compat props: object_set_accelerator_compat_props(),
+     * called from configure_accelerator().
+     */
+
     if (!qtest_enabled() && machine_class->deprecation_reason) {
         error_report("Machine type '%s' is deprecated: %s",
                      machine_class->name, machine_class->deprecation_reason);
     }
 
     /*
-     * Migration object can only be created after global properties
-     * are applied correctly.
+     * Note: creates a QOM object, must run only after global and
+     * compat properties have been set up.
      */
     migration_object_init();
 
-- 
2.17.2
