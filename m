Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0CAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895B2206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJAxC2QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895B2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKYW-0001DI-OU
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEk-00079A-75
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31194
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEi-0007vM-H9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERIE6m4jxrzYfG68k2WyVt3M0Z5JMhyFzvtHzf4SuG8=;
 b=WJAxC2QJF/zyAyxD0CrYTv2vsEDSxyx1mw2ujtLCJ5L+7WRaJz7x8u0XTXVj5YgSJZOAnC
 0NhB5aLHKltVFfDeTo9+onLXg8n1Z5zjUe5ULDqc/xhlrdi7UFBzOfTil/NNeJZB/1D78r
 d/qDdQTqBMrQiCQfL7FgHx9vlvc6KfU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-POH4V-zrPwykkvRaKVvA-g-1; Mon, 08 Jun 2020 12:02:49 -0400
X-MC-Unique: POH4V-zrPwykkvRaKVvA-g-1
Received: by mail-wr1-f69.google.com with SMTP id c14so7328545wrm.15
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ERIE6m4jxrzYfG68k2WyVt3M0Z5JMhyFzvtHzf4SuG8=;
 b=TSUNBBN6YdG91CWDOfxTYQzw21MkFREK13RkaP8j2f+9UyJleHkWBKlnLs5YuehNsF
 aPpYYlWasg/+VYs4mLYYhm1t1fq10H4m6WZZZpX9RVolr7zMmERvSf4qj8a1QxCy6s1u
 pggX9ZJQbqPtciiFz8NFjUbei8mMrloXAFNpmSTKD5+5acJ2QudSqXNE48B9YWk6X6ep
 MmYpV27y30mV6qWHphsBwAZxfvlG633r3M0jFvBhqDNY50Tj1jDfwDbjAMHRSryL2X4w
 iNEcu3uU1olsy/sSnXG4zkHLeYaPVJDjx9pswaFlgFb359X5YZwBWEY70stCuYlnKGiU
 IxCg==
X-Gm-Message-State: AOAM532r5H3atpAsXq3ovM7iow6xR+ZMnQL2XsHPDOd5TItViU85dhNN
 JJ4hp8v609mSwGt8Ki9PvtUrLY5UiJiKkVFjQ8anACn5nLGPrc1CYFuh25vcrcUyxal1OURebrC
 p/UBT/mOQUA6zCXU=
X-Received: by 2002:adf:cf06:: with SMTP id o6mr23925412wrj.163.1591632168116; 
 Mon, 08 Jun 2020 09:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl0bue+F9URFV2MLoWaC0ni3jZ25V2PPkWtrtnwtHvWPF3nP5GuuAiBdquATZ2VeeHOXjWiw==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr23925378wrj.163.1591632167963; 
 Mon, 08 Jun 2020 09:02:47 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z16sm155794wrm.70.2020.06.08.09.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:02:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 21/35] hw/lm32/lm32_hwsetup: Emit warning when old code is
 used
Date: Mon,  8 Jun 2020 18:00:30 +0200
Message-Id: <20200608160044.15531-22-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/lm32/lm32_hwsetup.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
index de94de177a..f4a4d8fe4b 100644
--- a/hw/lm32/lm32_hwsetup.h
+++ b/hw/lm32/lm32_hwsetup.h
@@ -27,6 +27,7 @@
 
 #include "qemu/cutils.h"
 #include "hw/loader.h"
+#include "hw/qdev-deprecated.h"
 
 typedef struct {
     void *data;
@@ -57,6 +58,8 @@ static inline HWSetup *hwsetup_init(void)
 {
     HWSetup *hw;
 
+    qdev_warn_deprecated_function_used();
+
     hw = g_malloc(sizeof(HWSetup));
     hw->data = g_malloc0(TARGET_PAGE_SIZE);
     hw->ptr = hw->data;
-- 
2.21.3


