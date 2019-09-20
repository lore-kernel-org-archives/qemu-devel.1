Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A5C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F992086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F992086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBL74-0007Os-9t
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKq8-00016i-04
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKq5-0004hX-LZ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpz-0004dk-SV; Fri, 20 Sep 2019 11:28:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 924F410CC1E6;
 Fri, 20 Sep 2019 15:28:46 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A2C319C5B;
 Fri, 20 Sep 2019 15:28:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 17/22] iotests: Add VM.assert_block_path()
Date: Fri, 20 Sep 2019 17:27:59 +0200
Message-Id: <20190920152804.12875-18-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 20 Sep 2019 15:28:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index daed4ee013..e6fb46287d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -670,6 +670,54 @@ class VM(qtest.QEMUQtestMachine):
=20
         return fields.items() <=3D ret.items()
=20
+    '''
+    @path is a string whose components are separated by slashes.
+    The first component is a node name, the rest are child names.
+    Examples:
+      - "qcow2-node/backing/file"
+      - "quorum-node/children.2/file"
+
+    @expected_node may be None.
+
+    @graph may be None or the result of an x-debug-query-block-graph
+    call that has already been performed.
+    '''
+    def assert_block_path(self, path, expected_node, graph=3DNone):
+        if graph is None:
+            graph =3D self.qmp('x-debug-query-block-graph')['return']
+
+        iter_path =3D iter(path.split('/'))
+        root =3D next(iter_path)
+        try:
+            node =3D next(node for node in graph['nodes'] if node['name'=
] =3D=3D root)
+        except StopIteration:
+            node =3D None
+
+        for path_node in iter_path:
+            assert node is not None, 'Cannot follow path %s' % path
+
+            try:
+                node_id =3D next(edge['child'] for edge in graph['edges'=
] \
+                                             if edge['parent'] =3D=3D no=
de['id'] and
+                                                edge['name'] =3D=3D path=
_node)
+
+                node =3D next(node for node in graph['nodes'] \
+                                 if node['id'] =3D=3D node_id)
+            except StopIteration:
+                node =3D None
+
+        assert node is not None or expected_node is None, \
+               'No node found under %s (but expected %s)' % \
+               (path, expected_node)
+
+        assert expected_node is not None or node is None, \
+               'Found node %s under %s (but expected none)' % \
+               (node['name'], path)
+
+        if node is not None and expected_node is not None:
+            assert node['name'] =3D=3D expected_node, \
+                   'Found node %s under %s (but expected %s)' % \
+                   (node['name'], path, expected_node)
=20
 index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
=20
--=20
2.21.0


