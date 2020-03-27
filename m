Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FD4C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C7220675
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGXb0Tfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C7220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmxe-0002gO-Eh
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHmwX-0000sY-Pi
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHmwW-0001pS-NW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHmwW-0001oj-Ju
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585307668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vr+3UYJLFSKZG8ktFtie/vjm4Z4gRJhmEP9NL974v7c=;
 b=EGXb0TfganaKNljIixqJpX/2r3qxm0i6+uItXGxOnnjZDA5+dSmq22P6zZmgKo28+EuIWI
 6Kuv8J6AtM1Xwi+h1CiuMsg1aswlueW6YlGN5ZPWoyDxbhDiqyFEzxmreSLHYOnXjXOgiC
 utxFHlWk8ioo0qpndPoZTlHe9/0kXFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-eu5EqtgkPx-XfFPVKRN1Zg-1; Fri, 27 Mar 2020 07:14:25 -0400
X-MC-Unique: eu5EqtgkPx-XfFPVKRN1Zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51B5F8010E3;
 Fri, 27 Mar 2020 11:14:24 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-77.pek2.redhat.com
 [10.72.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A51E85E030;
 Fri, 27 Mar 2020 11:14:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 06/13] hw/net/rtl8139: Simplify if/else statement
Date: Fri, 27 Mar 2020 19:14:00 +0800
Message-Id: <1585307647-24456-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
References: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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


