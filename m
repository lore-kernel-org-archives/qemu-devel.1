Received: from eggs.gnu.org ([2001:4830:134:3::10]:33431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJXt-00059X-LA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJXs-0003JB-Ix
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:52:41 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 18:51:19 +0100
Message-Id: <20181218175122.3229-3-philmd@redhat.com>
In-Reply-To: <20181218175122.3229-1-philmd@redhat.com>
References: <20181218175122.3229-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/5] block/sheepdog: Use QEMU_NONSTRING for
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>

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
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/sheepdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 0125df9d49..d4ad6b119d 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1224,7 +1224,7 @@ static int find_vdi_name(BDRVSheepdogState *s, cons=
t char *filename,
     SheepdogVdiReq hdr;
     SheepdogVdiRsp *rsp =3D (SheepdogVdiRsp *)&hdr;
     unsigned int wlen, rlen =3D 0;
-    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
+    QEMU_NONSTRING char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
=20
     fd =3D connect_to_sdog(s, errp);
     if (fd < 0) {
--=20
2.17.2
