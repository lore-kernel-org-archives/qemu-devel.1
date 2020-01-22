Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F550C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCD02253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfq/oel6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCD02253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuB4i-00017w-TR
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuB1Z-0005kU-81
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuB1X-0006JA-8f
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuB1X-0006Iz-4s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579680362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0D/foY0xfnPxSgAusOSLmGZ39GfCQPMvI9GzghkGMfg=;
 b=Rfq/oel6wGk2xmBvDfZ1DfA4so2Evaesu1HIIoCcndbSHQRuka6vygHv0yN7YFWFxyZm+I
 uQJZMMFwrpwK/aXwDEVs+RPNEb4QZxrftOwuacIsjJ1nNNIaVgu/R4e0nbeJtoLUGkXPEC
 xbC843GqY9u/O8RFhksvG+QxnxNPxy4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-ugO3wcoVMHuwJCw76nYSyw-1; Wed, 22 Jan 2020 03:05:59 -0500
Received: by mail-wr1-f70.google.com with SMTP id i9so2694474wru.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+KuxNZk9Kx5kRe0gipOUTAqT/cDTELiu4iT30gbrRvM=;
 b=rZH5aOGrdsk+PWtonIEdi7kfaoOjvWGSV1VB5rR9lIYKClFa7rtbF9PPvDg12F/Jpe
 6sOb/ordmJorTHR7Q/4W/dLIH5SBJtFYXzY41UZzVDjA2JxskUUvC7UI+AmKXji8noYF
 tImCm6yoOl5wJC0Fn2UEQXF63La7ExKAOrBidb6DJzAJHudd42vSslyObTi7/ITEbI7a
 GJFWuOU0n1+n/2U7wZan9CNh+WgcKjEmsReeS0PxIzj1w08E0/OxdQ4a0aAppWQQ0DGx
 WZmYsQ9NPILh9pFYfufacr3Uwa7dlTbqT8fFoNnbtU/568TFvsLKVafTJ9C1YFlZBtvr
 oiZw==
X-Gm-Message-State: APjAAAWezQcHAeY4y+uyucDqSdU6FXoI73BAmLQRqYg66bueT0r/s/Cn
 4OGkKNgV+qlVmpuHjDryD1pQ2UTvXq5Ovw8QCYNTr6Km5+42oGUqrG4ZWnIYvi9xACQKi8iz/r9
 R8M6Qmib28uAH2OE=
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr1539005wma.84.1579680357795; 
 Wed, 22 Jan 2020 00:05:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzd+NDj/PeCldrH/WuoF6v0uIyKNoO4F8mNQpAlHgvEFwpDjbyxtfkoN0i0L9ikKbqeBYvvjw==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr1538990wma.84.1579680357631; 
 Wed, 22 Jan 2020 00:05:57 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 w83sm2872198wmb.42.2020.01.22.00.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:05:57 -0800 (PST)
Date: Wed, 22 Jan 2020 03:05:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] bios-tables-test: fix up DIFF generation
Message-ID: <20200122080538.591734-3-mst@redhat.com>
References: <20200122080538.591734-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122080538.591734-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: ugO3wcoVMHuwJCw76nYSyw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turns out it goes to stdout which is suppressed even with V=3D1.
Force DIFF output to stderr to make it visible.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index 6b5f24bf62..c8db2839b2 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -463,13 +463,18 @@ static void test_acpi_asl(test_data *data)
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
                         g_free(diff);
                     } else {
                         fprintf(stderr, "acpi-test: Warning. not showing "
--=20
MST


