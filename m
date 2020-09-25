Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DDBC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FB6238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV2FsxJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FB6238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLblv-0001P3-Lf
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbw-0000my-UZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbu-00009I-JZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvIQsDwNl+94LSH/6oLoNRcB7oBvAmpNhdtuAr1b5VE=;
 b=bV2FsxJIqDuDnlyGAQ6uiSpwhkHeemGiWme1XL1N1RbdjIDpczre12vkeIyPlr8IV1qAgN
 u3XCyYAyRA6MFlsqHmV3bHd1qQDt+R+6gHVqB/AVo2Ezo/2XLj7PjhS18L2sQmxrxnKUQg
 UdsCyR2U5MT2JS1LqaDkoK6h5XVPM28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-GLmoNCc-PUmnLyKOAzuYcg-1; Thu, 24 Sep 2020 20:29:06 -0400
X-MC-Unique: GLmoNCc-PUmnLyKOAzuYcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 820F36408A
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:05 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE1235D9F1;
 Fri, 25 Sep 2020 00:29:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/47] qapi/doc.py: Change code templates from function to
 string
Date: Thu, 24 Sep 2020 20:28:18 -0400
Message-Id: <20200925002900.465855-6-jsnow@redhat.com>
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

For whatever reason, when these are stored as functions instead of
strings, it confuses sphinx-autodoc into believing them to be
docstrings, and it chokes on the syntax.

Keeping them as dumb strings instead avoids the problem.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index c41e9d29f5..d12eda9e1e 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -8,26 +8,26 @@
 from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
 
 
-MSG_FMT = """
+_MSG = '''
 @deftypefn {type} {{}} {name}
 
 {body}{members}{features}{sections}
 @end deftypefn
 
-""".format
+'''
 
-TYPE_FMT = """
+_TYPE = '''
 @deftp {{{type}}} {name}
 
 {body}{members}{features}{sections}
 @end deftp
 
-""".format
+'''
 
-EXAMPLE_FMT = """@example
+_EXAMPLE = '''@example
 {code}
 @end example
-""".format
+'''
 
 
 def subst_strong(doc):
@@ -57,7 +57,7 @@ def texi_example(doc):
     # function to subst_special() or subs_texi_special().  If we do that, we
     # need to delay it until after subst_vars() in texi_format().
     doc = subst_braces(doc).strip('\n')
-    return EXAMPLE_FMT(code=doc)
+    return _EXAMPLE.format(code=doc)
 
 
 def texi_format(doc):
@@ -90,7 +90,7 @@ def texi_format(doc):
         # Make sure to update section "Documentation markup" in
         # docs/devel/qapi-code-gen.txt when fixing this.
         if line.startswith('| '):
-            line = EXAMPLE_FMT(code=line[2:])
+            line = _EXAMPLE.format(code=line[2:])
         elif line.startswith('= '):
             line = '@section ' + line[2:]
         elif line.startswith('== '):
@@ -217,21 +217,21 @@ def texi_sections(doc, ifcond):
 
 
 def texi_type(typ, doc, ifcond, members):
-    return TYPE_FMT(type=typ,
-                    name=doc.symbol,
-                    body=texi_body(doc),
-                    members=members,
-                    features=texi_features(doc),
-                    sections=texi_sections(doc, ifcond))
+    return _TYPE.format(type=typ,
+                        name=doc.symbol,
+                        body=texi_body(doc),
+                        members=members,
+                        features=texi_features(doc),
+                        sections=texi_sections(doc, ifcond))
 
 
 def texi_msg(typ, doc, ifcond, members):
-    return MSG_FMT(type=typ,
-                   name=doc.symbol,
-                   body=texi_body(doc),
-                   members=members,
-                   features=texi_features(doc),
-                   sections=texi_sections(doc, ifcond))
+    return _MSG.format(type=typ,
+                       name=doc.symbol,
+                       body=texi_body(doc),
+                       members=members,
+                       features=texi_features(doc),
+                       sections=texi_sections(doc, ifcond))
 
 
 class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
-- 
2.26.2


