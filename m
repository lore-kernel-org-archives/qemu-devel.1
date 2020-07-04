Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D52C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5311A207D4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ge4dGhOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5311A207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkQ5-0002cw-Fj
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkH3-0002D0-7T
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:40:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkH0-0007mI-Ij
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHbfMTMnP0pPoIUOMaNBIF3qcn8JPSW/pdevUa2NjDA=;
 b=Ge4dGhOWB3qdHk64C5v/M/SFOAj1vNvDqqeyJxp9G4dwik0RJhQRSb+fBDcnv7Q9/ZdSCN
 z6ISOWPxA3j0UwdF643PTI6Oy82HkFQfAayFCog9ufgNH/PGRniblvNFhMc7zQEmvk5R7y
 gGN7Fq7wCEhAXJ7H77oDTsVs8oG1fUE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-irPMy5orPBGSTuD8JAPBdg-1; Sat, 04 Jul 2020 11:40:12 -0400
X-MC-Unique: irPMy5orPBGSTuD8JAPBdg-1
Received: by mail-wr1-f69.google.com with SMTP id a18so36013608wrm.14
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uHbfMTMnP0pPoIUOMaNBIF3qcn8JPSW/pdevUa2NjDA=;
 b=QLreFvRggsFZ5dPnrW8Qj4TyXqHFpI/0XtjAyLQo3aN9XuHhg8OcTVowAzpbisMe5v
 y0SgdfAa6II6vz8R9wpTDjpl6uRLyG4JfvDmZ0GNku4XPSZY52tXAuJDrIw7s0aGD//x
 OfjDg/VKoFe8WS+5jIeBhr6DZHNaKocrIML4bP/6/K24/cy+YU7obmmltRVJjv/6aJm4
 tFgw6Ww1xHTkmO3zFz/KzrREFdRtarib0fu92UWvZ7Y53QgSEh4+vG2crsogb/ZNAy7x
 cO2CxRWxgsF0hGl1pI/Jxy6yV5q0WBZlrTxhWfSq/d/mDOaPmOt2MutZTjkwDPpMcMsB
 VpDg==
X-Gm-Message-State: AOAM533Ocm3spl4FRbgRa7CDK7HMIdbuQ1mLhLUCjl2Yz336fSwBKUm5
 kno2Dw3l/z3f24u43oN6U6Ih+O/dAvNeKqjiWZh4Kykq6GpaxUZcvFayFlFAads2pdH2VsM1XR9
 vpXHAWmpjlYUZFWs=
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr40832232wmk.30.1593877211223; 
 Sat, 04 Jul 2020 08:40:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJPpdiXfwZHoJeVsztQrPxphUc0XkfpFMak7zIQP9ikycliG6Rrvj8/oUtw1GISYnquWwZtg==
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr40832203wmk.30.1593877211076; 
 Sat, 04 Jul 2020 08:40:11 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id q188sm16902969wma.46.2020.07.04.08.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:40:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 11/23] hw/dma/etraxfs_dma: Emit warning when old code
 is used
Date: Sat,  4 Jul 2020 17:38:56 +0200
Message-Id: <20200704153908.12118-12-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
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
 hw/dma/etraxfs_dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index c4334e87bf..d2f7e7ca9d 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
-
+#include "hw/qdev-deprecated.h"
 #include "hw/cris/etraxfs_dma.h"
 
 #define D(x)
@@ -765,6 +765,8 @@ void *etraxfs_dmac_init(hwaddr base, int nr_channels)
 {
 	struct fs_dma_ctrl *ctrl = NULL;
 
+    qdev_warn_deprecated_function_used();
+
 	ctrl = g_malloc0(sizeof *ctrl);
 
         ctrl->bh = qemu_bh_new(DMA_run, ctrl);
-- 
2.21.3


