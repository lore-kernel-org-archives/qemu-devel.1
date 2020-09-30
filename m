Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3DFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1FF206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVU028D/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1FF206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNUF3-0005w7-FA
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 01:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNToK-000243-L0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNToI-0000hN-Na
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601440424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RaRO2GfxYsm01Te7yy8HdRAk2vOVtaaVh5Zqj+YVgp8=;
 b=SVU028D//aQeJOQWxjbepEfBgWGJOH+e6ONpqh5YjYLGs0dZyRGrsbqH1pUwjnDmxcBO/G
 rLL4VoWrDqUQ8eQ0RP1U0OgQMbTndvDFeGusZlI66HnxHZI9KgElUjw2moqNPDrx5yyB/x
 ROSMuiwz8brUzMmZoOlxCHPVqLFrwCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-MGHXWMRyOYexq5NBL4hlFQ-1; Wed, 30 Sep 2020 00:33:22 -0400
X-MC-Unique: MGHXWMRyOYexq5NBL4hlFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53BD21074651;
 Wed, 30 Sep 2020 04:33:21 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C9AA7B40D;
 Wed, 30 Sep 2020 04:33:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 39/46] qapi/introspect.py: Unify return type of _make_tree()
Date: Wed, 30 Sep 2020 00:31:43 -0400
Message-Id: <20200930043150.1454766-40-jsnow@redhat.com>
In-Reply-To: <20200930043150.1454766-1-jsnow@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Returning a *something* or a Tuple of *something* is hard to accurately
type. Let's just always return a tuple for structural consistency.

Instances of the 'TreeNode' type can be replaced with the slightly more
specific 'AnnotatedNode' type.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 5cbdc7414bd..1c3ba41f1dc 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -53,14 +53,12 @@
 
 def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
                extra: Optional[Extra] = None
-               ) -> Union[TreeNode, AnnotatedNode]:
+               ) -> AnnotatedNode:
     if extra is None:
         extra = {}
     if ifcond:
         extra['if'] = ifcond
-    if extra:
-        return (obj, extra)
-    return obj
+    return (obj, extra)
 
 
 def _tree_to_qlit(obj: TreeNode,
@@ -128,7 +126,7 @@ def __init__(self, prefix: str, unmask: bool):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
-        self._trees: List[TreeNode] = []
+        self._trees: List[AnnotatedNode] = []
         self._used_types: List[QAPISchemaType] = []
         self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
@@ -195,7 +193,8 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
     @classmethod
     def _gen_features(cls,
-                      features: List[QAPISchemaFeature]) -> List[TreeNode]:
+                      features: List[QAPISchemaFeature]
+                      ) -> List[AnnotatedNode]:
         return [_make_tree(f.name, f.ifcond) for f in features]
 
     def _gen_tree(self, name: str, mtype: str, obj: _DObject,
@@ -215,7 +214,7 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
         self._trees.append(_make_tree(obj, ifcond, extra))
 
     def _gen_member(self,
-                    member: QAPISchemaObjectTypeMember) -> TreeNode:
+                    member: QAPISchemaObjectTypeMember) -> AnnotatedNode:
         obj: _DObject = {
             'name': member.name,
             'type': self._use_type(member.type)
@@ -231,7 +230,7 @@ def _gen_variants(self, tag_name: str,
         return {'tag': tag_name,
                 'variants': [self._gen_variant(v) for v in variants]}
 
-    def _gen_variant(self, variant: QAPISchemaVariant) -> TreeNode:
+    def _gen_variant(self, variant: QAPISchemaVariant) -> AnnotatedNode:
         obj: _DObject = {
             'case': variant.name,
             'type': self._use_type(variant.type)
-- 
2.26.2


