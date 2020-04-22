Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF1C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 21:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79722071C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 21:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8FrvArZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79722071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58571 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRNLl-0005Hy-OM
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 17:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthoine.bourgeois@gmail.com>) id 1jRNKs-0004Oa-Ec
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <anthoine.bourgeois@gmail.com>) id 1jRNKr-0004tx-Tn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:55:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthoine.bourgeois@gmail.com>)
 id 1jRNKr-0004p8-GG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:55:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id j2so4416046wrs.9
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dZG0n0VaLA7h/AbQlU3LwFM0V8Gn36yk9h6GHXolsbM=;
 b=e8FrvArZrmR+VkQhvNf3+hxicTA/HgvIBTcSNG+dwQWDYXh6eAg9io3692b3zwubHL
 qYsFV8ErKJO3M3VcYFbA7pz7176okwVM6nsjddxqxHPlAqxF39b8aIgiHCwpYDdWAAZw
 aVRW0biuVzFRPeNkUMrWrdgV+0V4/uoOXX3qUBbakeir3iMGERc6ikFodNSge/RxD9ol
 mxuD5QCStaOXosyrhGYKI7JOSlg2zMISrVFa2NSCPhLV1zSRxc+FLlQMrKYy9NizHxM4
 UVCs6GNh4xmUjLeF45meGcOq1ziG6NETiJgouI8ulayz9uiYpBtxD5c6Ug/pqbvgVw0j
 HOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dZG0n0VaLA7h/AbQlU3LwFM0V8Gn36yk9h6GHXolsbM=;
 b=euAEb4qWBfzgt7iNCTDqzVC3z0lqAL4QzXM6WQzgMq0X6ljmr6f15BUZU+HKDba5Zp
 sKFcKnKqoOj3bNiHWtda97Y5wv+l1bQpps1IOwi6aGG6UAuT8dTL0gDcsGABkdt1Y536
 eJFoeBCH2Dhjd4/ASiXyIsLKrOGE9nKKAj/EW6ZPfwcC2HHPaWGnzyiVxn2vU5c3dLOe
 J2sV0NacM0DXzAkemyi/Tw0AE3keKnZYrflyoQ5/ZTdKPIVKUa4FX/xC55uG6hhuyawD
 JeywRlvPsnjlZVuSeqEMcvyYfBFGhnyZu3JbGSzWv7zSJxiaDt+ui4yh1FP0cj5+4J8o
 IQ7g==
X-Gm-Message-State: AGi0PubdovlEsRS2SNo7OOD/NdBE5ZYltj2JkJKUh9YGWuHKHdj7ZTbY
 HRllX5eNObr0W2Aw4WYQSKImpFElY4U=
X-Google-Smtp-Source: APiQypIFLSc43SIGEMHD6Se+b2F6jt8CxvQXQzWUDWKCa2BNhlv8aZ2DikOmTd/BqAZBk3TpuxjYYQ==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr1162715wrn.209.1587592511538; 
 Wed, 22 Apr 2020 14:55:11 -0700 (PDT)
Received: from hobbes.blade-group.net
 ([2a01:e35:2fb2:a0d0:6d28:3d72:693e:c474])
 by smtp.gmail.com with ESMTPSA id c190sm874243wme.10.2020.04.22.14.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 14:55:11 -0700 (PDT)
From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/2] virtio-pci: update virtio pci bar layout documentation
Date: Wed, 22 Apr 2020 23:54:55 +0200
Message-Id: <20200422215455.10244-2-anthoine.bourgeois@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422215455.10244-1-anthoine.bourgeois@gmail.com>
References: <20200422215455.10244-1-anthoine.bourgeois@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=anthoine.bourgeois@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The modern io bar was never documented.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
---
 hw/virtio/virtio-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4cb784389c..d028c17c24 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1705,6 +1705,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
      *
      *   region 0   --  virtio legacy io bar
      *   region 1   --  msi-x bar
+     *   region 2   --  virtio modern io bar (off by default)
      *   region 4+5 --  virtio modern memory (64bit) bar
      *
      */
-- 
2.20.1


