Received: from eggs.gnu.org ([209.51.188.92]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUz5-00007H-IF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUz1-00044K-3s
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:49 -0500
Date: Tue, 15 Jan 2019 15:06:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-47-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 46/49] block/sheepdog: Use QEMU_NONSTRING for
 non NUL-terminated arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

GCC 8 added a -Wstringop-truncation warning:

  The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
  bug 81117 is specifically intended to highlight likely unintended
  uses of the strncpy function that truncate the terminating NUL
  character from the source string.

This new warning leads to compilation failures:

    CC      block/sheepdog.o
  qemu/block/sheepdog.c: In function 'find_vdi_name':
  qemu/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equa=
ls destination size [-Werror=3Dstringop-truncation]
       strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  make: *** [qemu/rules.mak:69: block/sheepdog.o] Error 1

As described previous to the strncpy() calls, the use of strncpy() is
correct here:

    /* This pair of strncpy calls ensures that the buffer is zero-filled,
     * which is desirable since we'll soon be sending those bytes, and
     * don't want the send_req to read uninitialized data.
     */
    strncpy(buf, filename, SD_MAX_VDI_LEN);
    strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);

Use the QEMU_NONSTRING attribute, since this array is intended to store
character arrays that do not necessarily contain a terminating NUL.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/sheepdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 90ab43baa4..ed14f7afbe 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1224,7 +1224,7 @@ static int find_vdi_name(BDRVSheepdogState *s, cons=
t char *filename,
     SheepdogVdiReq hdr;
     SheepdogVdiRsp *rsp =3D (SheepdogVdiRsp *)&hdr;
     unsigned int wlen, rlen =3D 0;
-    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
+    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN] QEMU_NONSTRING;
=20
     fd =3D connect_to_sdog(s, errp);
     if (fd < 0) {
--=20
MST
