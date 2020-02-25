Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B0AC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD1121744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIc9xlDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD1121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bu4-0007je-NV
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bt6-0006Ao-LI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bt5-0000se-Nj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bt5-0000sT-Jf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6h6ExH4pUokuedAFNzn/YRJX66rcUuWYe4974bSpgXs=;
 b=KIc9xlDgeI7USKaiIHe9SKD5feDRcj1x5OKKysgGuSxJLNvV+vICQyCcSw21wNYFs+fEpn
 PPAnqEsEGKJB8vu9iQCUa1kB6fmdEje9+seA4mbgGGQ+dwcUsV88PK6h6yfZ+nnBysQyP2
 3IeTYU5I0LBaxGMU77cwE1xNhBqoReE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-QERZu72mPluvgNe4CjWP5A-1; Tue, 25 Feb 2020 10:12:40 -0500
X-MC-Unique: QERZu72mPluvgNe4CjWP5A-1
Received: by mail-qt1-f199.google.com with SMTP id g26so15138544qts.16
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rBMXoO0qMiYn5SoVDdWygmuq7P3nv05NDp/olXioO30=;
 b=k4Jy3Xj4gYJAfwGZmVGulW9iaOVvYGZfHsdIbukKf6QbOxQcAzS2c3BgyHfBUq1tm7
 hSe8weIpU129nJwDHwzMa8x+lpX+Ez2BOpP3o+MIGhCVPQPW72FfJvGnc1yS1dYJUVQd
 o5hdGlSF8fzycZjjGNM0FZTsdoQBcRgKh0hWyFdGO5GNYoOGt1WhYGqYPItcjLNpFfFi
 kmdxceoT3o3gcT3WOawu7IBno+b+FQVb1OEoRoPFC1yg0RhlUi3V1OeB3PLP7uSg1IGu
 dqHTfrAYBmT82We6+Hjvy/bYX2YCdTnb/ph1KNkR9hZnOVgYvfTSFg8CmhvLxRqQDNGz
 82IQ==
X-Gm-Message-State: APjAAAUpuKTfaWrgUkRRP9f/6jcgbJbnzO777BHWFtKRPwaQ9uX4wegt
 55jE7wJRpYsEOP85bgA7WA32NN0ndyY4GVLUHTSZ/9VKIZtZxztylc8dQ6B667y+oEhR2CbcOFq
 GEHvUs5xRjiwMBZI=
X-Received: by 2002:a37:2710:: with SMTP id n16mr56960409qkn.235.1582643559403; 
 Tue, 25 Feb 2020 07:12:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAfJrENgTaZ0An4gRYa8zt04aRCHiWZvLec6a7I2C14uzK9Yd1FR22zC2GsQMl/PBXEGxd4g==
X-Received: by 2002:a37:2710:: with SMTP id n16mr56960337qkn.235.1582643558729; 
 Tue, 25 Feb 2020 07:12:38 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 w18sm5225606qki.40.2020.02.25.07.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:12:38 -0800 (PST)
Date: Tue, 25 Feb 2020 10:12:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/32] bios-tables-test: fix up DIFF generation
Message-ID: <20200225151210.647797-3-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
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


