Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3472FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15E42063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2DdErRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15E42063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKOM-0003mv-5t
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDY-0006Me-GM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58106
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDW-0007iQ-73
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxT4B45O1zWyFYki8IWzx+7CIdrw2K/5FRLdU4/GP/s=;
 b=N2DdErRqsyskEuGnIL6IIOra+szxgFTHezrH3k0nylRDWuV5ophAD6etCKcTawrsz+1NAp
 GZg3tyFIeLDnBXR5q6xZgD9JXWkA9kASGqE/FAzhtm4i5fxoyVhuZABTJwOglFafAz6Z97
 +HVomMRl/DPlD9V7hNYGcjleYUuGI7g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-QXGE1p6cP7WUbxeVuzq7zA-1; Mon, 08 Jun 2020 12:01:39 -0400
X-MC-Unique: QXGE1p6cP7WUbxeVuzq7zA-1
Received: by mail-wr1-f69.google.com with SMTP id z10so7390314wrs.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gxT4B45O1zWyFYki8IWzx+7CIdrw2K/5FRLdU4/GP/s=;
 b=K2GkBnyuKu2I5HKGA15nrqa1ZIOnSwJfccyuS8irv6Lk47n2RfV2mKFA9ngcsllDCD
 C8tQAXAhESVW5Rve1VZZ019/zbbzSo8uVhF0nlxzGhMNTHpCp5Q7pKVN34n6vC3zyhah
 ikXdJLNXLAGHojjk+/AcVuQhtiRCpvH6FszRMG3nwGOFz3J+DN6RcCsgOSLhu2wiaIsY
 8FGjyyjIFrcxmel5uC5lGAp6t7Bt1q04tSGkZGdJbtynPpkinJr6RsC+dpJsK7cTudlU
 o2wT5uzYWOfSp0K3D+hbU64/+6FVG2BzD5o4sAOE0NXnkUJgEFa5vK6UBnFmg8/j0qqi
 CHNA==
X-Gm-Message-State: AOAM533AdPMChQBRKpgm+S0h68jyi8/CcNdbjdmo29Aso0OR4qS6lRwy
 4eG0eTN+xkKI/Jk0RppTpD1dWs/WP9uykPVjziWKwVbhogPD37KWckUgXLMjEsBv/kkrC/i7Z8o
 KfOrDmvFYVCrEUXY=
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr76250wml.48.1591632098181; 
 Mon, 08 Jun 2020 09:01:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxecWPcyOuK8uF9ReCv2dq+PoGEfPzfu+FZfYV8n2WgE2MmJ6zu0OPEpglwHYV7Ppo9rtY/wQ==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr76223wml.48.1591632098001; 
 Mon, 08 Jun 2020 09:01:38 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id g3sm188327wrb.46.2020.06.08.09.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:01:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 09/35] hw/display/ramfb: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:18 +0200
Message-Id: <20200608160044.15531-10-philmd@redhat.com>
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
 hw/display/ramfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 79b9754a58..a4a427e5c7 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -18,6 +18,7 @@
 #include "hw/display/bochs-vbe.h" /* for limits */
 #include "ui/console.h"
 #include "sysemu/reset.h"
+#include "hw/qdev-deprecated.h"
 
 struct QEMU_PACKED RAMFBCfg {
     uint64_t addr;
@@ -120,6 +121,8 @@ RAMFBState *ramfb_setup(Error **errp)
     FWCfgState *fw_cfg = fw_cfg_find();
     RAMFBState *s;
 
+    qdev_warn_deprecated_function_used();
+
     if (!fw_cfg || !fw_cfg->dma_enabled) {
         error_setg(errp, "ramfb device requires fw_cfg with DMA");
         return NULL;
-- 
2.21.3


