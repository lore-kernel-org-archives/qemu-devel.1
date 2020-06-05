Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB00206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaoyXzhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB00206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8q2-0004HP-Jp
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8jP-0000jA-Ib
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8jO-0004bI-O8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyEDe8wylZalxNMNSz6RpL3nleNnTxzk4iV0Jrd1pvo=;
 b=YaoyXzhidMt6mcYh3Jyg+08TMh1lpsQxxR/9VHF+tzneqnJPlxe0CQ4LTVPED4IJvrNX3z
 z8rPtLSpla/HeFaYUeizylm7C+U4iGg0Lo+PLQNJxt3HmsAbrTsuvB04zxSRP/4qnKkEtF
 UXKjN28LdN8dALJjFbhZm5z3FnZdaMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-MszWj229MC2gRvPK356TRA-1; Fri, 05 Jun 2020 05:33:39 -0400
X-MC-Unique: MszWj229MC2gRvPK356TRA-1
Received: by mail-wm1-f72.google.com with SMTP id k185so2547077wme.8
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TyEDe8wylZalxNMNSz6RpL3nleNnTxzk4iV0Jrd1pvo=;
 b=RAiPhWkvleLcfRDv1MQb8COquyLG1T/J6vY4GC8nyehi5GvbkicsGWNZMBL3zEkssl
 gew/8wS53eiNCzbzIcQt+/gcO5wvZXUGX+Np67xyWDXx5rigmhuSpCCz0p5Nuxjqv03z
 mgrercl3iZTBSdTe6RXoUbG7YCYT3m/b/aIxM51h+nhkhcbJLVnxQN1oriuXzsPH5zsw
 R/iYC1nWrD8+5VkdAo6Tjpqx2lIyGk+tzK+1MmtOsHXteBasVMz6EQFlwbpxFmVkwrvR
 hID+FFF9X46ypYjTPIYRiE8GpdOrIZNTFk0kGX1kcwZgINpgmPL/8LPVmh2g7rPMVJDS
 g+Xw==
X-Gm-Message-State: AOAM533aQMENJ6NwmCyUDaAIyat3eOtYWLzumKj6lwuow1+pzjljDTXK
 WfmSxNr19XR4+DX27LcQYdz54/09X2e/0I/kTeaSFJ2gA7M9seJoeP7hF67jg0RdPnKyCMhzHU6
 6evWenhViP+tQzzI=
X-Received: by 2002:a05:600c:29a:: with SMTP id
 26mr1729385wmk.76.1591349617754; 
 Fri, 05 Jun 2020 02:33:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymbmxZ+EW/MVYQ7+Ov0hMO6Luws1CLehqpinroMrK8T7UGyPttCVb7pB3R/a0BQDjR1sj+KA==
X-Received: by 2002:a05:600c:29a:: with SMTP id
 26mr1729371wmk.76.1591349617572; 
 Fri, 05 Jun 2020 02:33:37 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c65sm11026622wme.8.2020.06.05.02.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 02:33:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/11] accel/Kconfig: Extract accel selectors into their
 own config
Date: Fri,  5 Jun 2020 11:32:53 +0200
Message-Id: <20200605093256.30351-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605093256.30351-1-philmd@redhat.com>
References: <20200605093256.30351-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


