Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3FC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E9320732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8frM/X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E9320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6saP-0006Zt-Tz
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sZC-00058I-E7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sZB-0000W4-D8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sZB-0000V2-77
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6h6ExH4pUokuedAFNzn/YRJX66rcUuWYe4974bSpgXs=;
 b=I8frM/X+M2VfJ8BMzIuSSa5oieEDkkxSfxXb6YpAoUpZKT3L1NM1AaC8Gd6w3B8I0zbOk0
 9AAPsO3wEy7tcui9CJGU3X1mwEW50OdoY01BqoML2prDWwDZZVcjUiO08lwu3Jr0AcTgon
 r1dM+DWKXx9pKIEb4hVR3RcVgHedzY4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-ZNd-cSg8OQS-useryikeIw-1; Wed, 26 Feb 2020 04:01:14 -0500
X-MC-Unique: ZNd-cSg8OQS-useryikeIw-1
Received: by mail-qk1-f200.google.com with SMTP id e11so3222897qkl.8
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rBMXoO0qMiYn5SoVDdWygmuq7P3nv05NDp/olXioO30=;
 b=BYTIDU7wMGSzKQ3l96RdJUczxWNjtQjJQWGcddLzcIYnFmVIcR7njJRNnETDZIjH8x
 YseDzRPOrxdCfCtnYt9AigCzY6Ixw3hLVbDDBXvkk8qIhmGpWBo14tUgrsZ4Th12drf5
 4oqn/tmg9ovKOdgYy5m8Zu869ydEF4RXTwPhbKnVSRHKmqHqfHOTvpFkUWnYwzFWbL04
 Xzm0DsA3iMpCKiwpj513GgM6FVdCxYsagogKqVY5W4iG8z0ANMbpbb6dam5U5gaE2DP3
 Bu2H/Nvu70Bx9BZRUjcTFeV7If6qvBedVyzYw6tskpSCOK/3oI72FimdeuzPnHjD//XL
 u3qA==
X-Gm-Message-State: APjAAAWvGSvfjGhaAGj3lEUOWQ3ukuoTl2xCY8NhZ5PWDb00hpNVGqDa
 fI7wR8I88iXBfG2+1f6DtglftdvB7Q7EK45uVcSq4HPB0Q/45FbhwKLhTWEX0fJ7TkRdaY+/uzD
 kGZhqBAa9HJU7lHY=
X-Received: by 2002:ac8:691a:: with SMTP id e26mr3727597qtr.287.1582707673280; 
 Wed, 26 Feb 2020 01:01:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLv6u9iOChvwhI09UVEf0pBse/eMNWdurq48bAQvTeWt2UVfkOCYdfTT8ehJn/GR7mfhcOGw==
X-Received: by 2002:ac8:691a:: with SMTP id e26mr3727579qtr.287.1582707673054; 
 Wed, 26 Feb 2020 01:01:13 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 k7sm739284qtd.79.2020.02.26.01.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:01:11 -0800 (PST)
Date: Wed, 26 Feb 2020 04:01:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/30] bios-tables-test: fix up DIFF generation
Message-ID: <20200226090010.708934-3-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turns out it goes to stdout which is suppressed even with V=3D1.
Force DIFF output to stderr to make it visible.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index 9c3c4680e4..1aed0ee7df 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -463,13 +463,19 @@ static void test_acpi_asl(test_data *data)
                         "Actual [asl:%s, aml:%s], Expected [asl:%s, aml:%s=
].\n",
                         exp_sdt->aml, sdt->asl_file, sdt->aml_file,
                         exp_sdt->asl_file, exp_sdt->aml_file);
+                fflush(stderr);
                 if (getenv("V")) {
                     const char *diff_cmd =3D getenv("DIFF");
                     if (diff_cmd) {
-                        int ret G_GNUC_UNUSED;
                         char *diff =3D g_strdup_printf("%s %s %s", diff_cm=
d,
                             exp_sdt->asl_file, sdt->asl_file);
+                        int out =3D dup(STDOUT_FILENO);
+                        int ret G_GNUC_UNUSED;
+
+                        dup2(STDERR_FILENO, STDOUT_FILENO);
                         ret =3D system(diff) ;
+                        dup2(out, STDOUT_FILENO);
+                        close(out);
                         g_free(diff);
                     } else {
                         fprintf(stderr, "acpi-test: Warning. not showing "
--=20
MST


