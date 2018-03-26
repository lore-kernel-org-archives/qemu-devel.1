Received: from eggs.gnu.org ([2001:4830:134:3::10]:55454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tm0-0006Wh-6m
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlz-0003cZ-Bu
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tlz-0003c1-1D
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:59 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:14 +0200
Message-Id: <20180326150916.9602-37-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 36/38] monitor: start making
 qmp_human_monitor_command() asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This prepares the work for HMP commands to be asynchronous. For now
this will and the return synchronously.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/misc.json |  3 ++-
 monitor.c      | 14 ++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 5636f4a149..04e704eb6c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1307,7 +1307,8 @@
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
-  'returns': 'str' }
+  'returns': 'str',
+  'async': true }
=20
 ##
 # @ObjectPropertyInfo:
diff --git a/monitor.c b/monitor.c
index f7826f5626..e11c0abdca 100644
--- a/monitor.c
+++ b/monitor.c
@@ -637,8 +637,8 @@ static void monitor_data_destroy(Monitor *mon)
     g_queue_free(mon->qmp.qmp_requests);
 }
=20
-char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
-                                int64_t cpu_index, Error **errp)
+void qmp_human_monitor_command(const char *command_line, bool has_cpu_in=
dex,
+                               int64_t cpu_index, QmpReturn *qret)
 {
     char *output =3D NULL;
     Monitor *old_mon, hmp;
@@ -651,15 +651,15 @@ char *qmp_human_monitor_command(const char *command=
_line, bool has_cpu_index,
     if (has_cpu_index) {
         int ret =3D monitor_set_cpu(cpu_index);
         if (ret < 0) {
-            cur_mon =3D old_mon;
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
+            Error *err =3D NULL;
+            error_setg(&err, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
+            qmp_return_error(qret, err);
             goto out;
         }
     }
=20
     handle_hmp_command(&hmp, command_line);
-    cur_mon =3D old_mon;
=20
     qemu_mutex_lock(&hmp.out_lock);
     if (qstring_get_length(hmp.outbuf) > 0) {
@@ -669,9 +669,11 @@ char *qmp_human_monitor_command(const char *command_=
line, bool has_cpu_index,
     }
     qemu_mutex_unlock(&hmp.out_lock);
=20
+    qmp_human_monitor_command_return(qret, output);
+
 out:
     monitor_data_destroy(&hmp);
-    return output;
+    cur_mon =3D old_mon;
 }
=20
 static int compare_cmd(const char *name, const char *list)
--=20
2.17.0.rc1.1.g4c4f2b46a3
