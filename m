Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB79920723
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0piscV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB79920723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkb5-0001n8-1c
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkI5-0003kl-JN
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:41:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37395
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkI3-0008QH-Da
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGhDjSAMTvyc0GtSLCXSdOThvesECzDKYGUhUFBvKxM=;
 b=K0piscV5xQirRkf1GoFlPaLx9r5CJtcRIhCXVBoUlQJVOp0VsNai+2jscuNrxwouR+iMpg
 yX70bGM3cnuoXij52Q///XDic0SKzYpS5izPqsh/HtaQYE4lKET0UxbKk9TsA1e598bUff
 /btGFIHkyjLDSEXkqkldd8WcBzVCYKM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-liHf7rlpMCu57zK2shOMPg-1; Sat, 04 Jul 2020 11:41:17 -0400
X-MC-Unique: liHf7rlpMCu57zK2shOMPg-1
Received: by mail-wm1-f69.google.com with SMTP id v24so39802706wmh.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zGhDjSAMTvyc0GtSLCXSdOThvesECzDKYGUhUFBvKxM=;
 b=I5yx0x8DLpcyafgjQzK7gLCY7GLibfqaGcDhAByXYd+XFn8vOj0Dv7gztg9tbeKIMZ
 mAbO6eu+kbK9svFl6zbo4w0srNDnDokhpqQqtISZxN7w/FbFluNI2+Dqa3mt+iuXWfRA
 jK4Ldthw3zV8Q4EUecn/y0C0J5Ve6WnPx3VpUQzviSA2unpPqz0i6O9htv/jvHfTnNxP
 2TU/b4msby1ev6aP5vw61pKy13T3Iwav8VbHj44vkLdK0Gq7mIY2hxdmFK61quOV+A9V
 7pM8hw9B+esPEMN25oI4U42adcFT1MYba3TrIJ0f/nJRQ+S6I7CNLdLKj3ecOcScmk7z
 oKhw==
X-Gm-Message-State: AOAM5315pMZmwlu8mTyVjA5nLnSdtY93v1MOUKC1i7LAZfkwYtaaZwFI
 soittICx8rYZn7loXJYGpw9uUNjBw62HCeAap3Iy7dm8e5R2Gk3DJM6qMbChds3yka47TWs3E+X
 3covHrusgM61FU/0=
X-Received: by 2002:adf:db42:: with SMTP id f2mr40958771wrj.298.1593877275712; 
 Sat, 04 Jul 2020 08:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbE+aGDDMtvEhXpYLDyFkAKKq00ppivJij+CelWbeyfYysOcMWRUnfSqrisfL1wBnQD5WFVw==
X-Received: by 2002:adf:db42:: with SMTP id f2mr40958741wrj.298.1593877275481; 
 Sat, 04 Jul 2020 08:41:15 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j6sm17363975wma.25.2020.07.04.08.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:41:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 23/23] hw/xtensa/xtfpga: Emit warning when old code is
 used
Date: Sat,  4 Jul 2020 17:39:08 +0200
Message-Id: <20200704153908.12118-24-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/xtensa/xtfpga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 10de15855a..ddb843e6e8 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -50,6 +50,7 @@
 #include "xtensa_memory.h"
 #include "hw/xtensa/mx_pic.h"
 #include "migration/vmstate.h"
+#include "hw/qdev-deprecated.h"
 
 typedef struct XtfpgaFlashDesc {
     hwaddr base;
@@ -129,6 +130,8 @@ static XtfpgaFpgaState *xtfpga_fpga_init(MemoryRegion *address_space,
 {
     XtfpgaFpgaState *s = g_malloc(sizeof(XtfpgaFpgaState));
 
+    qdev_warn_deprecated_function_used();
+
     memory_region_init_io(&s->iomem, NULL, &xtfpga_fpga_ops, s,
                           "xtfpga.fpga", 0x10000);
     memory_region_add_subregion(address_space, base, &s->iomem);
-- 
2.21.3


