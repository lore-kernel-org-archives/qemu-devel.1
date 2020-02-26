Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFD3C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670F620732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbEAthsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670F620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sc9-0000hK-Ge
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sZG-0005Gb-Pm
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sZF-0000cb-O6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sZF-0000bd-IO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjaS3P94P86cbnJb7FE2dxVGEARWOCqkV6s3/6h3kVY=;
 b=hbEAthsO7R7o+MCl6nHavKjcAk9KjGdE1LGuJMaUAFBxcxVAswaKlSsqsGl3EMYtrUOxkt
 X8wXjKxSVawGl09sqVjQjHOMTfuSrP8JbAeuICkOpoM+Alkle5XixTBcd2wLD/eEQWd6/T
 iYVh2tfuDGO6exUXRFhMDyWLyR6MF+I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-sILVEqbsP6-BHgEj0mI4iA-1; Wed, 26 Feb 2020 04:01:19 -0500
X-MC-Unique: sILVEqbsP6-BHgEj0mI4iA-1
Received: by mail-qk1-f198.google.com with SMTP id h6so3209283qkj.14
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J5D3o460P1rhFujFo85Es8Mk9QVxMsWvqSgvXhqC66U=;
 b=kKkythif6XFWYKc7BuMzBAHYpkYkUrC+ytT1/lI6dwavsij4Xu7YTNkLiV9D161Npu
 9jAs8i12qYRiCxD7GYNmTNEThB4DbHRkkGccw4m+i7hjP9NEwd35wUJFqJ/xOwUiseoI
 OuFkRNQuq552LdIbREGhMhsWRTeT5zMszXLL9r21srJ23c6G6qwLRiHiS1pwOaRLHfa5
 XgMY+sEg50FYo6YS4/Snh4jP+X6pcU1L+zZGzCnXq24bvz//OOry2vSayjW9vy52zINn
 oudvU0iAABTQoeFwSy2F/Z9CG0Bjk2vFt8DxkorfdlPaXG12djh1xNDC5N8bV5nQPFlD
 BrGQ==
X-Gm-Message-State: APjAAAX35y5nSgWFPWqW1GoxnLLefBIUc0EkGnJePGZhRVjRBahyxhpX
 sVImI/3LNFK0l0B1DYJo8nQws60oOh2WgwOMcLISUHTPqa+4MmQp9bewvuQeFZ5CKQkXGH25Ypl
 lWiaJ9234gJdW6YQ=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr3863941qtj.300.1582707678804; 
 Wed, 26 Feb 2020 01:01:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxNjpN5+kycGtet+9c9IGlnVeuxdLWsnklXI/N2mAvgcFXIM7k+8HZA4gMdDobnrwDiim/wg==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr3863913qtj.300.1582707678550; 
 Wed, 26 Feb 2020 01:01:18 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 p19sm747262qte.81.2020.02.26.01.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:01:17 -0800 (PST)
Date: Wed, 26 Feb 2020 04:01:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/30] bios-tables-test: default diff command
Message-ID: <20200226090010.708934-4-mst@redhat.com>
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

Most people probably just want diff -u. So let's use that
as the default.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index 1aed0ee7df..0a597bbacf 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -465,25 +465,18 @@ static void test_acpi_asl(test_data *data)
                         exp_sdt->asl_file, exp_sdt->aml_file);
                 fflush(stderr);
                 if (getenv("V")) {
-                    const char *diff_cmd =3D getenv("DIFF");
-                    if (diff_cmd) {
-                        char *diff =3D g_strdup_printf("%s %s %s", diff_cm=
d,
-                            exp_sdt->asl_file, sdt->asl_file);
-                        int out =3D dup(STDOUT_FILENO);
-                        int ret G_GNUC_UNUSED;
+                    const char *diff_env =3D getenv("DIFF");
+                    const char *diff_cmd =3D diff_env ? diff_env : "diff -=
u";
+                    char *diff =3D g_strdup_printf("%s %s %s", diff_cmd,
+                                                 exp_sdt->asl_file, sdt->a=
sl_file);
+                    int out =3D dup(STDOUT_FILENO);
+                    int ret G_GNUC_UNUSED;
=20
-                        dup2(STDERR_FILENO, STDOUT_FILENO);
-                        ret =3D system(diff) ;
-                        dup2(out, STDOUT_FILENO);
-                        close(out);
-                        g_free(diff);
-                    } else {
-                        fprintf(stderr, "acpi-test: Warning. not showing "
-                            "difference since no diff utility is specified=
. "
-                            "Set 'DIFF' environment variable to a preferre=
d "
-                            "diff utility and run 'make V=3D1 check' again=
 to "
-                            "see ASL difference.");
-                    }
+                    dup2(STDERR_FILENO, STDOUT_FILENO);
+                    ret =3D system(diff) ;
+                    dup2(out, STDOUT_FILENO);
+                    close(out);
+                    g_free(diff);
                 }
             }
         }
--=20
MST


