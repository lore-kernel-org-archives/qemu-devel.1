Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C438C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C294207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQGQ/fX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C294207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMQx-00072J-BT
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMNu-0001ro-1K
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:32:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMNt-0006bj-8N
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590687120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TddrJguzfrgaRLDyn9iGC2VgogValgksso5e1JtaPfc=;
 b=ZQGQ/fX3Fb5tKbyhT4XfyW761090XhrgnTsvHhyR5/JinyY8w+eALPOteD3Io5ssO4oBVe
 EyUN46D9WeYBpZ3j6Bj9/aPYxZRroeRDTq6SjsYsxHqEI1RckpGn7PZycIM75SlnT6K5gJ
 KpP6uH4Ln4ULaPwlr5JwY3A0KQnE9zg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-jjIXJNAhNKGPi4mOUFJDDA-1; Thu, 28 May 2020 13:31:59 -0400
X-MC-Unique: jjIXJNAhNKGPi4mOUFJDDA-1
Received: by mail-wm1-f71.google.com with SMTP id f62so1236296wme.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TddrJguzfrgaRLDyn9iGC2VgogValgksso5e1JtaPfc=;
 b=bJubmDppVtb3aUXXZk34eKOAHqG5pvCEw0aQaHP8UXPcaV+SnWgyDfMQEcNWdExIEY
 a2lxoIAV2jIqumnUUGMfBLwN004hTxQp/n4i2DZQfggPUse0a4su1ybh/SroXX7DQq0H
 Rp3/mMHh6dT7oelZWzDqjWgRmfE3uA+ied8QJn5ndrZZ/91JKFhY/XmCl6eyplIt1K0Q
 eLgQs2Kdi0kgwH5Gxr9RV5FCCsjBXh7nflRyUThtX+QinFHlOuplP4YlDmyUE1If8W7V
 aBkJrlHS9fw6WlX1niKteV6H/W8d2K82IuwKth9bgnXraehCq3/ziPau+YP7p2ZzJqPZ
 1CGg==
X-Gm-Message-State: AOAM532TAx72QVth6IUC4IGT0YTEbY7b9XtzvwBNOlipgQMvvXj1xJhs
 6rG/paQQy1uuFrUGBTIF20oY2TpUltg+NH2WRwLS7xvuISKslMkkTqGnylIMejW+yz0NN8sPiZy
 00yUKBIqUxGy5RiQ=
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr2364363wru.15.1590687117763;
 Thu, 28 May 2020 10:31:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNeNgWBqPsZnE7gm4tx+jJtKg01QrNUTp0Qgr4IMdi7C0TLrnyvoknGnzEE2HFtbNgmLdbAA==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr2364339wru.15.1590687117612;
 Thu, 28 May 2020 10:31:57 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id y207sm8403040wmd.7.2020.05.28.10.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 10:31:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v7 3/5] softmmu/vl: Allow -fw_cfg 'gen_id' option to use
 the 'etc/' namespace
Date: Thu, 28 May 2020 19:31:39 +0200
Message-Id: <20200528173141.17495-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528173141.17495-1-philmd@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User-generated fw_cfg keys should be prefixed with "opt/".
However FW_CFG_DATA_GENERATOR keys are generated by QEMU,
so allow the "etc/" namespace in this specific case.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v7: reword commit description and added comment in code
---
 softmmu/vl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index cdb1d187ed..d5423eaf2b 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2049,7 +2049,13 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
                    FW_CFG_MAX_FILE_PATH - 1);
         return -1;
     }
-    if (strncmp(name, "opt/", 4) != 0) {
+    if (!nonempty_str(gen_id)) {
+        /*
+         * In this particular case where the content is populated
+         * internally, the "etc/" namespace protection is relaxed,
+         * so do not emit a warning.
+         */
+    } else if (strncmp(name, "opt/", 4) != 0) {
         warn_report("externally provided fw_cfg item names "
                     "should be prefixed with \"opt/\"");
     }
-- 
2.21.3


