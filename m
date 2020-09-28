Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06348C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9437420759
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3EVSfB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9437420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtGf-0006QL-Ky
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4J-0000eU-N4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4E-0002n4-DY
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:19:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hl9slfH0zxQ134l7Pfr//jBOIgk547l+qxt5CXwb7Qs=;
 b=O3EVSfB84UVLxgT23LlsnN+DiqrhTpHgI7gzknF9HICuW7WnwghitD5OyGMc2Jh2bJy+S+
 T3vlxNedLxznctnFO2Up+sEE61awueC3SQYADo0cEbZnOfzQHHmvY/7aLlQSMhAQ3CJYwT
 +G9b4FPgD7HeUq8htvZKG1Y0S+3ihvg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-OZvyuggeMXG0QGFHLIRHLA-1; Mon, 28 Sep 2020 09:19:44 -0400
X-MC-Unique: OZvyuggeMXG0QGFHLIRHLA-1
Received: by mail-wm1-f69.google.com with SMTP id u5so379146wme.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hl9slfH0zxQ134l7Pfr//jBOIgk547l+qxt5CXwb7Qs=;
 b=qG47DXk6NYEQRBAyX4NW9UsbKUZlrhX2mAS9SqHZc7VaF8SfXSZkkXw25KLzRxejwo
 b7g19TCtHeP6H/qbmD4AGkBsK/1mDaKE27me29/eiA+799B3tM1lMW4Unz0iQvUn2hoe
 EFvOv3gVkT52YUU6QHulsSlkrarCrTPGbiZNb/0SbBlm62WlxYjKh3pGbiNhr7DK+dyn
 CzkN6lTmUOPMosNAxJ0HKWPhsNdhwhqfjwmyQYJYMjLdioTzAoOAZ2YK2CjJYZi+Ymnq
 Q/MzAqxhLlo+dQQU3Zdp2ch9Syli5l8PvptRuIPxuzTGfDDgDzcndQ93EI9xD7Me7Jbu
 nEgA==
X-Gm-Message-State: AOAM530WYL1U0KSNFbydJMdEuAd8IorbtEjg+3FZAeXU3ElaUIXokq/v
 7Dl7osKH65piv1KZtuKHPOkPOxempCV0+JpOFJV1VTzQRDc7O2HOGSQa3YDagsUZqTf4c6Snthg
 OJVT2dxgytPyckQo=
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr1633390wmb.77.1601299182704; 
 Mon, 28 Sep 2020 06:19:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYoCu1W8ZOZC50kwm5Zi6PF3g8Wmc0+2rWOCbNTMdTYqqf1+PiCnHb4SkFJYiiU4evQRThQg==
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr1633363wmb.77.1601299182508; 
 Mon, 28 Sep 2020 06:19:42 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id b64sm1344104wmh.13.2020.09.28.06.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 06:19:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] qemu/bswap: Remove unused qemu_bswap_len()
Date: Mon, 28 Sep 2020 15:19:27 +0200
Message-Id: <20200928131934.739451-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928131934.739451-1-philmd@redhat.com>
References: <20200928131934.739451-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Last use of qemu_bswap_len() has been removed in commit
e5fd1eb05ec ("apb: add busA qdev property to PBM PCI bridge").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


