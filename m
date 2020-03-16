Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D26C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4FE20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo5R2g30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4FE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvBm-0008SP-LI
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuqI-0002C5-DO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuqH-0002Gq-Bz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54921)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuqH-0002Eb-7P
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7saW0lUMlIpBkC9nkeABH78vi2gIhiCg17Oi76zLWlE=;
 b=bo5R2g3087H9owdyLYjATCH6T3eWrz3KpZ0/O+xYUOAMTwDSpV0g6Uva70jsHBsBrPp+X5
 mTV6b+s3vXWwI7faNnZWCsVwiYqDFrDIK24pBgCud/IBPsUfn6m4dJpbB8FO5ICWCGnFOS
 CZA952ALMorBTHf5o52iXvSc9ih+SlM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-h4i9B59kOXetzTfGBReSmg-1; Mon, 16 Mar 2020 14:51:58 -0400
X-MC-Unique: h4i9B59kOXetzTfGBReSmg-1
Received: by mail-wr1-f70.google.com with SMTP id u18so9389483wrn.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QoeDp95rhSeqOCx6yt/pZwQZkXPtM1sdq4xaQ9mSdFE=;
 b=h3aGVWPDS0o5Js3CidpK6I/9tnU1jbaWdU1rQ1MCItgwSC3ziZfrA1oLxOicasEBWe
 1MD4THqWCFFRl9yNpz48C5w9cWgkUj8Grpgzbha0glphq2Zl/U8vURvMRcntgTv61g0n
 /4KmDhdV7QXGGBwA9/jI2x7nr/aHYSfNlh0XSN27vKi6GfSvn9gXowIvzb8DEohWlQyL
 +08ouxmXQNlhAdxZ+85rzH5fhBkKcMxdJlpV5yR3NjE0HXJIhnFQJRWBLievu9qylPDR
 xSe6Mz+0JdALmoVOARu6T2IxJODLNvv3EX6gxw6J7481Fu6O10DMxra/a2h9djUfo2Hr
 ruzw==
X-Gm-Message-State: ANhLgQ1/yU2vkm88ZVKQQNNCnTea4U8v7rYMCCA18G/jo/9NzLYrFl2c
 ++dNPIhUhXL/SwL80sTPDQFGWTzANgY8+vhbps2CaFODg59ycOgNf/7i+H7DGuLLqZdNvJAfBjG
 dbOG7lFpk/U+CWD4=
X-Received: by 2002:adf:fd92:: with SMTP id d18mr820967wrr.342.1584384717416; 
 Mon, 16 Mar 2020 11:51:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvHiMyzQJBhIjrgn79306jr9XzhYtnTKRpX8ufMugmEPB0QdPSY1Q3K49hZAePtMSoci5d7BQ==
X-Received: by 2002:adf:fd92:: with SMTP id d18mr820953wrr.342.1584384717274; 
 Mon, 16 Mar 2020 11:51:57 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id c5sm27146659wma.3.2020.03.16.11.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 21/25] hw/char: Let devices own the MemoryRegion they create
Date: Mon, 16 Mar 2020 19:50:02 +0100
Message-Id: <20200316185006.576-22-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/serial.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 9298881af9..2ab8b69e03 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -997,7 +997,7 @@ static void serial_io_realize(DeviceState *dev, Error *=
*errp)
         return;
     }
=20
-    memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
+    memory_region_init_io(&s->io, OBJECT(dev), &serial_io_ops, s, "serial"=
, 8);
     sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
 }
@@ -1106,8 +1106,9 @@ static void serial_mm_realize(DeviceState *dev, Error=
 **errp)
         return;
     }
=20
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[smm->endianness], s=
mm,
-                          "serial", 8 << smm->regshift);
+    memory_region_init_io(&s->io, OBJECT(dev),
+                          &serial_mm_ops[smm->endianness], smm, "serial",
+                          8 << smm->regshift);
     sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
 }
--=20
2.21.1


