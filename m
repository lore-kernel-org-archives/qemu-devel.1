Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EB4C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FE52253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmsaRJDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FE52253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuB2i-0006xv-0Q
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuB1U-0005i1-71
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuB1T-0006IA-A6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuB1T-0006Hy-6Q
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579680358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgQZE+CAHPfxOe90xsEJw1km1zHj+aED1ZfJaWHIImw=;
 b=CmsaRJDOlhOYMZmeHWEdwwqhNhOCr6OxUKv8Nos4LiLhXqInr1YyQXaEoIyyWjIioSpp+o
 MuTUZ/XxXHJ+meKtfLyxjs6ePK9lIFVeYwbGnwq4c8mnRVL6/5KFJwQluIp7QAkYqdgxxZ
 +VGXtfxcmy0MvQlpxrLbirPR25obeo0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-k9U782qAPKK9S0nqxSO2xw-1; Wed, 22 Jan 2020 03:05:56 -0500
Received: by mail-wr1-f72.google.com with SMTP id j4so2677831wrs.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ohtvbpi6C3mgUqd4HNTl8GS6jn6LfpItHWheVW3ZFjc=;
 b=GqLl8Ca3/JjqHGD8neDDqloTXjDLHZ2I4aa0iEkJplIEuMsqKc77qah5EXuZwRyFuD
 lRBx1k67JZyBCkQeepLn3tN4PWmQqqYkcCdKJ+aeeOQdE2y09hAlwDsQWjz22LUeeCLv
 2c8+hcZJLIoZ1iNpMZBsylpG512V8d11WS5HSxZUIstvM0alHr77yuOck5pxNkMI7bLt
 8dnYsTcFJ2Lpi1OJ+F8jzAONF5rmLjZS2xB9m+Hgo5frRVAA2Nf8ml8maDV8SoVb5Ooc
 6DBm5go41iibkC/NsRq692JziX/EKWvYSDk1hyyzsZ7r6iUvixx1CCfG0djw6SQrilnE
 GwYw==
X-Gm-Message-State: APjAAAUaInhCj6e7PeWHu9JCd3qjV6ksTcwerPxsHARMLvhxizC8wL7i
 SfsanqHjupAml7jWPZgXqX5d3pnKAf1pxj0NrJVbd1xZehI0jN7dV+A0Ranqp6S3onV5txdNHtl
 OJflc4Ayo3BJgTD8=
X-Received: by 2002:a7b:cd0a:: with SMTP id f10mr1579853wmj.56.1579680355135; 
 Wed, 22 Jan 2020 00:05:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPDWCvFnPzwcDxatN6Yk8YM6eA4EOIaOOJnfGb3Q/pdkGca3wCPrGOEOmTxcvf/l+Lf7sMUw==
X-Received: by 2002:a7b:cd0a:: with SMTP id f10mr1579834wmj.56.1579680354918; 
 Wed, 22 Jan 2020 00:05:54 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 s15sm52470666wrp.4.2020.01.22.00.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:05:54 -0800 (PST)
Date: Wed, 22 Jan 2020 03:05:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] bios-tables-test: tell people how to update
Message-ID: <20200122080538.591734-2-mst@redhat.com>
References: <20200122080538.591734-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122080538.591734-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: k9U782qAPKK9S0nqxSO2xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

For now just a pointer to the source file.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index 3ab4872bd7..6b5f24bf62 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -426,7 +426,9 @@ static void test_acpi_asl(test_data *data)
=20
         fprintf(stderr,
                 "acpi-test: Warning! %.4s binary file mismatch. "
-                "Actual [aml:%s], Expected [aml:%s].\n",
+                "Actual [aml:%s], Expected [aml:%s].\n"
+                "See source file tests/qtest/bios-tables-test.c "
+                "for instructions on how to update expected files.\n",
                 exp_sdt->aml, sdt->aml_file, exp_sdt->aml_file);
=20
         all_tables_match =3D all_tables_match &&
--=20
MST


