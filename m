Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19DBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC0D206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iucCv+0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC0D206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6cK-0003dd-Vv
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6Vg-0003E8-Ff
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6Ve-0001ZU-7K
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPSewU/obJZZ+xmFVwvCb+4WWA37/u+KC2O9DKCBvlk=;
 b=iucCv+0bQQGTuwF3+Fp6e/KycyAWoEeeQgyevSkOP5b4fqcXgC8bb+kXRieq9ibchcVhnN
 nKODkITe+zpoSY6b4oLZ1SRTcMCrCAzvo6BLBKd9aiNmUy5b5+5cQ82T9d4ioDruMSIili
 aAHcinpCE2KBLHOMyrYSCAN0mGnj4Ng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-7DP-mpoRPMmT2PFdAFugSQ-1; Thu, 15 Oct 2020 12:53:37 -0400
X-MC-Unique: 7DP-mpoRPMmT2PFdAFugSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DB2480363A;
 Thu, 15 Oct 2020 16:53:36 +0000 (UTC)
Received: from localhost (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C65C16EF68;
 Thu, 15 Oct 2020 16:53:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] qapi: introduce IfPredicateList and IfAny
Date: Thu, 15 Oct 2020 20:52:50 +0400
Message-Id: <20201015165255.1573897-5-marcandre.lureau@redhat.com>
In-Reply-To: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
References: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Generalize IfAll to allow 'any' conditions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 29e0697c27..f5166e0bad 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -215,25 +215,37 @@ class IfOption(IfPredicate):
         return self.option == other.option
 
 
-class IfAll(IfPredicate):
+class IfPredicateList(IfPredicate):
+    C_OP = ""
+
     def __init__(self, pred_list: Sequence[IfPredicate]):
         self.pred_list = pred_list
 
     def cgen(self) -> str:
-        return " && ".join([p.cgen() for p in self.pred_list])
+        op = " " + self.C_OP + " "
+        return "(%s)" % op.join([p.cgen() for p in self.pred_list])
 
     def __bool__(self) -> bool:
         return bool(self.pred_list)
 
     def __repr__(self) -> str:
-        return f"IfAll({self.pred_list})"
+        ty = type(self)
+        return f"{ty.__qualname__}({self.pred_list})"
 
     def __eq__(self, other: object) -> bool:
-        if not isinstance(other, IfAll):
+        if not isinstance(other, type(self)):
             return False
         return self.pred_list == other.pred_list
 
 
+class IfAll(IfPredicateList):
+    C_OP = "&&"
+
+
+class IfAny(IfPredicateList):
+    C_OP = "||"
+
+
 class IfCond:
     def __init__(self, ifcond: Optional[Sequence[str]] = None):
         pred_list = [IfOption(opt) for opt in ifcond or []]
-- 
2.28.0


