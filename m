Received: from eggs.gnu.org ([209.51.188.92]:35921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ggSGo-0003Uu-GC
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ggSGn-00058h-Nu
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:36:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ggSGn-000581-In
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:36:33 -0500
From: P J P <ppandit@redhat.com>
Date: Mon,  7 Jan 2019 16:04:26 +0530
Message-Id: <20190107103426.2669-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qga: check length of command-line &
 environment variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, niuguoxiang <niuguoxiang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Qemu guest agent while executing user commands does not seem to
check length of argument list and/or environment variables passed.
It may lead to integer overflow or infinite loop issues. Add check
to avoid it.

Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 qga/commands.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index 0c7d1385c2..6d684ef209 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -231,17 +231,22 @@ static char **guest_exec_get_args(const strList *en=
try, bool log)
     int count =3D 1, i =3D 0;  /* reserve for NULL terminator */
     char **args;
     char *str; /* for logging array of arguments */
-    size_t str_size =3D 1;
+    size_t str_size =3D 1, args_max;
=20
+    args_max =3D sysconf(_SC_ARG_MAX);
     for (it =3D entry; it !=3D NULL; it =3D it->next) {
         count++;
         str_size +=3D 1 + strlen(it->value);
+        if (str_size >=3D args_max / 2
+            || count >=3D args_max / sizeof(char *)) {
+            break;
+        }
     }
=20
     str =3D g_malloc(str_size);
     *str =3D 0;
     args =3D g_malloc(count * sizeof(char *));
-    for (it =3D entry; it !=3D NULL; it =3D it->next) {
+    for (it =3D entry; it !=3D NULL && i < count; it =3D it->next) {
         args[i++] =3D it->value;
         pstrcat(str, str_size, it->value);
         if (it->next) {
--=20
2.20.1
