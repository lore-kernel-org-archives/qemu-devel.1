Received: from eggs.gnu.org ([2001:4830:134:3::10]:34642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jixiang_zhang@h3c.com>) id 1etT87-0002iV-It
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jixiang_zhang@h3c.com>) id 1etT82-0001Ls-KE
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:51 -0500
Received: from smtp.h3c.com ([60.191.123.56]:35799 helo=h3cmg01-ex.h3c.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jixiang_zhang@h3c.com>) id 1etT81-0001Ir-Pl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:04:46 -0500
From: Zhangjixiang <jixiang_zhang@h3c.com>
Date: Wed, 7 Mar 2018 07:02:28 +0000
Message-ID: <CC0ED444C2C80B429092A9F3715307D9D457069E@H3CMLB12-EX.srv.huawei-3com.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] HMP: Initialize err before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

When bdrv_snapshot_delete return fail, the errp will not be
assigned a valid value in error_propagate as errp didn't be
initialized in hmp_delvm, then error_reportf_err will use an
uninitialized value(call by hmp_delvm), and qemu crash.

Signed-off-by: zhangjixiang <jixiang_zhang@h3c.com>
---
hmp.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 7870d6a300..4a4da004e9 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1340,7 +1340,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
void hmp_delvm(Monitor *mon, const QDict *qdict)
{
     BlockDriverState *bs;
-    Error *err;
+    Error *err =3D NULL;
     const char *name =3D qdict_get_str(qdict, "name");
     if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
--
2.11.0
