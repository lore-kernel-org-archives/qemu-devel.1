Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E0CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BCB2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mru2aeYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BCB2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4XW-0001WD-Bg
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4L7-0007rb-M5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4L5-0006yI-UI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7ARdMdjChejWzNOv4rbThOcf14/Pp3Q0pevnTZmOLU=;
 b=Mru2aeYGSi9Qd/mKVg8D5e5kubhsN/fE8+QSwqzPhlmj7wHsUDqr6kqcwIS7ycBmP/3/GX
 wrznmKgrtNQJZCE4hxi2yHHbIFtVr+VdYdvOy8sSDCIkm5NijjsxCfV3AhqMjI5OEpyYPK
 PNmnfxHRcCYK0QMBnrICB/plLOx6EWs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-LY4l8oY5Onmxac_bSHVb_A-1; Thu, 29 Oct 2020 05:35:19 -0400
X-MC-Unique: LY4l8oY5Onmxac_bSHVb_A-1
Received: by mail-ed1-f71.google.com with SMTP id 28so940956edv.9
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E7ARdMdjChejWzNOv4rbThOcf14/Pp3Q0pevnTZmOLU=;
 b=b20dnmyD1+4qM7ZlIoGfUrTd/a7lI6xwx+AfLyNKL7jDzxB7yTd4u9wTd2E62fwvsP
 dt0uTHRw7p3uxl9crf+esEpJf8o20sMC+eV32wWfarhsWxC4BmzSL1SmY0eVfVSELoXD
 ADt3YeMkM3tYxjqhTG+0l8QH7NdAv/Ny42kNV7WqRBgfJU6wJGEaV+518LH/U5tCFtbx
 NuyLfHlMJpOOukxIEYJ4x0Hl2rUqxAoZu8b5he9FzXrYyN3sWAt+WwL2df0yqXsAQBYd
 G5Iin/TYvqf6zwvPpmxYu9uYYL79miA2YRHNPZlBQLcDnoQKlaxzJPsGTqJHDzyFmzKk
 IqjA==
X-Gm-Message-State: AOAM530+nJdZvL8IDRWVEu2viJADgJ/OS7XpeeonQCeSlAXSl/6xzvRh
 2xBrXYXXuPTIq9MV668NwDiXWcwex8ZnpXV5fX2p9N4WY/rY4bXk6nyl8E3hybi3uOVXovIBOA6
 oSututea+It7gHJk=
X-Received: by 2002:aa7:d843:: with SMTP id f3mr3132448eds.354.1603964117845; 
 Thu, 29 Oct 2020 02:35:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAay3pmJYlLgbH6MPTB2Q0PEhx1HhlZ8YZ0CFL2D+WbqyLxHWDudhWsgUz+4hKpE6k5jM12w==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr3132424eds.354.1603964117514; 
 Thu, 29 Oct 2020 02:35:17 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id ao17sm1179118ejc.18.2020.10.29.02.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:35:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 24/25] block/nvme: Fix nvme_submit_command() on
 big-endian host
Date: Thu, 29 Oct 2020 10:33:05 +0100
Message-Id: <20201029093306.1063879-25-philmd@redhat.com>
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

The Completion Queue Command Identifier is a 16-bit value,
so nvme_submit_command() is unlikely to work on big-endian
hosts, as the relevant bits are truncated.
Fix by using the correct byte-swap function.

Fixes: bdd6a90a9e5 ("block: Add VFIO based NVMe driver")
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index c8ef69cbb28..a06a188d530 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -469,7 +469,7 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
     assert(!req->cb);
     req->cb = cb;
     req->opaque = opaque;
-    cmd->cid = cpu_to_le32(req->cid);
+    cmd->cid = cpu_to_le16(req->cid);
 
     trace_nvme_submit_command(q->s, q->index, req->cid);
     nvme_trace_command(cmd);
-- 
2.26.2


