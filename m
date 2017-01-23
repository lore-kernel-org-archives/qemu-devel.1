Received: from eggs.gnu.org ([2001:4830:134:3::10]:49051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chaojianhu@hotmail.com>) id 1cVUVF-0007M2-Ty
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chaojianhu@hotmail.com>) id 1cVUVC-0000BQ-Q6
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:37:05 -0500
Received: from bay004-omc4s12.hotmail.com ([65.54.190.214]:53567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chaojianhu@hotmail.com>)
	id 1cVUVC-0000As-Be
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:37:02 -0500
From: Hu Chaojian <chaojianhu@hotmail.com>
Date: Mon, 23 Jan 2017 02:36:58 +0000
Message-ID: <CY1PR17MB03131CCE5DF2F49602956D1BDB720@CY1PR17MB0313.namprd17.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] util/envlist: Fix 2 bugs in envlist_setenv and
 envlist_unsetenv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ppandit@redhat.com" <ppandit@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Hu Chaojian <chaojianhu@hotmail.com>

From: chaojianhu <chaojianhu@hotmail.com>

In envlist_setenv, if any malloc fails, there will be inconsistency on el_c=
ount.

And in envlist_unsetenv, if env is "", the strncmp will be passed, eventual=
ly=20
wrong envlist_entry (shoud be the first one) will be removed.

Finally, in envlist_parse, to delimit environments with ',' is wrong, since=
 value
may contain ','. I suggest delete envlist_parse from the source code.

Reported-by: chaojianhu <chaojianhu@hotmail.com>
Signed-off-by: chaojianhu <chaojianhu@hotmail.com>

---
 util/envlist.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/util/envlist.c b/util/envlist.c
index e86857e..5d68a6a 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -157,9 +157,8 @@ envlist_setenv(envlist_t *envlist, const char *env)
 		QLIST_REMOVE(entry, ev_link);
 		free((char *)entry->ev_var);
 		free(entry);
-	} else {
-		envlist->el_count++;
-	}
+        envlist->el_count--;
+    }
=20
 	if ((entry =3D malloc(sizeof (*entry))) =3D=3D NULL)
 		return (errno);
@@ -168,6 +167,7 @@ envlist_setenv(envlist_t *envlist, const char *env)
 		return (errno);
 	}
 	QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
+    envlist->el_count++;
=20
 	return (0);
 }
@@ -185,6 +185,11 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
 	if ((envlist =3D=3D NULL) || (env =3D=3D NULL))
 		return (EINVAL);
=20
+    envname_len =3D strlen(env);
+    if (0 =3D=3D envname_len) {
+        return -EINVAL;
+    }
+
 	/* env is not allowed to contain '=3D' */
 	if (strchr(env, '=3D') !=3D NULL)
 		return (EINVAL);
@@ -193,7 +198,6 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
 	 * Find out the requested entry and remove
 	 * it from the list.
 	 */
-	envname_len =3D strlen(env);
 	for (entry =3D envlist->el_entries.lh_first; entry !=3D NULL;
 	    entry =3D entry->ev_link.le_next) {
 		if (strncmp(entry->ev_var, env, envname_len) =3D=3D 0)
--=20
1.9.1
