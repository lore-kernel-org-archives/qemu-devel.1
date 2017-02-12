Received: from eggs.gnu.org ([2001:4830:134:3::10]:47236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj82-00077Q-31
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj81-0007Kz-3C
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:02 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:38:36 +0100
Message-Id: <20170212013844.6560-4-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 13/21] block/nfs: fix NULL pointer dereference
 in URI parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Lieven <pl@kamp.de>

parse_uint_full wants to put the parsed value into the
variable passed via its second argument which is NULL.

Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 1485942829-10756-2-git-send-email-pl@kamp.de
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nfs.c b/block/nfs.c
index a564340d15..baaecff3fd 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -108,12 +108,13 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
     qdict_put(options, "path", qstring_from_str(uri->path));
 
     for (i = 0; i < qp->n; i++) {
+        unsigned long long val;
         if (!qp->p[i].value) {
             error_setg(errp, "Value for NFS parameter expected: %s",
                        qp->p[i].name);
             goto out;
         }
-        if (parse_uint_full(qp->p[i].value, NULL, 0)) {
+        if (parse_uint_full(qp->p[i].value, &val, 0)) {
             error_setg(errp, "Illegal value for NFS parameter: %s",
                        qp->p[i].name);
             goto out;
-- 
2.11.0
