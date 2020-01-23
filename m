Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056A321D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsJAKLi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056A321D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuekL-00081E-M7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrX-0005Br-86
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrV-0003gU-5W
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrU-0003dt-V6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:33 -0500
Received: by mail-wm1-x336.google.com with SMTP id t23so2643262wmi.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8o2MYpvI7aFlrgYsavAuUGYtCTtrg8wkmD8yOXg8nnA=;
 b=fsJAKLi6UhEXrhKGxW9/uVdq7MtDu8rJJAwboEmWG13CgOtZpqyeTXFCB/Xf/1EbyN
 cEXWgR8OcsjFUVEcQxMlsuJnG+rbkBtKKWI/+nTWZfTcN61JtZ+FWA0mya5sXXRGUHLE
 pzVFm9VLYDcpEhckzDk53UD97FwaG1O3UAogA9ReXZAdsZ6FbPotondicqH4jEHB7frk
 DEAALTq31pdxf+x5S+pmk/ac+WABSwE6HVAjIab08yuiv0ATqAJRfxXs5vHgkFHwMsRQ
 EceSH0kXePf9LMHunNm+DkKbI71jcx/yomqgBXcAonKn3sgBVIS8sSNnEq9pVY3zvhC/
 BkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8o2MYpvI7aFlrgYsavAuUGYtCTtrg8wkmD8yOXg8nnA=;
 b=WED+LnA/MddkFgD+yrg8HMQ9NFlZRkv1DB0yfDFYiM/jc0ZjXLhOnFtvqAviqPaMBC
 7ebBNTXC6tcffQvZAeiGcIfo7csH5u2cR1uyj5emewSekbBQNtHp+wKn0HGbEIC0+qFG
 mdHGb1a39sPSS7rPl/bZvm9n5EouNMQM70abftJYw/Io35JBNFjA+VQBC8Qh4v7EM7PR
 8ur44pUUfYA+RNuvlMSOPJIAvKp4cZ69zD1D5c9+YuaBEf6ywUZv9wM+NHisoCBvYmdr
 B3I1boJx03D7AZJU49uBoig/INQK2DoElTTbKF8WaUpxy4PGA3dEjYb/rrWvE2dc84BC
 BVpw==
X-Gm-Message-State: APjAAAX6o+t9pvUSSX4h06ja7CLWQfLiYCUVhZ1Hg7wwVuTARFEO2DPE
 RTqdU5c7pJTqzPEfp3ppJR1CVrqP
X-Google-Smtp-Source: APXvYqzYl8unTyylQ2Jwcf3aclmnpGyRHmmIUo38uCC23TFafCmfTcTevXz/zEA8+A2YmMiICmiYRg==
X-Received: by 2002:a05:600c:1050:: with SMTP id
 16mr4460164wmx.86.1579787371810; 
 Thu, 23 Jan 2020 05:49:31 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/59] accel: Introduce the current_accel() wrapper
Date: Thu, 23 Jan 2020 14:48:31 +0100
Message-Id: <1579787342-27146-29-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The accel/ code only accesses the MachineState::accel field.
As we simply want to access the accelerator, not the machine,
add a current_accel() wrapper.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200121110349.25842-9-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c          | 5 +++++
 include/sysemu/accel.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/accel/accel.c b/accel/accel.c
index 1c5c3a6..cb555e3 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -63,6 +63,11 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
     return ret;
 }
 
+AccelState *current_accel(void)
+{
+    return current_machine->accelerator;
+}
+
 void accel_setup_post(MachineState *ms)
 {
     AccelState *accel = ms->accelerator;
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index d4c1429..47e5788 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -70,4 +70,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms);
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
 
+AccelState *current_accel(void);
+
 #endif
-- 
1.8.3.1



