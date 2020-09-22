Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E2C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEC2221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROqTwWxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEC2221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrFo-0006lZ-OF
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2A-0001uh-Or
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr29-0000IW-1a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JdZ+TveSLm9WMvQZT4ODeQh1hliceCe++JyKAmqb6c=;
 b=ROqTwWxh7kDVxGmEHEkCiwCxnzYToCgszn9vo4rzoHzzEAezsoP9Bwpz31pHmbLX5juSfa
 deaJsTWk/d0LpxXfroy/usUPGQaHo5/soO7lvqdyt4bq0faQDFr3EVn09u6+KCrHEmGoH4
 bnpjJ5J5DvoFsZbBmRcz18OAkYjb7VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-ov5rF7CUNMqcuA5kdQrP3g-1; Tue, 22 Sep 2020 18:45:10 -0400
X-MC-Unique: ov5rF7CUNMqcuA5kdQrP3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54912186DD28;
 Tue, 22 Sep 2020 22:45:09 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB045C1A3;
 Tue, 22 Sep 2020 22:45:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 01/25] qapi/schema: add Visitable mixin
Date: Tue, 22 Sep 2020 18:44:37 -0400
Message-Id: <20200922224501.4087749-2-jsnow@redhat.com>
In-Reply-To: <20200922224501.4087749-1-jsnow@redhat.com>
References: <20200922224501.4087749-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python doesn't have anything quite exactly like Traits, Interfaces, or
Mixins; but we can approximate it.

Add a 'Visitable' class that enforces a type signature for the visit()
method; this way, mypy is ensuring that even for otherwise unrelated
classes that do not inherit from a common base, this signature will
always be forced to be compatible.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 51af0449f5..55434f5c82 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -25,7 +25,13 @@
 from .parser import QAPISchemaParser
 
 
-class QAPISchemaEntity:
+class Visitable:
+    """Abstract duck that suggests a class is visitable."""
+    def visit(self, visitor: 'QAPISchemaVisitor') -> None:
+        raise NotImplementedError
+
+
+class QAPISchemaEntity(Visitable):
     meta: Optional[str] = None
 
     def __init__(self, name: str, info, doc, ifcond=None, features=None):
@@ -136,7 +142,7 @@ def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         pass
 
 
-class QAPISchemaModule:
+class QAPISchemaModule(Visitable):
     def __init__(self, name):
         self.name = name
         self._entity_list = []
@@ -812,7 +818,7 @@ def visit(self, visitor):
             self.arg_type, self.boxed)
 
 
-class QAPISchema:
+class QAPISchema(Visitable):
     def __init__(self, fname):
         self.fname = fname
         parser = QAPISchemaParser(fname)
-- 
2.26.2


