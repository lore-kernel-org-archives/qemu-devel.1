Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B8C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77694206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWE3KiMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77694206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMQp-000075-LE
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMLy-0001vU-D8
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMLx-0005Cp-70
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28011
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMLx-0005Aw-1y
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=you1BNnIeWey8KnPaYhu1Usou9ayEsaOY1T/aNIHy6g=;
 b=SWE3KiMdwGHufm3wA6lw60OhY33NtTmtJnkuTQ78MWP9Wg/IPhSYqfvmUjvgYeEl8SMxwk
 utFbCu0vIvaImU2Xa1eYBYE2UpLANTfe8RuCVOjm7LoXVMojZCMTd6IN142SclggQAac17
 9xbBGG6I1Id77tfPH1SdQr3ZEuXPHnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-y3TTSorwNJ6XAMJfDvTQUg-1; Tue, 31 Dec 2019 13:34:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42D55800EB8;
 Tue, 31 Dec 2019 18:34:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23B6167673;
 Tue, 31 Dec 2019 18:34:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 14/14] hw/intc/Kconfig: Let APIC select IOAPIC
Date: Tue, 31 Dec 2019 19:32:16 +0100
Message-Id: <20191231183216.6781-15-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: y3TTSorwNJ6XAMJfDvTQUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

apic_eoi() calls ioapic_eoi_broadcast(), so APIC has to
select the IOAPIC Kconfig.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>

RFC because I'm not sure the design is correct (meanwhile the fix is, howev=
er).
---
 hw/intc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index a189d6fedd..82748ae13d 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -24,6 +24,7 @@ config APIC
     bool
     select MSI_NONBROKEN
     select I8259
+    select IOAPIC
=20
 config ARM_GIC_KVM
     bool
--=20
2.21.0


