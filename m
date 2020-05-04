Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC955C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6DB20658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjxGzc3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6DB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXma-00068U-SN
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgy-0005Ql-Ke
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:47:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgx-0004QJ-PS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588585635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjRnLX9M7bUl75vfzRMtWTmWeSyX9kHOv2IRdhv8Iws=;
 b=QjxGzc3SXeVLTtFSs8Zki5vKFJoGA/ZmeJxWAOUIn6OTaxQ3F8vzpMA2OeWyYiBpsNMzeZ
 srJOvZVl5Au+D3/BreSnwWPGYg+FmrXuNLsqGvw2dPyuQ4NR94/FDulWkzhMgvY3PlgyeJ
 tSN6h66ZRuUaO2xq9cVuUUuM1xZk3Zk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-gJSRrdtFNXCWb5EESIl58g-1; Mon, 04 May 2020 05:47:13 -0400
X-MC-Unique: gJSRrdtFNXCWb5EESIl58g-1
Received: by mail-wm1-f72.google.com with SMTP id f128so4584505wmf.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/2PMb8bKNoIe3zdK975EoqjSZA5Q1oobp2Wmj1tp7JI=;
 b=ZC+QRtuR9HqN2W7bHv9aBEpZedTwhZm2cFFi2LVSDcuDd45kM7dLXdK2Kn2o5UbBsI
 biYj/8MjXv8nlgy3d+zKS+9qPuNAjVth849Xfl5BB1RlDh4UUSc6LDn7gp9xPSLiO1pE
 jcJfCLChCey1AfS9n439lleXQk0QW3TuZe4ymzv2EjZL5/OgK/8jP/Ryv44Y4AgWz74W
 WmuVHd+JCY4f1QY7MNcFrl8egeZMh+ueaEQVnVcRVvTdHz64RTYRIEUgxrPuxMSv6d0C
 hU29+jX2BVh0kefKEbyE4wu39vnHlhQngZAHF9SFn4RJy5bU4n/watsZD/Vp14nHrXHx
 ujHg==
X-Gm-Message-State: AGi0Pua8XAlQzFfwWSa7hEQPysDGAyEGQI/c5fyJ1Kv74tomQAt+XYBy
 2Q3GpwCnR9knJbfJhBgOtB/wzxqDdOmisxeAcNjnHvotjHve0U1LITiBCRJoC0N49V4VKMEPLOn
 bDiFn6r4yHH9afxg=
X-Received: by 2002:a5d:6851:: with SMTP id o17mr17705309wrw.267.1588585632041; 
 Mon, 04 May 2020 02:47:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypI+2oU2RG7lr6h2JSNsnUiHUj64/fYdRmk23Z5JZlApNNlOXer7RKtCYAwL9x6Ruy1ebZS7QQ==
X-Received: by 2002:a5d:6851:: with SMTP id o17mr17705294wrw.267.1588585631878; 
 Mon, 04 May 2020 02:47:11 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id t16sm18099065wrm.26.2020.05.04.02.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:47:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 6/6] hw/block/nvme: Make device target agnostic
Date: Mon,  4 May 2020 11:46:41 +0200
Message-Id: <20200504094641.4963-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504094641.4963-1-philmd@redhat.com>
References: <20200504094641.4963-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:14:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NVMe device should not use target specific API.
Use memory_region_do_writeback() (which was introduced
in commit 61c490e25e0, after the NVMe emulated device
was added) to replace qemu_ram_writeback().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC because I have no clue how dirty_log_mask works.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Beata Michalska <beata.michalska@linaro.org>
---
 hw/block/nvme.c        | 4 +---
 hw/block/Makefile.objs | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9b453423cf..9b0ac0ea2a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -46,7 +46,6 @@
 #include "qapi/visitor.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/block-backend.h"
-#include "exec/ram_addr.h"
=20
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -1207,8 +1206,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr a=
ddr, unsigned size)
          */
         if (addr =3D=3D 0xE08 &&
             (NVME_PMRCAP_PMRWBM(n->bar.pmrcap) & 0x02)) {
-            qemu_ram_writeback(n->pmrdev->mr.ram_block,
-                               0, n->pmrdev->size);
+            memory_region_do_writeback(&n->pmrdev->mr, 0, n->pmrdev->size)=
;
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


