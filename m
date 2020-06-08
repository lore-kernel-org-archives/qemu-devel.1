Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F128C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B30206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9Bg3SGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B30206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKRl-0000RH-0t
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKE1-0006eZ-DJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDz-0007pp-5i
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swd27F6/1+WGmnfSzwg22l5POZg58LkwHV81fIkNGaQ=;
 b=I9Bg3SGt6fJjBznCJnmuebKOkfIsY+xlTIuinUP+CFUiZCoimp3HLWGwCowrVMhwRjYP4+
 P4k/BUr3gzilwB8U0T/ALs5lFgCqzsFN8qPpWhQnu+uD8d7p+TDBc7YqUP5NFoJQbqPFMT
 siLHs1ld5R9z1vY/Nc2gWiJfZum9Ekg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-wuIVBMqsOeyjKpz0UZ2BPA-1; Mon, 08 Jun 2020 12:02:08 -0400
X-MC-Unique: wuIVBMqsOeyjKpz0UZ2BPA-1
Received: by mail-wr1-f72.google.com with SMTP id p10so7360003wrn.19
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=swd27F6/1+WGmnfSzwg22l5POZg58LkwHV81fIkNGaQ=;
 b=slIgrvmEY1ZlbOMTG6fp4DMYXNUfDebd8TpviELhGesxjTXUFy90SzqYM6/jM4zjnD
 0/i0Yo498U6290jm8+U0TYLOVRf/DGCwWrXWOofHU0n5ByNC4qHqTXavIZU/u6R7joFF
 eKrxAT4pb2cJ5JGMyvxi5TEf2EWHz8IgIBlv9ZErZUWmhBEXFMEhhghoOcZkhXBhOmfz
 PAmRjENC2SioDdvUYiJo8YlxWF8dFEsBI6UJ9nfDaYNlMNpIbzQ8Z+BW3JpfSMbV+dL3
 5cshYJ8AoA3Ckl6Iw/WaDdfqXkR4p5lvLyaYG1GJDAUJJBfZagw7mlzbsnfMi8Up51UJ
 lKSA==
X-Gm-Message-State: AOAM533J1nxRhAuMcKNIOtHN9mPHMdAJ+dT4kN1wkDvN2wPtspyBGstb
 pjHOUTK2wyLZ4JQ904XUgelAX2JaYo97QnHlEX9LfvybzZhlkcwt8QCUQ3Cr1HxxaputLH1Is+q
 35r/Cdd2TNNnNhgo=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr58677wmb.168.1591632126779;
 Mon, 08 Jun 2020 09:02:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwD9AlGEl1YrzMFzzhVE1vb4kbCf4YFVdSir7m67DLKARx2zMO0OlXdHqSCrgQOgDPIF6US1w==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr58578wmb.168.1591632126013;
 Mon, 08 Jun 2020 09:02:06 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z206sm13115wmg.30.2020.06.08.09.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:02:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 14/35] hw/i386/pc: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:23 +0200
Message-Id: <20200608160044.15531-15-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
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
 hw/i386/pc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2128f3d6fe..c71809fd28 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -94,6 +94,7 @@
 #include "vmport.h"
 #include "fw_cfg.h"
 #include "trace.h"
+#include "hw/qdev-deprecated.h"
 
 GlobalProperty pc_compat_5_0[] = {};
 const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
@@ -348,6 +349,8 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = g_new0(GSIState, 1);
     if (kvm_ioapic_in_kernel()) {
         kvm_pc_setup_irq_routing(pci_enabled);
-- 
2.21.3


