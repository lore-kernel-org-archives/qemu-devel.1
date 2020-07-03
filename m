Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5677208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buxmrBPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5677208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNcy-0000Vo-4V
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrNbh-00073r-TP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:28:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrNbf-0006dW-Rc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593790080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pNmG9jjW2jNd4sNOYr7D1yE1KNWC5+nXpAgFyJUH6o=;
 b=buxmrBPZ7WceR724MDmbw9SxcC4mH2jO8L2YWi0fBm+B8YZAFtjRp/3CRTMF3qJFUakdWz
 6fvNwO7lJIDdbXpRhGe5ss4lgjzR1ek83vpwrELEtu8HBjtiE3hw/eCjtQzdAxQPvfw05Q
 qfYG6VBOyWqRUwXKERpApsJvCSm3QUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-OwTgMYSlMbKVglFi3mvbEg-1; Fri, 03 Jul 2020 11:27:56 -0400
X-MC-Unique: OwTgMYSlMbKVglFi3mvbEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00584A0BD7;
 Fri,  3 Jul 2020 15:27:56 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-207.ams2.redhat.com
 [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F247A1972A;
 Fri,  3 Jul 2020 15:27:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, zhukeqian1@huawei.com,
 stefanha@redhat.com
Subject: [PULL 2/5] virtiofsd: Check capability calls
Date: Fri,  3 Jul 2020 16:27:45 +0100
Message-Id: <20200703152748.277255-3-dgilbert@redhat.com>
In-Reply-To: <20200703152748.277255-1-dgilbert@redhat.com>
References: <20200703152748.277255-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Message-Id: <20200629115420.98443-3-dgilbert@redhat.com>
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


