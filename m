Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7685E22B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsb3ceBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7685E22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFwD-0000KL-MQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFtR-0004Uy-0Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFtP-0000oP-5q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598526990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4NDq7xY/p5nEHU+fj0NRxwrZ3KkfBVlXtATn0X/fuM=;
 b=gsb3ceBNGH1vz4NDZRFHZtjPS+yln66epCW/OlBJbqgPyTf/+mitybAFa1ueoX6/6lo/MB
 9fnjqyzkqxnJVsAeU+fm8uPO7LUJsYjWilNH1X1tBytwuaREsVc3/Cj4oNonxgS86j3VVL
 XiNWulOV1P3jkh5OkqfGLLfATWHUenc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-ywK183ZVPm-1VzSDJyqixQ-1; Thu, 27 Aug 2020 07:16:28 -0400
X-MC-Unique: ywK183ZVPm-1VzSDJyqixQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B08E6420EA;
 Thu, 27 Aug 2020 11:16:27 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1066978370;
 Thu, 27 Aug 2020 11:16:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] migration: stop returning errno from load_snapshot()
Date: Thu, 27 Aug 2020 12:16:02 +0100
Message-Id: <20200827111606.1408275-4-berrange@redhat.com>
In-Reply-To: <20200827111606.1408275-1-berrange@redhat.com>
References: <20200827111606.1408275-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

None of the callers care about the errno value since there is a full
Error object populated. This gives consistency with save_snapshot()
which already just returns -1.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3826c437cc..711137bcbe 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2870,20 +2870,20 @@ int load_snapshot(const char *name, Error **errp)
     if (!replay_can_snapshot()) {
         error_setg(errp, "Record/replay does not allow loading snapshot "
                    "right now. Try once more later.");
-        return -EINVAL;
+        return -1;
     }
 
     if (!bdrv_all_can_snapshot(errp)) {
-        return -ENOTSUP;
+        return -1;
     }
     ret = bdrv_all_find_snapshot(name, errp);
     if (ret < 0) {
-        return ret;
+        return -1;
     }
 
     bs_vm_state = bdrv_all_find_vmstate_bs(errp);
     if (!bs_vm_state) {
-        return -ENOTSUP;
+        return -1;
     }
     aio_context = bdrv_get_aio_context(bs_vm_state);
 
@@ -2892,11 +2892,11 @@ int load_snapshot(const char *name, Error **errp)
     ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
     aio_context_release(aio_context);
     if (ret < 0) {
-        return ret;
+        return -1;
     } else if (sn.vm_state_size == 0) {
         error_setg(errp, "This is a disk-only snapshot. Revert to it "
                    " offline using qemu-img");
-        return -EINVAL;
+        return -1;
     }
 
     /* Flush all IO requests so they don't interfere with the new state.  */
@@ -2911,7 +2911,6 @@ int load_snapshot(const char *name, Error **errp)
     f = qemu_fopen_bdrv(bs_vm_state, 0);
     if (!f) {
         error_setg(errp, "Could not open VM state file");
-        ret = -EINVAL;
         goto err_drain;
     }
 
@@ -2927,14 +2926,14 @@ int load_snapshot(const char *name, Error **errp)
 
     if (ret < 0) {
         error_setg(errp, "Error %d while loading VM state", ret);
-        return ret;
+        return -1;
     }
 
     return 0;
 
 err_drain:
     bdrv_drain_all_end();
-    return ret;
+    return -1;
 }
 
 void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
-- 
2.26.2


