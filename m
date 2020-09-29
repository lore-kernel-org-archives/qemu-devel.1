Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE1FC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1B520756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpG+b/lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1B520756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOWJ-0000Qw-2Y
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMM-0005py-2h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMK-0004bL-Du
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:33 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7QZwS1vfY6pxc/yL3I5YaiK5BX/yKl7ag6KjP4fakU=;
 b=GpG+b/lWH5CaNRA7+1GUQ57KcLCLoLgqp74gvQPvjXvBHIwc/RKgzni9R7q1xtS0MLzQlI
 eGIrcgR3ShObSxtLSWOAjvjdp0jyLP7MY8SqrOtt+0k/45lAyhZO7AGuINbmKq44QCFSAk
 sSYEwiL6MNKOCWrLN8Eyz4j3Mky8uww=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-SnJ6O-4pM6qZIXjX7fIRZQ-1; Tue, 29 Sep 2020 18:44:30 -0400
X-MC-Unique: SnJ6O-4pM6qZIXjX7fIRZQ-1
Received: by mail-wr1-f72.google.com with SMTP id d9so2348346wrv.16
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i7QZwS1vfY6pxc/yL3I5YaiK5BX/yKl7ag6KjP4fakU=;
 b=aQJSZcwwIQdDDXdQcUsLFOuY3PXMtca0c7E46MzMWYmsFxgn6BGhsRXTBrf34RHVKh
 zDziqv5xIANbwBSa+DGHUYJuDZskYKKd+ygCRGk6hdy5wYCL4qFXzImTPqYWayttBngl
 nMJbTQ9f/rZ40/LnzpYg7E96c8rCnXxeG0mtNvaLfpfi8jb6o/8pH1I/2GXTdTvwyJyO
 /1oiiv2lMd4DiFOEzMqki3mDbLpxkRmgV9rR4OREWhW2ANsl8/1dA6pu9zB7O6cJVvMj
 Rv+QBGgsdt+RYmaIi3BvPUrvsqrhDB4V50hhk7F9yyw9WcE5de10nUeN5BkWiNGdXHdx
 G+wA==
X-Gm-Message-State: AOAM531NBep4wyFUXPo7ZdG9j+pSZK+Eo3p4ut8vS3jSWOTPYkoVWMvV
 0xQvjrYUqrtZh394RdCXvtIHnZYvGJbeYvbD1aIhj/PsmJXk9HJuZyOVbwxdstMneX3XBrm2Ifp
 /ui9SID5Hxu5FqgE=
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr7104484wrm.150.1601419468594; 
 Tue, 29 Sep 2020 15:44:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweTjjV4JKSEFC7bdGe1az/c9DKmrvmR/EC6wrTRHkRT+Xz0xLKGZVKIrTri3by7ejJMMBAyw==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr7104459wrm.150.1601419468383; 
 Tue, 29 Sep 2020 15:44:28 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id j10sm7850036wrn.2.2020.09.29.15.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/12] target/arm: Restrict ARMv6 cpus to TCG accel
Date: Wed, 30 Sep 2020 00:43:49 +0200
Message-Id: <20200929224355.1224017-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929224355.1224017-1-philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM requires a cpu based on (at least) the ARMv7 architecture.

Only enable the following ARMv6 CPUs when TCG is available:

  - ARM1136
  - ARM1176
  - ARM11MPCore
  - Cortex-M0

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d2876b2c8b..e01eb55bc0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -6,6 +6,10 @@ config ARM_V5
     bool
     select TCG
 
+config ARM_V6
+    bool
+    select TCG
+
 config ARM_VIRT
     bool
     imply PCI_DEVICES
@@ -123,6 +127,7 @@ config NETDUINOPLUS2
 
 config NSERIES
     bool
+    select ARM_V6
     select OMAP
     select TMP105   # tempature sensor
     select BLIZZARD # LCD/TV controller
@@ -391,6 +396,7 @@ config FSL_IMX25
 
 config FSL_IMX31
     bool
+    select ARM_V6
     select SERIAL
     select IMX
     select IMX_I2C
-- 
2.26.2


