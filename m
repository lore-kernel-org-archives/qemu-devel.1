Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B1C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD38206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJGad8Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD38206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMNk-0003oa-SH
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMK7-0007UF-W0
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMK6-0007TS-UU
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMK6-0007ST-Pw
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8zT9hMVESj5Eti91E6Xy3QJmXt+rT5wjccs06y86/k=;
 b=aJGad8BpmvmXoPIWIEwDhZcNQThRFrOYCuUqKkg9M31fyaVmSsg7j8admdjS8hf5TR74Qx
 pmhlTEURCRlOa7795ky2HfcNSzjuFhcafGqmYTko3ZWmo805MUX7jlV1bZG1+RtFX532xA
 P4VXXb9GULYbsqRgFsoTz1u0ljFhyrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-cnp9WkqLM-eaGTP4xNNZ5A-1; Tue, 31 Dec 2019 13:32:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1322610054E3;
 Tue, 31 Dec 2019 18:32:51 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E943267673;
 Tue, 31 Dec 2019 18:32:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 02/14] hw/intc/i8259: Fix Kconfig dependency on ISA bus
Date: Tue, 31 Dec 2019 19:32:04 +0100
Message-Id: <20191231183216.6781-3-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: cnp9WkqLM-eaGTP4xNNZ5A-1
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

The 8259 Interrupt Controller sits on a ISA bus.
Add the missing dependency to fix:

    LINK    x86_64-softmmu/qemu-system-x86_64
  /usr/bin/ld: ../hw/intc/i8259_common.o: in function `pic_common_realize':
  hw/intc/i8259_common.c:84: undefined reference to `isa_register_ioport'
  /usr/bin/ld: hw/intc/i8259_common.c:86: undefined reference to `isa_regis=
ter_ioport'
  /usr/bin/ld: ../hw/intc/i8259_common.o: in function `i8259_init_chip':
  hw/intc/i8259_common.c:97: undefined reference to `isa_create'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC Chipset)
---
 hw/intc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 10a680b53a..a189d6fedd 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -3,6 +3,7 @@ config HEATHROW_PIC
=20
 config I8259
     bool
+    select ISA_BUS
=20
 config PL190
     bool
--=20
2.21.0


