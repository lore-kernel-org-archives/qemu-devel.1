Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0088C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA33B20675
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPSO6Zyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA33B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHn33-00033s-TA
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHmwf-0001B1-KZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHmwe-00024d-Ee
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHmwe-00024G-AN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585307676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IfY2ZtlHiL4jateNZsER6EbnuIhItjbibF6E20oqA9o=;
 b=FPSO6Zytbm0kTuHhLCWULsmQRmmhtwebxViGwr+UBHZK59/4Xv9aVCzPEZXFdhlXaFs5JJ
 kQof5dlhp2zMv47SeUBp8yvwkvmNRECA78R1IC+y0BfbMjN7WqSKAClf00djVc60SP/CdX
 Do5vX3KFqPZ+zNHvTJL+WL2yW3IQztI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Z9M-zn0fMr2xy0fQZYsb7g-1; Fri, 27 Mar 2020 07:14:31 -0400
X-MC-Unique: Z9M-zn0fMr2xy0fQZYsb7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE7BA1005509;
 Fri, 27 Mar 2020 11:14:30 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-77.pek2.redhat.com
 [10.72.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3886E5E01F;
 Fri, 27 Mar 2020 11:14:28 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 09/13] hw/net/can: Make CanBusClientInfo::can_receive() return
 a boolean
Date: Fri, 27 Mar 2020 19:14:03 +0800
Message-Id: <1585307647-24456-10-git-send-email-jasowang@redhat.com>
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

The CanBusClientInfo::can_receive handler return whether the
device can or can not receive new frames. Make it obvious by
returning a boolean type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/can/can_sja1000.c | 8 ++++----
 hw/net/can/can_sja1000.h | 2 +-
 include/net/can_emu.h    | 2 +-
 net/can/can_socketcan.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 39c78fa..ea915a0 100644
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
diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h
index 220a622..7ca9cd6 100644
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
index d4fc51b..fce9770 100644
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
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 29bfacd..807f31f 100644
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
2.5.0


