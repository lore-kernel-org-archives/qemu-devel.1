Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD56C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AAF218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9DImOZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AAF218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6buB-00085r-Iu
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bt9-0006GE-Ij
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bt8-0000tl-KP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60904
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bt8-0000tV-GG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjaS3P94P86cbnJb7FE2dxVGEARWOCqkV6s3/6h3kVY=;
 b=P9DImOZOwKgfpFjMD6v+bYazwgvoJSPQ3C2dvSQhV7NdIAQDCb1486DcUGyRZbvzcTQ7VQ
 2zLBAKVpZELy+q1dzXvVanH0LnmDLUNffmubU2PHpEdNBokSr6b3oldK+EIxxdqvFQb15J
 peCdjHCniqmzTm+nWN7VEFuh1R4xYOo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-vfwCJJz_N7OkD0vquyFCDA-1; Tue, 25 Feb 2020 10:12:44 -0500
X-MC-Unique: vfwCJJz_N7OkD0vquyFCDA-1
Received: by mail-qk1-f198.google.com with SMTP id n130so10214177qke.19
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J5D3o460P1rhFujFo85Es8Mk9QVxMsWvqSgvXhqC66U=;
 b=NmOHD6TQ7fkjY/1qkIuFY6VMn0MAu+KaJhwrSorHnbC5CKnaCO03nKn58N9FnhWSzD
 SjoFc3tRQOAw7my/CJkFrK32DVJrhGUXfU3CmGT2cVhF+KUnWHcINLJT5DyQ0t2Ddt1l
 LkuUITs/aXWhtUeOfsp8j+SFZwz2+N0Vt4Tq5Q0kcZgiwilGuBgxTDTENST/4lL7O8dz
 49USMCBHTDLNpQ2Y15Hq14WxmfLaoQ9crj3Qsyqp+DO40MVTfyID4RRXoij8FX1ajl1s
 bxXVHo65YJh8nVS2bFi9I63QJfbzFS0agO1XRMOMLRKG5Jr4CEY6V9Y+JVc2kxG1Lqx7
 0rrg==
X-Gm-Message-State: APjAAAXZaqjRNDI/hn3XY1OSHa4afox6junBkEWEK13JfZsm742EYcsx
 BB8y/hN9lIW5d9t+vThFrM8iX8mLzJ/YhKu912n7rdK7jGqADH+P2fUc12y7g9QcmOibuayBiyS
 Z7ina7HNFMAtHNjM=
X-Received: by 2002:aed:3324:: with SMTP id u33mr52520211qtd.322.1582643563684; 
 Tue, 25 Feb 2020 07:12:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqynn7/+8ZltdmYi6IBqD4+4Uij0q5vOGxRokGddAQo3bE+6kbnyMJevv1OKQyoTkpVfP32ZKw==
X-Received: by 2002:aed:3324:: with SMTP id u33mr52520182qtd.322.1582643563445; 
 Tue, 25 Feb 2020 07:12:43 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 z34sm7652256qtd.42.2020.02.25.07.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:12:42 -0800 (PST)
Date: Tue, 25 Feb 2020 10:12:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] bios-tables-test: default diff command
Message-ID: <20200225151210.647797-4-mst@redhat.com>
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
X-Received-From: 205.139.110.61
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


