Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD050C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362C2206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSFqTfB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362C2206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6Zq-00007Y-RB
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6VX-0003CM-4z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6VT-0001XT-6m
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6XqbdTmAAMKzjvPz+W9jXvLZtl93eke5o8q4430lAk=;
 b=JSFqTfB+oAG94X2JiZCmQT8Yt5MqrU/UhdfDwmTI0jbfipHUoBfvpA7XtpJrFMuNSpwr2x
 COYHPMrskwaIUePjP/p/1CP4br4Qpm28YkIpTWh278SnhSe0D4m3087T7dKCsaxHP4aXAx
 TiWq27HPVJN2aM7eyRj1Xg6l+xfc3Hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-yIO1wSHuPM63wJ_Hr4CRTg-1; Thu, 15 Oct 2020 12:53:29 -0400
X-MC-Unique: yIO1wSHuPM63wJ_Hr4CRTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4B9BAF9A0;
 Thu, 15 Oct 2020 16:53:28 +0000 (UTC)
Received: from localhost (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E526E60CD0;
 Thu, 15 Oct 2020 16:53:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/9] qapi: start building an 'if' predicate tree
Date: Thu, 15 Oct 2020 20:52:49 +0400
Message-Id: <20201015165255.1573897-4-marcandre.lureau@redhat.com>
In-Reply-To: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
References: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
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
Cc: jsnow@redhat.com, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following patches are going to express conditions in some target
language agostic way. For that, let's start building a predicate tree of
configuration options.

The tree will be less expressive than full C macros expressions, and
will be based only on identifier. For this reason, it will use have
operations: 'all', 'any' and 'not'. ('and'/'or' have a connotation of
expression operands)

For now, the documentation will use the C condition expression (as
that's already what is exposed with defined(FOO), &&, || etc).
Eventually, we may want to generate a more human friendly syntax later.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/sphinx/qapidoc.py                 |  6 +--
 scripts/qapi/common.py                 | 69 ++++++++++++++++++++------
 tests/qapi-schema/doc-good.out         | 12 ++---
 tests/qapi-schema/qapi-schema-test.out | 58 +++++++++++-----------
 4 files changed, 91 insertions(+), 54 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index db9520f37f..31b47e4745 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -112,12 +112,10 @@ class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
     def _nodes_for_ifcond(self, ifcond, with_if=True):
         """Return list of Text, literal nodes for the ifcond
 
-        Return a list which gives text like ' (If: cond1, cond2, cond3)', where
-        the conditions are in literal-text and the commas are not.
+        Return a list which gives text like ' (If: C-condition)'.
         If with_if is False, we don't return the "(If: " and ")".
         """
-        condlist = intersperse([nodes.literal('', c) for c in ifcond.ifcond],
-                               nodes.Text(', '))
+        condlist = [nodes.literal('', ifcond.gen_if())]
         if not with_if:
             return condlist
 
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 58ddec3bc5..29e0697c27 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -194,33 +194,72 @@ def guardend(name: str) -> str:
                  name=c_fname(name).upper())
 
 
+class IfPredicate:
+    def cgen(self) -> str:
+        raise NotImplementedError()
+
+
+class IfOption(IfPredicate):
+    def __init__(self, option: str):
+        self.option = option
+
+    def cgen(self) -> str:
+        return self.option
+
+    def __repr__(self) -> str:
+        return repr(self.option)
+
+    def __eq__(self, other: object) -> bool:
+        if not isinstance(other, IfOption):
+            return False
+        return self.option == other.option
+
+
+class IfAll(IfPredicate):
+    def __init__(self, pred_list: Sequence[IfPredicate]):
+        self.pred_list = pred_list
+
+    def cgen(self) -> str:
+        return " && ".join([p.cgen() for p in self.pred_list])
+
+    def __bool__(self) -> bool:
+        return bool(self.pred_list)
+
+    def __repr__(self) -> str:
+        return f"IfAll({self.pred_list})"
+
+    def __eq__(self, other: object) -> bool:
+        if not isinstance(other, IfAll):
+            return False
+        return self.pred_list == other.pred_list
+
+
 class IfCond:
     def __init__(self, ifcond: Optional[Sequence[str]] = None):
