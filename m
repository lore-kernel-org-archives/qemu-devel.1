Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EA0C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0958C206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqKawgPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0958C206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMSM-0002XH-QA
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMKo-0000A1-HJ
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMKn-0001Mj-Cq
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:33:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMKn-0001Kn-7s
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIAu7a2EIYqO6Epo2dSB57lqrOGVbfU2rmoXjKF3iOg=;
 b=DqKawgPz2AZXiReeMssG97BSXNk+Zsqk1SaORF57UbSqctdAXq0jNFun35tCJS/Y0ufwZg
 yAGU/D/JhFzG/3QQWAHX/n1fS4zPWJem0Cj8m5yImG7azDAdnvCpaA1htP9J6QFI0UqCJ1
 UJNVsh8s7YteL6i10OIr+Y4MF2iC4eY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-hq4WiI_uPuGkJEtu8-sfwQ-1; Tue, 31 Dec 2019 13:33:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D3B58017DF;
 Tue, 31 Dec 2019 18:33:33 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DE3A67673;
 Tue, 31 Dec 2019 18:33:20 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 06/14] hw/ppc/Kconfig: Restrict the MPC I2C controller to
 e500-based platforms
Date: Tue, 31 Dec 2019 19:32:08 +0100
Message-Id: <20191231183216.6781-7-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hq4WiI_uPuGkJEtu8-sfwQ-1
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

Only the PowerPC e500-based platforms use the MPC I2C controller.
Do not build it for the other machines.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/ppc-softmmu.mak | 1 -
 hw/ppc/Kconfig                  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.=
mak
index bf86128a0c..61b78b844d 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,7 +1,6 @@
 # Default configuration for ppc-softmmu
=20
 # For embedded PPCs:
-CONFIG_MPC_I2C=3Dy
 CONFIG_DS1338=3Dy
 CONFIG_E500=3Dy
 CONFIG_PPC405=3Dy
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index f927ec9c74..0cd8d4053e 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -105,6 +105,7 @@ config E500
     select PLATFORM_BUS
     select PPCE500_PCI
     select SERIAL
+    select MPC_I2C
=20
 config VIRTEX
     bool
--=20
2.21.0


