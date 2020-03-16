Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DCBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43D92051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZxFlwkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43D92051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtAp-0002dA-OK
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsHo-0004hp-Rw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsHn-0007em-Up
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52773)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsHn-0007Yf-Ql
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnhwsKKx2kZHqqWBEaWLP72fKQXGq24cvJF0rKa3l1k=;
 b=fZxFlwkpZ3Ny+FFNTuEj6W18Ym4xznZ3B8eCYs4IuPH6ZXyK1KAPvHHD6kD80XzWvVwY32
 Ic2Wu7a8aDUP80csblJd9iOxyboVpS47pT3/vD6C6ZuxhRNljAmZy3KVqCyibrgieejKgH
 R1wJCdmtWjA84D5D/FvbBR0JzpPhCfw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-jt4vyjXIPZaR540rWGHjZw-1; Mon, 16 Mar 2020 12:08:12 -0400
X-MC-Unique: jt4vyjXIPZaR540rWGHjZw-1
Received: by mail-wm1-f69.google.com with SMTP id a13so6012483wme.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kMtlamo7Zl3wCiVgcr8iciiwh4khJI79F07LAInMKRc=;
 b=nZEHWfpgWPeErpCgZ0FDRsOjrImvTFxThmzsl8OawYX29YLDb8y5Yqdj7Xr43sThOu
 n9dgGSfXvSXtMdqFn0X8D6u4U6Oah42d6MP/DdlAtTlwZ17n5HfWDQIpqC4ooVbaQ4RY
 DeOwDNiy5Y6zDZ2S1pwla/t8A27lu0/nUaemIamki2kWkN6Rm3nnuEcscZCAETWR1qDi
 TdxHVycVZywrzI0gLSNDttSDx7H+5nlUIf5awJakhpqohfE3Rk3Yly6NbmBDnhtmG2co
 3Iug0pRVBXs5JGuuolf9/rJlWh6zR8adyzBH7vcFpowK4bCjUXASJlvu51s6sXEqYAw2
 KIkA==
X-Gm-Message-State: ANhLgQ2JxTCdGYMYeDz5V1rDKiFq7notONJklFPkTMmXNoEkHaKElIH4
 w0T/dO29akn62oOalW7sAHXGn6uilF5qB00tLOGnn9/oLHTF2GFnn7ycGI5bwOdj2uOL77uGZM/
 K9KbWaZWkvyI55to=
X-Received: by 2002:a1c:3241:: with SMTP id y62mr29793847wmy.66.1584374890987; 
 Mon, 16 Mar 2020 09:08:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuQxAMoxg+u/+lPk/pzDgAO3wAjX2ARHQMgEZz41ANJhw8Gpk7UQYNDXjdjZkbYOg+VPhVfcg==
X-Received: by 2002:a1c:3241:: with SMTP id y62mr29793824wmy.66.1584374890780; 
 Mon, 16 Mar 2020 09:08:10 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id 127sm70683wmd.38.2020.03.16.09.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:08:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/19] hw/arm: Automatically select the 'virt' machine on
 KVM
Date: Mon, 16 Mar 2020 17:06:32 +0100
Message-Id: <20200316160634.3386-18-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When building a KVM-only QEMU, the 'virt' machine is a good
default :)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d0903d8544..8e801cd15f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -1,5 +1,6 @@
 config ARM_VIRT
     bool
+    default y if KVM
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VFIO_AMD_XGBE
--=20
2.21.1


