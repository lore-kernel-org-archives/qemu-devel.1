Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4322DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1E02065F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoREJ7cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1E02065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqE6W-0002V4-Ba
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE4M-0007Uh-2H
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE4K-0006R0-H3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593515091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZCe5OgsdLzHyTw8HV351yv3jE/x9fSK5ohsnhOc0Kk=;
 b=YoREJ7czVVrCBVPZvQbL02ZSdIv36qOH3/h9CwxjzWtje/GmAu+uuhVwClt6DCzljbGS9X
 MjUKfMAP0aBdy/ypN+h8i7F0mb7yTpBOlHw1vtx/zqPyLy1h4AnTqaHp8gJtlvqJdC/4bk
 Yub96knXQHBSmHHzsnLVWo1JHYRhFVM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-40z8NBxTN1ybQt7q1hqBdg-1; Tue, 30 Jun 2020 07:04:47 -0400
X-MC-Unique: 40z8NBxTN1ybQt7q1hqBdg-1
Received: by mail-ed1-f71.google.com with SMTP id 92so16630270edl.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YZCe5OgsdLzHyTw8HV351yv3jE/x9fSK5ohsnhOc0Kk=;
 b=a6kzgnNl/Tecl6WmW2zZpPdxNo18ktB6nOwWM8z4e8LWQ4mPOQoLCQQ+EEENFguJiD
 8wp7UcHa/Cgfh//d43bCf42idn/GLI4oldu726XzEeLOpj/YPeEP4mESd594QmFw55v2
 0/hkekkv/04vzA4pgzXuYsFj0Fx6u+tL+PB5HZ39LmhF8nMj5U13DTTd8X6xBwpf+J+L
 Hic8Cl/+osP534ks72VjslUIOF37iVabLOUQjT717q8pbpxVRrf+t5eUYfuspzyVrauc
 h0tbjtsBNcW7GaRMB8sTNi/5983e9+ZV5EnqVWj0pyELpkKdC/vm4otnhG+utqNuw0Qp
 pkIA==
X-Gm-Message-State: AOAM5317AamaFCH6LaSqMemj5+dNPYW3NbqE47zsGVvjA9eyq7DIxkz5
 kaJ1Y0QvpU2KODzDfJMFj9+b5qvlxKGe/gSeB0Zuwv+N8avs8PAx2ZM4QVfmSd7cejmJpQkX/FG
 /pBMCc8t6wrehxJw=
X-Received: by 2002:a17:906:2851:: with SMTP id
 s17mr18057134ejc.347.1593515086525; 
 Tue, 30 Jun 2020 04:04:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxquEY1ayhYdraosdZZbxagGQCURPcP1PP5/ZbIJQXa3Ch69ikv0ig+if7CiLz0O1U9PJeqpQ==
X-Received: by 2002:a17:906:2851:: with SMTP id
 s17mr18057121ejc.347.1593515086374; 
 Tue, 30 Jun 2020 04:04:46 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id sa10sm1756669ejb.79.2020.06.30.04.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 04:04:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] hw/block/nvme: Fix pmrmsc register size
Date: Tue, 30 Jun 2020 13:04:28 +0200
Message-Id: <20200630110429.19972-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630110429.19972-1-philmd@redhat.com>
References: <20200630110429.19972-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Persistent Memory Region Controller Memory Space Control
register is 64-bit wide. See 'Figure 68: Register Definition'
of the 'NVM Express Base Specification Revision 1.4'.

Fixes: 6cf9413229 ("introduce PMR support from NVMe 1.4 spec")
Reported-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
---
 include/block/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 71c5681912..82c384614a 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -21,7 +21,7 @@ typedef struct QEMU_PACKED NvmeBar {
     uint32_t    pmrsts;
     uint32_t    pmrebs;
     uint32_t    pmrswtp;
-    uint32_t    pmrmsc;
+    uint64_t    pmrmsc;
 } NvmeBar;
 
 enum NvmeCapShift {
-- 
2.21.3


