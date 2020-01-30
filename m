Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B274DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F32A214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSU/KA39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F32A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHnz-0007M9-MG
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ixHcm-0005I9-SB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ixHcl-00053Z-KW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ixHcl-000503-ET
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shrWSK6Ov06puri1nWGHpSuDgV37Ra1SkZO+4VRJSB0=;
 b=DSU/KA39tzTDok6LngRtcp7/qz4Rs7VGTb2wST1LMNibrDjXQPTorej5YmiH1LNV0jvwmf
 Uf7ZJxCIEljdb477Z3u3cn/hpPMaXqBmcxAq83FZk6jMgJXtenN6796QMa87x+ADnH5sDN
 aiTSHEeDNd7TcjP+EkTV122SS4ahbn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-ZLcmCmV1PJmilVGt3romtg-1; Thu, 30 Jan 2020 16:45:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67E44108C316;
 Thu, 30 Jan 2020 21:45:13 +0000 (UTC)
Received: from localhost (ovpn-204-145.brq.redhat.com [10.40.204.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F110E19488;
 Thu, 30 Jan 2020 21:45:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 16/21] iotests: Add VM.assert_block_path()
Date: Thu, 30 Jan 2020 22:44:26 +0100
Message-Id: <20200130214431.333510-17-mreitz@redhat.com>
In-Reply-To: <20200130214431.333510-1-mreitz@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ZLcmCmV1PJmilVGt3romtg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 01b58dcb50..69861cf05e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -713,6 +713,62 @@ class VM(qtest.QEMUQtestMachine):
=20
         return fields.items() <=3D ret.items()
=20
+    def assert_block_path(self, root, path, expected_node, graph=3DNone):
+        """
+        Check whether the node under the given path in the block graph
+        is @expected_node.
+
+        @root is the node name of the node where the @path is rooted.
+
+        @path is a string that consists of child names separated by
+        slashes.  It must begin with a slash.
+
+        Examples for @root + @path:
+          - root=3D"qcow2-node", path=3D"/backing/file"
+          - root=3D"quorum-node", path=3D"/children.2/file"
+
+        Hypothetically, @path could be empty, in which case it would
+        point to @root.  However, in practice this case is not useful
+        and hence not allowed.
+
+        @expected_node may be None.  (All elements of the path but the
+        leaf must still exist.)
+
+        @graph may be None or the result of an x-debug-query-block-graph
+        call that has already been performed.
+        """
+        if graph is None:
+            graph =3D self.qmp('x-debug-query-block-graph')['return']
+
+        iter_path =3D iter(path.split('/'))
+
+        # Must start with a /
+        assert next(iter_path) =3D=3D ''
+
+        node =3D next((node for node in graph['nodes'] if node['name'] =3D=
=3D root),
+                    None)
+
+        for child_name in iter_path:
+            assert node is not None, 'Cannot follow path %s' % path
+
+            try:
+                node_id =3D next(edge['child'] for edge in graph['edges'] =
\
+                                             if edge['parent'] =3D=3D node=
['id'] and
+                                                edge['name'] =3D=3D child_=
name)
+
+                node =3D next(node for node in graph['nodes'] \
+                                 if node['id'] =3D=3D node_id)
+            except StopIteration:
+                node =3D None
+
+        if node is None:
+            assert expected_node is None, \
+                   'No node found under %s (but expected %s)' % \
+                   (path, expected_node)
+        else:
+            assert node['name'] =3D=3D expected_node, \
+                   'Found node %s under %s (but expected %s)' % \
+                   (node['name'], path, expected_node)
=20
 index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
=20
--=20
2.24.1


