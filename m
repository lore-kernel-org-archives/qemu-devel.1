Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F6C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75B02225E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYidfso0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75B02225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQ2c-0003KQ-SA
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTy-0003ue-7j
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTw-0004Uu-8F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Utic1r2QfB0RLxuIXWbW8/BZ/+Cux5YDi1b1KSr+AQ=;
 b=GYidfso0Fs6V8pu9jz7RkdSWfsLRBpXnqezJqJw86p2TUuOBDDXfefSeLMwEb/a+Fx+sZ3
 mqHhfWlg2l636Wbe3feta8828EQVQWbfJO/7MPj8dv4GKQsT1Z2Vn6GlU6A2kviMpmI5jw
 N9pvxSbLzeNgWNQwgR1hvB7lRlYzGXM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-vlUElww6NwivCcISXKAjYg-1; Tue, 27 Oct 2020 09:57:45 -0400
X-MC-Unique: vlUElww6NwivCcISXKAjYg-1
Received: by mail-ej1-f72.google.com with SMTP id k13so887897ejv.16
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Utic1r2QfB0RLxuIXWbW8/BZ/+Cux5YDi1b1KSr+AQ=;
 b=A2WAmwY9vasCidxEUFPjTWjxlHZOIPukoe+Cn5CMbvGi9YFyX6tpEoLHjDVSWD0A4M
 jRRzYvjmjjYacMV9oH2vIv9vOx1PKX8sll5LoBPbcYYLnl86ekZkrT60V3tAINridnOk
 YvSo939kCpFbAtewnVRpbIYD86Ee0Fck8gkPj4fWjy3X1vIOb/wO3uNz81xvSOAKenU1
 Aj5FtQa2+BzmKrri0k2vBwh/gopdZ9y8V8UaBQ455zUtfn7Y4ka9TAsQz25AEk3p+cDV
 ribT6XbFtlGnXrvMPh3QwqQuvRsKw/uxsW059OAqV6aTBJ55efc/w9uUlukKbucYMR5e
 Rrrw==
X-Gm-Message-State: AOAM531LY/ymEmljwmNFI1GIcuLScUZ4CDLwgFng6Q2Uc8RJuR4o9wU8
 +vwbBkuacx+8igBCgXvvX3grkBHLz0IhsVX9dPdibYjX0OQ272EC4wCiKFxONEBtr5yCSWvZVuj
 wfOM1pWfkj5hINWM=
X-Received: by 2002:a50:ab07:: with SMTP id s7mr2344433edc.287.1603807063641; 
 Tue, 27 Oct 2020 06:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx52vu3HB69weFD17jCoA/z36Gtt2WNjlxz29VyUmlUG8o8YtK1ekcFZufUNtFYGFjTe0IueQ==
X-Received: by 2002:a50:ab07:: with SMTP id s7mr2344420edc.287.1603807063451; 
 Tue, 27 Oct 2020 06:57:43 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m25sm1014991edp.36.2020.10.27.06.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/25] block/nvme: Change size and alignment of IDENTIFY
 response buffer
Date: Tue, 27 Oct 2020 14:55:43 +0100
Message-Id: <20201027135547.374946-22-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index d2d57a287cc..ad70303c5c1 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -521,19 +521,20 @@ static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
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
     if (nvme_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to identify controller");
@@ -555,7 +556,7 @@ static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
-    memset(id, 0, sizeof(*id));
+    memset(id, 0, id_size);
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
     if (nvme_cmd_sync(bs, &cmd)) {
-- 
2.26.2


