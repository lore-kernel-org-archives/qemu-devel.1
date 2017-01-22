Received: from eggs.gnu.org ([2001:4830:134:3::10]:49815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chaojianhu@hotmail.com>) id 1cVDuw-0001Yw-Mo
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chaojianhu@hotmail.com>) id 1cVDut-000151-IR
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:54:30 -0500
Received: from blu004-omc4s16.hotmail.com ([65.55.111.155]:57118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chaojianhu@hotmail.com>)
	id 1cVDut-00014i-83
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:54:27 -0500
From: Hu Chaojian <chaojianhu@hotmail.com>
Date: Sun, 22 Jan 2017 08:54:23 +0000
Message-ID: <CY1PR17MB031324368F190B92EFA547ACDB730@CY1PR17MB0313.namprd17.prod.outlook.com>
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
wrong envlist_entry (shoud be the first one) will be  removed.

Finally, in envlist_parse, to delimit environments with ',' is wrong, since=
 value
may contain ','. I suggest delete envlist_parse from the source code.

Reported-by: chaojianhu <chaojianhu@hotmail.com>
Signed-off-by: chaojianhu <chaojianhu@hotmail.com>

---
 util/envlist.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/util/envlist.c b/util/envlist.c
index e86857e..327478b 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -130,7 +130,7 @@ envlist_parse(envlist_t *envlist, const char *env,
 int
 envlist_setenv(envlist_t *envlist, const char *env)
 {
-	struct envlist_entry *entry =3D NULL;
+	struct envlist_entry *entry =3D NULL, *entry_old =3D NULL;
 	const char *eq_sign;
 	size_t envname_len;
=20
@@ -147,26 +147,27 @@ envlist_setenv(envlist_t *envlist, const char *env)
 	 * we remove and release it before allocating a whole
 	 * new entry.
 	 */
-	for (entry =3D envlist->el_entries.lh_first; entry !=3D NULL;
-	    entry =3D entry->ev_link.le_next) {
-		if (strncmp(entry->ev_var, env, envname_len) =3D=3D 0)
+	for (entry_old =3D envlist->el_entries.lh_first; entry_old !=3D NULL;
+	    entry_old =3D entry_old->ev_link.le_next) {
+		if (strncmp(entry_old->ev_var, env, envname_len) =3D=3D 0)
 			break;
 	}
=20
-	if (entry !=3D NULL) {
-		QLIST_REMOVE(entry, ev_link);
-		free((char *)entry->ev_var);
-		free(entry);
-	} else {
-		envlist->el_count++;
-	}
-
 	if ((entry =3D malloc(sizeof (*entry))) =3D=3D NULL)
 		return (errno);
 	if ((entry->ev_var =3D strdup(env)) =3D=3D NULL) {
 		free(entry);
 		return (errno);
 	}
+
+	if (entry_old !=3D NULL) {
+		QLIST_REMOVE(entry_old, ev_link);
+		free((char *)entry_old->ev_var);
+		free(entry_old);
+	} else {
+		envlist->el_count++;
+	}
+
 	QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
=20
 	return (0);
@@ -185,6 +186,10 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
 	if ((envlist =3D=3D NULL) || (env =3D=3D NULL))
 		return (EINVAL);
=20
+	envname_len =3D strlen(env);
+	if(0 =3D=3D envname_len)
+		return (EINVAL);
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
