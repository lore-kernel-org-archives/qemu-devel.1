Received: from eggs.gnu.org ([209.51.188.92]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FL6-0004nT-8o
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FL2-0006Lb-Gn
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:03 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 14:14:36 +0100
Message-Id: <20190308131445.17502-4-armbru@redhat.com>
In-Reply-To: <20190308131445.17502-1-armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/12] vl: Fix latent bug with -global and
 onboard devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

main() registers the user's -global only after we create the machine
object, i.e. too late for devices created in the machine's
.instance_init().

Fortunately, we know the bug is only latent: the commit before
previous fixed a bug that would've crashed any attempt to create a
device in an .instance_init().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/vl.c b/vl.c
index 712b92d707..b6368662e0 100644
--- a/vl.c
+++ b/vl.c
@@ -2939,17 +2939,6 @@ static void user_register_global_props(void)
                       global_init_func, NULL, NULL);
 }
=20
-/*
- * Note: we should see that these properties are actually having a
- * priority: accel < machine < user. This means e.g. when user
- * specifies something in "-global", it'll always be used with highest
- * priority than either machine/accelerator compat properties.
- */
-static void register_global_properties(MachineState *ms)
-{
-    user_register_global_props();
-}
-
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -3944,6 +3933,8 @@ int main(int argc, char **argv, char **envp)
      */
     loc_set_none();
=20
+    user_register_global_props();
+
     replay_configure(icount_opts);
=20
     if (incoming && !preconfig_exit_requested) {
@@ -4252,12 +4243,6 @@ int main(int argc, char **argv, char **envp)
                      machine_class->name, machine_class->deprecation_rea=
son);
     }
=20
-    /*
-     * Register all the global properties, including accel properties,
-     * machine properties, and user-specified ones.
-     */
-    register_global_properties(current_machine);
-
     /*
      * Migration object can only be created after global properties
      * are applied correctly.
--=20
2.17.2
