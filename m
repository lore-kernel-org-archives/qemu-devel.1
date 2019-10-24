Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84807CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AD1205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtYaImCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AD1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeU4-0000JV-Lb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiy-0007rU-Bn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiw-0007kk-Qz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdiw-0007kL-Ks
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id w9so1562808wmm.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VxP5UE5BCXFLhC5XcjHpWnJKP5zOKoEUmAkBP6uQR5E=;
 b=FtYaImCerhgmONNB4V1RofJlku4Z6xB5kwbcx65CPuMctA4nq2N4Q68nq841Fa9/7W
 XcCwwnyB7GxUU5vyCUag6ZFOM9URkSKZR/t1vfR15nGwOBA1IAe/ip/oAvi/OUGJha8w
 i+wF9dIcQIh+JtNUH9F64XtGWRO+iDyKlXsGpnEXSvySC9FUuG03u0vj/eYxHr5+j9JE
 ffuP5YW0JYBOQXuk4hrgtJkx0oFvlez7LsBIUru/Ot0LL0wO81RGIZ1R5LkZ3aWAzWTC
 7PGFApGc8WQUaedROHcOBXwDM9cM/u+WZiUQFXz5yrVZjAal6QKUecAvma9iL40H55sJ
 ftCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=VxP5UE5BCXFLhC5XcjHpWnJKP5zOKoEUmAkBP6uQR5E=;
 b=Ic7ykaF7WrqdV/162iPGipIO+h64+dobfhe6TNC5//+lJqX5hyAxaz20Xtr5M+DlKW
 nkIZpu3RULldkZu72kCtpbK9C+g9ZDHCAjRE0l4GWSOIZEA6NUHUHSsOGuidreAEBL5a
 EM/cUdIHc7W2roGjRMI/tbZ6sCFCl0LNnxGRqR8ml5AcTzFWwzsfZBgLhqsYgyxxJKp4
 N6xEn/Cbvq+FNeayzCbUvDKMd+N5/LSba1ZftekQkB2deUb9dUkmrWSYSEhcB3bNUvMr
 V4cO3Ww6xESyV5cpekvrBYFCUp3/mBrz1IR08Vv4RK22FcQGDdbFn/3V3M9l/AQ2rdLM
 CXIA==
X-Gm-Message-State: APjAAAUxd6Unyn73flpf3HQ/R78wv2g/EvwrfxXxqA/FkuWBxg/fI2vY
 XvKp+m0zFYJlCKTd2hL1FG6jtLSj
X-Google-Smtp-Source: APXvYqxi0x4/74E8dAI2vTtTxCOwIUaRHZSKgRiVOwyU7WO2QCZkxGPsi0a5UgCJ1eIEf/O7N4VOzA==
X-Received: by 2002:a1c:e91a:: with SMTP id q26mr451061wmc.32.1571925861440;
 Thu, 24 Oct 2019 07:04:21 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/39] checkpatch: suggest qemu_real_host_page_size instead of
 getpagesize() or sysconf(_SC_PAGESIZE)
Date: Thu, 24 Oct 2019 16:03:38 +0200
Message-Id: <1571925835-31930-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
CC: Richard Henderson <richard.henderson@linaro.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20191017004633.13229-1-richardw.yang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index aa9a354..ab68a16 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2915,6 +2915,12 @@ sub process {
 		if ($line =~ /\bbzero\(/) {
 			ERROR("use memset() instead of bzero()\n" . $herecurr);
 		}
+		if ($line =~ /\bgetpagesize\(\)/) {
+			ERROR("use qemu_real_host_page_size instead of getpagesize()\n" . $herecurr);
+		}
+		if ($line =~ /\bsysconf\(_SC_PAGESIZE\)/) {
+			ERROR("use qemu_real_host_page_size instead of sysconf(_SC_PAGESIZE)\n" . $herecurr);
+		}
 		my $non_exit_glib_asserts = qr{g_assert_cmpstr|
 						g_assert_cmpint|
 						g_assert_cmpuint|
-- 
1.8.3.1



