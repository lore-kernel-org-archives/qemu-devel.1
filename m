Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DDD2463C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXKDy1oD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DDD2463C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5Ft-000679-HI
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX5EO-0004Fn-Ne
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX5EL-00009O-FU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603729217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVKc2e9k/V1lT7QNozwVCIpi+MpJJr6mZH0jhTcph6A=;
 b=MXKDy1oDnPC2sDUm5qPFVTpjLtVX9w22MiTNjPtzcTS2ZDL14oozkZhjH+15pkcvpT1wy4
 l3kCksx+0lBf5Jha7MLXGTJvPVIFteTPzbsNuwGn5XHET3toPAKY+IVTmNXEvAjEtGhhEc
 cIhwpMeVorC1F6QoMIH/yg+Vc6XPTPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-10BFls6zODSOStrqmumSAA-1; Mon, 26 Oct 2020 12:20:13 -0400
X-MC-Unique: 10BFls6zODSOStrqmumSAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FCEC1084CA0;
 Mon, 26 Oct 2020 16:20:12 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F54D5D9E8;
 Mon, 26 Oct 2020 16:20:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, yubihong@huawei.com, peterx@redhat.com,
 peter.maydell@linaro.org
Subject: [PULL 03/16] migration: Don't use '#' flag of printf format
Date: Mon, 26 Oct 2020 16:19:39 +0000
Message-Id: <20201026161952.149188-4-dgilbert@redhat.com>
In-Reply-To: <20201026161952.149188-1-dgilbert@redhat.com>
References: <20201026161952.149188-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bihong Yu <yubihong@huawei.com>

Signed-off-by: Bihong Yu <yubihong@huawei.com>
Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1603163448-27122-3-git-send-email-yubihong@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/block.c | 2 +-
 migration/ram.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 4b8576b8d6..273392be78 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -998,7 +998,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
                    (addr == 100) ? '\n' : '\r');
             fflush(stdout);
         } else if (!(flags & BLK_MIG_FLAG_EOS)) {
-            fprintf(stderr, "Unknown block migration flags: %#x\n", flags);
+            fprintf(stderr, "Unknown block migration flags: 0x%x\n", flags);
             return -EINVAL;
         }
         ret = qemu_file_get_error(f);
diff --git a/migration/ram.c b/migration/ram.c
index 433489d633..6ed4f9e507 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3298,7 +3298,7 @@ static int ram_load_postcopy(QEMUFile *f)
             multifd_recv_sync_main();
             break;
         default:
-            error_report("Unknown combination of migration flags: %#x"
+            error_report("Unknown combination of migration flags: 0x%x"
                          " (postcopy mode)", flags);
             ret = -EINVAL;
             break;
@@ -3576,7 +3576,7 @@ static int ram_load_precopy(QEMUFile *f)
             if (flags & RAM_SAVE_FLAG_HOOK) {
                 ram_control_load_hook(f, RAM_CONTROL_HOOK, NULL);
             } else {
-                error_report("Unknown combination of migration flags: %#x",
+                error_report("Unknown combination of migration flags: 0x%x",
                              flags);
                 ret = -EINVAL;
             }
-- 
2.28.0


