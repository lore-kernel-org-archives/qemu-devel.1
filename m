Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0537C4363D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829FB20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkCVLQ1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829FB20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPS83-0003pM-H6
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6t-0002Ec-PV
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6s-0002B2-4H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601910545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8HvFbMwn8LXryreWytPx2pphwh/293AKkCKPj/4rNc=;
 b=ZkCVLQ1t6dsdUOj6nIee+dgaicAkz4kfcIL75SDdhhqLqTxTebSOhHjMpBgbYmY2fEhs+u
 vMX8RwgEZg/jp/MAHZbA/kZ0aLXLTAkdFb0KFn5faCcAjsyoGVZJdYFUkti8dRETvow9mu
 JO4Su/s6gOmwxeQ3/IQ4PzhgWMS77So=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404--3d2-SHsO96BMKtFByDeIA-1; Mon, 05 Oct 2020 11:09:04 -0400
X-MC-Unique: -3d2-SHsO96BMKtFByDeIA-1
Received: by mail-wm1-f71.google.com with SMTP id l15so1819628wmh.9
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x8HvFbMwn8LXryreWytPx2pphwh/293AKkCKPj/4rNc=;
 b=nse3p0v3geMjZaiwyBnnxux9Cb4ayLjnZu5VsFmJyECfQeDKY8pZP51d49D6fee8/A
 QPX7bXRHvKFdbNDf25C9x21pDCNLX3ScQjVRqGDzN7QpXBYYEWgc0cryXgf1rGrxBpv3
 9kf5zHL9wtqTzA4bLMTVJTjfv2EQjmo4oKAhnysm2Xa2T3fSIwyl91MPzRObCMdkgBX/
 G32Vw4PhGGVCOV/mqzZtKrzlqzwJjROOMSOM+lNFjZIZBmQNEqBPCS1xvSN86Wvvunna
 n3l1bwdunenAtIFkeNEEXie7/Yed3P412yjUE3ElKOkUMyO/y6bFwfK1bf9KyOj8AKh/
 CDNQ==
X-Gm-Message-State: AOAM532HvZ7/0js4ajawrY9BnjNoWbxdUvH4QIGC5p6wfX2u4XUTn6ZF
 xBOvKjOUitTOqrzv9/L6/DlhjyHythNPWC6NKAVoe9t+qdMnIKUPbVl/ecZXykhrSwgwFUQogUJ
 Wl9aAIoJNZtPXmqM=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr91478wml.42.1601910542865; 
 Mon, 05 Oct 2020 08:09:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywnV+Ar0B1xB8rrlin3Saz9kF4Oz6jGmOK7PH7MBrvBVKp6mF3fGZfllbHaRutIz+7yfK5+w==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr91441wml.42.1601910542639; 
 Mon, 05 Oct 2020 08:09:02 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z83sm69496wmb.4.2020.10.05.08.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:09:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/4] hw/mips/Kconfig: Let boston machine select FDT
Date: Mon,  5 Oct 2020 17:08:44 +0200
Message-Id: <20201005150845.2124381-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005150845.2124381-1-philmd@redhat.com>
References: <20201005150845.2124381-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'boston' machine is the only MIPS one using QEMU FDT API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 67d39c56a4..faf4c3a606 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -51,3 +51,4 @@ config MIPS_CPS
 
 config MIPS_BOSTON
     bool
+    select FDT
-- 
2.26.2


