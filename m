Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054AC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC1A20708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fG33HLfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC1A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwSr-0008Fc-9d
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWwRl-0006ci-Qm
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:25:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWwRl-0002Cx-1D
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588919120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87P32Kl/23kk0D1p3Mn+1uBjkyslr+Glpw+ZqggV/4k=;
 b=fG33HLfx+uldlo6dO5WMOGEAUFN2/MxBFgBTjmY1rh7aZIA51s+mNl8qeczWwvXlKBOKzM
 pB9wuiKT+UmUxG0shfJSSxF7iy7Dt69afxT1LdwhPdIMsxRxNDOlIvW7tBUr/PXSn5NMvY
 XGiW35KjlPs91WoEJUNL7jrhMPWOWMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-Aski_cZ8NaGOZtokLAxvvA-1; Fri, 08 May 2020 02:25:18 -0400
X-MC-Unique: Aski_cZ8NaGOZtokLAxvvA-1
Received: by mail-wr1-f72.google.com with SMTP id a12so404385wrv.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 23:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=msg2yf/FEYiTLrt9QncWwUsE+vw2haTQYPoKbGwSl1Y=;
 b=aA5+LMGK/Z2z2u8CgkBCFe98lRSju24ePuPCyQpKt0zXJwjqtfrlSl6bdZjtX8wfpv
 x356vQEpupfgZL3wbakSesrzJXH8bmaZu9Xn0r00bhIiJbAncTE8FCKMc+/M4KXE1vj0
 xEHrv7v6GxnwDl665I81RF5LjuYEdT75qUlk9ySorSXLRNQkFwPUW4D9HsGjgtpdUFCF
 kVsB443MoUCta0O1koa8NbLcNbpmhuGxxow1sTra1J46KWwkfjYmNeuQL2L9gta3vQKJ
 hPSHqHKjAtX9LaPiDs1MZr8c96g0Y3tITtVKsbdMVFoT3IQoJ5nFVomgHeTFKuochOF6
 4O5Q==
X-Gm-Message-State: AGi0PuZvPidmzJvIAMb6Tcf5XZb3m4aIS74SxXWyyC/RNo2LXXhP74+9
 Zy68Rx4m7ZRecAqW9QDr1174l4rKgifG3Zx1KgbAyZxRonCiVv+S8zcoZ/+FO3t6LU1GhBcWcN0
 qVXgm0y5RnxipFWQ=
X-Received: by 2002:a1c:b684:: with SMTP id
 g126mr13615161wmf.163.1588919116995; 
 Thu, 07 May 2020 23:25:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypI0Fdhu6oSUk9BPDVZ+GA/sMq60b8qUgC2N/TaNDzcyZU4XbdbPHWVc9XayCa43CM0Jb2uCIA==
X-Received: by 2002:a1c:b684:: with SMTP id
 g126mr13615147wmf.163.1588919116818; 
 Thu, 07 May 2020 23:25:16 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a8sm1241280wrg.85.2020.05.07.23.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 23:25:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/block: Let the NVMe emulated device be target-agnostic
Date: Fri,  8 May 2020 08:24:55 +0200
Message-Id: <20200508062456.23344-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200508062456.23344-1-philmd@redhat.com>
References: <20200508062456.23344-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than the non-target specific memory_region_msync() function
is available, use it to make this device target-agnostic.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/nvme.c        | 6 ++----
 hw/block/Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9b453423cf..8a72dce0e6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -46,8 +46,7 @@
 #include "qapi/visitor.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/block-backend.h"
-#include "exec/ram_addr.h"
-
+#include "exec/memory.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
@@ -1207,8 +1206,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr a=
ddr, unsigned size)
          */
         if (addr =3D=3D 0xE08 &&
             (NVME_PMRCAP_PMRWBM(n->bar.pmrcap) & 0x02)) {
-            qemu_ram_writeback(n->pmrdev->mr.ram_block,
-                               0, n->pmrdev->size);
+            memory_region_msync(&n->pmrdev->mr, 0, n->pmrdev->size);
         }
         memcpy(&val, ptr + addr, size);
     } else {
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 47960b5f0d..8855c22656 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -13,6 +13,6 @@ common-obj-$(CONFIG_SH4) +=3D tc58128.o
=20
 obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk.o
-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
+common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
=20
 obj-y +=3D dataplane/
--=20
2.21.3


