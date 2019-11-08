Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290C7FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBA8224F1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2z1Q+2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBA8224F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3Vi-0004A9-Nn
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT3Ts-0002Yg-6j
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tq-0003Jz-3J
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT3To-0003HY-7T
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573216506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxnnNO6K+9iLDzwL1oPBiucVaNMfMzLQ28KNK8wvARs=;
 b=a2z1Q+2falaqnm9NRtizgTd7VT+XGfOxLvhgHBFsvwBeqY4lUoLgbrWC2TxZ/8T+BleBjI
 knHTgSXUrANBrTHcIiRU0Atulz727vXwMtAHRZ+HYyitLwgUzNua6SfE15ywz47oAAF7hC
 AWKvyKpfpj9m0QOTJohsxcgjdIaEzQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-WzZxtrfxPWaJJQWUvFLm7Q-1; Fri, 08 Nov 2019 07:35:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D505800C72;
 Fri,  8 Nov 2019 12:35:01 +0000 (UTC)
Received: from localhost (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2DA05D6AE;
 Fri,  8 Nov 2019 12:35:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v4 2/5] block: Use bdrv_qapi_perm_to_blk_perm()
Date: Fri,  8 Nov 2019 13:34:52 +0100
Message-Id: <20191108123455.39445-3-mreitz@redhat.com>
In-Reply-To: <20191108123455.39445-1-mreitz@redhat.com>
References: <20191108123455.39445-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WzZxtrfxPWaJJQWUvFLm7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can save some LoC in xdbg_graph_add_edge() by using
bdrv_qapi_perm_to_blk_perm().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/block.c b/block.c
index 066433f3e2..ae279ff21f 100644
--- a/block.c
+++ b/block.c
@@ -4870,36 +4870,23 @@ static void xdbg_graph_add_node(XDbgBlockGraphConst=
ructor *gr, void *node,
 static void xdbg_graph_add_edge(XDbgBlockGraphConstructor *gr, void *paren=
t,
                                 const BdrvChild *child)
 {
-    typedef struct {
-        unsigned int flag;
-        BlockPermission num;
-    } PermissionMap;
-
-    static const PermissionMap permissions[] =3D {
-        { BLK_PERM_CONSISTENT_READ, BLOCK_PERMISSION_CONSISTENT_READ },
-        { BLK_PERM_WRITE,           BLOCK_PERMISSION_WRITE },
-        { BLK_PERM_WRITE_UNCHANGED, BLOCK_PERMISSION_WRITE_UNCHANGED },
-        { BLK_PERM_RESIZE,          BLOCK_PERMISSION_RESIZE },
-        { BLK_PERM_GRAPH_MOD,       BLOCK_PERMISSION_GRAPH_MOD },
-        { 0, 0 }
-    };
-    const PermissionMap *p;
+    BlockPermission qapi_perm;
     XDbgBlockGraphEdge *edge;
=20
-    QEMU_BUILD_BUG_ON(1UL << (ARRAY_SIZE(permissions) - 1) !=3D BLK_PERM_A=
LL + 1);
-
     edge =3D g_new0(XDbgBlockGraphEdge, 1);
=20
     edge->parent =3D xdbg_graph_node_num(gr, parent);
     edge->child =3D xdbg_graph_node_num(gr, child->bs);
     edge->name =3D g_strdup(child->name);
=20
-    for (p =3D permissions; p->flag; p++) {
-        if (p->flag & child->perm) {
-            QAPI_LIST_ADD(edge->perm, p->num);
+    for (qapi_perm =3D 0; qapi_perm < BLOCK_PERMISSION__MAX; qapi_perm++) =
{
+        uint64_t flag =3D bdrv_qapi_perm_to_blk_perm(qapi_perm);
+
+        if (flag & child->perm) {
+            QAPI_LIST_ADD(edge->perm, qapi_perm);
         }
-        if (p->flag & child->shared_perm) {
-            QAPI_LIST_ADD(edge->shared_perm, p->num);
+        if (flag & child->shared_perm) {
+            QAPI_LIST_ADD(edge->shared_perm, qapi_perm);
         }
     }
=20
--=20
2.23.0


