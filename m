Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802D4206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhYx6MLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802D4206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNUIQ-00022c-Go
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 01:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTnz-0001qP-H7
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTnx-0000eY-Kw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:33:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601440404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WS+/NhqHRIsfFqOUXGDIPNhJnjsm0Dqy/vn0t6B30+U=;
 b=OhYx6MLHvpFF6HWoQk5/W6zPT3w3+zaP69ACq1vosGKgUaieRuqlfcfPyDrLT8vO+/CzdH
 pNaVXa9NmFrgznODTJU71H6Bo+2Jcons2p3lr0whtPyhvhW0fc3FtJT2HorKivQPdEXfjG
 bToN0aafq/jn3yb+Q+YzTQd2f5OqyQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-Op5Nj0hdNEe_bvknLtV83Q-1; Wed, 30 Sep 2020 00:33:20 -0400
X-MC-Unique: Op5Nj0hdNEe_bvknLtV83Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2713801AC8;
 Wed, 30 Sep 2020 04:33:18 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8377B40D;
 Wed, 30 Sep 2020 04:33:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 38/46] qapi/introspect.py: add _gen_features helper
Date: Wed, 30 Sep 2020 00:31:42 -0400
Message-Id: <20200930043150.1454766-39-jsnow@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
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

_make_tree might receive a dict or some other type. Adding features
information should arguably be performed by the caller at such a time
when we know the type of the object and don't have to re-interrogate it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f7de3953391..5cbdc7414bd 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -52,16 +52,12 @@
 
 
 def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
-               features: List[QAPISchemaFeature],
                extra: Optional[Extra] = None
                ) -> Union[TreeNode, AnnotatedNode]:
     if extra is None:
         extra = {}
     if ifcond:
         extra['if'] = ifcond
-    if features:
-        assert isinstance(obj, dict)
-        obj['features'] = [(f.name, {'if': f.ifcond}) for f in features]
     if extra:
         return (obj, extra)
     return obj
@@ -197,6 +193,11 @@ def _use_type(self, typ: QAPISchemaType) -> str:
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
 
+    @classmethod
+    def _gen_features(cls,
+                      features: List[QAPISchemaFeature]) -> List[TreeNode]:
+        return [_make_tree(f.name, f.ifcond) for f in features]
+
     def _gen_tree(self, name: str, mtype: str, obj: _DObject,
                   ifcond: List[str],
                   features: Optional[List[QAPISchemaFeature]]) -> None:
@@ -209,7 +210,9 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
             name = self._name(name)
         obj['name'] = name
         obj['meta-type'] = mtype
-        self._trees.append(_make_tree(obj, ifcond, features, extra))
+        if features:
+            obj['features'] = self._gen_features(features)
+        self._trees.append(_make_tree(obj, ifcond, extra))
 
     def _gen_member(self,
                     member: QAPISchemaObjectTypeMember) -> TreeNode:
@@ -219,7 +222,9 @@ def _gen_member(self,
         }
         if member.optional:
             obj['default'] = None
-        return _make_tree(obj, member.ifcond, member.features)
+        if member.features:
+            obj['features'] = self._gen_features(member.features)
+        return _make_tree(obj, member.ifcond)
 
     def _gen_variants(self, tag_name: str,
                       variants: List[QAPISchemaVariant]) -> _DObject:
@@ -231,7 +236,7 @@ def _gen_variant(self, variant: QAPISchemaVariant) -> TreeNode:
             'case': variant.name,
             'type': self._use_type(variant.type)
         }
-        return _make_tree(obj, variant.ifcond, None)
+        return _make_tree(obj, variant.ifcond)
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
-- 
2.26.2


