Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45561C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5308207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ai7vVRuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5308207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXANW-0002OP-Mp
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 17:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXAAo-00049P-3M
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXAAi-0001WY-MX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603748214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzR1jpkyEvGckWPaDmHWHkzzpNd44v+7R6OfTtEDH+4=;
 b=ai7vVRuYeWb67kw6uWumS827eIlfWTPuXo5olEEVmI0lFXPcLdg/5A7okIyVryIMRNfqSp
 Wxum5cFjkn90HhgXYTY3s9xvT7hGVK/byxDdEjMWOmaCYVOfFqBwNbaJQEaziFMkp9VtIs
 ZcG/E3dfJbZwDb8js0OUHWkFekyvlfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Tbxvh5SfNJ24Eyvs5WQ9zw-1; Mon, 26 Oct 2020 17:36:52 -0400
X-MC-Unique: Tbxvh5SfNJ24Eyvs5WQ9zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3745809DD5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 21:36:51 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B90519728;
 Mon, 26 Oct 2020 21:36:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 15/16] qapi/expr.py: move related checks inside check_xxx
 functions
Date: Mon, 26 Oct 2020 17:36:36 -0400
Message-Id: <20201026213637.47087-16-jsnow@redhat.com>
In-Reply-To: <20201026213637.47087-1-jsnow@redhat.com>
References: <20201026213637.47087-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

There's not a big obvious difference between the types of checks that
happen in the main function versus the kind that happen in the
functions. Now they're in one place for each of the main types.

As part of the move, spell out the required and optional keywords so
they're obvious at a glance.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/expr.py | 55 ++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 9253560cd9ce..3b62e801a42c 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -347,6 +347,10 @@ def check_enum(expr: Expression, info: QAPISourceInfo) -> None:
     :param expr: `Expression` to validate.
     :param info: QAPI source file information.
     """
+    check_keys(expr, info, 'enum',
+               required=('enum', 'data'),
+               optional=('if', 'features', 'prefix'))
+
     name = expr['enum']
     members = expr['data']
     prefix = expr.get('prefix')
@@ -377,6 +381,11 @@ def check_struct(expr: Expression, info: QAPISourceInfo) -> None:
     :param expr: `Expression` to validate.
     :param info: QAPI source file information.
     """
+    check_keys(expr, info, 'struct',
+               required=('struct', 'data'),
+               optional=('base', 'if', 'features'))
+    normalize_members(expr['data'])
+
     name = cast(str, expr['struct'])  # Asserted in check_exprs
     members = expr['data']
 
@@ -391,6 +400,13 @@ def check_union(expr: Expression, info: QAPISourceInfo) -> None:
     :param expr: `Expression` to validate.
     :param info: QAPI source file information.
     """
+    check_keys(expr, info, 'union',
+               required=('union', 'data'),
+               optional=('base', 'discriminator', 'if', 'features'))
+
+    normalize_members(expr.get('base'))
+    normalize_members(expr['data'])
+
     name = cast(str, expr['union'])  # Asserted in check_exprs
     base = expr.get('base')
     discriminator = expr.get('discriminator')
@@ -423,6 +439,11 @@ def check_alternate(expr: Expression, info: QAPISourceInfo) -> None:
     :param expr: Expression to validate.
     :param info: QAPI source file information.
     """
+    check_keys(expr, info, 'alternate',
+               required=('alternate', 'data'),
+               optional=('if', 'features'))
+    normalize_members(expr['data'])
+
     members = expr['data']
 
     if not members:
@@ -446,6 +467,13 @@ def check_command(expr: Expression, info: QAPISourceInfo) -> None:
     :param expr: `Expression` to validate.
     :param info: QAPI source file information.
     """
+    check_keys(expr, info, 'command',
+               required=['command'],
+               optional=('data', 'returns', 'boxed', 'if', 'features',
+                         'gen', 'success-response', 'allow-oob',
+                         'allow-preconfig', 'coroutine'))
+    normalize_members(expr.get('data'))
+
     args = expr.get('data')
     rets = expr.get('returns')
     boxed = expr.get('boxed', False)
@@ -467,6 +495,11 @@ def check_event(expr: Expression, info: QAPISourceInfo) -> None:
       :if: ``Optional[Ifcond]`` (see: `check_if`)
       :features: ``Optional[Features]`` (see: `check_features`)
     """
+    check_keys(expr, info, 'event',
+               required=['event'],
+               optional=('data', 'boxed', 'if', 'features'))
+    normalize_members(expr.get('data'))
+
     args = expr.get('data')
     boxed = expr.get('boxed', False)
 
@@ -534,38 +567,16 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
                                "documentation comment required")
 
         if meta == 'enum':
-            check_keys(expr, info, meta,
-                       ['enum', 'data'], ['if', 'features', 'prefix'])
             check_enum(expr, info)
         elif meta == 'union':
-            check_keys(expr, info, meta,
-                       ['union', 'data'],
-                       ['base', 'discriminator', 'if', 'features'])
-            normalize_members(expr.get('base'))
-            normalize_members(expr['data'])
             check_union(expr, info)
         elif meta == 'alternate':
-            check_keys(expr, info, meta,
-                       ['alternate', 'data'], ['if', 'features'])
-            normalize_members(expr['data'])
             check_alternate(expr, info)
         elif meta == 'struct':
-            check_keys(expr, info, meta,
-                       ['struct', 'data'], ['base', 'if', 'features'])
-            normalize_members(expr['data'])
             check_struct(expr, info)
         elif meta == 'command':
-            check_keys(expr, info, meta,
-                       ['command'],
-                       ['data', 'returns', 'boxed', 'if', 'features',
-                        'gen', 'success-response', 'allow-oob',
-                        'allow-preconfig', 'coroutine'])
-            normalize_members(expr.get('data'))
             check_command(expr, info)
         elif meta == 'event':
-            check_keys(expr, info, meta,
-                       ['event'], ['data', 'boxed', 'if', 'features'])
-            normalize_members(expr.get('data'))
             check_event(expr, info)
         else:
             assert False, 'unexpected meta type'
-- 
2.26.2


