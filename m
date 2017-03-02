Received: from eggs.gnu.org ([2001:4830:134:3::10]:35084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWG-0005W1-1C
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWE-0002pr-AE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  2 Mar 2017 22:43:57 +0100
Message-Id: <1488491046-2549-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 06/15] sheepdog: Don't truncate long VDI name
 in _open(), _create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

sd_parse_uri() truncates long VDI names silently.  Reject them
instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/sheepdog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index deb110e..72a52a6 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -985,7 +985,9 @@ static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
         ret = -EINVAL;
         goto out;
     }
-    pstrcpy(vdi, SD_MAX_VDI_LEN, uri->path + 1);
+    if (g_strlcpy(vdi, uri->path + 1, SD_MAX_VDI_LEN) >= SD_MAX_VDI_LEN) {
+        goto out;
+    }
 
     qp = query_params_parse(uri->query);
     if (qp->n > 1 || (s->is_unix && !qp->n) || (!s->is_unix && qp->n)) {
-- 
2.7.4
