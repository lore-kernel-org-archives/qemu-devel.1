Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34312C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF55D22262
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enDA81Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF55D22262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKq7t-0003YY-Rx
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbP-00014q-QN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbO-00063U-6k
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t3h9oDxjRXo+hECtZgRnukmRJ9G3Oo8Skvbxpet8Zc=;
 b=enDA81SqhnxAgiqjHXsLVQV+e/aOgVTLgW33A+Gi35HJ40ejtUOgwnIl8TUfcdw1Jbx5as
 AqOJMzOv0aNfsDYqsEeOiv67JeSjynew1bNKpVnSLyUs6x8KS3BLCMQV29aH0xRp+E4NWu
 PixSodHHHweLfTi1z2AcWKtPKzu5MY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-dvWLFTBYO9iIO7oiSEvv-w-1; Tue, 22 Sep 2020 17:13:27 -0400
X-MC-Unique: dvWLFTBYO9iIO7oiSEvv-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E74964088;
 Tue, 22 Sep 2020 21:13:26 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 414EF614F5;
 Tue, 22 Sep 2020 21:13:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 09/16] qapi/expr.py: rewrite check_if
Date: Tue, 22 Sep 2020 17:13:06 -0400
Message-Id: <20200922211313.4082880-10-jsnow@redhat.com>
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

This is a only minor rewrite to address some minor style nits.  Don't
compare against the empty list to check for the empty condition, and
move the normalization forward to unify the check on the now-normalized
structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/expr.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 6b064a2138..5d5c3d050d 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -136,15 +136,15 @@ def check_if_str(ifcond: object) -> None:
     ifcond = expr.get('if')
     if ifcond is None:
         return
-    if isinstance(ifcond, list):
-        if ifcond == []:
-            raise QAPISemError(
-                info, "'if' condition [] of %s is useless" % source)
-        for elt in ifcond:
-            check_if_str(elt)
-    else:
-        check_if_str(ifcond)
-        expr['if'] = [ifcond]
+
+    if not isinstance(ifcond, list):
+        ifcond = [ifcond]
+        expr['if'] = ifcond
+    if not ifcond:
+        raise QAPISemError(
+            info, "'if' condition [] of %s is useless" % source)
+    for elt in ifcond:
+        check_if_str(elt)
 
 
 def normalize_members(members: object) -> None:
-- 
2.26.2


