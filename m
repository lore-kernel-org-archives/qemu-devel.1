Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF87C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5057422248
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be7m1XTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5057422248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG12G-0001JX-CL
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG115-0007QS-5W
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG113-0004Hb-BA
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599661444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XveAq6dKRegNYH6qGpDAxuD8T7S7WZA4o4LfFGLZC+A=;
 b=be7m1XTXMEzPPYeSsw57j0+kMW03DKDJMokshxWM22gXP6+lYaEk/NA6i7SbrVzWS3ii3B
 ULVV6K1ZrlQzTgWI7jwIboI66unsBbi6EKzKifQphmPOG/mz5MrxDsizDidWDZx1SvEqNf
 aNg92a1N9tuiEKfRZzefUiOutIL26Mg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-WZKOu_JxPVySybSAQBb8Hw-1; Wed, 09 Sep 2020 10:24:03 -0400
X-MC-Unique: WZKOu_JxPVySybSAQBb8Hw-1
Received: by mail-wr1-f71.google.com with SMTP id x15so1021712wrm.7
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XveAq6dKRegNYH6qGpDAxuD8T7S7WZA4o4LfFGLZC+A=;
 b=SsHXtJAV3sMb849SSp+RdLXsdojRdN+DEPBLHibrbbwkfV+GVjytBse2aByW0s6rQH
 sc29vYXAdKDvkaMKpxcaU62CL8QVJpNteVhnrO6RAOs1ge5tPgamFSTyQN8E1qG2HACh
 AAJJ7Wnl63aPFW4WxgOQ6CRRYW6TnJaelKd//ueB4QWDvCa8jnEY5nsZjJUn79Dwnbcx
 xMITTFnjpyu913vcYk97tZG/gIjkl3EjH4lNWk8pO3L7ivbLp9gjbNXtDSs7H9/L9CU9
 ll0RuU4HEb0ugPW8JJQokQmwRAAs7xP1FDe7kK0gq2h/reWH+uT/cJxI6R9Ir/cULoyv
 LuRQ==
X-Gm-Message-State: AOAM530qPwVjAEeMeYRMS4OuhU1b3XUiLbHpJxEZlvK1L5ygNTMe849v
 4/QcCEYiHgsWZs13oijHQx/t8I55QkQurfiDI2Jewzr2x7T4OJaQyaBXKsd5sooCQWGPG/G2tdn
 u3b2laGa1TO1JVqU=
X-Received: by 2002:a5d:6551:: with SMTP id z17mr4291191wrv.200.1599661441704; 
 Wed, 09 Sep 2020 07:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3FEHScspgccwbCDzV4fWJUTuSOhYcB6BMl1A1rL9E6LZXgx+zpH5y2bLOShSE7qqnxgzSzg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr4291165wrv.200.1599661441449; 
 Wed, 09 Sep 2020 07:24:01 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p3sm3996274wmm.40.2020.09.09.07.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 07:24:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/4] util/vfio-helpers: Improve reporting unsupported IOMMU
 type
Date: Wed,  9 Sep 2020 16:23:51 +0200
Message-Id: <20200909142354.334859-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909142354.334859-1-philmd@redhat.com>
References: <20200909142354.334859-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change the confuse "VFIO IOMMU check failed" error message by
the explicit "VFIO IOMMU Type1 is not supported" once.

Example on POWER:

 $ qemu-system-ppc64 -drive if=none,id=nvme0,file=nvme://0001:01:00.0/1,format=raw
 qemu-system-ppc64: -drive if=none,id=nvme0,file=nvme://0001:01:00.0/1,format=raw: VFIO IOMMU Type1 is not supported

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 583bdfb36fc..55b4107ce69 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -261,7 +261,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     }
 
     if (!ioctl(s->container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
-        error_setg_errno(errp, errno, "VFIO IOMMU check failed");
+        error_setg_errno(errp, errno, "VFIO IOMMU Type1 is not supported");
         ret = -EINVAL;
         goto fail_container;
     }
-- 
2.26.2


