Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0126C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764C020715
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvQo5PIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764C020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqwK-00017x-EV
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt6-0004lu-HJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt4-0007g9-HX
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jx/RLJEheVGU74xhwDSBCExsWp4oxNEyMTUGMehjDwU=;
 b=DvQo5PIVqriNoVVXHBImWXeB3CkEPFiAP0E24JGjCDONhAYgtMFZk89KbOWMcfPBfLFhMo
 JM08d2jkGiOOmXy1gYKHlF1DfsRHpO59lv581um1kULcPfTmolZhxAQzx9xc3V/fA+dLLB
 NWWK1ss7nGYA1Yalk1H7EqcCDRqn0+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-tVCcdv-ONGuryEcPGvS1Bg-1; Tue, 22 Sep 2020 18:35:47 -0400
X-MC-Unique: tVCcdv-ONGuryEcPGvS1Bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A785681CBE9;
 Tue, 22 Sep 2020 22:35:46 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2E9860BF4;
 Tue, 22 Sep 2020 22:35:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 18/26] qapi/parser.py: Modify _include() to use parser state
Date: Tue, 22 Sep 2020 18:35:17 -0400
Message-Id: <20200922223525.4085762-19-jsnow@redhat.com>
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It doesn't need to take quite so many arguments.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 5b3a9b5da8..77067b2f5d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -144,8 +144,7 @@ def _parse(self) -> None:
                 incl_fname = os.path.join(os.path.dirname(self._fname),
                                           include)
                 self._add_expr(OrderedDict({'include': incl_fname}), info)
-                exprs_include = self._include(include, info, incl_fname,
-                                              self._included)
+                exprs_include = self._include(include, incl_fname)
                 if exprs_include:
                     self.exprs.extend(exprs_include.exprs)
                     self.docs.extend(exprs_include.docs)
@@ -179,26 +178,22 @@ def reject_expr_doc(cls, doc: Optional['QAPIDoc']) -> None:
                 "documentation for '%s' is not followed by the definition"
                 % doc.symbol)
 
-    @classmethod
-    def _include(cls,
-                 include: str,
-                 info: QAPISourceInfo,
-                 incl_fname: str,
-                 previously_included: Set[str]
-                 ) -> Optional['QAPISchemaParser']:
+    def _include(self, include: str,
+                 incl_fname: str) -> Optional['QAPISchemaParser']:
         incl_abs_fname = os.path.abspath(incl_fname)
+
         # catch inclusion cycle
-        inf = info
+        inf = self.info
         while inf:
             if incl_abs_fname == os.path.abspath(inf.fname):
-                raise QAPISemError(info, "inclusion loop for %s" % include)
+                raise QAPISemError(self.info, f"inclusion loop for {include}")
             inf = inf.parent
 
         # skip multiple include of the same file
-        if incl_abs_fname in previously_included:
+        if incl_abs_fname in self._included:
             return None
 
-        return QAPISchemaParser(incl_fname, previously_included, info)
+        return QAPISchemaParser(incl_fname, self._included, self.info)
 
     def accept(self, skip_comment: bool = True) -> None:
         """
-- 
2.26.2


