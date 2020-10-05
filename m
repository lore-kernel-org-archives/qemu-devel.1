Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F1C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DA120774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6kmcmEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DA120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOAn-0005W0-HR
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPO8y-0003iP-36
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPO8w-0001rK-Bi
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601895297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8MSMvH0EGCYLgtqlWbOI3p4RLhGZ+KMS1a1Fylf9ro=;
 b=i6kmcmEmhtdREccXEMG1fN4hO0neFMxnCyDwaC2xmyh5dDh8oFooilRb3YlrkDy2TNcpl9
 G6GGYwh1ydFM0F7Tmfr42d+40RbCHihuyyEpuct20RoU4MG0+286HQAqcHkBv6sejWtg0g
 K1ztGUVKcvH94f3w4W4K95Jkz653mEU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-nMqIjDq0Nb-HdIk_P7S-2g-1; Mon, 05 Oct 2020 06:54:55 -0400
X-MC-Unique: nMqIjDq0Nb-HdIk_P7S-2g-1
Received: by mail-wr1-f72.google.com with SMTP id g6so3861353wrv.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m8MSMvH0EGCYLgtqlWbOI3p4RLhGZ+KMS1a1Fylf9ro=;
 b=eGYXPVVNeFZnIG0CoN0WMjN4vUoGEyWor9OioBYbRS2fcIhwFhZ7FuUdsNspxnNmmN
 XQzViBfUWi6wobED0j98SBgQEKguI98FHpRd30bQw5c/0pAIj2TXrpvrllk3ZsYwI43h
 xkXXgpXtpkGWQQudFHhkLGtAnQ/As8VESa1eFKjYJISiGd7cfSiXO7gCFN2yQZQG9muI
 vjRQJrJtZfgVt6cKVEZs+FxKbxRrQ++NYInPPTS7blypc6v+KrlvCXKG8yroTjc7AWGC
 CLUzGNbYQzJVtWjXFcEoK06WTAhmOJNDj2amnKEun4YTethluUKKfV/WyVe2S59bR4P1
 oT+g==
X-Gm-Message-State: AOAM533UuzoYgceU1R7wDpcyns1T/SbHKTc2/y4yGXI0pAXTLujmB1Cj
 XAgryhrubPsJQNZ4ZsZXyadcIrleiJ2YuXXso8lk8xbS9hyVmTU3ar3AYJ1lOfhzCON0QPY1VdP
 Oye4Lh+e1jJoxAuQ=
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr17005543wrv.222.1601895294375; 
 Mon, 05 Oct 2020 03:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5I1CyuSubTUSQDDYiGGWISM9QKMHHSJxB5MgymvpXAzBUx49+X69fI5+2zxRSaJqWgqK3YQ==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr17005533wrv.222.1601895294236; 
 Mon, 05 Oct 2020 03:54:54 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q2sm3640992wrw.40.2020.10.05.03.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:54:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] tests: Only build socket_scm_helper when a softmmu
 target is available
Date: Mon,  5 Oct 2020 12:54:41 +0200
Message-Id: <20201005105442.2093105-3-philmd@redhat.com>
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

Do not try to build socket_scm_helper if not softmmu target
is available. This fixes:

  $ make check-block
  Generating qemu-version.h with a meson_exe.py custom command
  make: *** No rule to make target 'tests/qemu-iotests/socket_scm_helper', needed by 'check-block'.  Stop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 40d909badc..d257777560 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -136,7 +136,9 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 check:
 
 ifeq ($(CONFIG_TOOLS)$(CONFIG_POSIX),yy)
+ifneq ($(TARGET_DIRS),)
 QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
+endif
 check: check-block
 check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
 		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-- 
2.26.2