-        self.ifcond = ifcond or []
+        pred_list = [IfOption(opt) for opt in ifcond or []]
+        self.pred = IfAll(pred_list)
 
     def __bool__(self) -> bool:
-        return bool(self.ifcond)
+        return bool(self.pred)
 
     def __repr__(self) -> str:
-        return repr(self.ifcond)
+        return repr(self.pred)
 
     def __eq__(self, other: object) -> bool:
         if not isinstance(other, IfCond):
             return NotImplemented
-        return self.ifcond == other.ifcond
+        return self.pred == other.pred
 
     def gen_if(self) -> str:
-        ret = ''
-        for ifc in self.ifcond:
-            ret += mcgen('''
+        if self.pred:
+            return mcgen('''
 #if %(cond)s
-''', cond=ifc)
-        return ret
+''', cond=self.pred.cgen())
+        return ""
 
     def gen_endif(self) -> str:
-        ret = ''
-        for ifc in reversed(self.ifcond):
-            ret += mcgen('''
-#endif /* %(cond)s */
-''', cond=ifc)
-        return ret
+        if self.pred:
+            return mcgen('''
+#endif // %(cond)s
+''', cond=self.pred.cgen())
+        return ""
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 419284dae2..0d27323c47 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -12,15 +12,15 @@ enum QType
 module doc-good.json
 enum Enum
     member one
-        if ['defined(IFONE)']
+        if IfAll(['defined(IFONE)'])
     member two
-    if ['defined(IFCOND)']
+    if IfAll(['defined(IFCOND)'])
     feature enum-feat
 object Base
     member base1: Enum optional=False
 object Variant1
     member var1: str optional=False
-        if ['defined(IFSTR)']
+        if IfAll(['defined(IFSTR)'])
         feature member-feat
     feature variant1-feat
 object Variant2
@@ -29,7 +29,7 @@ object Object
     tag base1
     case one: Variant1
     case two: Variant2
-        if ['IFTWO']
+        if IfAll(['IFTWO'])
     feature union-feat1
 object q_obj_Variant1-wrapper
     member data: Variant1 optional=False
@@ -38,13 +38,13 @@ object q_obj_Variant2-wrapper
 enum SugaredUnionKind
     member one
     member two
-        if ['IFTWO']
+        if IfAll(['IFTWO'])
 object SugaredUnion
     member type: SugaredUnionKind optional=False
     tag type
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
-        if ['IFTWO']
+        if IfAll(['IFTWO'])
     feature union-feat2
 alternate Alternate
     tag type
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 8868ca0dca..8ba658cd38 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -298,65 +298,65 @@ command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Unio
 object TestIfStruct
     member foo: int optional=False
     member bar: int optional=False
-        if ['defined(TEST_IF_STRUCT_BAR)']
-    if ['defined(TEST_IF_STRUCT)']
+        if IfAll(['defined(TEST_IF_STRUCT_BAR)'])
+    if IfAll(['defined(TEST_IF_STRUCT)'])
 enum TestIfEnum
     member foo
     member bar
-        if ['defined(TEST_IF_ENUM_BAR)']
-    if ['defined(TEST_IF_ENUM)']
+        if IfAll(['defined(TEST_IF_ENUM_BAR)'])
+    if IfAll(['defined(TEST_IF_ENUM)'])
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=False
 enum TestIfUnionKind
     member foo
     member union_bar
-        if ['defined(TEST_IF_UNION_BAR)']
-    if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
+        if IfAll(['defined(TEST_IF_UNION_BAR)'])
+    if IfAll(['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)'])
 object TestIfUnion
     member type: TestIfUnionKind optional=False
     tag type
     case foo: q_obj_TestStruct-wrapper
     case union_bar: q_obj_str-wrapper
