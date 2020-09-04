Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC467C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7D7206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnyHtz7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7D7206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEB5M-000236-NW
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEB2L-0006Bb-I6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEB2J-0006Z0-Dl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599223306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VufwieRg1JhzJ8aiEIPGgbaappTVL2Md8brdGSxPk4=;
 b=gnyHtz7+7M446FMfoS4HHJSFt+t5eIrbZiwCMb0AFc9O4iwPOG8mwemhhRN0yWagxNEDT2
 n/b1ay9aR5IEY4HJlKW1KmetDP5GJybXSMQ9BjE9mRQUkRhNVOgFJQLT4IoZMx54Nck/S0
 q7yeUAShGs3d+lzfqV+3IewRrNT3wrI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-rkzPP4T8N8iVGvBW2n_WTQ-1; Fri, 04 Sep 2020 08:41:45 -0400
X-MC-Unique: rkzPP4T8N8iVGvBW2n_WTQ-1
Received: by mail-wm1-f70.google.com with SMTP id s24so1685224wmh.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 05:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7VufwieRg1JhzJ8aiEIPGgbaappTVL2Md8brdGSxPk4=;
 b=QTdXmm3PEIOYEWcZXM2kcy/IGCUro58RZxY0CYV+HDvbBA5+eLwzm0pcnMDye2ru77
 mDUfRTI1rIvcApKBCixkQD1U/PGPd6g+bMFQwm7IGC8GGL/iDz9OUxDD7a1TvmS0/BMK
 kD3SWDWO916Fx0Ltn1iqrhCzH6mR9LbwylVHznggUmNLT3nuMY0yXZYVI+WGr2qUoGZm
 ET7b2Zg4GwsKDkYwlElEOMmioPUYUdGpy2V67+/EevW2dS4H7STaE/Kb6/iskXtcKONA
 IWkRFafS4rSjEXoAJPp4E7dOGK3OQ2nabdbiFjOguVgzGec9rEidu+I2yLt9Eu/SZ3zP
 wdpg==
X-Gm-Message-State: AOAM530dzBlEURwHjsoj6mcqtSa7khJQRkMdFg+8tPD2erxbQ4YSPSFB
 U1yN4oM2txwo53YHbzkZkrDXPQGj2BtdEUHYzv70jO5eGRz9GiePYIjMrsYxAVdi/N6gsloByLL
 dVKXgCdWe0LsM8Mk=
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr7071083wmf.115.1599223303840; 
 Fri, 04 Sep 2020 05:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVi/GUgffyREeodIUQafcx6gCUFbKZYQ9L5hsgCZmvitYkx7UDwU4aWagX61dklCdT5ZXTew==
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr7071066wmf.115.1599223303648; 
 Fri, 04 Sep 2020 05:41:43 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id u66sm11118306wmg.44.2020.09.04.05.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 05:41:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] block/nvme: Use generic NvmeBar structure
Date: Fri,  4 Sep 2020 14:41:29 +0200
Message-Id: <20200904124130.583838-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904124130.583838-1-philmd@redhat.com>
References: <20200904124130.583838-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 07:42:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit f3c507adcd7 ("NVMe: Initial commit for new storage interface")
introduced the NvmeBar structure. Unfortunately in commit bdd6a90a9e5
("block: Add VFIO based NVMe driver") we duplicated it.

Apparently in commit a3d9a352d48 ("block: Move NVMe constants to
a separate header") we tried to unify headers but forgot to remove
the structure declared in the block/nvme.c source file.

Do it now, and remove the structure size check which is redundant
with the header check added in commit 74e18435c0e ("hw/block/nvme:
Align I/O BAR to 4 KiB").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index c9c3fc02fed..a216cc407f6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -83,28 +83,10 @@ typedef struct {
 
 /* Memory mapped registers */
 typedef volatile struct {
-    struct {
-        uint64_t cap;
-        uint32_t vs;
-        uint32_t intms;
-        uint32_t intmc;
-        uint32_t cc;
-        uint32_t reserved0;
-        uint32_t csts;
-        uint32_t nssr;
-        uint32_t aqa;
-        uint64_t asq;
-        uint64_t acq;
-        uint32_t cmbloc;
-        uint32_t cmbsz;
-        uint8_t  reserved1[0xec0];
-        uint8_t  cmd_set_specfic[0x100];
-    } ctrl;
+    NvmeBar ctrl;
     uint32_t doorbells[];
 } NVMeRegs;
 
-QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
-
 #define INDEX_ADMIN     0
 #define INDEX_IO(n)     (1 + n)
 
-- 
2.26.2


