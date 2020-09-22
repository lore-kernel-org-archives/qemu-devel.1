Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2070C4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFC120BED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WISJy4pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFC120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr9n-0004eZ-8B
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2G-00022y-Jr
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2E-0000Mc-8v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZAEtLKopk829H7OKJ8rtnLJ/Xh1HLCsfdaUY3bhzkY=;
 b=WISJy4peJ6hLVkwu0G228byFlHbs+TlcuA01nD55SWMm9qp+S4Ez0+jv0cSz9iLpon/mst
 zkmZYANx+/baRNfb6IHcymg9JaUB9dgA2Og+m8+KdyPlVFy9GtTbT67T283g37wIvtdEfC
 3GAeqC8TzNA+nMXA4liNWFtN8WRYmAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-H1iVNuZ_OIylNndb7AhkkA-1; Tue, 22 Sep 2020 18:45:15 -0400
X-MC-Unique: H1iVNuZ_OIylNndb7AhkkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 402751005E66;
 Tue, 22 Sep 2020 22:45:14 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E17F5C1A3;
 Tue, 22 Sep 2020 22:45:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 06/25] qapi/schema.py: constrain QAPISchemaEvent arg_type type
Date: Tue, 22 Sep 2020 18:44:42 -0400
Message-Id: <20200922224501.4087749-7-jsnow@redhat.com>
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index c9a62711c2..aaf20f776b 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -792,13 +792,14 @@ def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
     def check(self, schema):
         super().check(schema)
         if self._arg_type_name:
-            self.arg_type = schema.resolve_type(
+            arg_type = schema.resolve_type(
                 self._arg_type_name, self.info, "event's 'data'")
-            if not isinstance(self.arg_type, QAPISchemaObjectType):
+            if not isinstance(arg_type, QAPISchemaObjectType):
                 raise QAPISemError(
                     self.info,
                     "event's 'data' cannot take %s"
-                    % self.arg_type.describe())
+                    % arg_type.describe())
+            self.arg_type = arg_type
             if self.arg_type.variants and not self.boxed:
                 raise QAPISemError(
                     self.info,
-- 
2.26.2


