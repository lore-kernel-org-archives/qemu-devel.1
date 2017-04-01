Received: from eggs.gnu.org ([2001:4830:134:3::10]:56295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu7n7-0001Ta-MK
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu7n6-0005Rc-MY
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:25:21 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 31 Mar 2017 21:25:08 -0400
Message-Id: <20170401012508.24665-4-jcody@redhat.com>
In-Reply-To: <20170401012508.24665-1-jcody@redhat.com>
References: <20170401012508.24665-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 3/3] block/curl: Check protocol prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

If the user has explicitly specified a block driver and thus a protocol,
we have to make sure the URL's protocol prefix matches. Otherwise the
latter will silently override the former which might catch some users by
surprise.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170331120431.1767-3-mreitz@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/curl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 34dbd33..2708d57 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -659,6 +659,7 @@ static int curl_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     const char *cookie;
     double d;
     const char *secretid;
+    const char *protocol_delimiter;
=20
     static int inited =3D 0;
=20
@@ -700,6 +701,15 @@ static int curl_open(BlockDriverState *bs, QDict *op=
tions, int flags,
         goto out_noclean;
     }
=20
+    if (!strstart(file, bs->drv->protocol_name, &protocol_delimiter) ||
+        !strstart(protocol_delimiter, "://", NULL))
+    {
+        error_setg(errp, "%s curl driver cannot handle the URL '%s' (doe=
s not "
+                   "start with '%s://')", bs->drv->protocol_name, file,
+                   bs->drv->protocol_name);
+        goto out_noclean;
+    }
+
     s->username =3D g_strdup(qemu_opt_get(opts, CURL_BLOCK_OPT_USERNAME)=
);
     secretid =3D qemu_opt_get(opts, CURL_BLOCK_OPT_PASSWORD_SECRET);
=20
--=20
2.9.3
