Received: from eggs.gnu.org ([209.51.188.92]:35894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6X-0000GT-Mb
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6V-0004hc-Hd
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6T-0004dp-H7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED8E8307E06D
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9648060A9A
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:34 +0100
Message-Id: <20190311220843.4026-19-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/27] vl: Fix latent bug with -global and
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

main() registers the user's -global only after we create the machine
object, i.e. too late for devices created in the machine's
.instance_init().

Fortunately, we know the bug is only latent: the commit before
previous fixed a bug that would've crashed any attempt to create a
device in an .instance_init().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190308131445.17502-4-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 vl.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/vl.c b/vl.c
index 5278beaae0..4f84d6568f 100644
--- a/vl.c
+++ b/vl.c
@@ -2937,17 +2937,6 @@ static void user_register_global_props(void)
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
@@ -3942,6 +3931,8 @@ int main(int argc, char **argv, char **envp)
      */
     loc_set_none();
=20
+    user_register_global_props();
+
     replay_configure(icount_opts);
=20
     if (incoming && !preconfig_exit_requested) {
@@ -4250,12 +4241,6 @@ int main(int argc, char **argv, char **envp)
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
