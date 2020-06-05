Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C81C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22FD2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBFScNtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22FD2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGj2-0006xx-8o
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGcW-0005iw-Bp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:59:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGcV-0000cB-HL
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591379946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyEDe8wylZalxNMNSz6RpL3nleNnTxzk4iV0Jrd1pvo=;
 b=DBFScNtgrbU+4dQcoFbbioUs4V1nwWurBOfndOxjPqSOsdXVnlJ/51u3lGv9nmjCb4BAAK
 vMXm8pl/4UgS8dbOP0A7bh3S2ycC9kSsUMyUATAVkrS/BAVFMgR10wvTvB0uT4lo/jgxBs
 PUuTiRhLqcDd3kxsvhlMoBCHXfwPoMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-QURzoE9jPpKD4KjSl37s8w-1; Fri, 05 Jun 2020 13:59:05 -0400
X-MC-Unique: QURzoE9jPpKD4KjSl37s8w-1
Received: by mail-wr1-f69.google.com with SMTP id o1so4044969wrm.17
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TyEDe8wylZalxNMNSz6RpL3nleNnTxzk4iV0Jrd1pvo=;
 b=aQs5K5QZYy6R/7oPIhaAXEtws8Jnpeo+seJeWhiss//50vIuo85TyGyqGQr6vkMvKJ
 ddgYWjkbvzIbh56gAr1khSIW77iMna4he2GJhdOYpKY6iVI6kDuHaXLuhTS24xr1v4GL
 lZE4mZ6uVVZiPCZBTmXSuRhTuyMO+FuDQVRoRMsnDSS4LeeHesA3ojdoKhF93VWnf8JF
 SbhZ3PP/rx63yMUdmru3wrd/YDb1qKD03FhcengDuY+M6lOcTXadA6XFRbOX7hI0dQX7
 ILcHC788X0GdY35F5n14G9CrODgbxj8oSz+tMlmQn2/ALn6ogpwEu1grCGwavGbYSevH
 16rQ==
X-Gm-Message-State: AOAM533Epe2yH/h2FJQS4K4zYzAcUGEL29nueYzYWKZsjFEURLJOV978
 gOTED6PzKDVsXtj219IQ08WY5doHIHpmmJThjLPRtgK+CQl2vEISxIODoY+Fl2uw7F27uSIcdW/
 EF9rAUZpOcF6YXAM=
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr3946375wml.48.1591379943911; 
 Fri, 05 Jun 2020 10:59:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlu+u6u7HSOzbgZ3HgkyyUSLpUGoHDDd461frAEbaTOzerWBp36tap+O9fZvpH6+oEEoReBA==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr3946365wml.48.1591379943748; 
 Fri, 05 Jun 2020 10:59:03 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id f9sm4398715wrf.74.2020.06.05.10.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:59:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/11] accel/Kconfig: Extract accel selectors into their
 own config
Date: Fri,  5 Jun 2020 19:58:18 +0200
Message-Id: <20200605175821.20926-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605175821.20926-1-philmd@redhat.com>
References: <20200605175821.20926-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the accel selectors from the global Kconfig.host to their
own Kconfig file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile      | 1 +
 Kconfig.host  | 7 -------
 accel/Kconfig | 6 ++++++
 3 files changed, 7 insertions(+), 7 deletions(-)
 create mode 100644 accel/Kconfig

diff --git a/Makefile b/Makefile
index 7666f81e8a..648757f79a 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,7 @@ MINIKCONF_ARGS = \
     CONFIG_PVRDMA=$(CONFIG_PVRDMA)
 
 MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host \
+                   $(SRC_PATH)/accel/Kconfig \
                    $(SRC_PATH)/hw/Kconfig
 MINIKCONF_DEPS = $(MINIKCONF_INPUTS) \
                  $(wildcard $(SRC_PATH)/hw/*/Kconfig)
diff --git a/Kconfig.host b/Kconfig.host
index 55136e037d..a6d871c399 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -2,9 +2,6 @@
 # down to Kconfig.  See also MINIKCONF_ARGS in the Makefile:
 # these two need to be kept in sync.
 
-config KVM
-    bool
-
 config LINUX
     bool
 
@@ -31,10 +28,6 @@ config VHOST_KERNEL
     bool
     select VHOST
 
-config XEN
-    bool
-    select FSDEV_9P if VIRTFS
-
 config VIRTFS
     bool
 
diff --git a/accel/Kconfig b/accel/Kconfig
new file mode 100644
index 0000000000..c21802bb49
--- /dev/null
+++ b/accel/Kconfig
@@ -0,0 +1,6 @@
+config KVM
+    bool
+
+config XEN
+    bool
+    select FSDEV_9P if VIRTFS
-- 
2.21.3


