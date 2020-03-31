Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1D8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1437C20772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jh+rhCaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1437C20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGw7-0001s4-6q
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJGqG-0000KQ-55
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJGqF-0005mA-1h
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24236
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJGqE-0005lY-Ag
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585660926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vr+3UYJLFSKZG8ktFtie/vjm4Z4gRJhmEP9NL974v7c=;
 b=Jh+rhCaVHTsOCbfYiBo3eNbwpj6DqeMaV/TjNL5P7odqLret2Gmuu1RRkmzyyUtiPg0V4x
 nJe5fuhQRBahyoCe90+jHFlywhY+XbA2JzVLbsmESEqiqGtvGyhwgTWNFq4MXcJ7nZYFIo
 okflmnUtZK7AnZ9QTAF8CsyrAe0lsHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-lj0_-5pLPJuguTByGOWBaA-1; Tue, 31 Mar 2020 09:22:04 -0400
X-MC-Unique: lj0_-5pLPJuguTByGOWBaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F353801E74;
 Tue, 31 Mar 2020 13:22:03 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-118.pek2.redhat.com
 [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FBE210002B5;
 Tue, 31 Mar 2020 13:22:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 06/14] hw/net/rtl8139: Simplify if/else statement
Date: Tue, 31 Mar 2020 21:21:31 +0800
Message-Id: <1585660899-11228-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
References: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Rewrite:

      if (E) {
          return A;
      } else {
          return B;
      }
      /* EOF */
  }

as:

      if (E) {
          return A;
      }
      return B;
  }

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rtl8139.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index ae4739b..ef32115 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -808,11 +808,11 @@ static int rtl8139_can_receive(NetClientState *nc)
         /* ??? Flow control not implemented in c+ mode.
            This is a hack to work around slirp deficiencies anyway.  */
         return 1;
-    } else {
-        avail =3D MOD2(s->RxBufferSize + s->RxBufPtr - s->RxBufAddr,
-                     s->RxBufferSize);
-        return (avail =3D=3D 0 || avail >=3D 1514 || (s->IntrMask & RxOver=
flow));
     }
+
+    avail =3D MOD2(s->RxBufferSize + s->RxBufPtr - s->RxBufAddr,
+                 s->RxBufferSize);
+    return avail =3D=3D 0 || avail >=3D 1514 || (s->IntrMask & RxOverflow)=
;
 }
=20
 static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, =
size_t size_, int do_interrupt)
--=20
2.5.0


