Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E40DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8B12072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VykcCIpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8B12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9unL-0004Jg-IE
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 13:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ukV-0008C6-0C
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ukT-0003B0-Pb
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ukT-0003A7-Kv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583431049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcfrRNhhNXvEb5Fsa8YSfU5JUFSi8stcMlq7fuF9rdY=;
 b=VykcCIpQLjYvOY7BkNfI2rK2MTg+sfoOZHOjZcysjbzblhejNw+nw9fN4HaJCvL/Okk7WP
 2wcdVw/RITjat9G2OJZYV2dx9+O6RFdGUMOPJUX6UpwBuSqC1WChEC+/GEpYGAXls9KzQ/
 qJX0GDoPlGxtkh1PyTm5a43Ez7vJpH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-XthAtOcEPYO_-llMcphPYA-1; Thu, 05 Mar 2020 12:57:27 -0500
X-MC-Unique: XthAtOcEPYO_-llMcphPYA-1
Received: by mail-wr1-f69.google.com with SMTP id m13so2609864wrw.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mt1XTfo73c5zQuFOCOurVKN5VFy185lbQ50F1P0uJNg=;
 b=OZ1FoAe2KIK25q7amFuDhwXtPqyB4uaMAdEhbu5HXNNL2/MmhQJYa8sfss/szoclUi
 T6knkGy6c/M+sRrQhGPPR4iESuEFq34stREOKIDJKgY8GmCumEKYe36J35M7adEY6qsB
 ew+xxFURS3ypVRkfPNGAkhA2DzZA/QHgFp8QyP5bgCH+hCoIaUI3SkChcpRlIiXGVmFU
 ftMUJihwjD1woN67bNmd66IzjSh4jSM/oRaOECofZnJjGeTm0OPWcT7TEYvPXWgWPyqP
 mZh5pLlOydaF0in3mUrwP+KjkN3dM6QssRTj7RFZ7WawPOC0DnanTwP6m6/kM26kYlxc
 Fs6Q==
X-Gm-Message-State: ANhLgQ0L3veRf7kHX9IRrexe6nVQvYyYRo1EAl1TsqPTqecrQUStacxr
 6jl4CnFLkRedvzgFXDhKLplAJCeZw9NDJvWs8Esn2bm9vLvjHwFSbqbTl8MBw8L5P4dw66KjGRe
 HYlhqCzCtekkV/HY=
X-Received: by 2002:a05:600c:301:: with SMTP id
 q1mr11021037wmd.182.1583431044210; 
 Thu, 05 Mar 2020 09:57:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvpSsAuRNIRWDFI9KBcRbWOUJFR4P0DhG3CflzNt8axmmml7Br4FITbn9yy8XmJbX93mHD63Q==
X-Received: by 2002:a05:600c:301:: with SMTP id
 q1mr11021018wmd.182.1583431044028; 
 Thu, 05 Mar 2020 09:57:24 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q3sm9545210wmj.38.2020.03.05.09.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 09:57:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] hw/net/can: Make CanBusClientInfo::can_receive() return a
 boolean
Date: Thu,  5 Mar 2020 18:56:50 +0100
Message-Id: <20200305175651.4563-7-philmd@redhat.com>
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

The CanBusClientInfo::can_receive handler return whether the
device can or can not receive new frames. Make it obvious by
returning a boolean type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/can/can_sja1000.h | 2 +-
 include/net/can_emu.h    | 2 +-
 hw/net/can/can_sja1000.c | 8 ++++----
 net/can/can_socketcan.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h
index 220a622087..7ca9cd681e 100644
--- a/hw/net/can/can_sja1000.h
+++ b/hw/net/can/can_sja1000.h
@@ -137,7 +137,7 @@ void can_sja_disconnect(CanSJA1000State *s);
=20
 int can_sja_init(CanSJA1000State *s, qemu_irq irq);
=20
-int can_sja_can_receive(CanBusClientState *client);
+bool can_sja_can_receive(CanBusClientState *client);
=20
 ssize_t can_sja_receive(CanBusClientState *client,
                         const qemu_can_frame *frames, size_t frames_cnt);
diff --git a/include/net/can_emu.h b/include/net/can_emu.h
index d4fc51b57d..fce9770928 100644
--- a/include/net/can_emu.h
+++ b/include/net/can_emu.h
@@ -83,7 +83,7 @@ typedef struct CanBusClientState CanBusClientState;
 typedef struct CanBusState CanBusState;
=20
 typedef struct CanBusClientInfo {
-    int (*can_receive)(CanBusClientState *);
+    bool (*can_receive)(CanBusClientState *);
     ssize_t (*receive)(CanBusClientState *,
         const struct qemu_can_frame *frames, size_t frames_cnt);
 } CanBusClientInfo;
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 39c78faf9b..ea915a023a 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -733,21 +733,21 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr =
addr, unsigned size)
     return temp;
 }
=20
-int can_sja_can_receive(CanBusClientState *client)
+bool can_sja_can_receive(CanBusClientState *client)
 {
     CanSJA1000State *s =3D container_of(client, CanSJA1000State, bus_clien=
t);
=20
     if (s->clock & 0x80) { /* PeliCAN Mode */
         if (s->mode & 0x01) { /* reset mode. */
-            return 0;
+            return false;
         }
     } else { /* BasicCAN mode */
         if (s->control & 0x01) {
-            return 0;
+            return false;
         }
     }
=20
-    return 1; /* always return 1, when operation mode */
+    return true; /* always return true, when operation mode */
 }
=20
 ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *f=
rames,
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 29bfacd4f8..807f31fcde 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -110,9 +110,9 @@ static void can_host_socketcan_read(void *opaque)
     }
 }
=20
-static int can_host_socketcan_can_receive(CanBusClientState *client)
+static bool can_host_socketcan_can_receive(CanBusClientState *client)
 {
-    return 1;
+    return true;
 }
=20
 static ssize_t can_host_socketcan_receive(CanBusClientState *client,
--=20
2.21.1


