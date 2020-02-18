Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84961C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB8E208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et98Imf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB8E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43pJ-0002RH-Dr
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43YE-0008IB-3U
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43YC-0001kH-UD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43YC-0001jk-P1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKziCwcuTyPl7Po16yiMFEdAaIqr4xYa4o6GFY1EjGQ=;
 b=et98Imf7vYymlAP4HSadJ0wjfVOA8IbNt8o0QDONGBwhnN/GhWV24aS4HUM9gTF3OfaYeF
 Fe6jQCZKTw5sRY2Cc8wlDfBcJy9rELEMjVET1FIc4VBCeewckeFW93asdaMTSK8OX5Sq+R
 P0YIR2Vp7gvOjZBq3X9l8scYlAM9j3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-TqKehsQ5MT2_5hTQihlUPg-1; Tue, 18 Feb 2020 09:08:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 340C4DB63;
 Tue, 18 Feb 2020 14:08:33 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE6619E9C;
 Tue, 18 Feb 2020 14:08:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 31/36] iotests: Add VM.assert_block_path()
Date: Tue, 18 Feb 2020 15:07:17 +0100
Message-Id: <20200218140722.23876-32-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TqKehsQ5MT2_5hTQihlUPg-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200218103454.296704-15-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.20.1


