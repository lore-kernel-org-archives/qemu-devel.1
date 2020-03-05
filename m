Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4677D2072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5cN9iEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4677D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9uno-0004eH-CF
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 13:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ukD-0007PX-0c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ukC-0002py-30
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ukB-0002pW-Vv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583431031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGHswVvKeRQxvy0qEQcO1JqCKgI3zH8psI7B4R/7eKQ=;
 b=M5cN9iEOPFcW+N/CiAJk18qybamIA8aJ7osIq7gxBMRpZzshSWf2fUw3YpRgOWv/SerOe5
 Ai6ppMrI8ZwJGprtotP/KLRnd9mhPhkDIrtGUXC/2oq/khUsGl7lPtmEhkHYEM5/5r4vM0
 Wy/nixJZNoV4jreDipHzTxkjQvapwcs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-FghEmYpzOSWxDiVDGS7gBQ-1; Thu, 05 Mar 2020 12:57:10 -0500
X-MC-Unique: FghEmYpzOSWxDiVDGS7gBQ-1
Received: by mail-wm1-f72.google.com with SMTP id v21so1868937wml.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=60PR0G6qPI4q8UeizT2SJgOmqcakhr9AMbPfUXTnwEg=;
 b=XAEJzTgqhOgh/QczHjAx3TDLGs2kOZZZv0Gk6I6Kafi0ZkG8kGY738BN2uI4PyxCRR
 59nVfjCgcFAy8jQksv4pjPGrnKUqolElYEUtNXrXMYLXy7aRKDH+CTH5B/vX24B2KZsg
 YUYmCqzYnJYPy4JL0Mdk/J4ew9BZTcLQUwQxW16oPQsQc6Y9C15JhoP+K4ONvAJ2NJNV
 PUcLHbGihXBVIlj73/7LP1s/DQKZUCGgSqc65AgpBag/pYol9uHZVBnGLoSbCx1RlCwv
 XbJwb9ek8AYGgWWcnzYde1RwUjMhHUArnkca5IiDiE9iWvqWSEiOX+FXULaRUco441rZ
 GcLQ==
X-Gm-Message-State: ANhLgQ0V/2c/XET85GF0V1ZvXQjC0NKBcApIiXCco7079+URlV1bB5Nk
 SqI/70CGI3+nWwsSgVnrs6t5HbdQuF+A7YrVBZEDBhgio69/9C3NocDmNMBIA4bNtPgRrXN/goX
 oosiVTgsevsXlo/k=
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr104578wru.35.1583431028616;
 Thu, 05 Mar 2020 09:57:08 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsN5NJ5s0QVpQKKfqwHa709/Td64F5/lWY+JWepk7pducB47SHKJ3+0JaCzv29sFkel3LOe+g==
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr104543wru.35.1583431028408;
 Thu, 05 Mar 2020 09:57:08 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r28sm47991406wra.16.2020.03.05.09.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 09:57:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/net/rtl8139: Simplify if/else statement
Date: Thu,  5 Mar 2020 18:56:47 +0100
Message-Id: <20200305175651.4563-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305175651.4563-1-philmd@redhat.com>
References: <20200305175651.4563-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: qemu-ppc@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Joel Stanley <joel@jms.id.au>, Beniamino Galvani <b.galvani@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/net/rtl8139.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index ae4739bc09..ef3211537f 100644
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
2.21.1


