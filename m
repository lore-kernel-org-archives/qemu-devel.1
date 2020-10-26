Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F0DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7CF21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVbBkQL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7CF21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8ol-0003Sb-S3
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8Ow-0006wE-1B
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8Ou-0003Ay-13
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603741407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7t+TOdJbR+kZy9WPkNJWw2EXuADY2daXwYBT0hG7Sy8=;
 b=LVbBkQL08nyQqwsxjhKjB2QYmN1WuT5aGnBBPBe6RGZ/FYncCTC0P7WrmZzY5JnRGNEMUn
 vNGhYXkz9M3RA956NYAnxaKPTJMdf18SHWuZ3fiaHXs7PPbDFX/P+/m0KjC0GDqJGJXg85
 kJ+RK9Obnb0FBGdlFfHjLUGQFEp1uDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-7d82Xk0nPqW5TFPPNtbBUQ-1; Mon, 26 Oct 2020 15:43:25 -0400
X-MC-Unique: 7d82Xk0nPqW5TFPPNtbBUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9187AF9DA
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 19:43:13 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EED105B4BA;
 Mon, 26 Oct 2020 19:43:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 06/11] qapi/introspect.py: add _gen_features helper
Date: Mon, 26 Oct 2020 15:42:46 -0400
Message-Id: <20201026194251.11075-7-jsnow@redhat.com>
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

_make_tree might receive a dict or some other type. Adding features
information should arguably be performed by the caller at such a time
when we know the type of the object and don't have to re-interrogate it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 803288a64e7..16282f2634b 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -76,16 +76,12 @@
 
 
 def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
-               features: List[QAPISchemaFeature],
                extra: Optional[Annotations] = None
                ) -> TreeValue:
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
@@ -221,6 +217,11 @@ def _use_type(self, typ: QAPISchemaType) -> str:
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
 
+    @classmethod
+    def _gen_features(cls,
+                      features: List[QAPISchemaFeature]) -> List[TreeValue]:
+        return [_make_tree(f.name, f.ifcond) for f in features]
+
     def _gen_tree(self, name: str, mtype: str, obj: _DObject,
                   ifcond: List[str],
                   features: Optional[List[QAPISchemaFeature]]) -> None:
@@ -233,7 +234,9 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
             name = self._name(name)
         obj['name'] = name
         obj['meta-type'] = mtype
-        self._trees.append(_make_tree(obj, ifcond, features, extra))
+        if features:
+            obj['features'] = self._gen_features(features)
+        self._trees.append(_make_tree(obj, ifcond, extra))
 
     def _gen_member(self,
                     member: QAPISchemaObjectTypeMember) -> TreeValue:
@@ -243,7 +246,9 @@ def _gen_member(self,
         }
         if member.optional:
             obj['default'] = None
-        return _make_tree(obj, member.ifcond, member.features)
+        if member.features:
+            obj['features'] = self._gen_features(member.features)
+        return _make_tree(obj, member.ifcond)
 
     def _gen_variants(self, tag_name: str,
                       variants: List[QAPISchemaVariant]) -> _DObject:
@@ -255,7 +260,7 @@ def _gen_variant(self, variant: QAPISchemaVariant) -> TreeValue:
             'case': variant.name,
             'type': self._use_type(variant.type)
         }
-        return _make_tree(obj, variant.ifcond, None)
+        return _make_tree(obj, variant.ifcond)
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
-- 
2.26.2


