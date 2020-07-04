Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6EBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C0420CC7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmCLO6jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C0420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrplz-00041P-Af
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpkc-0002C1-2u
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpkZ-0003vt-8z
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZH4WbM9lDKriwvJR5iWPBD2dYg3ljxsK8g2n7Z4PXs=;
 b=cmCLO6jAgxk6KRYb757A/FQwZv1ZGn09KfwehwZ7+TUd/B05HXMXbgVia+8uXr0Nhow9iF
 iNQMSf1j6CE5r0WiUZ+KdP8J4+zvTZ2QxnLK5khQODfIFjGj6nC/FZscpE3KstSl6YTOpj
 mDUSVrus0AabahKKCnGBp+RWER3SqX0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-LAQc1gRkMvqWf5U82UhfZw-1; Sat, 04 Jul 2020 17:31:05 -0400
X-MC-Unique: LAQc1gRkMvqWf5U82UhfZw-1
Received: by mail-wm1-f69.google.com with SMTP id c124so8405260wme.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HZH4WbM9lDKriwvJR5iWPBD2dYg3ljxsK8g2n7Z4PXs=;
 b=JOjlpxQIb7GbWpHTYvnYQ7cQDLI5ieyNiY6MJkA7R2tXcmPG25l6zYdqiFkMVejCxw
 Fw5vfB81vQSOIi5EmepvJ0bYtOAWSK3ZuA8TX72bT7FSTf7l9AyI5w66Hv8WYR/V9K8O
 yUnCzkUqr5gAujxU5UMBBNklxkXxZ2WuOATRzxjowrN9eRjH/ewKGzzMzeCvylGQBGjX
 UtiV1/1h9FXeJ+TXfx093Zlam+IoGBA03PzXlDD4c0LiK4jxCDKD5Gh3RqIVNv+DNcy5
 plz4UCQgjAdPxLy7plz2/e3iml2u+Kr9mVkGuuOCv2GZ6s6byteXRmmDEhibp2OqKbig
 nQVw==
X-Gm-Message-State: AOAM531gwVH2U7JWjqGvkjSZ2ewP3fdqMSjgaOvPaC8xc8KrD9t9MQf1
 xRDw3lFciIgm8ubgEarhpI2Ly7TqjfwQV8nBxkNGrRgtL6qZ01s5gDJeVXFm1IUKkoQPJK4+zK7
 6/2wICCkhys+oXdQ=
X-Received: by 2002:a1c:48:: with SMTP id 69mr44147188wma.32.1593898263563;
 Sat, 04 Jul 2020 14:31:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHvgHTGkWLDjdUq9WKVr7dTdGZagvjrh0bQBolk5vUhPp/bLvBv74WEwQZ1LkINYyrdO4KqA==
X-Received: by 2002:a1c:48:: with SMTP id 69mr44147177wma.32.1593898263416;
 Sat, 04 Jul 2020 14:31:03 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u15sm19258965wrm.64.2020.07.04.14.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 02/16] block/nvme: Avoid further processing if trace event
 not enabled
Date: Sat,  4 Jul 2020 23:30:37 +0200
Message-Id: <20200704213051.19749-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704213051.19749-1-philmd@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:04
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
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
index 2f5e3c2adf..8c30a5fee2 100644
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
2.21.3


