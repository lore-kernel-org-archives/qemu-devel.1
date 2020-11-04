Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04B92080C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mtv2DFmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04B92080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAmL-0006Xl-MY
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAl1-0005Gx-HA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:50:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAkz-0004G7-G1
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0heXC8AZt7eXzCvDvOmqsibMEQ+v+zzRIJ+pXZVz+w=;
 b=Mtv2DFmJVLZwa7O3SAkBYgj3z5YbvdqlbWzRVgUigCtclKYhoACFWZ1d/Vk9syQr7xyguD
 ngpmBFhSNnE9KkvqbbcSJ6BGYGqdOegEwR5C4OLub+olYDT7BPO64yzbCPVnKqeMSkCwCd
 vPlN4kOLnUosyzcO+Ou5MVmQq9j28P8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-mzhFKT23P-aRPJiB6CRmTw-1; Tue, 03 Nov 2020 23:50:47 -0500
X-MC-Unique: mzhFKT23P-aRPJiB6CRmTw-1
Received: by mail-wr1-f71.google.com with SMTP id w3so6590269wrt.11
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h0heXC8AZt7eXzCvDvOmqsibMEQ+v+zzRIJ+pXZVz+w=;
 b=G1eTEVq3RKi1bAqCSlkPopjHlk2mbN7fK1wTvz8SYUchCCV1dgAbQFYgs+RDi3DuuF
 BwlX1pmW7uJeMDMAWB282+kOUe5Bnu/sWl8g+OwpXInwCCmKxFS5Y3OuSzpcH4+QPSax
 P4EAe5dbA0RoboHU/BUncsPFtVvQFV40VxDiKrXdRcEguwk3vsMXy1rVPY0FSmZCVg8q
 9iepAgioxNpyGU9O/esB65hereEiAx01WoGOefVIW22VVMbjsrM1YWamCoYlbdbA5IgJ
 pq+gikoqAlDIQ0T2r8YajrpBA+6WSlMXedS5P7hWrQDz9qq/etMBJ0qrXlWHXxvP9pJv
 WJVw==
X-Gm-Message-State: AOAM531BsbQCVInANCQSUGm2b0dG5PAv07eAEnlludRpYp41ioYXAnOp
 rD1iRgxNR1lxFOl4xwjBntu+v5Noqqbr67TDye6Pqy6s3ZpjPDSYocCKplK/jLajxOQm73NiRYr
 t/GnzwBLaSSqg/R4=
X-Received: by 2002:adf:f142:: with SMTP id y2mr29293504wro.160.1604465446226; 
 Tue, 03 Nov 2020 20:50:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR8fS79irP/yMcqEEsTB+znKS1JR1WXzlvmNG1CDNAANTzslmkfifgBTPhApTG3c0iiAJIPQ==
X-Received: by 2002:adf:f142:: with SMTP id y2mr29293487wro.160.1604465446008; 
 Tue, 03 Nov 2020 20:50:46 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id q2sm881069wrw.40.2020.11.03.20.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:50:45 -0800 (PST)
Date: Tue, 3 Nov 2020 23:50:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/38] pc: comment style fixup
Message-ID: <20201104044937.226370-2-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix up checkpatch comment style warnings.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Chen Qun <kuhn.chenqun@huawei.com>
---
 hw/i386/pc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5e6c0023e0..17b514d1da 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1149,10 +1149,11 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             error_report("couldn't create HPET device");
             exit(1);
         }
-        /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
-            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
-            * IRQ8 and IRQ2.
-            */
+        /*
+         * For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7 and
+         * earlier, use IRQ2 for compat. Otherwise, use IRQ16~23, IRQ8 and
+         * IRQ2.
+         */
         uint8_t compat = object_property_get_uint(OBJECT(hpet),
                 HPET_INTCAP, NULL);
         if (!compat) {
-- 
MST


