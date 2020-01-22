Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED1C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DC724655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFrPRBGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DC724655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9tw-0000hj-0G
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9q6-0004KM-6f
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9q5-0007q6-6P
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9q5-0007pl-3O
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47oh9akmDrhkEtMoFDskPeBdfNDdFnGRT7tngWCeWTo=;
 b=eFrPRBGegOtqOUhjyVNZz7tUw3HNxrM3gviycmYHrwcmacuOAlAHq2WIj3vP9n2ibZgx+2
 hU7Xuj9LSLECeeAA6gU5/rU9G7pmpnJ4nBhO5x37ataKh5nxFcFNYeGsXKLkx642THZRaI
 2iBwv7vzastxjvsb3TQIlWwhKE4cdMg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-9ET7OsDCOMmDQg297eLG7A-1; Wed, 22 Jan 2020 01:50:06 -0500
Received: by mail-wm1-f70.google.com with SMTP id b133so123665wmb.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qLwCkCIBdxpEX8Qu8xH9v4eZQ8D42cjdHR7wkseYBRA=;
 b=RWo80zUtA6fKi2MUOLtDClQxdRKC2J4IeEKkaNaHDWsZaJT/ATEML+pwr3qi7uBX0b
 vJpppNfuesx8d6sZPQQvYe0C7mrSoWzEqqde4F5NXxTBaq9PjQtJyx2D1ObWiZQG93/Q
 Vde4Cf75hnJpyaNthndPAHH6GuyuwAUkbKwvYsf6mNxY6M+d+wxGkgyMdw+tRCJTqlat
 /HOxuCXjYEdYHD49V5zN/LgOFlhNOMO4eyIRNTVEHoO0e+Ph4jYj+YlLLsNEiwnzO3+q
 xpE0ZKsTfklawfVMJvvaCF1G4a3oH96WWzPbF36lN9vqrZoSuuteN7l2hV6LW0xdSTHj
 9n8w==
X-Gm-Message-State: APjAAAX/3i0TlHPqjBDTmemgefxZ0+++FQJTpH90Uxkxa3b4uA+d1N+K
 ElVwKfLiIRjJ0qg88A3cVKA/maeVm+Mw3NSi9ylFXdlskt5zaxtagD/6+16vY6ARly35WiVq7LU
 Gep+Vxh/6r9LFYI8=
X-Received: by 2002:adf:ee11:: with SMTP id y17mr8973809wrn.425.1579675805272; 
 Tue, 21 Jan 2020 22:50:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvIVRA2Q1iB2VjDQmReIAFRqgVHEms5wDpG3HXrqhCL35GuzKqpzikCS+Wby4B4KkpDl5HUA==
X-Received: by 2002:adf:ee11:: with SMTP id y17mr8973795wrn.425.1579675805103; 
 Tue, 21 Jan 2020 22:50:05 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 i10sm56890840wru.16.2020.01.21.22.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:04 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/17] acpi: cpuhp: spec: clarify store into 'Command data'
 when 'Command field' == 0
Message-ID: <20200122064907.512501-6-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 9ET7OsDCOMmDQg297eLG7A-1
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


