Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C591C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE310206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE310206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbu6j-0002lr-Kt
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbu35-0000ux-Ad; Sun, 08 Nov 2020 18:24:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbu33-0000GW-Jh; Sun, 08 Nov 2020 18:24:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id h6so5262085pgk.4;
 Sun, 08 Nov 2020 15:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8sFMHG4A1NXc60aR+dQ5Qpal+/YO08FLzmS69fkJXIc=;
 b=VzeD3JWqfR4TAehKhCHvkwyn8feNGYEHcqCIQT/1M57Y/TJn271BNPw9ZtV6/Gtvc0
 5odW5sKYOElMkmkIQ8NTrHOmLY8U5xdgZStBVzFeL0nfkxdgGiSuxrbYz6yWFv2SR0fC
 FwD4U8NVRNNMz4u7WgCDY5uTkDhT/LorTJCaT6GxZ5v2DmsXw70cnKLBU6edH741/EgJ
 4b4FlUJaAoEvInRhonBaedNFx0rOxRPp9/s4m+Xw1xQDQzEQECIdAuPtjAOVCUgvnsWi
 Uy6KGKsTyrdExO3St5cKobD2iCoPMhIckuxyrztmUww++yE3d2cbASrksZojw893Xmt2
 BGDA==
X-Gm-Message-State: AOAM530VDmiRzz9AZ4BJw7dbwh8pOaNpyLBsg31CSiCKK9EDThJPEkPg
 iXjNZKjS0mzAh4hrg+RWlvDMoQTl6MQ=
X-Google-Smtp-Source: ABdhPJxdVCYJU4IEOzNMXxjr7Km/+3nMznVGvzPu+SeXt/gVuuGVar/D5SA1+wCbem3yiMEOQgcoLQ==
X-Received: by 2002:a17:90a:3d0f:: with SMTP id
 h15mr9881096pjc.234.1604877875779; 
 Sun, 08 Nov 2020 15:24:35 -0800 (PST)
Received: from localhost.localdomain ([73.93.154.215])
 by smtp.gmail.com with ESMTPSA id z3sm8275171pgl.73.2020.11.08.15.24.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:24:35 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/7] block: check availablity for preadv/pwritev on mac
Date: Sun,  8 Nov 2020 15:24:24 -0800
Message-Id: <20201108232425.1705-8-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108232425.1705-1-j@getutm.app>
References: <20201108232425.1705-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.195;
 envelope-from=osy86github@gmail.com; helo=mail-pg1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 18:24:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

macOS 11/iOS 14 added preadv/pwritev APIs. Due to weak linking, configure
will succeed with CONFIG_PREADV even when targeting a lower OS version. We
therefore need to check at run time if we can actually use these APIs.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 block/file-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index d83219df55..a9d69746a0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1394,12 +1394,24 @@ static bool preadv_present = true;
 static ssize_t
 qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t offset)
 {
+#ifdef CONFIG_DARWIN /* preadv introduced in macOS 11 */
+    if (!__builtin_available(macOS 11, iOS 14, watchOS 7, tvOS 14, *)) {
+        preadv_present = false;
+        return -ENOSYS;
+    } else
+#endif
     return preadv(fd, iov, nr_iov, offset);
 }
 
 static ssize_t
 qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
 {
+#ifdef CONFIG_DARWIN /* pwritev introduced in macOS 11 */
+    if (!__builtin_available(macOS 11, iOS 14, watchOS 7, tvOS 14, *)) {
+        preadv_present = false;
+        return -ENOSYS;
+    } else
+#endif
     return pwritev(fd, iov, nr_iov, offset);
 }
 
-- 
2.28.0


