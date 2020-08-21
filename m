Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CECC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACF5204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZe7UayP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACF5204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9D8Y-00085Z-IC
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7C-0006PL-UJ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7B-0002fK-8B
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=969biaX/G7f1D/6G5QoxlHmmKW8KQsbMUTT5iH7LPeo=;
 b=MZe7UayP0qNjMGiEb7tb5/oppge9VcgM/UO5zPI0zaL8w5AZ1zMo8/hhIrsDHXkBegyL68
 SLAjj/eEIriMQ607usr1vfyVtYBmJY2/vHZ0BXizRcgjg8mpsaV5fWhg24xtPuQBUFjfV0
 9343mAlUsCzRuJxIGy5ktE9clYr+oWE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-0MFAZjN0NMSZqWvBztomWA-1; Fri, 21 Aug 2020 15:54:14 -0400
X-MC-Unique: 0MFAZjN0NMSZqWvBztomWA-1
Received: by mail-wm1-f72.google.com with SMTP id k204so1374775wmb.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=969biaX/G7f1D/6G5QoxlHmmKW8KQsbMUTT5iH7LPeo=;
 b=UK0AFU0vjSg5gtBaZ+V6cK6ZywkdPCzhs5pDoOxVQ/qpYGednWOokaS0g+d7gMZK9r
 rg+7ZzrEfSgmoTTfwx/FyXps5h9PnJgZGmzH5nrEo44itfM+J8fBBUmq7F8uPeeuFFQG
 fgW1w411b80vrbm3Gnmj9QoQqOwF364/OmIIDlVvpBlu4Imd9vxLMevkOMtF9dMm9Gkk
 bO0yAH1EHIwowoOiUFQgSwQftoBumd0sjsCrpuez7Gl5DjhW6QPEeE3nu1sHDwdXzqPl
 Ne6+5YffeEaeN9kTPiIOGgYYOclspf47UuuD8l6gVTgdSkfrvN3Tc1m8pm5aZ3nl6t+o
 0O2Q==
X-Gm-Message-State: AOAM532Nij0ZDr6zkZFzAk+qldOpoadhhwfSgcsHk0WuyfGGlN8anKOf
 BK/C9qW3xmV5BocVDUs2vc0zVyDjK1wRjUMEPpO/khGVVWNFx5eVLhJjpY9yykuyIsqJm7paHlm
 WsvA0RNe3KlDvpKM=
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr2400675wrt.73.1598039653155;
 Fri, 21 Aug 2020 12:54:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZMtp1rDhksvpZhU0EoNPybYyltpwgKpxYxPw5/0AcKlG4wRhNKIQcnM0oRFyzHHd/p2Ck1w==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr2400660wrt.73.1598039653005;
 Fri, 21 Aug 2020 12:54:13 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id x2sm6767121wrg.73.2020.08.21.12.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/15] block/nvme: Avoid further processing if trace event
 not enabled
Date: Fri, 21 Aug 2020 21:53:46 +0200
Message-Id: <20200821195359.1285345-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
References: <20200821195359.1285345-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
index 2f5e3c2adfa..8c30a5fee28 100644
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


