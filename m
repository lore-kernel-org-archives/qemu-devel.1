Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7534FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A2720663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Ifm+oVoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A2720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvuY0-0005bJ-JC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 23:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jvuXN-0004u9-0W
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 23:26:21 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jvuXL-0001ZY-F2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 23:26:20 -0400
Received: by mail-lj1-x243.google.com with SMTP id x9so5422581ljc.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bEPjoiPi7H2qfpIIVg3VIa6tY0m8LPlx2RcrM5pbFuU=;
 b=Ifm+oVoaYqrYOslWcjkxN3jXKYSuhXc9/n6f2bPnZKiE7GSJLV0qA1SyuLttqHiBs2
 jIuALbl3RwuHVxMmMpE6mrKQ0syENQWttEmBPvaZewWB9/ldyQQ4JLwkPxGE9l4q55sL
 /Jqpbl+TfwkE8if0GrjbX5NWmttEjcUfOfSYS8tkXFzadnH84lNm4I2184KFTo0DhoGD
 pStYtNJN/YZqfkWOs20FZXehSdXXqT7tEkJgBN+SLzV1k8AbnaGMqZCjCDbKprTfu9x6
 NRNi60IBsdDgj0DtDkR+KCew6ZIZSMZLHoew+JF6RtKhFTuD9OngAjh62wcTzBHvKNwn
 6pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bEPjoiPi7H2qfpIIVg3VIa6tY0m8LPlx2RcrM5pbFuU=;
 b=PtTt2z5t68+PEx0klLaqIUKrkxBk1arb5C+qIa9AxEaUwk92h/3pfMnKEINP48vBup
 pDLassgRKPOQakrCqH/lhLgfVW9uM7KlDOgslnWiOZe/f+dIeMs7EQVD4cF7UlpDQzLP
 TUUzSMjcze0Eg3GM9j5yrRQ+qPdUtzwJ2pl9/8K1/7Zc1SjYf8NoUNRZWUF23f43bSNH
 xJMxjbY8W+cGlPp75qsw1foc78i0Uq2t0sScaI+IZe7Q3AMI34f+HPWqCqBAuPyUclsD
 zifkyAbPWv1Glfg1fKDW7qWZSwQnKR/z25sXzcTAfjS1oRrthSOKXD4xNi3Gj/4qZLa/
 wgSg==
X-Gm-Message-State: AOAM530/dDJ3iYb3D/O6QYf82edD2+incORqhOcPFY9p9aMiPlz1THwu
 jTSE4hXO1OzcmUeOdytJqe8PdxP2s3JJEA==
X-Google-Smtp-Source: ABdhPJyTQVCNczsCBo7r2ndHPndfPCXIt1QsFefqk4g2IjB2Nuz3F7Pz8h86i2cWkMYCxX7Eqr8How==
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr935750ljk.327.1594869977333; 
 Wed, 15 Jul 2020 20:26:17 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id a23sm887899lfb.10.2020.07.15.20.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 20:26:16 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH] hmp: Changed hmp_netdev_add() using qmp_marshal_netdev_add()
Date: Thu, 16 Jul 2020 06:55:32 +0300
Message-Id: <20200716035532.1407660-1-andrew@daynix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::243;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

There is an issue, that netdev can't be removed if it was added using hmp.
The bug appears after 08712fcb851034228b61f75bd922863a984a4f60 commit.
It happens because of unclear QemuOpts that was created during
hmp_netdev_add(), now it uses qmp analog function -
qmp_marshal_netdev_add().

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 monitor/hmp-cmds.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 2b0b58a336..b747935687 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1597,19 +1597,10 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 void hmp_netdev_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
-    QemuOpts *opts;
-
-    opts = qemu_opts_from_qdict(qemu_find_opts("netdev"), qdict, &err);
-    if (err) {
-        goto out;
-    }
+    QDict *non_constant_dict = qdict_clone_shallow(qdict);
 
-    netdev_add(opts, &err);
-    if (err) {
-        qemu_opts_del(opts);
-    }
-
-out:
+    qmp_marshal_netdev_add(non_constant_dict, NULL, &err);
+    qobject_unref(non_constant_dict);
     hmp_handle_error(mon, err);
 }
 
-- 
2.27.0


