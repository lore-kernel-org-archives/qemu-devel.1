Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFACC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5933D20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXGW5+MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5933D20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb0k-00066h-EY
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazp-0004LY-8W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazo-000602-9t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26332
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazo-0005zG-6R
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtsjpTBF0GqaghML3YQTQ1/tMXVw713kPgZppEdgPj8=;
 b=hXGW5+MFV98Hib/OBnge2tien27MZYIo9eDPBDKJ3e5zNOWrjpuFlbT95LYHLV3CI95x5o
 uXv68BJMJjapzS0gl+hW7uyMqBBa9cSE+fNQets2a2ZOr3lG8DBvE2OwBcs1oIO9KoiMGD
 /9V0zCQRPHmXETQxSPVDgWDtN9w2yK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-dUIYYJb7Oiy-8AGGriSDxg-1; Mon, 03 Feb 2020 07:38:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DED891851FD9;
 Mon,  3 Feb 2020 12:38:28 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A25A361070;
 Mon,  3 Feb 2020 12:38:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/13] hw/input: Do not enable CONFIG_PCKBD by default
Date: Mon,  3 Feb 2020 13:38:07 +0100
Message-Id: <20200203123811.8651-10-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dUIYYJb7Oiy-8AGGriSDxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i8042 PS/2 Controller should not be enabled by default. It has
to be selected by machines or chipsets (e.g. SuperIO chipsets).

Message-Id: <20200115113748.24757-1-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/input/Kconfig | 1 -
 hw/isa/Kconfig   | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 25c77a1b87..64f14daabf 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -7,7 +7,6 @@ config LM832X
=20
 config PCKBD
     bool
-    default y
     select PS2
     depends on ISA_BUS
=20
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 8a38813cc1..c7f07854f7 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -16,6 +16,7 @@ config I82378
 config ISA_SUPERIO
     bool
     select ISA_BUS
+    select PCKBD
=20
 config PC87312
     bool
--=20
2.18.1


