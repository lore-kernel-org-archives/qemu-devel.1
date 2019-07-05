Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BADC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03438216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRICEbgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03438216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjV9V-0003tx-2o
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUiH-0002QM-JI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUiG-0001ck-KM
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUiG-0001bh-Dp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so11049419wrs.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1Q2/Kno8eBtSRnDs1aukgO8GHqqzId6Tt8OoZfKY3WI=;
 b=aRICEbgUlenPNq03o1RTqWe1mKxm+raDhHJlmoxHE8wBYhlnCtsg2ANxxnGctl+yS3
 mofc0FY7YL1JLwR1dKBVXojjC3BgQujgbu4dEm/MOl1K/j2VdToNdQy3lX/7AiAfMEYE
 1W9q4IqYRRTGysMaHtPigxnABrs5DJVkL4omA0cx+ydi1yqYEoH1QNrC9Dk8w8VJ7Qru
 XdI2YluuWGY8NhIhHCgyeTcjLJCzFULdHVUQSQEtzohR4BNmIY9EZg97mzisHvdi/Put
 eZyX2OedrFrU1P3wbMLeqIlPKe1rxd9Zm+OnBu6SOmFzkbJdnM5KYq7zO/vrj7EIqrX0
 SoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=1Q2/Kno8eBtSRnDs1aukgO8GHqqzId6Tt8OoZfKY3WI=;
 b=Ekh5aeTFacomAoZirfDVUM9WZNqGknUWBjKgmryAbLIm1W7dixvmqLcUL99CGwEniR
 RxlQWSK6nOAk3fgYREF6WmgbsOvQWfev0Jt6vRqL/bmHOA0fmt9eYLtDCvVdYvejVy3o
 ntydLKJH1TUSQcFcvc2leO/JdNSykwon7aM2qpVENkJUtDJ4yG+OSsUZwg8s3r0W+Pso
 kP9OxSyph2egT18O2Hc6/Dz+LjK0oo/PdbVF8MQP2Fl3dWNP3QdlLPOABlSBWz7PgVmI
 v1WMf1YfeqT7HnITPX4dGhElOMAYIeSW8/XTsK/mhSIj8vhcpCQX73bS9m6MrcsiQdRd
 5Vkw==
X-Gm-Message-State: APjAAAWG40ZyEtNjFwx2t6iSpjlbxDiwsxxOesJtNcaWj7aRoyVthiqI
 mjyc+yvRMHIp5eTS0T6g7bqEt2pdOo8=
X-Google-Smtp-Source: APXvYqxMIHhSaWL2xz/FwhURU4L/+LoNQILntLn8Ja33W+VgMpvfu+6h8OKKDCNYFx3EGkLxolN4PA==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr5531462wrs.330.1562358102956; 
 Fri, 05 Jul 2019 13:21:42 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id l9sm5582926wmh.36.2019.07.05.13.21.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:21:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:21:39 +0200
Message-Id: <1562358100-27171-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358100-27171-1-git-send-email-pbonzini@redhat.com>
References: <1562358100-27171-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 1/2] Makefile: generate header file with the
 list of devices enabled
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
Cc: Julio Montes <julio.montes@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julio Montes <julio.montes@intel.com>

v2: generate config-devices.h which contains the list of devices enabled

Message-Id: <20190705143554.10295-1-julio.montes@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Julio Montes <julio.montes@intel.com>
---
 Makefile.target       | 4 ++++
 scripts/create_config | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index 72c267f..7154e99 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -45,6 +45,9 @@ include $(SRC_PATH)/tests/tcg/Makefile.include
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
 
+config-devices.h: config-devices.h-timestamp
+config-devices.h-timestamp: config-devices.mak
+
 ifdef CONFIG_TRACE_SYSTEMTAP
 stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp $(QEMU_PROG)-log.stp
 
@@ -168,6 +171,7 @@ obj-y += hw/$(TARGET_BASE_ARCH)/
 endif
 
 generated-files-y += hmp-commands.h hmp-commands-info.h
+generated-files-y += config-devices.h
 
 endif # CONFIG_SOFTMMU
 
diff --git a/scripts/create_config b/scripts/create_config
index d727e5e..00e86c8 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -58,6 +58,8 @@ case $line in
     name=${line%=*}
     echo "#define $name 1"
     ;;
+ CONFIG_*=n) # configuration
+    ;;
  CONFIG_*=*) # configuration
     name=${line%=*}
     value=${line#*=}
-- 
1.8.3.1



