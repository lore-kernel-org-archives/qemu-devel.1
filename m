Received: from eggs.gnu.org ([2001:4830:134:3::10]:41781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOz0-0004qI-2I
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOyy-00049x-DC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOyy-000498-7Q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:39 -0300
Message-Id: <20170919201850.14772-2-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/12] vl: Clean up user-creatable objects when
 exiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Delete all user-creatable objects in /objects when exiting QEMU, so they
can perform cleanup actions.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170824192315.5897-2-ehabkost@redhat.com>
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Zack Cornelius <zack.cornelius@kove.net>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object_interfaces.h | 8 ++++++++
 qom/object_interfaces.c         | 5 +++++
 vl.c                            | 1 +
 3 files changed, 14 insertions(+)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfa=
ces.h
index d63c1c28f8..d23e11bc53 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -147,4 +147,12 @@ int user_creatable_add_opts_foreach(void *opaque,
  */
 void user_creatable_del(const char *id, Error **errp);
=20
+/**
+ * user_creatable_cleanup:
+ *
+ * Delete all user-creatable objects and the user-creatable
+ * objects container.
+ */
+void user_creatable_cleanup(void);
+
 #endif
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 3bb8959f09..6824a88caa 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -193,6 +193,11 @@ void user_creatable_del(const char *id, Error **errp=
)
     object_unparent(obj);
 }
=20
+void user_creatable_cleanup(void)
+{
+    object_unparent(object_get_objects_root());
+}
+
 static void register_types(void)
 {
     static const TypeInfo uc_interface_info =3D {
diff --git a/vl.c b/vl.c
index 9e62e92aea..ad49314608 100644
--- a/vl.c
+++ b/vl.c
@@ -4887,6 +4887,7 @@ int main(int argc, char **argv, char **envp)
     audio_cleanup();
     monitor_cleanup();
     qemu_chr_cleanup();
+    user_creatable_cleanup();
     /* TODO: unref root container, check all devices are ok */
=20
     return 0;
--=20
2.13.5
