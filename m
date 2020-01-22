Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063EAC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD96824656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYMBpcPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD96824656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8xR-0000kg-Dj
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8vw-0007UU-KD
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8vv-0004bb-ID
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8vv-0004bM-EM
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47oh9akmDrhkEtMoFDskPeBdfNDdFnGRT7tngWCeWTo=;
 b=IYMBpcPhKemRbgOiB4M//ujsH7dSAr3drqmts4IW4z4yXSxPhqBVzpzNJQkTLPsP5EGoI7
 mGtqQQSQQOb5CTt7wUhDK2uP0ADWgvdXXXAJrhFQccfv8Oj/rJ0u3FLzUmiNhRr0P9DbcK
 F4rmt5IDXez8UD6hmRMlWpBrI+ajCyU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-kzqe9fV7N4a2RQ-daQQIZA-1; Wed, 22 Jan 2020 00:52:03 -0500
Received: by mail-wr1-f72.google.com with SMTP id f17so2541499wrt.19
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qLwCkCIBdxpEX8Qu8xH9v4eZQ8D42cjdHR7wkseYBRA=;
 b=oYMdd79W+NVXOJskgJef6X6fWkTirApkbq34M0ORGwXxLK2CDag/xkwpDdvIldXpcE
 DgR2mFD0Nu/Dql/233fMXgdNJ/CJsANb3GCXgSsawfy7Jei97SuJZ4JyPiLZ74eHJI/h
 SrG7RLDQ/DmjKmdyIY5XCGAfkmyIq6hs+CH1FcsiDIfw6XsVlcCeDhR4V5E/Hz0XHVas
 wXGFAvJwi76qbcZfHqhg4+jt0hsYonLCuocNl51htLIh8Hx3j3x1M8e9wHHBTZQMVFE2
 ixs4qWzUsH13DLylTOwChMUm1If5H080euPswcsPnXZlYfE/nRdqvj6N9H2QWgNSl1Ar
 oEmA==
X-Gm-Message-State: APjAAAWa3JjV/GekMAhxdxOknhN2iX0suEa3SGImoa7DBlQovfhLeyF7
 EFKRfHhB7Qu1PM7LwT6e90Z3nMZ1YeEnnYjz3PDAd6S11eXmP1mtLcpcsGLAJjmN1fyiqIVpwXS
 y2MsCI5IL6RKvr3U=
X-Received: by 2002:adf:fd07:: with SMTP id e7mr8984654wrr.21.1579672322459;
 Tue, 21 Jan 2020 21:52:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEP9pQnY5hG2BGMbolQlQ8N1qFez9Gali6doNiI+2etAg+y4PJ6KFMfongtaWfbdxiAobulg==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr8984633wrr.21.1579672322166;
 Tue, 21 Jan 2020 21:52:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 b18sm56663327wru.50.2020.01.21.21.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:52:01 -0800 (PST)
Date: Wed, 22 Jan 2020 00:52:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] acpi: cpuhp: spec: clarify store into 'Command data'
 when 'Command field' == 0
Message-ID: <20200122055115.429945-6-mst@redhat.com>
References: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: kzqe9fV7N4a2RQ-daQQIZA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Write section of 'Command data' register should describe what happens
when it's written into. Correct description in case the last stored
'Command field' value is equal to 0, to reflect that currently it's not
supported.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1575896942-331151-7-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index d5108720bf..8fb9ad22e6 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -90,8 +90,7 @@ write access:
             other values: reserved
     [0x6-0x7] reserved
     [0x8] Command data: (DWORD access)
-          current 'Command field' value:
-              0: OSPM reads value of CPU selector
+          if last stored 'Command field' value:
               1: stores value into OST event register
               2: stores value into OST status register, triggers
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
--=20
MST


