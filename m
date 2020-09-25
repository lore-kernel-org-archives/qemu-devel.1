Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A72EC47425
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BA4206C9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOn3s2QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BA4206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLc0X-0003be-4d
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbce-0001Pu-G0
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbcL-0000E2-PJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:30:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jtt1teyTwpqrjeo/zCyCcq8bTpQT3nPi5ZdArBIjlNc=;
 b=UOn3s2QCBIwGzi0ZOrAuyMIoZUNV/M7GuoIrYUPWV0G/FqX2aF2yKrgOEMm7UYxF+4fKaV
 2ogFUvJoU3Y20G54Qou22f+id+UKbUZMauspx5LdMIgWoK0XnfJ8jt0r/kw5tmywyDcaKo
 MpCgDvY3BRnWIEjaUh0XJ3v887Gkar8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-N7v_6DHWPXukJlayTpbriw-1; Thu, 24 Sep 2020 20:29:37 -0400
X-MC-Unique: N7v_6DHWPXukJlayTpbriw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E2E26408A
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:36 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 866645D9DD;
 Fri, 25 Sep 2020 00:29:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 39/47] qapi/introspect.py: add _gen_features helper
Date: Thu, 24 Sep 2020 20:28:52 -0400
Message-Id: <20200925002900.465855-40-jsnow@redhat.com>
In-Reply-To: <20200925002900.465855-1-jsnow@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
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
index 7d4dc3f8ee..08b3783ba7 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -51,16 +51,12 @@
 
 
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
@@ -196,6 +192,11 @@ def _use_type(self, typ: QAPISchemaType) -> str:
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
@@ -208,7 +209,9 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
             name = self._name(name)
         obj['name'] = name
         obj['meta-type'] = mtype
-        self._trees.append(_make_tree(obj, ifcond, features, extra))
+        if features:
+            obj['features'] = self._gen_features(features)
+        self._trees.append(_make_tree(obj, ifcond, extra))
 
     def _gen_member(self,
                     member: QAPISchemaObjectTypeMember) -> TreeNode:
@@ -218,7 +221,9 @@ def _gen_member(self,
         }
         if member.optional:
             obj['default'] = None
-        return _make_tree(obj, member.ifcond, member.features)
+        if member.features:
+            obj['features'] = self._gen_features(member.features)
+        return _make_tree(obj, member.ifcond)
 
     def _gen_variants(self, tag_name: str,
                       variants: List[QAPISchemaVariant]) -> _DObject:
@@ -230,7 +235,7 @@ def _gen_variant(self, variant: QAPISchemaVariant) -> TreeNode:
             'case': variant.name,
             'type': self._use_type(variant.type)
         }
-        return _make_tree(obj, variant.ifcond, None)
+        return _make_tree(obj, variant.ifcond)
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
-- 
2.26.2


