Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27450C34035
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E967E206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyOu8qKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E967E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40Or-0006uh-5v
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j40ED-000254-Px
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j40EC-0007cE-J7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j40EB-0007aM-98
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582022141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJiSY8aLeMkLp7k5JdMdK9u1USDPPnfK/5mrL6tNNLU=;
 b=PyOu8qKHuFpK4JTC4hcywgsknnpDmkJnf9+xz4UHq+QFFkF0lf72whAfOkVwYGCudiBISO
 5xujF/KE7ovumJuBGHdsiTLFKNwvx2XhSXAw4QIM05LWO+FCKUB5XujZbahsv6z9l8c+6/
 eC2mRQFTxkd8m/pQcjauz30DtmbXn/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-xEu3n3P-MYiWjaTVj7XXaw-1; Tue, 18 Feb 2020 05:35:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9016100550E;
 Tue, 18 Feb 2020 10:35:38 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D961001920;
 Tue, 18 Feb 2020 10:35:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 14/19] iotests: Add VM.assert_block_path()
Date: Tue, 18 Feb 2020 11:34:49 +0100
Message-Id: <20200218103454.296704-15-mreitz@redhat.com>
In-Reply-To: <20200218103454.296704-1-mreitz@redhat.com>
References: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xEu3n3P-MYiWjaTVj7XXaw-1
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
 tests/qemu-iotests/iotests.py | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 0473e824ed..8815052eb5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -714,6 +714,65 @@ class VM(qtest.QEMUQtestMachine):
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
+        # An empty @path is not allowed, so the root node must be present
+        assert node is not None, 'Root node %s not found' % root
+
+        for child_name in iter_path:
+            assert node is not None, 'Cannot follow path %s%s' % (root, pa=
th)
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


