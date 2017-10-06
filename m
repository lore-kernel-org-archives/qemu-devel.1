Received: from eggs.gnu.org ([2001:4830:134:3::10]:43051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRj-0001cZ-92
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRi-0007Na-4N
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:00 -0300
Message-Id: <20171006235023.11952-66-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 65/88] util: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: more changes in util/envlist.c, more files updated]
---
 util/acl.c         | 6 +++---
 util/envlist.c     | 6 +++---
 util/error.c       | 2 +-
 util/iohandler.c   | 2 +-
 util/module.c      | 4 ++--
 util/qemu-option.c | 8 ++++----
 util/qht.c         | 2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/util/acl.c b/util/acl.c
index c105addadc..f5d8295fe2 100644
--- a/util/acl.c
+++ b/util/acl.c
@@ -56,7 +56,7 @@ qemu_acl *qemu_acl_init(const char *aclname)
     if (acl)
         return acl;
 
-    acl = g_malloc(sizeof(*acl));
+    acl = g_new(qemu_acl, 1);
     acl->aclname = g_strdup(aclname);
     /* Deny by default, so there is no window of "open
      * access" between QEMU starting, and the user setting
@@ -117,7 +117,7 @@ int qemu_acl_append(qemu_acl *acl,
 {
     qemu_acl_entry *entry;
 
-    entry = g_malloc(sizeof(*entry));
+    entry = g_new(qemu_acl_entry, 1);
     entry->match = g_strdup(match);
     entry->deny = deny;
 
@@ -146,7 +146,7 @@ int qemu_acl_insert(qemu_acl *acl,
         i++;
         if (i == index) {
             qemu_acl_entry *entry;
-            entry = g_malloc(sizeof(*entry));
+            entry = g_new(qemu_acl_entry, 1);
             entry->match = g_strdup(match);
             entry->deny = deny;
 
diff --git a/util/envlist.c b/util/envlist.c
index 1eeb7fca87..5934095b7d 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -24,7 +24,7 @@ envlist_create(void)
 {
 	envlist_t *envlist;
 
-	envlist = g_malloc(sizeof(*envlist));
+	envlist = g_new(envlist_t, 1);
 
 	QLIST_INIT(&envlist->el_entries);
 	envlist->el_count = 0;
@@ -158,7 +158,7 @@ envlist_setenv(envlist_t *envlist, const char *env)
 		envlist->el_count++;
 	}
 
-	entry = g_malloc(sizeof(*entry));
+	entry = g_new(struct envlist_entry, 1);
 	entry->ev_var = g_strdup(env);
 	QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
 
@@ -218,7 +218,7 @@ envlist_to_environ(const envlist_t *envlist, size_t *count)
 	struct envlist_entry *entry;
 	char **env, **penv;
 
-	penv = env = g_malloc((envlist->el_count + 1) * sizeof(char *));
+	penv = env = g_new(char *, envlist->el_count + 1);
 
 	for (entry = envlist->el_entries.lh_first; entry != NULL;
 	    entry = entry->ev_link.le_next) {
diff --git a/util/error.c b/util/error.c
index 3efdd69162..cfb829b1f8 100644
--- a/util/error.c
+++ b/util/error.c
@@ -56,7 +56,7 @@ static void error_setv(Error **errp,
     }
     assert(*errp == NULL);
 
-    err = g_malloc0(sizeof(*err));
+    err = g_new0(Error, 1);
     err->msg = g_strdup_vprintf(fmt, ap);
     if (suffix) {
         char *msg = err->msg;
diff --git a/util/iohandler.c b/util/iohandler.c
index 623b55b9ec..518922dcea 100644
--- a/util/iohandler.c
+++ b/util/iohandler.c
@@ -128,7 +128,7 @@ int qemu_add_child_watch(pid_t pid)
             return 1;
         }
     }
-    rec = g_malloc0(sizeof(ChildProcessRecord));
+    rec = g_new0(ChildProcessRecord, 1);
     rec->pid = pid;
     QLIST_INSERT_HEAD(&child_watches, rec, next);
     return 0;
diff --git a/util/module.c b/util/module.c
index c90973721f..1533dbdc63 100644
--- a/util/module.c
+++ b/util/module.c
@@ -65,7 +65,7 @@ void register_module_init(void (*fn)(void), module_init_type type)
     ModuleEntry *e;
     ModuleTypeList *l;
 
-    e = g_malloc0(sizeof(*e));
+    e = g_new0(ModuleEntry, 1);
     e->init = fn;
     e->type = type;
 
@@ -80,7 +80,7 @@ void register_dso_module_init(void (*fn)(void), module_init_type type)
 
     init_lists();
 
-    e = g_malloc0(sizeof(*e));
+    e = g_new0(ModuleEntry, 1);
     e->init = fn;
     e->type = type;
 
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 9b1dc8093b..8a121bfc40 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -534,7 +534,7 @@ static void opt_set(QemuOpts *opts, const char *name, const char *value,
         return;
     }
 
-    opt = g_malloc0(sizeof(*opt));
+    opt = g_new0(QemuOpt, 1);
     opt->name = g_strdup(name);
     opt->opts = opts;
     if (prepend) {
@@ -564,7 +564,7 @@ void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
     QemuOpt *opt;
     const QemuOptDesc *desc = opts->list->desc;
 
-    opt = g_malloc0(sizeof(*opt));
+    opt = g_new0(QemuOpt, 1);
     opt->desc = find_desc_by_name(desc, name);
     if (!opt->desc && !opts_accepts_any(opts)) {
         error_setg(errp, QERR_INVALID_PARAMETER, name);
@@ -585,7 +585,7 @@ void qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
     QemuOpt *opt;
     const QemuOptDesc *desc = opts->list->desc;
 
-    opt = g_malloc0(sizeof(*opt));
+    opt = g_new0(QemuOpt, 1);
     opt->desc = find_desc_by_name(desc, name);
     if (!opt->desc && !opts_accepts_any(opts)) {
         error_setg(errp, QERR_INVALID_PARAMETER, name);
@@ -665,7 +665,7 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
             return opts;
         }
     }
-    opts = g_malloc0(sizeof(*opts));
+    opts = g_new0(QemuOpts, 1);
     opts->id = g_strdup(id);
     opts->list = list;
     loc_save(&opts->loc);
diff --git a/util/qht.c b/util/qht.c
index ff4d2e6974..c5d153d573 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -331,7 +331,7 @@ static struct qht_map *qht_map_create(size_t n_buckets)
     struct qht_map *map;
     size_t i;
 
-    map = g_malloc(sizeof(*map));
+    map = g_new(struct qht_map, 1);
     map->n_buckets = n_buckets;
 
     map->n_added_buckets = 0;
-- 
2.14.2
