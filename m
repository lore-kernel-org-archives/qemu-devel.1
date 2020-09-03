Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457BCC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B0020639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+sOmI7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B0020639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoQC-0005FU-4G
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLl-0007u8-R5
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLj-0007nt-Ro
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7z5+e7/E61U4fRcXXvYvhWwXvlJc3olBRQ++jvakag=;
 b=g+sOmI7FxjDu/Aig799lLF7tx9Bx10DQEBskCsV83MHYBo31ZZKoxItZDmjyGQ3t15Mmtm
 kijnhRV5PlB+NS8cX6uP/Iou8lLF9VzJd7Y2vEoSIaTpDlq0DSYJTZQ6z1ff3MlBLyWrw/
 p0okEhtEJwXjEoPwjLjVZUpZAiibF1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-yx_tLw-YN720faERTkJ_fg-1; Thu, 03 Sep 2020 08:28:16 -0400
X-MC-Unique: yx_tLw-YN720faERTkJ_fg-1
Received: by mail-wr1-f69.google.com with SMTP id j2so1020376wrr.14
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+7z5+e7/E61U4fRcXXvYvhWwXvlJc3olBRQ++jvakag=;
 b=kB0CL/zL0zKR8TmNbZ+Fx4uo0lV9xql94tMxRGliWZOTJcC1N796H78XkOoyumoznI
 SJACeHZlM2aaGarrNrdC1VbOuiRqlhBTW7TzdaSDPZnWdYc3UrAdSOXkdQeEP1vS+dhF
 vZKBCZm0EkCA45rBFS5l+mzSqJSCH/P1rUpyzFE/Abie+eQQFEjfveDAMG227HU4Pa3u
 pufU7DMIAOls7Cpz5lajVS3O9D8N1c97iAajjIPeAE/eCumOuNwYYh+lf+HCNv69u7P0
 pswZFx/q3K8eSOkKP5lj802D6CRIsgyGlByvTIMojoesnaI62+KxC3tUjxK5wuuVJIKE
 AXTQ==
X-Gm-Message-State: AOAM530i7nst0ajXMIstmzYQ6t5QG9P0MQv1WMHxurC0jzqsGzXiLOa/
 HHSbm+E1t89VdSl8WD7PHX9QubFUphZRjtZEQTY6c1WMI8olkDQMngeRSyyKwyEaanEx53AyWPA
 pmBmM7m2NopOWydE=
X-Received: by 2002:adf:f149:: with SMTP id y9mr2151724wro.93.1599136095285;
 Thu, 03 Sep 2020 05:28:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5KnYvmOYgjIWd+xJOB2ZjZt26hiMyyQIshol0yYlICSgCfoxw8TF+P0sC9PbkNh66W8hmZw==
X-Received: by 2002:adf:f149:: with SMTP id y9mr2151709wro.93.1599136095092;
 Thu, 03 Sep 2020 05:28:15 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id m3sm4197434wmb.26.2020.09.03.05.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/15] block/nvme: Avoid further processing if trace event
 not enabled
Date: Thu,  3 Sep 2020 14:27:50 +0200
Message-Id: <20200903122803.405265-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid further processing if TRACE_NVME_SUBMIT_COMMAND_RAW is
not enabled. This is an untested intend of performance optimization.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index a2b006be56d..4d4f728159f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -441,6 +441,9 @@ static void nvme_trace_command(const NvmeCmd *cmd)
 {
     int i;
 
+    if (!trace_event_get_state_backends(TRACE_NVME_SUBMIT_COMMAND_RAW)) {
+        return;
+    }
     for (i = 0; i < 8; ++i) {
         uint8_t *cmdp = (uint8_t *)cmd + i * 8;
         trace_nvme_submit_command_raw(cmdp[0], cmdp[1], cmdp[2], cmdp[3],
-- 
2.26.2


