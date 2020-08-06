Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE96C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA31223121
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dui3pkyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA31223121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gQP-0003sc-U7
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3gPq-0003M4-8A
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:58:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3gPo-0005aP-OY
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596722319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cepDETQUo+jJLvqnzAfamax3Xlpb/zYuUECWLtj0je8=;
 b=dui3pkynO5BJ3Abp+TMxcUa3w+Xj72gyFbOz85Bu0tagcatdo09AViFpPHbNVQcpXf+28r
 DPnKdgZeRIn4MRFALCGLldu+05+m1wKVQbRG8eaHYHp7rq/m75//2KEQEaHJoGaPh1akn8
 lN3e8zai5NnIDDi4CcF1rXmmbuJRhCM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-ArqDZBVePcSSLkAPuhRe5w-1; Thu, 06 Aug 2020 09:58:38 -0400
X-MC-Unique: ArqDZBVePcSSLkAPuhRe5w-1
Received: by mail-wr1-f71.google.com with SMTP id f14so14756072wrm.22
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 06:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cepDETQUo+jJLvqnzAfamax3Xlpb/zYuUECWLtj0je8=;
 b=Gl2Hj4vVZHpCffTLIw2cgakvoXrrsQcaIZsic+JmCNriGk18XeZHToySSZNDd66e2C
 BlVq0irKkPoBpYXO1batuMVwDx5aHSXfEQCgBkNO+zlqSvDpjNLIzI93rAx2SmjvXewM
 y3WdiOiZCYebYXyV0XI1Y97uFW3l+ZGr6ViEdQPdqpcLXUf7xZL0wjItYYliMEW6UZlM
 H7UWssNIfUNzFAiS0UsxI8XK5Vx6XIHLg3eCaSl0CtwKtYPaD6YXCMLj96KNFkke77QH
 Y0o/BrPAHeVi+2tnSEXPhMNfrjK+WU1Pi+rjYNSD7WrXWefg/IWbA9xypaz0Qk3F+o5T
 sRqw==
X-Gm-Message-State: AOAM532WPeNDaRxdQYIyUthDjAwF5q3I9GVLzGwo7icP3R97TBJC7D5g
 WAhX3Fu3fAfkjzh7RMi1itFlTaKr++32AjKlNFZKGRY5NyKCd7FRB28SefPqEamxYK4jNzFOOzu
 Oxcf+6FIuW9bdl9k=
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr8011586wme.27.1596722315219; 
 Thu, 06 Aug 2020 06:58:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9oRQGKeLAuOtaRv/DDBw/3hZKYQxZX/HqoqmzccjeYp8xXjwqcYCpS6RO+sdjl6VDEQqfDA==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr8011568wme.27.1596722314984; 
 Thu, 06 Aug 2020 06:58:34 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id x2sm7093978wrg.73.2020.08.06.06.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:58:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] Revert "mailmap: Update philmd email address"
Date: Thu,  6 Aug 2020 15:58:32 +0200
Message-Id: <20200806135832.2319-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This mailmap entry does not work as I expected. I am receiving
emails related to my hobbyist contributions in my work mailbox
and I get distracted :) Remove the entry to keep things separated.

This reverts commit 289371239153b24cb7bd96b6948c6b40b4627a9b.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .mailmap | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 81c2ce0937..2d97a14af3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -54,7 +54,6 @@ Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
-Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
-- 
2.21.3


