Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC263C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB1E2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EER/8xPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB1E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAhv-00009K-K4
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgZ-0006L6-6t
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgY-0002RH-Aa
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590165493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuJZZIJUjKA4i/zVtfzhkV/IDLDSLy/ar8aF3AVhXnk=;
 b=EER/8xPEXLhMh6b+RdqkpnshZYJH3aN8n1nkyl3i2rGMRFXOxJ4Lz+DPNwmb/Qawd2A/3N
 EhEc/nULdT9tt5MN1IYAKkCfAqpPyDg0cggh2iJL2VD+Gt4Treb6leUAiGGLtzZYHEWl/Y
 pndiKSsUPOk6I7QBdX2eouNJUlC/xk8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-99JmMUzuP3uFo0dxPLB16g-1; Fri, 22 May 2020 12:38:11 -0400
X-MC-Unique: 99JmMUzuP3uFo0dxPLB16g-1
Received: by mail-wr1-f71.google.com with SMTP id l12so4610392wrw.9
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xuJZZIJUjKA4i/zVtfzhkV/IDLDSLy/ar8aF3AVhXnk=;
 b=iL7Y1uZx9yVUE1KlsNkiQqEmRf2EW9JZI3UQ5o6ngbHaOWn1xr8/ErFQRhe2+4NBJp
 MxoNQnip/9s1JznIADzh0t1fy6bqrJYmr88/R/6iYwOEPbiDSM79no5Sp/sFJvxjha2H
 XmLwRJb6v7jR9glW6dqSoykEtXNhhfwjU1KYcYJ7eIzm0/SGjtor6WcPorKMRq0JD/SL
 Vw785BO9NCIFddbRBtMIBekj+kPhOoNE3SDkovCUanrWJlZIqXt0OUy2XISZgBe2b9M9
 0pS3uhX6WdLb4fmk3kEzSQNohKDF0Ll1bUve9rn6VySn5rPqc1iVs+928mSSKoWYIn1f
 7kuA==
X-Gm-Message-State: AOAM532nSc+FZLXTUEQ1Zf7lnmrS01tmpJko+U0cLE0fzxCbKe/mWZo9
 etVhGR6VyAgl3/BK5kE4urGGraKwyD+oQAY2uMDeb9cBJRafkLMJpOIZfdqe8EG5DriRwlXVj4s
 mPr1ZeQRDzaC+1rA=
X-Received: by 2002:adf:e84e:: with SMTP id d14mr3909169wrn.31.1590165490526; 
 Fri, 22 May 2020 09:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV0Fpvtw1W12OUzt2ujJXLn983QOFj6SGi+vIb+xZ6epS5uqNVP/ev3zO5zA4wpyos3R6FWQ==
X-Received: by 2002:adf:e84e:: with SMTP id d14mr3909158wrn.31.1590165490324; 
 Fri, 22 May 2020 09:38:10 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v205sm9891755wmg.11.2020.05.22.09.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:38:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/11] MAINTAINERS: Add an 'overall' entry for accelerators
Date: Fri, 22 May 2020 18:37:50 +0200
Message-Id: <20200522163759.11480-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522163759.11480-1-philmd@redhat.com>
References: <20200522163759.11480-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:12:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>

v2: Cover accel/accel.c & accel/Makefile.objs (thuth)
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00c1c1ed8b..f7ee0c77f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -415,6 +415,17 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
 
+Guest CPU Cores (other accelerators)
+------------------------------------
+Overall
+M: Richard Henderson <rth@twiddle.net>
+R: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: include/sysemu/accel.h
+F: accel/accel.c
+F: accel/Makefile.objs
+F: accel/stubs/Makefile.objs
+
 X86 HVF CPUs
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 S: Maintained
-- 
2.21.3