-        if ['defined(TEST_IF_UNION_BAR)']
-    if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
+        if IfAll(['defined(TEST_IF_UNION_BAR)'])
+    if IfAll(['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)'])
 object q_obj_TestIfUnionCmd-arg
     member union_cmd_arg: TestIfUnion optional=False
-    if ['defined(TEST_IF_UNION)']
+    if IfAll(['defined(TEST_IF_UNION)'])
 command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
-    if ['defined(TEST_IF_UNION)']
+    if IfAll(['defined(TEST_IF_UNION)'])
 alternate TestIfAlternate
     tag type
     case foo: int
     case bar: TestStruct
-        if ['defined(TEST_IF_ALT_BAR)']
-    if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
+        if IfAll(['defined(TEST_IF_ALT_BAR)'])
+    if IfAll(['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)'])
 object q_obj_TestIfAlternateCmd-arg
     member alt_cmd_arg: TestIfAlternate optional=False
-    if ['defined(TEST_IF_ALT)']
+    if IfAll(['defined(TEST_IF_ALT)'])
 command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
-    if ['defined(TEST_IF_ALT)']
+    if IfAll(['defined(TEST_IF_ALT)'])
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=False
     member bar: TestIfEnum optional=False
-        if ['defined(TEST_IF_CMD_BAR)']
-    if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
+        if IfAll(['defined(TEST_IF_CMD_BAR)'])
+    if IfAll(['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'])
 command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
     gen=True success_response=True boxed=False oob=False preconfig=False
-    if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
+    if IfAll(['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'])
 command TestCmdReturnDefThree None -> UserDefThree
     gen=True success_response=True boxed=False oob=False preconfig=False
 array TestIfEnumList TestIfEnum
-    if ['defined(TEST_IF_ENUM)']
+    if IfAll(['defined(TEST_IF_ENUM)'])
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=False
     member bar: TestIfEnumList optional=False
-        if ['defined(TEST_IF_EVT_BAR)']
-    if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
+        if IfAll(['defined(TEST_IF_EVT_BAR)'])
+    if IfAll(['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)'])
 event TestIfEvent q_obj_TestIfEvent-arg
     boxed=False
-    if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
+    if IfAll(['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)'])
 object FeatureStruct0
     member foo: int optional=False
 object FeatureStruct1
@@ -379,17 +379,17 @@ object FeatureStruct4
 object CondFeatureStruct1
     member foo: int optional=False
     feature feature1
-        if ['defined(TEST_IF_FEATURE_1)']
+        if IfAll(['defined(TEST_IF_FEATURE_1)'])
 object CondFeatureStruct2
     member foo: int optional=False
     feature feature1
-        if ['defined(TEST_IF_FEATURE_1)']
+        if IfAll(['defined(TEST_IF_FEATURE_1)'])
     feature feature2
-        if ['defined(TEST_IF_FEATURE_2)']
+        if IfAll(['defined(TEST_IF_FEATURE_2)'])
 object CondFeatureStruct3
     member foo: int optional=False
     feature feature1
-        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
+        if IfAll(['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)'])
 enum FeatureEnum1
     member eins
     member zwei
@@ -429,17 +429,17 @@ command test-command-features3 None -> None
 command test-command-cond-features1 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
-        if ['defined(TEST_IF_FEATURE_1)']
+        if IfAll(['defined(TEST_IF_FEATURE_1)'])
 command test-command-cond-features2 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
-        if ['defined(TEST_IF_FEATURE_1)']
+        if IfAll(['defined(TEST_IF_FEATURE_1)'])
     feature feature2
-        if ['defined(TEST_IF_FEATURE_2)']
+        if IfAll(['defined(TEST_IF_FEATURE_2)'])
 command test-command-cond-features3 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
-        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
+        if IfAll(['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)'])
 event TEST-EVENT-FEATURES1 None
     boxed=False
     feature deprecated
-- 
2.28.0


