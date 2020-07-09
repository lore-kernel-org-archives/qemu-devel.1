Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 23:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F2D20672
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 23:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMdQXERH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F2D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtfb9-0005EI-Jl
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 19:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtfaQ-0004Nn-EM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 19:04:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtfaO-00031m-Uh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 19:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594335851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FcXSbZAgxMI0RN2PhLbWMzvJJzdPV3Ktq/LsSfvpFIc=;
 b=DMdQXERHFI2I4i4thhjZSaXGCkLKAEiK+shOvoOIeq7KJ5GDZUAzy9NMKqzdZA1gcKmxFH
 0t5NiHUiuLImnRluTokdoRzAW+cb++5/NOFM36i3A9hVxr6vbhRQx/GBmH7KKkGv8/cUOi
 5XUf3pvj2QpvSd2jG+SUur7lvHX8leQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-YZ9ohakJPEePRJtMmZ9-nw-1; Thu, 09 Jul 2020 19:04:07 -0400
X-MC-Unique: YZ9ohakJPEePRJtMmZ9-nw-1
Received: by mail-wm1-f71.google.com with SMTP id c81so3869233wmd.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 16:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FcXSbZAgxMI0RN2PhLbWMzvJJzdPV3Ktq/LsSfvpFIc=;
 b=C1132IR6fA8xENYzMjJR5MnBf3h7svgqTNAta2JrCx4VJnu2n6ujlg8KK4XM/BemOY
 uxSE9EKYzmV2HZOg2R3W/8QrUPGMMM9CBspFej7uekNmcP8nWC3JKvLG/9seufEkbvdt
 j5qeOF8aLmmDqdxoF1RjMPHb/P0C6Km1XjjJLzMpXizptfN1/tIva4cIzKsNZGAHwefR
 5Chblc8KIH8wHaE3iTNoXU49OX0VWJT+8A2QceAU7M/ZcmFTTcy2KFMTFxpvLgQgbOq4
 g17pBD9LttLodiSsL1h1GpLhz3OKqIEkZ0UIIdqn3De6sBnpLt8bL3WbgCYRoLJ8Ft7Z
 83Bg==
X-Gm-Message-State: AOAM531r1htGqyqZzihqKQQuYyQxKbrUD9SWmSKlCuiiVTjF6fXnqbMq
 vfIIulIhd6fwf25kKx0rnp+QsMExnS/YXYKzdyjBuWKG8HJ055HKHPAAG2/0CsSEfHXliMschDR
 6MzlTVLPS4ubWoe0=
X-Received: by 2002:a1c:f203:: with SMTP id s3mr2131316wmc.126.1594335846224; 
 Thu, 09 Jul 2020 16:04:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws/p3tzDXIr/Hs5Bj0K9FkN7vu74YBiAOVQgf2+EYtLo0qWao+c04HLGClPHGutoGTTcLYew==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr2131303wmc.126.1594335846066; 
 Thu, 09 Jul 2020 16:04:06 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 c25sm6201685wml.46.2020.07.09.16.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 16:04:05 -0700 (PDT)
Date: Thu, 9 Jul 2020 19:04:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] vhost-vdpa: fix the compile issue without kvm
Message-ID: <20200709230330.236699-2-mst@redhat.com>
References: <20200709230330.236699-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709230330.236699-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:25:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

Fix the compile issue in the system without the kvm support

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200708084922.21904-1-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index a3d17fe0f9..65d5aaf08a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -19,8 +19,7 @@
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/vhost-vdpa.h"
 #include "qemu/main-loop.h"
-#include <linux/kvm.h>
-#include "sysemu/kvm.h"
+#include "cpu.h"
 
 static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
 {
-- 
MST


