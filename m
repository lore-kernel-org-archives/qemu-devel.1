Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65060C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32842076E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpTAc5Oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32842076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1fu-0004wy-4z
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1bj-0008ED-Dg
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1be-0001JR-Ae
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600855352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaJU4qce4d8kLY5vBvpzDPXaE03+xeWvm32Nm0kkdv0=;
 b=DpTAc5Oyg9czhwXv645EcE2ji3nrwz0Dq8mkmxvC0QYUWGGlAOzRYPWn2FX6J7SYIkUr/s
 z4l/jREtVGcteSUAr8PZpgHR5htXPhdQPQK61BxWJpxEpoBejhvYVAyAZdlv8QFLDV1tVr
 1cE6pKDogyUhNCF+OV4kQNKWkPBGSgQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-83peldihNlCRObXJPAK-AA-1; Wed, 23 Sep 2020 06:02:29 -0400
X-MC-Unique: 83peldihNlCRObXJPAK-AA-1
Received: by mail-wr1-f69.google.com with SMTP id 33so8594733wrk.12
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VaJU4qce4d8kLY5vBvpzDPXaE03+xeWvm32Nm0kkdv0=;
 b=ZfBPNERAEQCVd7L1HjggmNDjvJgkblBkNfjqEMxewzB9obnX+uE8sOiqNyHr3VbCsS
 G7oI5wQ/eUfHiLOL2Ow5x0iOhdYEuuFPcqCJoDNODtg6k6yEhMgf+6flSFrdmm9VZqDt
 anM+3DAHhceCTZ8RpfP49ezat968qoILDOfMKPlpWrD2E9s3AVXjpGH8JYI1NsokSmnZ
 N+zfYUgvybIm4+OU4RAmFCezyk46x8BUhmI2FSU6dI4yEOa8FMEFtEiJLfPgjkS5M0I5
 PAOATFc8v9Hz8+YevwFfMciQvXW2O+cCGJG7a29IZ9ODhdmE9+KKqIGX2yTeS34o6Zz2
 qDpQ==
X-Gm-Message-State: AOAM532BFhZau0ql2hW/86Kivnr59YZOeq26eaRItHdaMW78XRnEkUfX
 N+pmyGHJbEACqo4lwjwg0jUOE0G0I0hvoU7eKqffqwPO1ikdrj6YFVYAY+Oaj5wTUIor2g8UIkq
 QnVAyXMPLX6zqaII=
X-Received: by 2002:a5d:5307:: with SMTP id e7mr10083455wrv.215.1600855347525; 
 Wed, 23 Sep 2020 03:02:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyErCwKgS8P5jJGkmT3fVvMkXsnbfsZMC3MQP86hUlkn2JWmNiVPlc8a9KPYjiOzhfMoa6EIA==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr10083433wrv.215.1600855347379; 
 Wed, 23 Sep 2020 03:02:27 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t188sm8029162wmf.41.2020.09.23.03.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 03:02:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] qemu/bswap: Remove unused qemu_bswap_len()
Date: Wed, 23 Sep 2020 12:02:17 +0200
Message-Id: <20200923100220.674903-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923100220.674903-1-philmd@redhat.com>
References: <20200923100220.674903-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Last use of qemu_bswap_len() has been removed in commit
e5fd1eb05ec ("apb: add busA qdev property to PBM PCI bridge").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/bswap.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 1d3e4c24e41..8b01c38040c 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -169,12 +169,6 @@ CPU_CONVERT(le, 16, uint16_t)
 CPU_CONVERT(le, 32, uint32_t)
 CPU_CONVERT(le, 64, uint64_t)
 
-/* len must be one of 1, 2, 4 */
-static inline uint32_t qemu_bswap_len(uint32_t value, int len)
-{
-    return bswap32(value) >> (32 - 8 * len);
-}
-
 /*
  * Same as cpu_to_le{16,32}, except that gcc will figure the result is
  * a compile-time constant if you pass in a constant.  So this can be
-- 
2.26.2


