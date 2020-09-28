Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AB4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5BA20E65
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8B7to1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5BA20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtZ8-0000OC-2w
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4b-0000pn-Hg
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4Z-0002op-O6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01GR7uo5lwZc+yIqp2XAePCo6kJWui/s9AmyV2I4Bcc=;
 b=H8B7to1pV23otGZrYFCKFydib2+dmHxLnAGRRIwbxAAPD7TmB8oD5zE2teuOnf4dEf6F9i
 und8CDRRKGr8h4HfjxkD2EUgrVIDTfUZQmRDrRm+smEmZZnBzWDjKnYDWIiFFm30ZTj/6a
 6hPBTpc+17gwxUv5ToojqXgq6fd3iDw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-ffp61MN1PQSjuAUMF991Tw-1; Mon, 28 Sep 2020 09:20:05 -0400
X-MC-Unique: ffp61MN1PQSjuAUMF991Tw-1
Received: by mail-wr1-f72.google.com with SMTP id 33so401061wrk.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=01GR7uo5lwZc+yIqp2XAePCo6kJWui/s9AmyV2I4Bcc=;
 b=GGu6LLVEzyxOIXeuIsoatk9fH0MdxM9E7JR53C6GztBhGVXJ+LO8LGBXzv1s609f0w
 RACVDfuCUVakF2nUXv2pkjc/mATsBJuXcHCv0qWmC/T5tanUAnceP+088invt4cjmj5Y
 RItRtHqYpeeJEvLpQ5qQ1IvNoKuHsQXfYWJS4LeGEBB9TJdcSzDxSX4sbEoqNuDBWedO
 NlrVYGYn8e3SOj4X1BR5tpLkMbh6E5UhQ2FeaYA84avyCzp9cuw4VPXlCyocmthQE3qa
 nnLd/sH3d2SYvP88vv4ZwvmtwpYb6w0fkRdPqy5u8ZQqcCSnZuP3a1y2J9g+jOpr/Kf8
 8sxA==
X-Gm-Message-State: AOAM532RENMNue7NMts8i0s13bx+6YORPktGFCNqqJS++LLRvZYZWRFf
 FaiVLpPN4G80KgkRqitVA3c10S0WzAOYgjCO8F3BISJGZsoUzRCLR+eI2A4yAGCoZhNL3jMM+L3
 jOg0ctpFncxAP/xc=
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr1816014wrc.71.1601299203798; 
 Mon, 28 Sep 2020 06:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRb/MptPfIb8V1ZZQJzsk6PCTgiXyYbDVQOS/vQAmwn1XFKrLmnjBlEJjT0jPXMMKaVlCz+Q==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr1815982wrc.71.1601299203649; 
 Mon, 28 Sep 2020 06:20:03 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id f12sm1132893wmf.26.2020.09.28.06.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 06:20:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] qemu/bswap: Use compiler __builtin_bswap() on Haiku
Date: Mon, 28 Sep 2020 15:19:31 +0200
Message-Id: <20200928131934.739451-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Carlier <devnexen@gmail.com>, Carlo Arenas <carenas@gmail.com>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit efc6c070aca ("configure: Add a test for the minimum
compiler version") the minimum compiler version required for GCC
is 4.8, which supports __builtin_bswap().
Remove the Haiku specific ifdef'ry.

This reverts commit 652a46ebba970017c7a23767dcc983265cdb8eb7
("bswap.h: Include <endian.h> on Haiku for bswap operations").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: David Carlier <devnexen@gmail.com>
Cc: Carlo Arenas <carenas@gmail.com>
---
 include/qemu/bswap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 55916670d39..719d620bfe6 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,8 +8,6 @@
 # include <machine/bswap.h>
 #elif defined(__FreeBSD__)
 # include <sys/endian.h>
-#elif defined(__HAIKU__)
-# include <endian.h>
 #else
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
-- 
2.26.2


