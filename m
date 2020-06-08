Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C35C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2762053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul0cJiIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2762053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKhW-0007bm-9U
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFH-0007Qz-HX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFG-0008Al-DF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6htctWfi0MuFSG0QMH05N/TPpEubln82RtGM2+VRUkY=;
 b=Ul0cJiIVNQn4mBpQsqELB939niuIBptRc4P0+yZfe5NLoh/q0RBlkA2CiR4p8tlycIa36L
 eK/ubT+1YDMyFH43qmUAjkFflYGZYgBsdMVgYgZidAU7Nru+AP/J4bDbvyzgRpCt7BIN+8
 6xEwdg9BR38CyY1ws+jzlA/cn3umFnE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-7kh9l5kCOxaw4HWqFxYXcw-1; Mon, 08 Jun 2020 12:03:26 -0400
X-MC-Unique: 7kh9l5kCOxaw4HWqFxYXcw-1
Received: by mail-wr1-f71.google.com with SMTP id w4so7366419wrl.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6htctWfi0MuFSG0QMH05N/TPpEubln82RtGM2+VRUkY=;
 b=f11whdfc8FfA8nLrbZtqD9NpzTA6nCIME7n9i27SlI5yUBb6rfa+QcbgnjLs93I8OU
 2L1QWc28YVldb0GkiuYg4sc/J5J+/I51kC52S4Pvq5jmlGGNCsTVsBiA3UZKZaUOBwvS
 tlZ5PASt57S9IjSRpGzZ9Pn6ymD8uzAD4x5w5v3ugPW/Q2hxFd9jnYFyI+LmfEHtUM8z
 m3ORbBMpyKAjxe1A1nrXhkxW02+nn5s+bEQFTTByZanMYAwEsxbAM94bDaCgBlhY060E
 Djm5OV6/80Ch6tkwUr79+LnOnNh9OjfISmov3udCJJ15iOo3lNfIN6NQHMLsQ4Gjt54l
 HhoA==
X-Gm-Message-State: AOAM531+PE11pMF/IHABQy0ki5wVBL8V2uQHNLpA6/IrKsmt8pQXbeIA
 Ef5SkoWKXO/WRLED7M2E1Oz7WPRi4NHamTuWajTNGuPeWcSN0jSCYQTO/VAg+FENkuCC4lEBNbE
 Zb+AGA8TsVL2/WDA=
X-Received: by 2002:a5d:5585:: with SMTP id i5mr23967099wrv.112.1591632204337; 
 Mon, 08 Jun 2020 09:03:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPoWRkkwB/FnLCAhEPa5I9PvgN5hBH0wEtPqJP6K6G5xK4bW4Hm9SvYdS2VHkDfOIc4QPeAQ==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr23967049wrv.112.1591632204161; 
 Mon, 08 Jun 2020 09:03:24 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id f71sm21622wmf.22.2020.06.08.09.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:03:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 27/35] hw/ppc/ppc: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:36 +0200
Message-Id: <20200608160044.15531-28-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/ppc/ppc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 4a11fb1640..39fcf746c5 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -37,6 +37,7 @@
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "hw/qdev-deprecated.h"
 
 //#define PPC_DEBUG_IRQ
 //#define PPC_DEBUG_TB
@@ -1114,6 +1115,8 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
     PowerPCCPU *cpu = env_archcpu(env);
     ppc_tb_t *tb_env;
 
+    qdev_warn_deprecated_function_used();
+
     tb_env = g_malloc0(sizeof(ppc_tb_t));
     env->tb_env = tb_env;
     tb_env->flags = PPC_DECR_UNDERFLOW_TRIGGERED;
-- 
2.21.3


