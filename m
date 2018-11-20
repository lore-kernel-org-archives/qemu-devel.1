Received: from eggs.gnu.org ([2001:4830:134:3::10]:34340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gP7x1-0003wk-7R
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gP7wz-00059x-1o
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:28:31 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 19:27:51 +0400
Message-Id: <20181120152753.10463-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181120152753.10463-1-marcandre.lureau@redhat.com>
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1? 1/3] sheepdog: fix stringop-truncation
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It seems adding an assert is enough to silence GCC.
(sd_parse_snapid_or_tag() g_strlcpy() ensures that we don't get in
that situation)

~/src/qemu/block/sheepdog.c: In function 'find_vdi_name':
~/src/qemu/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 =
equals destination size [-Werror=3Dstringop-truncation]
     strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/sheepdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 0125df9d49..f8877b611d 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1236,6 +1236,7 @@ static int find_vdi_name(BDRVSheepdogState *s, cons=
t char *filename,
      * don't want the send_req to read uninitialized data.
      */
     strncpy(buf, filename, SD_MAX_VDI_LEN);
+    assert(strlen(tag) < SD_MAX_VDI_TAG_LEN);
     strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
=20
     memset(&hdr, 0, sizeof(hdr));
--=20
2.19.1.708.g4ede3d42df
