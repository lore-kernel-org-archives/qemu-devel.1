Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F76723D1F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ssm65922"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F76723D1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsP8-0004jn-MR
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpsMu-00007C-IB
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:54:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpsMs-0007GW-TN
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593431674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mji2VZefKYBc2WwzMHOzrV0/osx4TGutpi09pgSZE74=;
 b=Ssm65922WGOc49zH1f+ZzkQg921sdyZuBMzuIinisvJYbNutIBixoAOQ1jC8MJ4iMLuTcH
 fETt+RyiTsTt//anR7/L7vbo+SPvb/74oWAzfK+4tuEU0Atg8yIr4nPsHpqHYpS1LgfhJV
 CdG8buVuhz9YOyj17tfdUNc7V83hGiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-sJLutpjKPsafhlt0DHeWlQ-1; Mon, 29 Jun 2020 07:54:32 -0400
X-MC-Unique: sJLutpjKPsafhlt0DHeWlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A301AEC1A3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 11:54:31 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-210.ams2.redhat.com
 [10.36.114.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7C9796B8F;
 Mon, 29 Jun 2020 11:54:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, virtio-fs@redhat.com, stefanha@redhat.com,
 vgoyal@redhat.com
Subject: [PATCH v2 2/3] virtiofsd: Check capability calls
Date: Mon, 29 Jun 2020 12:54:19 +0100
Message-Id: <20200629115420.98443-3-dgilbert@redhat.com>
In-Reply-To: <20200629115420.98443-1-dgilbert@redhat.com>
References: <20200629115420.98443-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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


