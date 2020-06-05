Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDCAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA08A207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbODm1hT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA08A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh6yO-0003Kf-VX
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xX-0001jD-5u
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32157
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xV-0004v6-GG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUsnVeQ0+evM91jOln2H7E8Gqf85iDyOxRzdS5TrXzA=;
 b=JbODm1hTgIPjYDjVEA4A1uO/mrhRDKAeHHPZ5aqmqE9svaI2gnFxjvA21axhv/dRf7ReeS
 XMU1Z0FJAgJ6TdTq/ZeGb7Cs2j6sKpxG4kmMQwWnG4mNNBjdb5ouxOl0Meoox57t+xm5+z
 l3cTZwqNBNEMfU20/RheRXqBVsHeKfE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-ClkaJsAoMrCZ_UfBtwGmwg-1; Fri, 05 Jun 2020 03:40:07 -0400
X-MC-Unique: ClkaJsAoMrCZ_UfBtwGmwg-1
Received: by mail-wr1-f72.google.com with SMTP id i6so1819850wrr.23
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IUsnVeQ0+evM91jOln2H7E8Gqf85iDyOxRzdS5TrXzA=;
 b=AWZmP0922k5zdxlSLdSkKEjgK7OCeHNNi5D4p0zgfd+QqFt5vs3I233KR3cX9dGPGd
 4yuFjyR8gb2XvNl6qHKsItjH7T/fkyajK4ctxayPLacUw2AnwgwWnEG7cXuDGVdsZ6Hc
 ZPI89fb/9ZgG24xM+ADIX8XLrSDC9zEcnxJQG4phNis7wdLQMtoG0qH9dhcbolQJW5c4
 L2yMaMDscsPrPVTEWNG026poo7rgaVJY7/lZoY0Kxg8etORZwTFhUgTwvzMR9Tme4hKT
 4BjVVSBxD9FiRcI7WWivxqEOPNDl10m0TQCEPGNpfazjcq5tEzYU1fXazLbgeMAJX5l4
 37gQ==
X-Gm-Message-State: AOAM5331kJBSO3dcus2RBeb/sCuixG/Z2/18xtvAbGPxh/vHS2vBeWuW
 mBubmSGwHdGuEeoYHgA9dluOuiSXYRF4aYlNYf7Ibzu71i1KUA+sezY3CZ3y/eQ2Xxgx6olvc8y
 nNu0/WQOE0IF7JAQ=
X-Received: by 2002:a1c:49:: with SMTP id 70mr1264458wma.184.1591342806008;
 Fri, 05 Jun 2020 00:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywjsjHCArYCXcd7C+BsUh6EYyl4kGluBrgjSgK/LTnFovF2p3rba3FkAYKfrREBm2wHutZkg==
X-Received: by 2002:a1c:49:: with SMTP id 70mr1264445wma.184.1591342805850;
 Fri, 05 Jun 2020 00:40:05 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id i74sm11214750wri.49.2020.06.05.00.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/11] MAINTAINERS: Add an 'overall' entry for accelerators
Date: Fri,  5 Jun 2020 09:39:44 +0200
Message-Id: <20200605073953.19268-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605073953.19268-1-philmd@redhat.com>
References: <20200605073953.19268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
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
index 948790b433..f725c12161 100644
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


