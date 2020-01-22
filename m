Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B4C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C4024656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zxbpio/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C4024656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8zz-0003zB-JZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8vq-0007Iw-19
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8vo-0004Z1-R9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38127
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8vo-0004Yo-NO
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhMnOXw2jltLb3g6o0bZN0GY8d9d1JsgKnb3ojyU5uY=;
 b=Zxbpio/6QHFCyxbioShwCzqYxFU7rGG8pf/iMknyq0FWzy2/wvgq2PSwVXQFI0Iic1Nsyb
 qgIUp4B/8ixZuosIp6lriny101fl2vQfEO31eVoTY7IqIH8XYJo7FlSPVknLHJLSB/SD7m
 OTM0AXrc4OuzUWnHt4xORJvQonWoHQ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-dusI85DqPsaZghcQFV1JHw-1; Wed, 22 Jan 2020 00:51:57 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so2535738wrh.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SmP96JjZ61jUtUgNUruj35mPI4zb3UYO5pk5xajyjow=;
 b=KrWY3UP7x8Ienpn/fTQQ8hl3eAHwZs6J3otBKiF/CCkDgiC6K317fwzqNrHGaOehhO
 gO7zIjd9kQLlGowo6KsI0e10pIfCZa0GbWfoUE5qJabst0VunFttFg4U4eWWW3JS2SYF
 MWvFFtEPnFzVyjkJHGjC1zDAEChjMOyb5pIfiZZScxd4yGTs0QVDzf/uXmXntC3pbCeR
 81VUGqrlWc8agsxrgps9VZ8WDW7aV9s++PFv7u6D7wecquUDnbaT3a5DbHN8KQcYOe/2
 X0UiOdT2DGBr7gp1TUuRg3L7VgkX+Ek1ddbPwqcgt8A3kl1XPNZegoD+6CJt4By57R9R
 AndQ==
X-Gm-Message-State: APjAAAUg5MfHMIYy2gdJckmx8K3PRgrpo8Akfww3veKkYQhsVntGwGAx
 bizeckJU2y/K/7ViOpLlLxHvCM/HqBcLqCOuiFvz/E8DhIp5c4071d+gd4K8Zhv9fnmihdINkoi
 LyxHUpDdTFp0mGLo=
X-Received: by 2002:a05:600c:411:: with SMTP id
 q17mr947227wmb.180.1579672316550; 
 Tue, 21 Jan 2020 21:51:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFPa95+06DfGK12UXuDyZp0doPjrsE3Fyrto7Z07jDIP3SWiHL65fuuZs/qbWUE3oaXaGxGA==
X-Received: by 2002:a05:600c:411:: with SMTP id
 q17mr947221wmb.180.1579672316381; 
 Tue, 21 Jan 2020 21:51:56 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 t1sm2495642wma.43.2020.01.21.21.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:51:55 -0800 (PST)
Date: Wed, 22 Jan 2020 00:51:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] acpi: cpuhp: spec: clarify 'CPU selector' register
 usage and endianness
Message-ID: <20200122055115.429945-4-mst@redhat.com>
References: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: dusI85DqPsaZghcQFV1JHw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

* Move reserved registers to the top of the section, so reader would be
  aware of effects when reading registers description.
* State registers endianness explicitly at the beginning of the section
* Describe registers behavior in case of 'CPU selector' register contains
  value that doesn't point to a possible CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1575896942-331151-5-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index ee219c8358..4e65286ff5 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -30,6 +30,18 @@ Register block base address:
 Register block size:
     ACPI_CPU_HOTPLUG_REG_LEN =3D 12
=20
+All accesses to registers described below, imply little-endian byte order.
+
+Reserved resisters behavior:
+   - write accesses are ignored
+   - read accesses return all bits set to 0.
+
+The last stored value in 'CPU selector' must refer to a possible CPU, othe=
rwise
+  - reads from any register return 0
+  - writes to any other register are ignored until valid value is stored i=
nto it
+On QEMU start, 'CPU selector' is initialized to a valid value, on reset it
+keeps the current value.
+
 read access:
     offset:
     [0x0-0x3] reserved
@@ -86,9 +98,3 @@ write access:
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
                  with current values of OST event and status registers.
             other values: reserved
-
-Selecting CPU device beyond possible range has no effect on platform:
-   - write accesses to CPU hot-plug registers not documented above are
-     ignored
-   - read accesses to CPU hot-plug registers not documented above return
-     all bits set to 0.
--=20
MST


