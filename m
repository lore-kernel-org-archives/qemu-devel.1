Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FAEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E21820738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+Oz6v7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E21820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEWx-0005Wj-FE
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETg-0008JR-N7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETe-0001MG-6w
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFvaXkZTKjDx5cRD4SdzQ8DkQ6V3EUCI1ITwbUTwI1E=;
 b=B+Oz6v7dqPJQR7Kqd02tmk3a/zKrl4IkzcrsamsJLNEFWo9DZP1tcK7vZwoJuhnIHO3OYG
 70VdGtfEDqezQrMh+/v1aNU7RrAmqGUuAxu+lw2iq+q5swUCCEgKLAPLHVFHNvzf77i+Fy
 DcN2G875OBIIglh6GRqClInZkwIDR9M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-8zXIXV8AN8WP6UqOplPyug-1; Wed, 24 Jun 2020 19:06:42 -0400
X-MC-Unique: 8zXIXV8AN8WP6UqOplPyug-1
Received: by mail-wm1-f72.google.com with SMTP id g187so4665737wme.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FFvaXkZTKjDx5cRD4SdzQ8DkQ6V3EUCI1ITwbUTwI1E=;
 b=spbBx4jDnh9b70F8uGFhmndlrFkYaogsGkKPZj+0EWKxWtmY2aUgsvmg92uoTkKg3g
 uTrYDKhZ2EDwQcZRGF+olKwBpJMjTSlm+hiL8v7NdKtBIiY35uXWvFiffYuU1Eh0+8fb
 bgGKxmCu2g26dtJtd4VlWeArcwc0WKqRaEJy73VfVE4nyqmm7r9whsNJEUKR6CSUZRju
 SL0wJqYvTvqmGftd1+NSGxgDPBopkqf9XP3AhtiQJbMZJPAcx5DKwZSU32KYimsrFI0i
 hDHf6Ujk1kwtEv8B13JShTAVMsYiPPjAky36keHKGV7L9alegSKnHPHMX70zdJIcx7+R
 Er0g==
X-Gm-Message-State: AOAM531+IIzD2vg9OvsXgVYzGg/yadaplpzlA4LWOMOX/XUxFKctHlhn
 aeCLtRQpEjW7HrJUO86W6JMrc9qIdzW/K87VLbexrSVhkR2muWKuYD7tMnmPqK9F0rwArKY5KZx
 Oez94sjQM1Dzwvys=
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr88827wmk.143.1593040001164; 
 Wed, 24 Jun 2020 16:06:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhRyS1fsGCzgI4mnuybl4XyDKFZEE1Bg+DLCaCxPgDE3g4ulKnK4W3h2yvXF191n+EST0C3Q==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr88814wmk.143.1593040000987; 
 Wed, 24 Jun 2020 16:06:40 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 y16sm29078848wro.71.2020.06.24.16.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:40 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/19] floppy: make isa_fdc_get_drive_max_chs static
Message-ID: <20200624230609.703104-5-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

acpi aml generator needs this, but it is in floppy code now
so we can make the function static.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Message-Id: <20200619091905.21676-5-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/block/fdc.h | 2 --
 hw/block/fdc.c         | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index c15ff4c623..5d71cf9722 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -16,7 +16,5 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
                        DriveInfo **fds, qemu_irq *fdc_tc);
 
 FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
-void isa_fdc_get_drive_max_chs(FloppyDriveType type,
-                               uint8_t *maxc, uint8_t *maxh, uint8_t *maxs);
 
 #endif
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 5244df6f91..f1da83f08e 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2747,8 +2747,8 @@ FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i)
     return isa->state.drives[i].drive;
 }
 
-void isa_fdc_get_drive_max_chs(FloppyDriveType type,
-                               uint8_t *maxc, uint8_t *maxh, uint8_t *maxs)
+static void isa_fdc_get_drive_max_chs(FloppyDriveType type, uint8_t *maxc,
+                                      uint8_t *maxh, uint8_t *maxs)
 {
     const FDFormat *fdf;
 
-- 
MST


