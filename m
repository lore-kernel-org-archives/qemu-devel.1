Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F6D206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtsMCa1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F6D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUoq-0007qo-W3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1joUl2-0002kF-8B
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:29:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1joUl0-0002UA-Mq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593102586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ayP1mCWFsPpODHDVmnJ8Vsl+6aR2uTSK1foOO3oEjo=;
 b=EtsMCa1/3qi0ZV4TRuqA53JIU6H6OqEphkAKCObB8es5HpRpSfJYKFYMO9Z8PWCN51JX2P
 UfIOjPD08IlpXWCts1mru14Zgt12uDnvD09IShefYaaaaTinNY9YsrtqS/fi7i5M5qguxF
 aSV3+5ZLQ1Jkq4MMczBzOcNOmBRTcEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-2Us3fmHPOVanKMugvYThCw-1; Thu, 25 Jun 2020 12:29:41 -0400
X-MC-Unique: 2Us3fmHPOVanKMugvYThCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0674107ACCD
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 16:29:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-254.ams2.redhat.com
 [10.36.114.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A542BD01E7;
 Thu, 25 Jun 2020 16:29:39 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, virtio-fs@redhat.com, stefanha@redhat.com,
 vgoyal@redhat.com
Subject: [PATCH 2/3] virtiofsd: Check capability calls
Date: Thu, 25 Jun 2020 17:29:28 +0100
Message-Id: <20200625162929.46672-3-dgilbert@redhat.com>
In-Reply-To: <20200625162929.46672-1-dgilbert@redhat.com>
References: <20200625162929.46672-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Check the capability calls worked.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index e373e3b36e..99d562046a 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2589,7 +2589,7 @@ static void setup_capabilities(void)
      */
     capng_setpid(syscall(SYS_gettid));
     capng_clear(CAPNG_SELECT_BOTH);
-    capng_updatev(CAPNG_ADD, CAPNG_PERMITTED | CAPNG_EFFECTIVE,
+    if (capng_updatev(CAPNG_ADD, CAPNG_PERMITTED | CAPNG_EFFECTIVE,
             CAP_CHOWN,
             CAP_DAC_OVERRIDE,
             CAP_DAC_READ_SEARCH,
@@ -2599,11 +2599,21 @@ static void setup_capabilities(void)
             CAP_SETUID,
             CAP_MKNOD,
             CAP_SETFCAP,
-            -1);
+            -1)) {
+        fuse_log(FUSE_LOG_ERR, "%s: capng_updatev failed\n", __func__);
+        exit(1);
+    }
 
-    capng_apply(CAPNG_SELECT_BOTH);
+    if (capng_apply(CAPNG_SELECT_BOTH)) {
+        fuse_log(FUSE_LOG_ERR, "%s: capng_apply failed\n", __func__);
+        exit(1);
+    }
 
     cap.saved = capng_save_state();
+    if (!cap.saved) {
+        fuse_log(FUSE_LOG_ERR, "%s: capng_save_state failed\n", __func__);
+        exit(1);
+    }
     pthread_mutex_unlock(&cap.mutex);
 }
 
-- 
2.26.2


