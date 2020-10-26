Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B838CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435AD207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHkjf7WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435AD207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAL1-0008Av-AT
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 17:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXAAk-00046j-7h
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXAAd-0001W3-1H
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603748210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaeIISdvKHLxN9nER0GC5PZOgVkEsw2xJcGmhNEMuAM=;
 b=cHkjf7WENJMmuHWsjYeTkwZJehIim6OI1AsOd/7a4TMZerHYjT0cT2Owj6ecE+PL9yjq/v
 sEI78StOxTtMRF5rJy44DEJm9Zl5c5SPocf9uqmmDwKV10kiAH2dp8NGEyqoJiLvyYQzu9
 dngDp5ejyAVUXNrPRilMCSATpyBGwfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-bKdD4lK1PsmTVCEfe_B4MA-1; Mon, 26 Oct 2020 17:36:48 -0400
X-MC-Unique: bKdD4lK1PsmTVCEfe_B4MA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF9818C89D5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 21:36:47 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 872401972B;
 Mon, 26 Oct 2020 21:36:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 09/16] qapi/expr.py: rewrite check_if
Date: Mon, 26 Oct 2020 17:36:30 -0400
Message-Id: <20201026213637.47087-10-jsnow@redhat.com>
In-Reply-To: <20201026213637.47087-1-jsnow@redhat.com>
References: <20201026213637.47087-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a only minor rewrite to address some minor style nits.  Don't
compare against the empty list to check for the empty condition, and
move the normalization forward to unify the check on the now-normalized
structure.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/expr.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index b393ccd30e92..4d4ee3daa002 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -143,15 +143,15 @@ def check_if_str(ifcond: object) -> None:
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


