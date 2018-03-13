Received: from eggs.gnu.org ([2001:4830:134:3::10]:54366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evj47-0004Td-0k
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evj46-0003mL-4c
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:30:03 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 13 Mar 2018 08:29:56 -0400
Message-Id: <20180313122956.21442-2-jcody@redhat.com>
In-Reply-To: <20180313122956.21442-1-jcody@redhat.com>
References: <20180313122956.21442-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] block: include original filename when
 reporting invalid URIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Consider passing a JSON based block driver to "qemu-img commit"

$ qemu-img commit 'json:{"driver":"qcow2","file":{"driver":"gluster",\
                  "volume":"gv0","path":"sn1.qcow2",
                  "server":[{"type":\
		  "tcp","host":"10.73.199.197","port":"24007"}]},}'

Currently it will commit the content and then report an incredibly
useless error message when trying to re-open the committed image:

  qemu-img: invalid URI
  Usage: file=3Dgluster[+transport]://[host[:port]]volume/path[?socket=3D=
...][,file.debug=3DN][,file.logfile=3D/path/filename.log]

With this fix we get:

  qemu-img: invalid URI json:{"server.0.host": "10.73.199.197",
      "driver": "gluster", "path": "luks.qcow2", "server.0.type":
      "tcp", "server.0.port": "24007", "volume": "gv0"}

Of course the root cause problem still exists, but now we know
what actually needs fixing.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180206105204.14817-1-berrange@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/gluster.c  | 2 +-
 block/sheepdog.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 63d3c37d4c..296e036b3d 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -665,7 +665,7 @@ static int qemu_gluster_parse(BlockdevOptionsGluster =
*gconf,
     if (filename) {
         ret =3D qemu_gluster_parse_uri(gconf, filename);
         if (ret < 0) {
-            error_setg(errp, "invalid URI");
+            error_setg(errp, "invalid URI %s", filename);
             error_append_hint(errp, "Usage: file=3Dgluster[+transport]:/=
/"
                                     "[host[:port]]volume/path[?socket=3D=
...]"
                                     "[,file.debug=3DN]"
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 8680b2926f..797ea5953b 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1036,7 +1036,7 @@ static void sd_parse_uri(SheepdogConfig *cfg, const=
 char *filename,
=20
     cfg->uri =3D uri =3D uri_parse(filename);
     if (!uri) {
-        error_setg(&err, "invalid URI");
+        error_setg(&err, "invalid URI '%s'", filename);
         goto out;
     }
=20
--=20
2.13.6
