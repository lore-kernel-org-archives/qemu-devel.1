Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D3C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5B8206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6pP8130"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5B8206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lew-0002vw-VL
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lX7-0004sM-Er
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lX6-00053A-5E
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lX6-00052c-0G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvIA11c99fe9jZjyk6Bhj+dUz8AZyW6zBDm4tJjkdl0=;
 b=M6pP8130TCNN20jOqy/yn8zC+zWl35M2q5d8128XA/WZCZNUGa7y2tEeiPi3qwlcK6sc5I
 MZbuAGtONIxUUxJUumaXJU1cFw+0BwNRS6WwRFl2Uhb10z4h8V8D3kK6d++/Y4/OWRgq8L
 mu6uFapgRXE0op2MDiyuI5a8b6mCxhk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-_IsJbITLORy3SMuZ_tY9Vg-1; Thu, 20 Feb 2020 08:06:21 -0500
X-MC-Unique: _IsJbITLORy3SMuZ_tY9Vg-1
Received: by mail-wm1-f69.google.com with SMTP id y7so578873wmd.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pVKWVWwp9TVJU5qM7Beut+kG2DV5MFLYTF1Kx3cmH3A=;
 b=BBE8bw9yxRb1pHTbcelyXHYX7Vt5M72h3Jj+5fdr+hUE+NnqTL6eXh0m9lIt/7Fj8l
 vwUmVzD/3hfgrsi30kudUKOiKvG21eZSYgPkXRwsI/C8B0YsBPqve6z/jrt2PQpljLhK
 teRy5gWveedTcpuD9kFVH73TD2yFyF9Mq8yZ5TMHl+nA+Kq9qRx58Go0w+RTg3WCaNeS
 65hTxN+FJTbA7Y7/1dZggoWC7Sk89xPeyWXUth8uiFIUgeaLWlC3fuocJGxl0laLrdgk
 x8MSSDboP5w9AZyIpgjjflsUkFl3z7y8Sw47W4BX+tHDFRoBgK/lPfmI3bpi3J5kjibH
 3C4Q==
X-Gm-Message-State: APjAAAUiRMdRflJrMdXJMVJ7OtPkHEzZGJL3AyUcwoW+LgMhY4avEOh/
 wPrpFknxCgGgsgAfM2xD3/LwUzLOELwrUZeRqGx4tSFU3H3jaKTXCelYdoJ1X1zFjD6Ca3hQ6R3
 rXFsxnzz/fBXIG/k=
X-Received: by 2002:a5d:4687:: with SMTP id u7mr40881742wrq.176.1582203980253; 
 Thu, 20 Feb 2020 05:06:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfQdFudKu/IvbI9dQMK95qUdVs2MjCpL2sBTVu5yezv4G1pdvxpKJvTb+aMe+m36JC5h7NRg==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr40881691wrq.176.1582203979939; 
 Thu, 20 Feb 2020 05:06:19 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 07/20] hw/net: Avoid casting non-const pointer,
 use address_space_write()
Date: Thu, 20 Feb 2020 14:05:35 +0100
Message-Id: <20200220130548.29974-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NetReceive prototype gets a const buffer:

  typedef ssize_t (NetReceive)(NetClientState *, const uint8_t *, size_t);

We already have the address_space_write() method to write a const
buffer to an address space. Use it to avoid:

  hw/net/i82596.c: In function =E2=80=98i82596_receive=E2=80=99:
  hw/net/i82596.c:644:54: error: passing argument 4 of =E2=80=98address_spa=
ce_rw=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer targ=
et type [-Werror=3Ddiscarded-qualifiers]

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/coccinelle/exec_rw_const.cocci | 14 ++++++++++++++
 hw/net/dp8393x.c                       |  3 +--
 hw/net/i82596.c                        |  4 ++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/ex=
ec_rw_const.cocci
index a0054f009d..4e459d915b 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -1,6 +1,20 @@
 // Usage:
 //  spatch --sp-file scripts/coccinelle/exec_rw_const.cocci --dir . --in-p=
lace
=20
+// Use address_space_write instead of casting to non-const
+@@
+type T;
+const T *V;
+expression E1, E2, E3, E4;
+@@
+(
+- address_space_rw(E1, E2, E3, (T *)V, E4, 1)
++ address_space_write(E1, E2, E3, V, E4)
+|
+- address_space_rw(E1, E2, E3, (void *)V, E4, 1)
++ address_space_write(E1, E2, E3, V, E4)
+)
+
 // Remove useless cast
 @@
 expression E1, E2, E3, E4;
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a134d431ae..580ae4437e 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -787,8 +787,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
     /* Put packet into RBA */
     DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
     address =3D dp8393x_crba(s);
-    address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, rx_len, 1);
+    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED, buf, rx_l=
en);
     address +=3D rx_len;
     address_space_rw(&s->as, address,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 3a0e1ec4c0..a292984e06 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -640,8 +640,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_=
t *buf, size_t sz)
             }
             rba =3D get_uint32(rbd + 8);
             /* printf("rba is 0x%x\n", rba); */
-            address_space_rw(&address_space_memory, rba,
-                MEMTXATTRS_UNSPECIFIED, (void *)buf, num, 1);
+            address_space_write(&address_space_memory, rba,
+                                MEMTXATTRS_UNSPECIFIED, buf, num);
             rba +=3D num;
             buf +=3D num;
             len -=3D num;
--=20
2.21.1


