Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E15C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C023520774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqAvztmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C023520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOCR-0008Bj-TH
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPO93-0003tM-AB
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPO90-0001sa-Tw
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601895302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/z9yRp8+WHql3Xgj+kTqlTxcqqInaLF1iEEzvMMLOY8=;
 b=hqAvztmErrmA0gddHWR52YuDk0zRxaiqdCgke1UODTscU6FO8llP3OXElU3jvcVfCJJ8iU
 u8J74+OaLvRAd1jqRPwV6GZJ/z880tk0proHM06nCBvVbhSBPmAJc2ZzTneU8b7lMxG2yq
 QwZNvcMc4VpDDF4wq+kec5dWnI5moME=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-WZj1WodbPZCdU3fziuFFww-1; Mon, 05 Oct 2020 06:55:00 -0400
X-MC-Unique: WZj1WodbPZCdU3fziuFFww-1
Received: by mail-wr1-f71.google.com with SMTP id w7so3868767wrp.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/z9yRp8+WHql3Xgj+kTqlTxcqqInaLF1iEEzvMMLOY8=;
 b=D19Vlr0CEPDGoePJtPvk29UFVrq43kqQ5OoMLuECIiZUQKWsOV5CkJGRMdJ73y68zm
 dVEl3A5ajVE+HLrHGuVm7uNIpUDfNfYLYcVaUmMScK5lv/ZnL8+xcY9J5Ey0keaUAcbj
 hsrnHfkozgYHLy46ZmxisAjTqvIeTo718PpDJJPKexaB55tBfQHbbUENqK2iEW8Qhj2S
 XDkVbuL67hHQNoOOdXrXFe9TiUyqjpfcCiSGr5rPNZbMZWTv/A9yQmup0dAq3Ixuygck
 +93Myh4DTQF0Iuf6xMKeIOmldbKFqKpHqW4t8CvuuYC76IiNEfN2wykZMKnocuIM2Ux0
 rEpA==
X-Gm-Message-State: AOAM530pykNYBvXCmoaQ6lGaD6KHCiLQ4JPLnjxiEc10RDYJdMQOEWBs
 xf8Ve2K7zRe7kQX4FqAiX3eqgPZG5qpeOlILL8n9bJLd3ulQ78UoJfOXgNp6UbpXQRN2IRZAI3B
 X7DBUbRf8D1c2cDo=
X-Received: by 2002:a1c:a949:: with SMTP id s70mr6315259wme.17.1601895299457; 
 Mon, 05 Oct 2020 03:54:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzReQJ75SoObycGxzGbogKef3teUeSgq/xjMcZfRZMX1mVnciDi3ttxM3qyhlYq80FpIZK4Mw==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr6315241wme.17.1601895299253; 
 Mon, 05 Oct 2020 03:54:59 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a15sm13811809wrn.3.2020.10.05.03.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:54:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] tests: Add a trivial qemu-storage-daemon test
Date: Mon,  5 Oct 2020 12:54:42 +0200
Message-Id: <20201005105442.2093105-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005105442.2093105-1-philmd@redhat.com>
References: <20201005105442.2093105-1-philmd@redhat.com>
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
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test fails on top of commit 69699f3055
("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
because the TYPE_FW_CFG_DATA_GENERATOR_INTERFACE registered
in hw/nvram/fw_cfg.c is not linked into qemu-storage-daemon:

  $ make check-block
  Generating qemu-version.h with a meson_exe.py custom command
    qemu-storage-daemon
  tests/qemu-storage-daemon.sh: line 10: 2089929 Aborted                 (core dumped)

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/Makefile.include       |  3 +++
 tests/qemu-storage-daemon.sh | 10 ++++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 tests/qemu-storage-daemon.sh

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d257777560..be12581c77 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -142,7 +142,10 @@ endif
 check: check-block
 check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
 		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
+		storage-daemon/qemu-storage-daemon \
 		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
+	$(call quiet-command, \
+			$(SRC_PATH)/tests/qemu-storage-daemon.sh, "qemu-storage-daemon")
 	@$<
 endif
 
diff --git a/tests/qemu-storage-daemon.sh b/tests/qemu-storage-daemon.sh
new file mode 100755
index 0000000000..9fd4c73400
--- /dev/null
+++ b/tests/qemu-storage-daemon.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+# Test all QOM dependencies are resolved
+storage-daemon/qemu-storage-daemon \
+  --chardev stdio,id=qmp0  --monitor qmp0 \
+  > /dev/null << 'EOF'
+{"execute": "qmp_capabilities"}
+{"execute": "qom-list-types"}
+{"execute": "quit"}
+EOF
-- 
2.26.2


