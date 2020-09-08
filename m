Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6250CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B694C21532
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiKQoBnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B694C21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFXXl-00030L-Oz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWM-0001Fb-Sx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWJ-0008CX-RU
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599548062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0JZAzMlL7Xkk0++eImXbAXLot8IjA6/k/Y9LtwGs8Q=;
 b=FiKQoBnFX6wfDQAb1tAJRMpWq1Lhz0daIvxCrkhMpBiXJQBIb5H9r1kPQbXxvKg5829lzO
 E3/KRjOEup2VVJzFIAFrR4/V/zUhUv6vs0fAtklZjEW+nCzZVJH7zl61J0qoe6vqGhgHqA
 aYGLqKe0ii3StM/F7814exFF3Aw5y1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-xC50Hkq6NxKbXlQiOnywWg-1; Tue, 08 Sep 2020 02:54:20 -0400
X-MC-Unique: xC50Hkq6NxKbXlQiOnywWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88917802B79;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F01B5C1C4;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 852D611329B4; Tue,  8 Sep 2020 08:54:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] qapi: Reject section markup in definition documentation
Date: Tue,  8 Sep 2020 08:54:13 +0200
Message-Id: <20200908065417.3158250-2-armbru@redhat.com>
In-Reply-To: <20200908065417.3158250-1-armbru@redhat.com>
References: <20200908065417.3158250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Section markup in definition documentation makes no sense and can
produce invalid Texinfo.  Reject.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200320091805.5585-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt           |  2 ++
 scripts/qapi/parser.py                 |  5 +++++
 tests/qapi-schema/doc-bad-section.err  |  1 +
 tests/qapi-schema/doc-bad-section.json |  3 +--
 tests/qapi-schema/doc-bad-section.out  | 24 ------------------------
 5 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f3e7ced212..9eede44350 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -835,6 +835,8 @@ Double the '=' for a subsection title:
 
     # == Subsection title
 
+Both are only permitted in free-form documentation.
+
 '|' denotes examples:
 
     # | Text of the example, may span
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index abadacbb0e..f12c67d7d2 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -282,6 +282,11 @@ class QAPISchemaParser:
                 doc.end_comment()
                 self.accept()
                 return doc
+            if self.val.startswith('# ='):
+                if doc.symbol:
+                    raise QAPIParseError(
+                        self,
+                        "unexpected '=' markup in definition documentation")
             doc.append(self.val)
             self.accept(False)
 
diff --git a/tests/qapi-schema/doc-bad-section.err b/tests/qapi-schema/doc-bad-section.err
index e69de29bb2..785cacc08c 100644
--- a/tests/qapi-schema/doc-bad-section.err
+++ b/tests/qapi-schema/doc-bad-section.err
@@ -0,0 +1 @@
+doc-bad-section.json:5:1: unexpected '=' markup in definition documentation
diff --git a/tests/qapi-schema/doc-bad-section.json b/tests/qapi-schema/doc-bad-section.json
index 560df4b087..8175d95867 100644
--- a/tests/qapi-schema/doc-bad-section.json
+++ b/tests/qapi-schema/doc-bad-section.json
@@ -1,9 +1,8 @@
 # = section within an expression comment
-# BUG: not rejected
 
 ##
 # @Enum:
-# == Produces *invalid* texinfo
+# == No good here
 # @one: The _one_ {and only}
 #
 # @two is undocumented
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
index 367e2a1c3e..e69de29bb2 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,24 +0,0 @@
-module None
-object q_empty
-enum QType
-    prefix QTYPE
-    member none
-    member qnull
-    member qnum
-    member qstring
-    member qdict
-    member qlist
-    member qbool
-module doc-bad-section.json
-enum Enum
-    member one
-    member two
-doc symbol=Enum
-    body=
-== Produces *invalid* texinfo
-    arg=one
-The _one_ {and only}
-    arg=two
-
-    section=None
-@two is undocumented
-- 
2.26.2


