Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3209C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8751D20757
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTsCFAi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8751D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr3t-0003tW-LA
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2C-0001wj-Rc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2B-0000KJ-82
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PlNM83s6DVVzNRgOd3tBHRT+FdvTT/OuXY5mruJgZU8=;
 b=JTsCFAi1XSd9EUVpdOtipbsUEsP6aaQBFKHu2pdvaz2zXDAfvH+RksMTCX9zcqvPznrSTp
 ckiVPMfkJsUwez45d15WyHnSeTEI8X3NA9by/lgXlHPrdr+3iNUhJ1pPtDm/Rkvh9+IjXf
 +b1OSeq+UYUso96nI9vWMcKWU7keSD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-lL9xakWLMR2VfU6EphOEoQ-1; Tue, 22 Sep 2020 18:45:12 -0400
X-MC-Unique: lL9xakWLMR2VfU6EphOEoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A20481CBEB;
 Tue, 22 Sep 2020 22:45:11 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B5D65C1A3;
 Tue, 22 Sep 2020 22:45:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 03/25] qapi/schema.py: add assert in stub methods
Date: Tue, 22 Sep 2020 18:44:39 -0400
Message-Id: <20200922224501.4087749-4-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
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

Instead of pass (an implicit return none), use raise NotImplementedError
to mark a function as abstract -- one that doesn't return. This allows
us to correctly type the stub.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 0201b42095..a53631e660 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -176,8 +176,8 @@ def visit(self, visitor):
 class QAPISchemaType(QAPISchemaEntity):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
-    def c_type(self):
-        pass
+    def c_type(self) -> str:
+        raise NotImplementedError()
 
     # Return the C type to be used in a parameter list.
     def c_param_type(self):
@@ -187,8 +187,8 @@ def c_param_type(self):
     def c_unboxed_type(self):
         return self.c_type()
 
-    def json_type(self):
-        pass
+    def json_type(self) -> str:
+        raise NotImplementedError()
 
     def alternate_qtype(self):
         json2qtype = {
-- 
2.26.2


