Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B953C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD512054F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFJta/4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD512054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOpq-0003IR-Kv
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOe6-0001hr-Su
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOe5-0006ZU-Ra
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:42:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27149
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jONJc-0006pT-Nk
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 11:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586877452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=elfX9Jap2S51zkLes32cUESThcaOh4oCLB1Mj17tGoQ=;
 b=dFJta/4vJgKPAiWS25a4C9t81N5d8VMR9r27h1ndw7co8hM/o42PGutuKsNTeCd+5HbeCd
 9mZM9v2v4H08VcBVbPX2E+h+NQqKwIQ4kVoAn4JlSh9tZAhzXN68lH46asHek2DHNFb8+X
 cwAS8yGwW/GCQXRgrX8DqStZY1W8m3s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-YtZxACtAPTCVRzM8Xn3_dQ-1; Tue, 14 Apr 2020 11:17:30 -0400
X-MC-Unique: YtZxACtAPTCVRzM8Xn3_dQ-1
Received: by mail-wr1-f71.google.com with SMTP id m5so5743347wru.15
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 08:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RslDUjfrw1mYqJ+woerz+C46TheRzySb2oFzeCEKBZA=;
 b=e4vN9bzIV/KTdbtyusHxZFCzg4sKvJYIOCMRKFpTuHwW2ua2Ta7r/S6E56PDMl11wV
 HafH3Y3XXnXt4ZhSXBy+HKGr++/btxX4hPI74Y1/efgsvUjcEpfSc8BU/ZOxCKns4kuh
 Ul/eORddpl7f/QYX9bYzR61XEtTfHHtsRdcr3snf8CI1zqYG+wZT1Q8MX2YAf0+Yr3Nm
 7wumuXG24snXaPLxGQS3VAGtRtF7CpGr8dJtjraS2wwOr+8e0yNSy2hfHxf8NMUCxS7Z
 B1a7yWevCQpZPsgxmyvwo/+Br3vxPDbelnBXYVGJn6R1hmCAtUy07v5gl37q5YjBgosj
 LJKA==
X-Gm-Message-State: AGi0PuabrLJ+J6r6tky6ezwqLbCA9RXgJbd3Nfu0vCf1heNfPWjmDb0k
 cLCt/BIcbc1OeqBwE+IKtfj36HMgqH8UZN+WuEIdiNH57FlDbqwRwg00bdNpYis6dfZpeJIoghq
 bn0UQuQLB2jBmCRs=
X-Received: by 2002:adf:dd07:: with SMTP id a7mr10964645wrm.349.1586877449407; 
 Tue, 14 Apr 2020 08:17:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypKA3dfH+EmvoIX2ADuzqJq72Fm0mrQA5oHzVwobpm8jlTsxrDU6JZ4fJLuRLKn+Trj8Tc03Zg==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr10964628wrm.349.1586877449227; 
 Tue, 14 Apr 2020 08:17:29 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id g74sm19268685wme.44.2020.04.14.08.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 08:17:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block/nvme: Remove memory leak
Date: Tue, 14 Apr 2020 17:17:26 +0200
Message-Id: <20200414151727.17012-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: bdd6a90a9 ("Add VFIO based NVMe driver")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nvme.c b/block/nvme.c
index 7b7c0cc5d6..9f3c7ab819 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -163,6 +163,7 @@ static void nvme_init_queue(BlockDriverState *bs, NVMeQ=
ueue *q,
     }
     r =3D qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
     if (r) {
+        qemu_vfree(q->queue);
         error_setg(errp, "Cannot map queue");
     }
 }
--=20
2.21.1


