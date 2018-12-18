Received: from eggs.gnu.org ([2001:4830:134:3::10]:41250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDEW-00015D-3t
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDBf-0000fg-Md
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:05:21 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:03:32 +0100
Message-Id: <20181218110333.22558-3-philmd@redhat.com>
In-Reply-To: <20181218110333.22558-1-philmd@redhat.com>
References: <20181218110333.22558-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] block/sheepdog: Replace strncpy() by
 strpadcpy(pad='\0')
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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

We could add a #pragma GCC diagnostic ignored "-Wstringop-truncation"
around, disable the warning globally using -Wno-stringop-truncation,
but since QEMU provides the strpadcpy() which does the same purpose,
simply use it to avoid the annoying warning.

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1803872
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/sheepdog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 0125df9d49..72e1aef6ea 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1231,12 +1231,12 @@ static int find_vdi_name(BDRVSheepdogState *s, co=
nst char *filename,
         return fd;
     }
=20
-    /* This pair of strncpy calls ensures that the buffer is zero-filled=
,
+    /* This pair of strpadcpy calls ensures that the buffer is zero-fill=
ed,
      * which is desirable since we'll soon be sending those bytes, and
      * don't want the send_req to read uninitialized data.
      */
-    strncpy(buf, filename, SD_MAX_VDI_LEN);
-    strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
+    strpadcpy(buf, SD_MAX_VDI_LEN, filename, '\0');
+    strpadcpy(buf + SD_MAX_VDI_LEN, SD_MAX_VDI_TAG_LEN, tag, '\0');
=20
     memset(&hdr, 0, sizeof(hdr));
     if (lock) {
--=20
2.17.2
