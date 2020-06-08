Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF7FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E165206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyRNygOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E165206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKcz-0001B5-Br
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFn-00081w-Pz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:04:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFm-0008Ge-Vk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNDlXKA4V05uqH+zGvitoUZAatp4aCkSuEKALsyTQs8=;
 b=gyRNygOPKTodhkBJ6A5D56U74zKqRJS5rE+wNZ5Y7FeOwFX6LfCpUJQQKBaOhxnYRQV/sd
 17/dsHy5HZLYFZbKNXQ6Ea8VBlpoFrMkzFNNtDjp7FykHaIkOvWeI3L03OEWrKArd8kz6a
 QE/222skRmADh6QDSvJPpL/QCTon8j0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-NENkx7-mOtCQH2OX2bhVPQ-1; Mon, 08 Jun 2020 12:04:00 -0400
X-MC-Unique: NENkx7-mOtCQH2OX2bhVPQ-1
Received: by mail-wm1-f70.google.com with SMTP id p24so9470wma.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sNDlXKA4V05uqH+zGvitoUZAatp4aCkSuEKALsyTQs8=;
 b=QeDU6EIYjhgEhRfYUR+ZJ2IEG1Xkrb/pwRTITqZkAI7C1bvK7+HTmyvJZGm848Z1xM
 dLR8d2VKluq/GZBgnLyCUuXSy3fkS1QxooMezcvE9bOjqB3gs+CHppp141L5RbOslYqc
 ZBr8XIH5Z5TIaYV6mb805oDgix8TFaJRgyhy7WOfwVMM0E4aEs0by+vgNwHkm2qLCuTT
 HShQzlX8ACSEe/fsJGeoCEoswMPC7KeMFHD52LL2Pw1FYNZHC4mAbMEgtjfUELMxijL9
 QE6qP4XIqtANj+VhWjeThP6WjNHlRjp6QT+rJNGzzKsZvDbp7w959SmgidlJ8cqvHsAK
 vYLw==
X-Gm-Message-State: AOAM532g6ar6fVOOk4iEc69iJ1MC1iFnbT4u4sB7nOlNmGCwaaU/wB+h
 5YM00smwzMQShwD5mAwHtqi3843xAIDXI2CHjjRbtRN1QPEeiqHDAoMzD+KXNncZL9KbzOkIyc/
 WG3bxKQoJcef7z/Y=
X-Received: by 2002:a1c:2082:: with SMTP id g124mr55794wmg.21.1591632239016;
 Mon, 08 Jun 2020 09:03:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6Ea3200SCtYHheH/UK2Mas0Wr6/SnNtzGrclQZuKXFOcXxL+qpSERI07OhtEH9rZ1aPQhvQ==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr55753wmg.21.1591632238819;
 Mon, 08 Jun 2020 09:03:58 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id h188sm48452wmh.2.2020.06.08.09.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:03:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 33/35] hw/timer/slavio_timer: Emit warning when old code
 is used
Date: Mon,  8 Jun 2020 18:00:42 +0200
Message-Id: <20200608160044.15531-34-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 hw/timer/slavio_timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 4c5d65e391..16f21669bf 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -31,6 +31,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/module.h"
+#include "hw/qdev-deprecated.h"
 
 /*
  * Registers of hardware timer in sun4m.
@@ -392,6 +393,8 @@ static void slavio_timer_init(Object *obj)
     unsigned int i;
     TimerContext *tc;
 
+    qdev_warn_deprecated_function_used();
+
     for (i = 0; i <= MAX_CPUS; i++) {
         uint64_t size;
         char timer_name[20];
-- 
2.21.3


