Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0DFC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A08E221E8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hot9pERb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A08E221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpnm-0000IP-Hy
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbX-0001ME-4d
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbV-00064d-4B
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Je01v8tianvun5dGhcapKD/fWgdPcSCTuzFS6zyvrOM=;
 b=Hot9pERbAl/29Zt9984dahKmxrx3IOahAiXR3Zg7h7ocDsWaZUQIc9EAlyDZJ157B3gyIV
 aAFQZoNZY92K3e5mls1zkegSb6YySGN1kqbLmpq5lc/0/zZ1MMk37DlrJrldeFxcnuZSsk
 r0m+6nRpl8+8Hsrp8LXQUnmQtl539dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-tnwVAhegNAic_vT0-kWgmg-1; Tue, 22 Sep 2020 17:13:34 -0400
X-MC-Unique: tnwVAhegNAic_vT0-kWgmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8820310BBEC3;
 Tue, 22 Sep 2020 21:13:33 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A89DD73670;
 Tue, 22 Sep 2020 21:13:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 15/16] qapi/expr.py: move related checks inside check_xxx
 functions
Date: Tue, 22 Sep 2020 17:13:12 -0400
Message-Id: <20200922211313.4082880-16-jsnow@redhat.com>
In-Reply-To: <20200922211313.4082880-1-jsnow@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's not a big obvious difference between the types of checks that
happen in the main function versus the kind that happen in the
functions. Now they're in one place for each of the main types.

As part of the move, spell out the required and optional keywords so
they're obvious at a glance.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/expr.py | 55 ++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 69ee9e3f18..74b2681ef8 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -333,6 +333,10 @@ def check_enum(expr: Expression, info: QAPISourceInfo) -> None:
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
@@ -363,6 +367,11 @@ def check_struct(expr: Expression, info: QAPISourceInfo) -> None:
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
 
@@ -377,6 +386,13 @@ def check_union(expr: Expression, info: QAPISourceInfo) -> None:
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
@@ -409,6 +425,11 @@ def check_alternate(expr: Expression, info: QAPISourceInfo) -> None:
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
@@ -432,6 +453,13 @@ def check_command(expr: Expression, info: QAPISourceInfo) -> None:
     :param expr: `Expression` to validate.
     :param info: QAPI source file information.
     """
+    check_keys(expr, info, 'command',
+               required=['command'],
+               optional=('data', 'returns', 'boxed', 'if', 'features',
+                         'gen', 'success-response', 'allow-oob',
+                         'allow-preconfig'))
+    normalize_members(expr.get('data'))
+
     args = expr.get('data')
     rets = expr.get('returns')
     boxed = expr.get('boxed', False)
@@ -453,6 +481,11 @@ def check_event(expr: Expression, info: QAPISourceInfo) -> None:
         if:       `Optional[Ifcond]`
         features: `Optional[Features]`
     """
+    normalize_members(expr.get('data'))
+    check_keys(expr, info, 'event',
+               required=['event'],
+               optional=('data', 'boxed', 'if', 'features'))
+
     args = expr.get('data')
     boxed = expr.get('boxed', False)
 
@@ -519,38 +552,16 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
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
-                        'allow-preconfig'])
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


