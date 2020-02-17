Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B4C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A21C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4WvAslq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A21C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dT6-00081c-FI
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3dSI-0007PI-Of
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3dSH-0003A0-6t
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:16:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3dSH-00038y-2K
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581934604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IUaVcGjN28qdV/RxtUDKDL/AV+GNVJZv0wUdvWNIeo0=;
 b=E4WvAslqWcNAkCN8oY5kzTF9ZYziZwiVplUZ//ndtA7vTeJZm13OL/h2UQiZrhnuuWh1pF
 8L71vbwGjvOusyVNjMx1AYeZdxdRK9YRJ39v0f8n8LKJIc8jtPO2CMW3JyLfh+UaW2k+Dg
 FdiHRyof2FOFM2x2QE5O5yHX6A2HnF4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-FHvigm66O8Cd5V6ghFvdvw-1; Mon, 17 Feb 2020 05:16:42 -0500
Received: by mail-wm1-f71.google.com with SMTP id f207so6813118wme.6
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 02:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xwLS+COmcR41GGeeIBPxB9dBo+JD9m5623Lo315G/CY=;
 b=uVUphjDnFWBUYVnL3KLuobQHDc+O9gP5ggZ5u8mc9qgtmc2R6iw4KHvH8/bmS5aoqh
 kA3JVXwJMIlncmKSRZhLZ6vf+JUk+mJ//O4UNhzfQxgaFMUVJMfG/w5+b0MGcv5I6/qj
 3ygzH4HhcMfanc+2Vlkm3S/ycP8qjW0KfWl9HTMutJxdlIyTJwUrsa9wxHG+l5hgsl3F
 c+YarwnM/QNslyFLegiV+3hXZfNZVu+kKWj2Q4DUC4mpmAqNOmdugbCw6BzmTji5cgR/
 TnsR43u0Y94YhKhSz5A+VLnLWfrx3RHnhEmXkauqGIiorNNxtUb1luW0uUvmtgNN2emU
 CkHw==
X-Gm-Message-State: APjAAAUlog67Frsg/r3qlXKgxJSzmgfMcJnaTQs++fTj0B2yclcfBohE
 xy+JjMhIdSPusrkE5DOZxnug9+7qUFu6+r6FHZ5pqKAnxzoLCurJfftatu5uauWRKdWzYjAz3wE
 KoTbw77kFe0qTHic=
X-Received: by 2002:a05:600c:410f:: with SMTP id
 j15mr20888146wmi.132.1581934600692; 
 Mon, 17 Feb 2020 02:16:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqx44WJz7H+E9nr52G5R5D5EYr5Wl+aipaNkgq5ZtCqdiZFcdQYkQ7axqELVlGqoYzOJXwMk+w==
X-Received: by 2002:a05:600c:410f:: with SMTP id
 j15mr20888116wmi.132.1581934600400; 
 Mon, 17 Feb 2020 02:16:40 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s23sm295486wra.15.2020.02.17.02.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 02:16:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/net/rocker: Report unimplemented feature with
 qemu_log_mask(UNIMP)
Date: Mon, 17 Feb 2020 11:16:37 +0100
Message-Id: <20200217101637.27558-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: FHvigm66O8Cd5V6ghFvdvw-1
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warnings reported by Clang static code analyzer:

    CC      hw/net/rocker/rocker.o
  hw/net/rocker/rocker.c:213:9: warning: Value stored to 'tx_tso_mss' is ne=
ver read
          tx_tso_mss =3D rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_MSS]);
          ^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/net/rocker/rocker.c:217:9: warning: Value stored to 'tx_tso_hdr_len' i=
s never read
          tx_tso_hdr_len =3D rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_HDR=
_LEN]);
          ^                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
  hw/net/rocker/rocker.c:255:9: warning: Value stored to 'tx_l3_csum_off' i=
s never read
          tx_l3_csum_off +=3D tx_tso_mss =3D tx_tso_hdr_len =3D 0;
          ^                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: dc488f888
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/rocker/rocker.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 81dd3b5f14..15d66f6cbc 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -27,6 +27,7 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
+#include "qemu/log.h"
=20
 #include "rocker.h"
 #include "rocker_hw.h"
@@ -207,14 +208,22 @@ static int tx_consume(Rocker *r, DescInfo *info)
=20
     if (tlvs[ROCKER_TLV_TX_L3_CSUM_OFF]) {
         tx_l3_csum_off =3D rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_L3_CSUM_=
OFF]);
+        qemu_log_mask(LOG_UNIMP, "rocker %s: L3 not implemented"
+                                 " (cksum off: %u)\n",
+                      __func__, tx_l3_csum_off);
     }
=20
     if (tlvs[ROCKER_TLV_TX_TSO_MSS]) {
         tx_tso_mss =3D rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_MSS]);
+        qemu_log_mask(LOG_UNIMP, "rocker %s: TSO not implemented (MSS: %u)=
\n",
+                      __func__, tx_tso_mss);
     }
=20
     if (tlvs[ROCKER_TLV_TX_TSO_HDR_LEN]) {
         tx_tso_hdr_len =3D rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_HDR_=
LEN]);
+        qemu_log_mask(LOG_UNIMP, "rocker %s: TSO not implemented"
+                                 " (hdr length: %u)\n",
+                      __func__, tx_tso_hdr_len);
     }
=20
     rocker_tlv_for_each_nested(tlv_frag, tlvs[ROCKER_TLV_TX_FRAGS], rem) {
@@ -249,12 +258,6 @@ static int tx_consume(Rocker *r, DescInfo *info)
         iovcnt++;
     }
=20
-    if (iovcnt) {
-        /* XXX perform Tx offloads */
-        /* XXX   silence compiler for now */
-        tx_l3_csum_off +=3D tx_tso_mss =3D tx_tso_hdr_len =3D 0;
-    }
-
     err =3D fp_port_eg(r->fp_port[port], iov, iovcnt);
=20
 err_too_many_frags:
--=20
2.21.1


