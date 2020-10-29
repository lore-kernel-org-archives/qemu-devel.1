Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB653C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2FC2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/Lh4ilK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2FC2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4X5-0000vU-Jf
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Kh-0007QV-4B
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Kf-0006qP-KP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWiNSG2LUOKYVBwx8cuVrYTSHgZcY9BMn/MdeeoAo/g=;
 b=i/Lh4ilKDhkxr2YwsTetdA1kDxEKD5XbjqogzJIwP8e4TsnuCE6cfkr0vEjsdZBdT6EkyM
 ZYB4WGUbZgx3ShIHdeDMYD8VZuFL8+IJ9LYga27WtGSQtTsgYJEzMVZppHPC7cgpiqn0+1
 VERTqrm0DcIRcdQxquFWNiuf7q4Rhsw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-pT430mQMMYaLnspxPHLMyQ-1; Thu, 29 Oct 2020 05:34:52 -0400
X-MC-Unique: pT430mQMMYaLnspxPHLMyQ-1
Received: by mail-ed1-f71.google.com with SMTP id ay19so918977edb.23
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rWiNSG2LUOKYVBwx8cuVrYTSHgZcY9BMn/MdeeoAo/g=;
 b=ZyE3DU2Lr8o3sNLbC0APpxduBGPVpwCLbfHUTh/DYlU+t9OcSVChBhiizVMO8iq69x
 oElx3HJu9+zjp1NMqIYofrMZyz73QpHuBGtNZfWTo3si6hWPuWlf3eJIlFn59eZl9OEB
 MJGC8ZI5ibnWNljRCg2l2OKPHuiiN/M+/ukd1Q6aHlEppxA4V55uZj7j+doAXgFRw6sO
 Niag1H5sG5MNoRCDXIkR3B0XNqJULiwS8jS6Tu/fiZky/lx4ZIoRA/i7gnh9+e9e4bzB
 DV286qNNGmnfC3qESRt/OO2Uy/10dUzvcGr4dkNr9WODonkHJBi+VN7sAgwWLrQdiwiO
 5mSA==
X-Gm-Message-State: AOAM533Pblprnoc1sP2izuLgijpQMMBSpqKdKJvxi0wmnVQYxjKmDK9A
 41ZqgMPvK0PPe+tDdmXb334+3fLpmgl6rieAj+pjfcbV3WgHGDR05yxOeRCLuVhVpVhpH0dsSct
 C3OtRPFgN54XDm1s=
X-Received: by 2002:a17:906:268c:: with SMTP id
 t12mr2980897ejc.377.1603964091267; 
 Thu, 29 Oct 2020 02:34:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2fplAeCmn4KjQvLFwcFetSv60We+HjuDBR+g03i54KhnKmwag5CQRx/3lJomd4K8fucH/4w==
X-Received: by 2002:a17:906:268c:: with SMTP id
 t12mr2980881ejc.377.1603964091126; 
 Thu, 29 Oct 2020 02:34:51 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id qp17sm1125194ejb.111.2020.10.29.02.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 19/25] block/nvme: Change size and alignment of
 IDENTIFY response buffer
Date: Thu, 29 Oct 2020 10:33:00 +0100
Message-Id: <20201029093306.1063879-20-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

In preparation of 64kB host page support, let's change the size
and alignment of the IDENTIFY command response buffer so that
the VFIO DMA MAP succeeds. We align on the host page size.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index bd3860ac4ef..7628623c05a 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -522,19 +522,20 @@ static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         .opcode = NVME_ADM_CMD_IDENTIFY,
         .cdw10 = cpu_to_le32(0x1),
     };
+    size_t id_size = QEMU_ALIGN_UP(sizeof(*id), qemu_real_host_page_size);
 
-    id = qemu_try_memalign(s->page_size, sizeof(*id));
+    id = qemu_try_memalign(qemu_real_host_page_size, id_size);
     if (!id) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
     }
-    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova);
+    r = qemu_vfio_dma_map(s->vfio, id, id_size, true, &iova);
     if (r) {
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
     }
 
-    memset(id, 0, sizeof(*id));
+    memset(id, 0, id_size);
     cmd.dptr.prp1 = cpu_to_le64(iova);
     if (nvme_admin_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to identify controller");
@@ -556,7 +557,7 @@ static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
-    memset(id, 0, sizeof(*id));
+    memset(id, 0, id_size);
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
     if (nvme_admin_cmd_sync(bs, &cmd)) {
-- 
2.26.2


