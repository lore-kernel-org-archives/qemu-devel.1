Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59031C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C5A2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDfi6HzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C5A2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMLO-0000ak-N5
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMJw-0007Ce-F9
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMJu-0006pZ-Uh
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMJu-0006mw-QY
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNrbe+4B+umJ4zWOxS26ufKgntytZstSfWcEVuRFYr4=;
 b=NDfi6HzRABsKNrEAg1cx1Yv1tFQPi/4Qr9+/smBEW3lLA7j1tIcHaywUoe8pVo7zLBIEGH
 d5A9lvyVY2BsQv+zoECi6JA/7hfbqMT7o1w9UZiFKtIfiQQsyNWyqVgwe8o2aEX3LmAeJQ
 PWXfgkrDiyoWtGHSNshwKVVedi4Yd10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-7M8wrOacOneps52M3JOhuQ-1; Tue, 31 Dec 2019 13:32:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A370477;
 Tue, 31 Dec 2019 18:32:38 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FEC68207A;
 Tue, 31 Dec 2019 18:32:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 01/14] hw/usb/redirect: Do not link 'usb-redir' device when
 USB not enabled
Date: Tue, 31 Dec 2019 19:32:03 +0100
Message-Id: <20191231183216.6781-2-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7M8wrOacOneps52M3JOhuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

The 'usb-redir' device requires the USB core code to work. Do not
link it when there is no USB support. This fixes:

  $ qemu-system-tricore -M tricore_testboard -device usb-redir
  qemu-system-tricore: -device usb-redir: No 'usb-bus' bus found for device=
 'usb-redir'

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/Makefile.objs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 0ab20f9d73..0052d49ce1 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -39,9 +39,11 @@ common-obj-$(CONFIG_USB_STORAGE_MTP)  +=3D dev-mtp.o
 endif
=20
 # usb redirection
+ifeq ($(CONFIG_USB),y)
 common-obj-$(CONFIG_USB_REDIR) +=3D redirect.o quirks.o
 redirect.o-cflags =3D $(USB_REDIR_CFLAGS)
 redirect.o-libs =3D $(USB_REDIR_LIBS)
+endif
=20
 # usb pass-through
 ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
--=20
2.21.0


