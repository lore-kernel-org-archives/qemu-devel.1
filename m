Received: from eggs.gnu.org ([2001:4830:134:3::10]:39813)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cUVmC-0003um-T5
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cUVm8-0003Ai-8I
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:32 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:50853 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cUVm7-000397-VI
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:28 -0500
From: Peter Lieven <pl@kamp.de>
Date: Fri, 20 Jan 2017 10:46:09 +0100
Message-Id: <1484905570-10520-2-git-send-email-pl@kamp.de>
In-Reply-To: <1484905570-10520-1-git-send-email-pl@kamp.de>
References: <1484905570-10520-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 1/2] block/nfs: fix NULL pointer dereference in
 URI parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

parse_uint_full wants to put the parsed value into the
variabled passed via its second argument which is NULL.

Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/nfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nfs.c b/block/nfs.c
index a564340..baaecff 100644
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
1.9.1
