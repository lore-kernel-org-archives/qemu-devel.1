Received: from eggs.gnu.org ([209.51.188.92]:55828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLk-0003Uk-TB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLk-0005Cf-02
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLj-0005C0-Jt
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:51 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:10:07 +0200
Message-Id: <20190409161009.6322-19-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 18/20] monitor: start making
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
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This prepares the work for HMP commands to be asynchronous.

Start making QMP human-monitor-command asynchronous, although
QmpReturn is used synchronously on error or after
handle_hmp_command().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/misc.json |  3 ++-
 monitor.c      | 14 ++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..f8fd4824fb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1344,7 +1344,8 @@
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
index 76bc2f8c7c..477ccd852d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -743,8 +743,8 @@ static void monitor_data_destroy(Monitor *mon)
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
@@ -757,15 +757,15 @@ char *qmp_human_monitor_command(const char *command=
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
     qemu_mutex_lock(&hmp.mon_lock);
     if (qstring_get_length(hmp.outbuf) > 0) {
@@ -775,9 +775,11 @@ char *qmp_human_monitor_command(const char *command_=
line, bool has_cpu_index,
     }
     qemu_mutex_unlock(&hmp.mon_lock);
=20
+    qmp_human_monitor_command_return(qret, output);
+
 out:
+    cur_mon =3D old_mon;
     monitor_data_destroy(&hmp);
-    return output;
 }
=20
 static int compare_cmd(const char *name, const char *list)
--=20
2.21.0.196.g041f5ea1cf
