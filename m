Received: from eggs.gnu.org ([2001:4830:134:3::10]:54089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GJj-0005jM-54
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GJg-0000Hz-7u
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:09:19 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:12 +0300
Message-Id: <ec45bbe5f1921c6553fbf9c0c76b358b0403c22d.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/23] util: Use g_malloc/g_free in envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Saurav Sachidanand <sauravsachidanand@gmail.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Saurav Sachidanand <sauravsachidanand@gmail.com>

Change malloc/strdup/free to g_malloc/g_strdup/g_free in
util/envlist.c.

Remove NULL checks for pointers returned from g_malloc and g_strdup
as they exit in case of failure. Also, update calls to envlist_create
to reflect this.

Free array and array contents returned by envlist_to_environ using
g_free in bsd-user/main.c and linux-user/main.c.

Update comments to reflect change in semantics.

Signed-off-by: Saurav Sachidanand <sauravsachidanand@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 bsd-user/main.c   | 14 ++++----------
 linux-user/main.c |  9 +++------
 util/envlist.c    | 47 +++++++++++++++++++----------------------------
 3 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 714a692e6f..04f95ddd54 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -744,10 +744,7 @@ int main(int argc, char **argv)
     qemu_init_cpu_list();
     module_call_init(MODULE_INIT_QOM);
=20
-    if ((envlist =3D envlist_create()) =3D=3D NULL) {
-        (void) fprintf(stderr, "Unable to allocate envlist\n");
-        exit(1);
-    }
+    envlist =3D envlist_create();
=20
     /* add current environment into the list */
     for (wrk =3D environ; *wrk !=3D NULL; wrk++) {
@@ -785,10 +782,7 @@ int main(int argc, char **argv)
                 usage();
         } else if (!strcmp(r, "ignore-environment")) {
             envlist_free(envlist);
-            if ((envlist =3D envlist_create()) =3D=3D NULL) {
-                (void) fprintf(stderr, "Unable to allocate envlist\n");
-                exit(1);
-            }
+            envlist =3D envlist_create();
         } else if (!strcmp(r, "U")) {
             r =3D argv[optind++];
             if (envlist_unsetenv(envlist, r) !=3D 0)
@@ -956,10 +950,10 @@ int main(int argc, char **argv)
     }
=20
     for (wrk =3D target_environ; *wrk; wrk++) {
-        free(*wrk);
+        g_free(*wrk);
     }
=20
-    free(target_environ);
+    g_free(target_environ);
=20
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         qemu_log("guest_base  0x%lx\n", guest_base);
diff --git a/linux-user/main.c b/linux-user/main.c
index 10a3bb3a12..5f20769cb9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4229,10 +4229,7 @@ int main(int argc, char **argv, char **envp)
     qemu_init_cpu_list();
     module_call_init(MODULE_INIT_QOM);
=20
-    if ((envlist =3D envlist_create()) =3D=3D NULL) {
-        (void) fprintf(stderr, "Unable to allocate envlist\n");
-        exit(EXIT_FAILURE);
-    }
+    envlist =3D envlist_create();
=20
     /* add current environment into the list */
     for (wrk =3D environ; *wrk !=3D NULL; wrk++) {
@@ -4429,10 +4426,10 @@ int main(int argc, char **argv, char **envp)
     }
=20
     for (wrk =3D target_environ; *wrk; wrk++) {
-        free(*wrk);
+        g_free(*wrk);
     }
=20
-    free(target_environ);
+    g_free(target_environ);
=20
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         qemu_log("guest_base  0x%lx\n", guest_base);
diff --git a/util/envlist.c b/util/envlist.c
index e86857e70a..1eeb7fca87 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -17,16 +17,14 @@ static int envlist_parse(envlist_t *envlist,
     const char *env, int (*)(envlist_t *, const char *));
