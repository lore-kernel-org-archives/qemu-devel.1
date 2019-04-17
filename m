Received: from eggs.gnu.org ([209.51.188.92]:59420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5U-0007YI-90
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5T-0007TE-Di
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:08 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 17 Apr 2019 12:11:00 -0500
Message-Id: <20190417171101.1254-2-eblake@redhat.com>
In-Reply-To: <20190417171101.1254-1-eblake@redhat.com>
References: <20190417171101.1254-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/2] cutils: Fix size_to_str() on 32-bit
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org

When extracting a human-readable size formatter, we changed 'uint64_t
div' pre-patch to 'unsigned long div' post-patch. Which breaks on
32-bit platforms, resulting in 'inf' instead of intended values larger
than 999GB.

Fixes: 22951aaa
CC: qemu-stable@nongnu.org
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 util/cutils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index e098debdc0c..d682c909015 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -825,7 +825,7 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
 char *size_to_str(uint64_t val)
 {
     static const char *suffixes[] =3D { "", "Ki", "Mi", "Gi", "Ti", "Pi"=
, "Ei" };
-    unsigned long div;
+    uint64_t div;
     int i;

     /*
--=20
2.20.1
