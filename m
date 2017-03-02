Received: from eggs.gnu.org ([2001:4830:134:3::10]:35078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWF-0005Vu-Vf
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWE-0002pU-4r
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  2 Mar 2017 22:43:52 +0100
Message-Id: <1488491046-2549-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/15] sheepdog: Defuse time bomb in sd_open()
 error handling
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

When qemu_opts_absorb_qdict() fails, sd_open() closes stdin, because
sd->fd is still zero.  Fortunately, qemu_opts_absorb_qdict() can't
fail, because:

1. it only fails when qemu_opt_parse() fails, and
2. the only member of runtime_opts.desc[] is a QEMU_OPT_STRING, and
3. qemu_opt_parse() can't fail for QEMU_OPT_STRING.

Defuse this ticking time bomb by jumping behind the file descriptor
cleanup on error.

Also do that for the error paths where sd->fd is still -1.  The file
descriptor cleanup happens to do nothing then, but let's not rely on
that here.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/sheepdog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 860ba61..fe15723 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1392,7 +1392,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
-        goto out;
+        goto out_no_fd;
     }
 
     filename = qemu_opt_get(opts, "filename");
@@ -1412,12 +1412,12 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     }
     if (ret < 0) {
         error_setg(errp, "Can't parse filename");
-        goto out;
+        goto out_no_fd;
     }
     s->fd = get_sheep_fd(s, errp);
     if (s->fd < 0) {
         ret = s->fd;
-        goto out;
+        goto out_no_fd;
     }
 
     ret = find_vdi_name(s, vdi, snapid, tag, &vid, true, errp);
@@ -1472,6 +1472,7 @@ out:
     if (s->fd >= 0) {
         closesocket(s->fd);
     }
+out_no_fd:
     qemu_opts_del(opts);
     g_free(buf);
     return ret;
-- 
2.7.4
