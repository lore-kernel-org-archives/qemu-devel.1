Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3F9C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4332076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5Z0/IWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4332076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr5R-00061p-OZ
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt0-0004W3-EN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsy-0007e0-HA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HMxZnigJXfXaR7x/BM++m7Lnpe90f238nIkOFQGWJI=;
 b=f5Z0/IWv6cfkn79PmpMcEWt9sdL6ULsqqmc/VSoys3EsEds1geiFiVFMXIrER4Hi3XpeuN
 hl2iLcDHEC8Ke8yrTRn4dSsqWL6Z44IoXmbwgB1SjqVzc7WBUHY70BGMQJkmjWSprm2rRJ
 cc6/7H6t8AKl+XaFObUO5rDKSUQ7mUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-0Tf8tEh_M9mWFIl1M4_rGQ-1; Tue, 22 Sep 2020 18:35:40 -0400
X-MC-Unique: 0Tf8tEh_M9mWFIl1M4_rGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6230E186DD27;
 Tue, 22 Sep 2020 22:35:39 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 888A960CCC;
 Tue, 22 Sep 2020 22:35:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 11/26] qapi/parser.py: Convert several methods to @classmethod
Date: Tue, 22 Sep 2020 18:35:10 -0400
Message-Id: <20200922223525.4085762-12-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:00:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's usually nicer to keep static methods as class methods -- this
allows them to call other class methods, to be subclassed and extended,
etc.

Meanwhile, any method that doesn't utilize `self` can be a class method.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 756c904257..75a693a9d7 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -139,15 +139,16 @@ def _parse(self):
     def _parse_error(self, msg: str) -> QAPIParseError:
         return QAPIParseError.make(self, msg)
 
-    @staticmethod
-    def reject_expr_doc(doc):
+    @classmethod
+    def reject_expr_doc(cls, doc):
         if doc and doc.symbol:
             raise QAPISemError(
                 doc.info,
                 "documentation for '%s' is not followed by the definition"
                 % doc.symbol)
 
-    def _include(self, include, info, incl_fname, previously_included):
+    @classmethod
+    def _include(cls, include, info, incl_fname, previously_included):
         incl_abs_fname = os.path.abspath(incl_fname)
         # catch inclusion cycle
         inf = info
@@ -162,7 +163,8 @@ def _include(self, include, info, incl_fname, previously_included):
 
         return QAPISchemaParser(incl_fname, previously_included, info)
 
-    def _pragma(self, name, value, info):
+    @classmethod
+    def _pragma(cls, name, value, info):
         if name == 'doc-required':
             if not isinstance(value, bool):
                 raise QAPISemError(info,
-- 
2.26.2


