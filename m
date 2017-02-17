Received: from eggs.gnu.org ([2001:4830:134:3::10]:58997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIV-0002Yr-2O
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIT-0004QP-OQ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIT-0004PZ-Hd
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:29 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA9B66AAC7
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcSVH019375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:29 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:25 +0100
Message-Id: <1487363905-9480-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 14/14] block: Don't bother asserting type of
 output visitor's output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

After a visit of a complex QAPI type FOO

    ov = qobject_output_visitor_new(&foo);
    visit_type_FOO(ov, NULL, expr, &error_abort);
    visit_complete(ov, &foo);

we can safely assume qobject_type(foo) is QTYPE_QDICT.  We do in many
places, but occasionally assert qobject_type(obj) == QTYPE_QDICT.
Don't.  The appropriate place to check such fundamental properties of
QAPI visitors is the test suite.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/nbd.c  | 2 --
 block/nfs.c  | 2 --
 block/qapi.c | 1 -
 3 files changed, 5 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 35f24be..a7f9108 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -537,8 +537,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     visit_type_SocketAddress(ov, NULL, &s->saddr, &error_abort);
     visit_complete(ov, &saddr_qdict);
     visit_free(ov);
-    assert(qobject_type(saddr_qdict) == QTYPE_QDICT);
-
     qdict_put_obj(opts, "server", saddr_qdict);
 
     if (s->export) {
diff --git a/block/nfs.c b/block/nfs.c
index 689eaa7..55a8a62 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -798,8 +798,6 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
     ov = qobject_output_visitor_new(&server_qdict);
     visit_type_NFSServer(ov, NULL, &client->server, &error_abort);
     visit_complete(ov, &server_qdict);
-    assert(qobject_type(server_qdict) == QTYPE_QDICT);
-
     qdict_put_obj(opts, "server", server_qdict);
     qdict_put(opts, "path", qstring_from_str(client->path));
 
diff --git a/block/qapi.c b/block/qapi.c
index ac480aa..a40922e 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -682,7 +682,6 @@ void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *f,
 
     visit_type_ImageInfoSpecific(v, NULL, &info_spec, &error_abort);
     visit_complete(v, &obj);
-    assert(qobject_type(obj) == QTYPE_QDICT);
     data = qdict_get(qobject_to_qdict(obj), "data");
     dump_qobject(func_fprintf, f, 1, data);
     qobject_decref(obj);
-- 
2.7.4
