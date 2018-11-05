Received: from eggs.gnu.org ([2001:4830:134:3::10]:50274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtC-0006q3-OF
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJht6-0002ts-1Z
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:09 +0100
Message-Id: <20181105163744.25139-2-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/36] block/vvfat: Fix crash when reporting
 error about too many files in directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

When using the vvfat driver with a directory that contains too many files=
,
QEMU currently crashes. This can be triggered like this for example:

 mkdir /tmp/vvfattest
 cd /tmp/vvfattest
 for ((x=3D0;x<=3D513;x++)); do mkdir $x; done
 qemu-system-x86_64 -drive \
   file.driver=3Dvvfat,file.dir=3D.,read-only=3Don,media=3Dcdrom

Seems like read_directory() is changing the mapping->path variable. Make
sure we use the right pointer instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index fc41841a5c..f2e7d501cf 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -973,10 +973,10 @@ static int init_directories(BDRVVVFATState* s,
         mapping =3D array_get(&(s->mapping), i);
=20
         if (mapping->mode & MODE_DIRECTORY) {
+            char *path =3D mapping->path;
             mapping->begin =3D cluster;
             if(read_directory(s, i)) {
-                error_setg(errp, "Could not read directory %s",
-                           mapping->path);
+                error_setg(errp, "Could not read directory %s", path);
                 return -1;
             }
             mapping =3D array_get(&(s->mapping), i);
--=20
2.19.1
