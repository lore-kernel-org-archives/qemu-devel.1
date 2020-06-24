Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CA3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F392420738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPyfhcGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F392420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEUv-0001mS-V9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETa-0008Fz-AQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETY-0001Gx-4d
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593039998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unmpPZT+vnpLsu4lIIaVV67y5xez7uhexAq7iIY4vXw=;
 b=HPyfhcGybRlHNBhyZIiHiIfSltFGmNezUlfQAwqZYY6wJutmXe0UARZMohIX9UXCz6/05r
 fvbTByQ1atJNvHdwbkE1kJA5ciSdYr+TJzrJ7yKulLaYsycyzbYElRE4SunBKef9/u+8bA
 N+KUaxxNAq9FmSmhNiI5JAwlMTW8G+Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-7CInZu-9OlScFJTzELXy9w-1; Wed, 24 Jun 2020 19:06:36 -0400
X-MC-Unique: 7CInZu-9OlScFJTzELXy9w-1
Received: by mail-wm1-f70.google.com with SMTP id a7so4655299wmf.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=unmpPZT+vnpLsu4lIIaVV67y5xez7uhexAq7iIY4vXw=;
 b=FD2NJwh/PSug/16H8U4aX1t2ySOy2Lptn5ZnAhsyEyxcjz0cixHJTQGI8lCRFl0k2+
 A7Zi0Y9Bz/3BV1FQ6XynrF3SQj37hgl1AYq/4DmTvyN31S2vljX6YmAu9uxEfn0SQuwb
 ybebHZTXHDqRcwHV+OJsF1ASLz2Cjeain1x3qsBKNl8b7DpjAFpkcX+EgsqcyYNR5SXM
 G5fIbMrTUY77buG4TP3Y7J61xNHIWcQDFE/SN/2E7JKux4YJTJ1AlK3KFkxGK6CzjLQU
 qMXV7gbiwC/z5DNSeB8/BShT2tsQtmd72ZzSrmI2apX6ByUWZyfSRssUrX7rkcAHZYkk
 vLCA==
X-Gm-Message-State: AOAM530U2FpJabFC7Al6MmBqvhDrUizSjWgkdSDBpVG5tEFoIlXfxx9E
 jHwlIhH64tkNHeufvzAz7DYBp4fAgG//4nhSQpvs3XWaMWdZWuBvvL/NCe9Fj6BX10Un2sPxt8K
 IrCgPBjmshfum2Ng=
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr36125726wrs.229.1593039995232; 
 Wed, 24 Jun 2020 16:06:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKCZlW+0JXE9TiCemf/+lstqFrAJ86Pr8zhKuKa52H9sHan2LZflf1+KahV2APOTnzIkhwTw==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr36125708wrs.229.1593039995044; 
 Wed, 24 Jun 2020 16:06:35 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 u23sm15316490wru.94.2020.06.24.16.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:34 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] acpi: bios-tables-test: show more context on asl diffs
Message-ID: <20200624230609.703104-3-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Makes it easier to create good commit messages from the logs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200619091905.21676-3-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index b482f76c03..c315156858 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -469,7 +469,7 @@ static void test_acpi_asl(test_data *data)
                 fflush(stderr);
                 if (getenv("V")) {
                     const char *diff_env = getenv("DIFF");
-                    const char *diff_cmd = diff_env ? diff_env : "diff -u";
+                    const char *diff_cmd = diff_env ? diff_env : "diff -U 16";
                     char *diff = g_strdup_printf("%s %s %s", diff_cmd,
                                                  exp_sdt->asl_file, sdt->asl_file);
                     int out = dup(STDOUT_FILENO);
-- 
MST


