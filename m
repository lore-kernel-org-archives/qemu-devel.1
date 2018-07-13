Received: from eggs.gnu.org ([2001:4830:134:3::10]:41104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpJ-0003sn-9x
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpI-00026f-5z
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpH-00024i-VC
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A50A340122C8
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:08:56 +0200
Message-Id: <20180713130916.4153-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/29] qio: add
 qio_channel_command_new_spawn_with_pre_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new function to let caller do some tuning thanks to a callback
before exec().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/io/channel-command.h | 18 ++++++++++++++++++
 io/channel-command.c         | 33 ++++++++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/include/io/channel-command.h b/include/io/channel-command.h
index 336d47fa5c..96c833daab 100644
--- a/include/io/channel-command.h
+++ b/include/io/channel-command.h
@@ -71,6 +71,24 @@ qio_channel_command_new_pid(int writefd,
                             int readfd,
                             pid_t pid);
=20
+/**
+ * qio_channel_command_new_spawn_with_pre_exec:
+ * @argv: the NULL terminated list of command arguments
+ * @flags: the I/O mode, one of O_RDONLY, O_WRONLY, O_RDWR
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Create a channel for performing I/O with the
+ * command to be spawned with arguments @argv.
+ *
+ * Returns: the command channel object, or NULL on error
+ */
+QIOChannelCommand *
+qio_channel_command_new_spawn_with_pre_exec(const char *const argv[],
+                                            int flags,
+                                            void (*pre_exec_cb)(void *),
+                                            void *data,
+                                            Error **errp);
+
 /**
  * qio_channel_command_new_spawn:
  * @argv: the NULL terminated list of command arguments
diff --git a/io/channel-command.c b/io/channel-command.c
index 3e7eb17eff..05903ff194 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -46,9 +46,12 @@ qio_channel_command_new_pid(int writefd,
=20
 #ifndef WIN32
 QIOChannelCommand *
-qio_channel_command_new_spawn(const char *const argv[],
-                              int flags,
-                              Error **errp)
+qio_channel_command_new_spawn_with_pre_exec(const char *const argv[],
+                                            int flags,
+                                            void (*pre_exec_cb)(void *),
+                                            void *data,
+                                            Error **errp)
+
 {
     pid_t pid =3D -1;
     int stdinfd[2] =3D { -1, -1 };
@@ -104,6 +107,10 @@ qio_channel_command_new_spawn(const char *const argv=
[],
             close(devnull);
         }
=20
+        if (pre_exec_cb) {
+            pre_exec_cb(data);
+        }
+
         execv(argv[0], (char * const *)argv);
         _exit(1);
     }
@@ -139,12 +146,13 @@ qio_channel_command_new_spawn(const char *const arg=
v[],
     }
     return NULL;
 }
-
 #else /* WIN32 */
 QIOChannelCommand *
-qio_channel_command_new_spawn(const char *const argv[],
-                              int flags,
-                              Error **errp)
+qio_channel_command_new_spawn_with_pre_exec(const char *const argv[],
+                                            int flags,
+                                            void (*pre_exec_cb)(void *),
+                                            void *data,
+                                            Error **errp)
 {
     error_setg_errno(errp, ENOSYS,
                      "Command spawn not supported on this platform");
@@ -152,6 +160,17 @@ qio_channel_command_new_spawn(const char *const argv=
[],
 }
 #endif /* WIN32 */
=20
+
+QIOChannelCommand *
+qio_channel_command_new_spawn(const char *const argv[],
+                              int flags,
+                              Error **errp)
+{
+    return qio_channel_command_new_spawn_with_pre_exec(argv, flags,
+                                                       NULL, NULL, errp)=
;
+}
+
+
 #ifndef WIN32
 static int qio_channel_command_abort(QIOChannelCommand *ioc,
                                      Error **errp)
--=20
2.18.0.129.ge3331758f1