=20
 /*
- * Allocates new envlist and returns pointer to that or
- * NULL in case of error.
+ * Allocates new envlist and returns pointer to it.
  */
 envlist_t *
 envlist_create(void)
 {
 	envlist_t *envlist;
=20
-	if ((envlist =3D malloc(sizeof (*envlist))) =3D=3D NULL)
-		return (NULL);
+	envlist =3D g_malloc(sizeof(*envlist));
=20
 	QLIST_INIT(&envlist->el_entries);
 	envlist->el_count =3D 0;
@@ -48,10 +46,10 @@ envlist_free(envlist_t *envlist)
 		entry =3D envlist->el_entries.lh_first;
 		QLIST_REMOVE(entry, ev_link);
=20
-		free((char *)entry->ev_var);
-		free(entry);
+		g_free((char *)entry->ev_var);
+		g_free(entry);
 	}
-	free(envlist);
+	g_free(envlist);
 }
=20
 /*
@@ -101,8 +99,7 @@ envlist_parse(envlist_t *envlist, const char *env,
 	if ((envlist =3D=3D NULL) || (env =3D=3D NULL))
 		return (EINVAL);
=20
-	if ((tmpenv =3D strdup(env)) =3D=3D NULL)
-		return (errno);
+	tmpenv =3D g_strdup(env);
     envsave =3D tmpenv;
=20
     do {
@@ -117,7 +114,7 @@ envlist_parse(envlist_t *envlist, const char *env,
         tmpenv =3D envvar + 1;
     } while (envvar !=3D NULL);
=20
-    free(envsave);
+    g_free(envsave);
     return ret;
 }
=20
@@ -155,18 +152,14 @@ envlist_setenv(envlist_t *envlist, const char *env)
=20
 	if (entry !=3D NULL) {
 		QLIST_REMOVE(entry, ev_link);
-		free((char *)entry->ev_var);
-		free(entry);
+		g_free((char *)entry->ev_var);
+		g_free(entry);
 	} else {
 		envlist->el_count++;
 	}
=20
-	if ((entry =3D malloc(sizeof (*entry))) =3D=3D NULL)
-		return (errno);
-	if ((entry->ev_var =3D strdup(env)) =3D=3D NULL) {
-		free(entry);
-		return (errno);
-	}
+	entry =3D g_malloc(sizeof(*entry));
+	entry->ev_var =3D g_strdup(env);
 	QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
=20
 	return (0);
@@ -201,8 +194,8 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
 	}
 	if (entry !=3D NULL) {
 		QLIST_REMOVE(entry, ev_link);
-		free((char *)entry->ev_var);
-		free(entry);
+		g_free((char *)entry->ev_var);
+		g_free(entry);
=20
 		envlist->el_count--;
 	}
@@ -212,12 +205,12 @@ envlist_unsetenv(envlist_t *envlist, const char *en=
v)
 /*
  * Returns given envlist as array of strings (in same form that
  * global variable environ is).  Caller must free returned memory
- * by calling free(3) for each element and for the array.  Returned
- * array and given envlist are not related (no common references).
+ * by calling g_free for each element and the array.
+ * Returned array and given envlist are not related (no common
+ * references).
  *
  * If caller provides count pointer, number of items in array is
- * stored there.  In case of error, NULL is returned and no memory
- * is allocated.
+ * stored there.
  */
 char **
 envlist_to_environ(const envlist_t *envlist, size_t *count)
@@ -225,13 +218,11 @@ envlist_to_environ(const envlist_t *envlist, size_t=
 *count)
 	struct envlist_entry *entry;
 	char **env, **penv;
=20
-	penv =3D env =3D malloc((envlist->el_count + 1) * sizeof (char *));
-	if (env =3D=3D NULL)
-		return (NULL);
+	penv =3D env =3D g_malloc((envlist->el_count + 1) * sizeof(char *));
=20
 	for (entry =3D envlist->el_entries.lh_first; entry !=3D NULL;
 	    entry =3D entry->ev_link.le_next) {
-		*(penv++) =3D strdup(entry->ev_var);
+		*(penv++) =3D g_strdup(entry->ev_var);
 	}
 	*penv =3D NULL; /* NULL terminate the list */
=20
--=20
2.11.0
