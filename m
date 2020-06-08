Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05138C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54FF2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTeBdDQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54FF2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKfM-0004mh-0Q
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFU-0007d8-BB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFT-0008Cp-Di
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tavsnBMcjbLYqmKTQpJNbu5aW+OtaIuHgP5ZHfhD4y8=;
 b=eTeBdDQGsa/LrE8sj2CQmX8iur7HQNbShZc9uFuZB6fKePQ+t8HJVOwGuaIuvTpbBhJJ2Y
 K6RUOPfwiOQg4/ejuFu790JwzHBIGwcW2sSsLhrL8MgfIs/A2Smp/udig9f+s0fOIdpJHe
 EEcZYWXHIJOa5WCpsOaqrV92W6clB2c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-5fB6McBdN9uIieCNyw0Jfg-1; Mon, 08 Jun 2020 12:03:41 -0400
X-MC-Unique: 5fB6McBdN9uIieCNyw0Jfg-1
Received: by mail-wr1-f71.google.com with SMTP id e1so7369427wrm.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tavsnBMcjbLYqmKTQpJNbu5aW+OtaIuHgP5ZHfhD4y8=;
 b=mEwL42ZuhMksccCUi6EX4qarxnECuXyPuLYYUKCAgw1zTZtkS84F55Kqbj4ugu+7ou
 37kfcP3gffc5n7D+sl2V5NELGfyKYa2N4CUmt7G7QIX4I8F9B3RVUmutwnZaZgpP+7Qj
 O1FWYydqPNe9eWHVFpxIECswk6iHOrOPrQAA2sHXKnDtiEVMpo+OeXtIyoExJqn6B4H8
 v6rVROj6VlsiB1cMgw73sFvZvs6AVA2FIJzZovliPsApDIg06p/zuBQF+lBBrzs9+vCg
 fHrwAeF9vaST8KcEFT6Zw6QTCnj5u7cii4AzpuVkiBChDqv3TalrpD/vlFxRzaxI+upj
 A+UA==
X-Gm-Message-State: AOAM533UUfklZWeZ1bM1i/lyOTntqV7k0Ns5ka1nX3/3SnUDf1CPdGq8
 cJp17IYZSvuR7IONlMlS1vNEFMfh6itbWJPPrVksIc+Rnui/cciD53RRQUB0lFtqCagFURvDhd/
 IgfeFlMfLD00kl0M=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr73343wmj.118.1591632216919;
 Mon, 08 Jun 2020 09:03:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1E2OUT8wjgYne61y8m5ATBeXEAgbFH/vhvj6PwSHzmhBdaDf8vJ9I14Vkb0SP4ZL7hYVwYg==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr73214wmj.118.1591632215737;
 Mon, 08 Jun 2020 09:03:35 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l17sm200565wrq.17.2020.06.08.09.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:03:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 29/35] hw/ppc/ppc_booke: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:38 +0200
Message-Id: <20200608160044.15531-30-philmd@redhat.com>
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
 hw/ppc/ppc_booke.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 652a21b806..a9e5e68578 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -31,7 +31,7 @@
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "kvm_ppc.h"
-
+#include "hw/qdev-deprecated.h"
 
 /* Timer Control Register */
 
@@ -338,6 +338,8 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags)
     booke_timer_t *booke_timer;
     int ret = 0;
 
+    qdev_warn_deprecated_function_used();
+
     tb_env      = g_malloc0(sizeof(ppc_tb_t));
     booke_timer = g_malloc0(sizeof(booke_timer_t));
 
-- 
2.21.3


