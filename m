Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2581C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4A724656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsBI6zEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4A724656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8xd-00013l-7T
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8w8-0007k1-22
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8w5-0004f3-Um
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8w5-0004eL-Qr
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSs10h7+g5GHkd748u1YKdPjMw3sPPNZXswgwHDuFfc=;
 b=TsBI6zEz256Ulf3cRvp8f+pJxKDLKaj04HlzXtkcDvfuiKDkPp9TY4Dvx3rmysnF/F1Lx8
 xH0RIYLWhX5/8WXLEDlsp1aoMejVIfPpDRdzV2dmfEzyhjfXdeeCg9KinPFxdczW+hoAOE
 1mH7sstBGbTihOcUwu1RnZlA83ZvgG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-DDIfF85aOiCZJ2UdP5kPvw-1; Wed, 22 Jan 2020 00:52:12 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so2512757wrm.17
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bshZ29A7PK62drys54Y2NwFiWKvTA5OkiFM7lPNvHYk=;
 b=DiVD05Uc0wZOwHDT3lPg6EV9iwNtArrjyfhm4z0eq3+VWOUCHRqvU8+EIWPsT2tZiy
 wcaYSknoySGCeedZftj8ftQB9P4wgKo9c+WgK9f1saVEss8VK1a/qqF6zf9ERBkOfnFu
 S2IBuEWtmf41faQs6RCUx4IVdnA6b0awU44ku8SMBLfCT6y+Pdc1LIijniJAEaBZkRdI
 zPZrGpRz12JCw+AEQuUEFLfJlxwVp1M74jGajR9IKRSDHo5QcRj9PCj2N3VGnjsgosjg
 qs4RdOJp+I3GuzeaNeD0u40v83xoYk0euh/axFIFD/99FUpTJdwNALIApXXunRSbtb6Q
 Kn3w==
X-Gm-Message-State: APjAAAXZmavyTvssePpJ+lhqyhFMlKmo0w4VUt5sv+/D9I3XZY12aO2O
 blk9OFAXhaZDKpvwa3cIAANbTuWWaxQnoTzKPjWGNUL60k0kVQYMSr2G16frzOOrZhdQCH9Dx87
 eLLGWCZcWbtvjb6M=
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr8862698wrn.75.1579672331093;
 Tue, 21 Jan 2020 21:52:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYZU0MD7/VttmeVfqo3pZ2nkyaVSZkLIl6xBOqEvPv40YPjtbiaDdxjI2BTNWQIBeEBaZEgw==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr8862673wrn.75.1579672330829;
 Tue, 21 Jan 2020 21:52:10 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 p18sm2413812wmb.8.2020.01.21.21.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:52:10 -0800 (PST)
Date: Wed, 22 Jan 2020 00:52:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
Message-ID: <20200122055115.429945-9-mst@redhat.com>
References: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: DDIfF85aOiCZJ2UdP5kPvw-1
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

Firmware can enumerate present at boot APs by broadcasting wakeup IPI,
so that woken up secondary CPUs could register them-selves.
However in CPU hotplug case, it would need to know architecture
specific CPU IDs for possible and hotplugged CPUs so it could
prepare environment for and wake hotplugged AP.

Reuse and extend existing CPU hotplug interface to return architecture
specific ID for currently selected CPU in 2 registers:
 - lower 32 bits in ACPI_CPU_CMD_DATA_OFFSET_RW
 - upper 32 bits in ACPI_CPU_CMD_DATA2_OFFSET_R

On x86, firmware will use CPHP_GET_CPU_ID_CMD for fetching the APIC ID
when handling hotplug SMI.

Later, CPHP_GET_CPU_ID_CMD will be used on ARM to retrieve MPIDR,
which serves the similar to APIC ID purpose.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1575896942-331151-10-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 3 +++
 hw/acpi/cpu.c                   | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index cb99cf3c8e..a8ce5e7402 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -47,6 +47,7 @@ read access:
     [0x0-0x3] Command data 2: (DWORD access)
               if value last stored in 'Command field':
                 0: reads as 0x0
+                3: upper 32 bits of architecture specific CPU ID value
                 other values: reserved
     [0x4] CPU device status fields: (1 byte access)
         bits:
@@ -61,6 +62,8 @@ read access:
     [0x8] Command data: (DWORD access)
           contains 0 unless value last stored in 'Command field' is one of=
:
               0: contains 'CPU selector' value of a CPU with pending event=
[s]
+              3: lower 32 bits of architecture specific CPU ID value
+                 (in x86 case: APIC ID)
=20
 write access:
     offset:
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index d475c06953..e2c957ce00 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -18,6 +18,7 @@ enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD =3D 0,
     CPHP_OST_EVENT_CMD =3D 1,
     CPHP_OST_STATUS_CMD =3D 2,
+    CPHP_GET_CPU_ID_CMD =3D 3,
     CPHP_CMD_MAX
 };
=20
@@ -75,6 +76,9 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr,=
 unsigned size)
         case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
            val =3D cpu_st->selector;
            break;
+        case CPHP_GET_CPU_ID_CMD:
+           val =3D cdev->arch_id & 0xFFFFFFFF;
+           break;
         default:
            break;
         }
@@ -85,6 +89,9 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr,=
 unsigned size)
         case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
            val =3D 0;
            break;
+        case CPHP_GET_CPU_ID_CMD:
+           val =3D cdev->arch_id >> 32;
+           break;
         default:
            break;
         }
--=20
MST


