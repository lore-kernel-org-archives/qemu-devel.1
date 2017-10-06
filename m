Received: from eggs.gnu.org ([2001:4830:134:3::10]:41740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQ1-0008TY-GQ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQ0-0005wr-Ji
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:31 -0300
Message-Id: <20171006235023.11952-37-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 36/88] SLIRP: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added net/slirp.c]
---
 net/slirp.c    | 4 ++--
 slirp/slirp.c  | 2 +-
 slirp/socket.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 318a26e892..c42e1fd0d0 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -869,7 +869,7 @@ net_init_slirp_configs(const StringList *fwd, int flags)
     while (fwd) {
         struct slirp_config_str *config;
 
-        config = g_malloc0(sizeof(*config));
+        config = g_new0(struct slirp_config_str, 1);
         pstrcpy(config->str, sizeof(config->str), fwd->value->str);
         config->flags = flags;
         config->next = slirp_configs;
@@ -973,7 +973,7 @@ int net_slirp_parse_legacy(QemuOptsList *opts_list, const char *optarg, int *ret
     if (QTAILQ_EMPTY(&slirp_stacks)) {
         struct slirp_config_str *config;
 
-        config = g_malloc(sizeof(*config));
+        config = g_new(struct slirp_config_str, 1);
         pstrcpy(config->str, sizeof(config->str), optarg);
         config->flags = SLIRP_CFG_LEGACY;
         config->next = slirp_configs;
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 1cb6b07004..9af9179afa 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -288,7 +288,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   struct in6_addr vnameserver6, const char **vdnssearch,
                   void *opaque)
 {
-    Slirp *slirp = g_malloc0(sizeof(Slirp));
+    Slirp *slirp = g_new0(Slirp, 1);
 
     slirp_init_once();
 
diff --git a/slirp/socket.c b/slirp/socket.c
index cb7b5b608d..2eccb68c2e 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -48,7 +48,7 @@ socreate(Slirp *slirp)
 {
   struct socket *so;
 
-  so = (struct socket *)malloc(sizeof(struct socket));
+  so = g_new(struct socket, 1);
   if(so) {
     memset(so, 0, sizeof(struct socket));
     so->so_state = SS_NOFDREF;
-- 
2.14.2
