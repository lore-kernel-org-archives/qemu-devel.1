Received: from eggs.gnu.org ([2001:4830:134:3::10]:55630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eAbm4-0002V4-0k
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eAbm0-0001wX-OL
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:12:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eAbm0-0001wI-GI
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:12:36 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  3 Nov 2017 21:12:29 +0800
Message-Id: <20171103131229.4737-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docker: Improved image checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

When a base image locally defined by QEMU, such as in the debian images,
is updated, the dockerfile checksum mechanism in docker.py still skips
updating the derived image, because it only looks at the literal content
of the dockerfile, without considering changes to the base image.

For example we have a recent fix e58c1f9b35e81 that fixed
debian-win64-cross by updating its base image, debian8-mxe, but due to
above "feature" of docker.py the image in question is automatically NOT
rebuilt unless you add NOCACHE=3D1. It is noticed on Shippable:

https://app.shippable.com/github/qemu/qemu/runs/541/2/console

because after the fix is merged, the error still occurs, and the log
shows the container image is, as explained above, not updated.

This is because at the time docker.py was written, there wasn't any
dependencies between QEMU's docker images.

Now improve this to preprocess any "FROM qemu:*" directives in the
dockerfiles while doing checksum, and inline the base image's dockerfile
content, recursively. This ensures any changes on the depended _QEMU_
images are taken into account.

This means for external images that we expect to retrieve from docker
registries, we still do it as before. It is not perfect, because
registry images can get updated too. Technically we could substitute the
image name with its hex ID as obtained with $(docker images $IMAGE
--format=3D"{{.Id}}"), but --format is not supported by RHEL 7, so leave
it for now.

Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 08122ca17d..1246ba9578 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -105,6 +105,28 @@ def _copy_binary_with_libs(src, dest_dir):
             so_path =3D os.path.dirname(l)
             _copy_with_mkdir(l , dest_dir, so_path)
=20
+def _read_qemu_dockerfile(img_name):
+    df =3D os.path.join(os.path.dirname(__file__), "dockerfiles",
+                      img_name + ".docker")
+    return open(df, "r").read()
+
+def _dockerfile_preprocess(df):
+    out =3D ""
+    for l in df.splitlines():
+        if len(l.strip()) =3D=3D 0 or l.startswith("#"):
+            continue
+        from_pref =3D "FROM qemu:"
+        if l.startswith(from_pref):
+            # TODO: Alternatively we could replace this line with "FROM =
$ID"
+            # where $ID is the image's hex id obtained with
+            #    $ docker images $IMAGE --format=3D"{{.Id}}"
+            # but unfortunately that's not supported by RHEL 7.
+            inlining =3D _read_qemu_dockerfile(l[len(from_pref):])
+            out +=3D _dockerfile_preprocess(inlining)
+            continue
+        out +=3D l + "\n"
+    return out
+
 class Docker(object):
     """ Running Docker commands """
     def __init__(self):
@@ -196,7 +218,7 @@ class Docker(object):
             checksum =3D self.get_image_dockerfile_checksum(tag)
         except Exception:
             return False
-        return checksum =3D=3D _text_checksum(dockerfile)
+        return checksum =3D=3D _text_checksum(_dockerfile_preprocess(doc=
kerfile))
=20
     def run(self, cmd, keep, quiet):
         label =3D uuid.uuid1().hex
--=20
2.13.6
