Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C33C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B1620732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoPWgHqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B1620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6saK-0006M5-1l
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sZ6-00050M-6z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sZ5-0000Kj-9I
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36681
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sZ5-0000IC-5L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3d4o92HiKW0GkrgYyraxaRI0YnnUbnRMpXEK0wLk1g=;
 b=PoPWgHqaSytOuheQe0fEo11wJgB7tOZeSDmdp0VbCjCmiHeyCMKf83epjm4d1mWq97UjEA
 8tmT+ns6TTyDKh3Kl8Z2sPLavG4QIfXkL13ix/399Qs02JR5Xrg/B9brH/vncx+KMJ+LA1
 NHhCPg0KIT9UQwp7RvbqulANltuGPAw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-UUManceyN66Uy_eFvueMwA-1; Wed, 26 Feb 2020 04:01:08 -0500
X-MC-Unique: UUManceyN66Uy_eFvueMwA-1
Received: by mail-qt1-f197.google.com with SMTP id e37so3562173qtk.7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=caX16DlQRmHBI59+o89Wqp82tnjVscp7M1/GhbqHicQ=;
 b=LrAaej9c+cvh7envcAE94WKws+GH4MCeiP+v69Rilb49SV6TqwYsGhpLlWxWNI3zpk
 PyewixjuqyAhSSDG0IG7ZEBzERnumViX3wNBhjj9vhkUK70jeWGpMH/BVd788clrGIU4
 42feX9dT+jfT5OSz6t6KtRep9YC8h4LPRYDwMGhc6nzbYLlzqmkh3SQtucZBxZZ5NmNX
 uMf1T/qRCgP363P6/lwv1CWCoC4vXgWLDocl8BrdM+3CFIQxC0YieByRidB3tQ7kHrxL
 lzy++JkQJZPDBy15+OlBNI4Df5pAVOtv47vfc3SXCJ/53AqPKc13JaHS80vLrw4SnUBm
 Acig==
X-Gm-Message-State: APjAAAXZ5wO+qJ/WMk8YEZnL0zUbB6qfKfNkwpbaW3poNU+TL26nyJA6
 MRv3mU8u1jei7McEn73b7m4Z6nuKbHtSX0WCg82nrOSv7yStYsZ6hc0HHe4z8hkeITCAlF5Mhqa
 4sGxs6NWq4yoWH8w=
X-Received: by 2002:a0c:e146:: with SMTP id c6mr3797668qvl.116.1582707667715; 
 Wed, 26 Feb 2020 01:01:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjAO8zfbwTlSjLmWbxvMHKZ8+QPmjGnyPfBqF+zajkNOmc9eGiSeJnBqDn4vDVmD69ARG5GA==
X-Received: by 2002:a0c:e146:: with SMTP id c6mr3797646qvl.116.1582707667445; 
 Wed, 26 Feb 2020 01:01:07 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 k7sm739189qtd.79.2020.02.26.01.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:01:06 -0800 (PST)
Date: Wed, 26 Feb 2020 04:01:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/30] bios-tables-test: tell people how to update
Message-ID: <20200226090010.708934-2-mst@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now just a pointer to the source file.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/bios-tables-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index b4752c644c..9c3c4680e4 100644
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


