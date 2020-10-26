Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76457C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E67E21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idEfhEY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E67E21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8tb-00018Q-JV
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8P2-00072a-Op
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8P0-0003BJ-MU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603741412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REDnd9QKNyIFxZBMsmQu+NVSaxxfmukU0lq6x9MljOQ=;
 b=idEfhEY78wjGFBxiILlecUV+U8IdzAosZORGRp7T2KKKeLTSNhBu4KP0PNxrClkDwgt0Hl
 WCG+EfViSDUeO/UAjznJ5nIewBfLYrG2HYYcqLmzEwIDu64s5AQBj4PSGvM1NDOUKV9Arr
 lSBsRSl5JVOVvj32S9tUP5QguvhQo4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-2_AaZsLeO56ALMNOEflGag-1; Mon, 26 Oct 2020 15:43:18 -0400
X-MC-Unique: 2_AaZsLeO56ALMNOEflGag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7EFC88EF23
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 19:43:14 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1DE85B4B9;
 Mon, 26 Oct 2020 19:43:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 07/11] qapi/introspect.py: Unify return type of _make_tree()
Date: Mon, 26 Oct 2020 15:42:47 -0400
Message-Id: <20201026194251.11075-8-jsnow@redhat.com>
In-Reply-To: <20201026194251.11075-1-jsnow@redhat.com>
References: <20201026194251.11075-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Returning two different types conditionally can be complicated to
type. Let's always return a tuple for consistency. Prohibit the use of
annotations with dict-values in this circumstance. It can be implemented
later if and when the need for it arises.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 16282f2634b..ef469b6c06e 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -77,14 +77,12 @@
 
 def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
                extra: Optional[Annotations] = None
-               ) -> TreeValue:
+               ) -> Annotated:
     if extra is None:
         extra = {}
     if ifcond:
         extra['if'] = ifcond
-    if extra:
-        return (obj, extra)
-    return obj
+    return (obj, extra)
 
 
 def _tree_to_qlit(obj: TreeValue,
@@ -98,12 +96,16 @@ def indent(level: int) -> str:
         ifobj, extra = obj
         ifcond = cast(Optional[Sequence[str]], extra.get('if'))
         comment = extra.get('comment')
+
+        msg = "Comments and Conditionals not implemented for dict values"
+        assert not (suppress_first_indent and (ifcond or comment)), msg
+
         ret = ''
         if comment:
             ret += indent(level) + '/* %s */\n' % comment
         if ifcond:
             ret += gen_if(ifcond)
-        ret += _tree_to_qlit(ifobj, level)
+        ret += _tree_to_qlit(ifobj, level, suppress_first_indent)
         if ifcond:
             ret += '\n' + gen_endif(ifcond)
         return ret
@@ -152,7 +154,7 @@ def __init__(self, prefix: str, unmask: bool):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
-        self._trees: List[TreeValue] = []
+        self._trees: List[Annotated] = []
         self._used_types: List[QAPISchemaType] = []
         self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
@@ -219,7 +221,8 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
     @classmethod
     def _gen_features(cls,
-                      features: List[QAPISchemaFeature]) -> List[TreeValue]:
+                      features: List[QAPISchemaFeature]
+                      ) -> List[Annotated]:
         return [_make_tree(f.name, f.ifcond) for f in features]
 
     def _gen_tree(self, name: str, mtype: str, obj: _DObject,
@@ -239,7 +242,7 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
         self._trees.append(_make_tree(obj, ifcond, extra))
 
     def _gen_member(self,
-                    member: QAPISchemaObjectTypeMember) -> TreeValue:
+                    member: QAPISchemaObjectTypeMember) -> Annotated:
         obj: _DObject = {
             'name': member.name,
             'type': self._use_type(member.type)
@@ -255,7 +258,7 @@ def _gen_variants(self, tag_name: str,
         return {'tag': tag_name,
                 'variants': [self._gen_variant(v) for v in variants]}
 
-    def _gen_variant(self, variant: QAPISchemaVariant) -> TreeValue:
+    def _gen_variant(self, variant: QAPISchemaVariant) -> Annotated:
         obj: _DObject = {
             'case': variant.name,
             'type': self._use_type(variant.type)
-- 
2.26.2


