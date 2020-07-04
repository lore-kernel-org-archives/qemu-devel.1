Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEBBC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B9D2184D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYIWe4FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B9D2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpwa-0005Ep-N2
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrple-0003rg-FK
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:32:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36463
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpla-0004A5-89
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnx5O7cQ73298hs0R7q+tCG4DHfssKmnNLY31qyZKnA=;
 b=RYIWe4FJnSPyNgb5ySDZQ+dYoYIyOoztlrL2oozXsG2JFhX/KeBEz5sFIpz+4dDqgAAzhn
 HNoXmFWQtrOfhEeNyM0b59yBpIPKr7PjerYQUDvV8XGilhTm4hHLgl1qn04YclzmrK49+D
 xh94ggFw7/BRtrqAW70432mqtr8wvGY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-42Sd_LZBMEiWoowMKcS_xQ-1; Sat, 04 Jul 2020 17:32:06 -0400
X-MC-Unique: 42Sd_LZBMEiWoowMKcS_xQ-1
Received: by mail-wm1-f70.google.com with SMTP id g187so40758270wme.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cnx5O7cQ73298hs0R7q+tCG4DHfssKmnNLY31qyZKnA=;
 b=SQO2Bd0TEU7rwa5VYKl0y4z0w8e/OlEEGpwBto5bBWev60Tq47aio7H7kj9lFSYzP+
 bj9Z/LJj72sj+wQC+K1QD6NEsbom8U3nymsWCKnLj8tirXl5tv3486CPPT2lH5VXYRLr
 oCooazVANDtP/vfKniv//FBswCWp+qA0cxolYM1O3opILvUvk9tSYMOKYn6tz5GKk2cK
 MsEh9YMZAhO5pCO0foZceJ/WheJYTiCtbLCCXFEJTXLoFlJ+Bx9u5xvNSMOpsYmT9SVB
 fMmIUWd2Il1h4/dEL3xbzLf1U5TITfGjoCADVvPWWlmCccDs9Pn3DqhmGsZBvxB9Pc/e
 bIYg==
X-Gm-Message-State: AOAM532bFNapLU1r1hQIjjVTy767Yr+/1ASz607BTUUHRER4NBJha0Pj
 S2uKNdJUHNmUN3liJuhLtvzMpx6QBnPKmnx8HS6B54zP3BZW8t2+2L7t6FuJqoXYuNMeEM9+Dq9
 0/RC4Y+aX+9rymRw=
X-Received: by 2002:a7b:c210:: with SMTP id x16mr18515164wmi.178.1593898325525; 
 Sat, 04 Jul 2020 14:32:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDywWeVhKAT9NqaNBQfOcgdd9QVPM1mgFtCiChV4xTMCMRRt5vEK1/7to6mYAErkkGKwqMMQ==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr18515153wmi.178.1593898325366; 
 Sat, 04 Jul 2020 14:32:05 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j4sm13607933wrp.51.2020.07.04.14.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:32:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 15/16] block/nvme: Move nvme_poll_cb() earlier
Date: Sat,  4 Jul 2020 23:30:50 +0200
Message-Id: <20200704213051.19749-16-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704213051.19749-1-philmd@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use this callback in nvme_add_io_queue()
in the next commit. To avoid forward-declaring it, move
it before. No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index a6ff660ad2..42c0d5284f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -638,6 +638,15 @@ static void nvme_handle_event(EventNotifier *n)
     nvme_poll_queues(s);
 }
 
+static bool nvme_poll_cb(void *opaque)
+{
+    EventNotifier *e = opaque;
+    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
+
+    trace_nvme_poll_cb(s);
+    return nvme_poll_queues(s);
+}
+
 static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
@@ -680,15 +689,6 @@ out_error:
     return false;
 }
 
-static bool nvme_poll_cb(void *opaque)
-{
-    EventNotifier *e = opaque;
-    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
-
-    trace_nvme_poll_cb(s);
-    return nvme_poll_queues(s);
-}
-
 static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
-- 
2.21.3


