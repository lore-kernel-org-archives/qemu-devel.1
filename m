Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC27C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B192064C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGXGnjkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B192064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZqe-0007na-0A
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZf3-0000d0-7x
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZf2-0001bS-0y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZf1-0001Z8-Nc
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kUKKeAf2s8djmV5zny/Aq4FrGtcS96wgzcVBqpzxsI=;
 b=OGXGnjkBKitaM5lljrqyC2Hjyylr1n3AYJK3tDDITS7w/m9CmMvMXkrLFja/bTXsUwIXQS
 2+tKlSzbNkjUdNhC60B8fSaUjL4zpCSxJphyWzsPznMAGo+cDysq1rLEkBvYI2PEKxicg6
 pDna9v4Q3kRF4lGuYL89dcLCiE+ZNjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105--h2u7_6uOF6RjR-my6orjA-1; Thu, 09 Jan 2020 10:23:45 -0500
X-MC-Unique: -h2u7_6uOF6RjR-my6orjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E57231800D4E;
 Thu,  9 Jan 2020 15:23:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE46980608;
 Thu,  9 Jan 2020 15:23:36 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/15] vl: Make current_machine a local variable
Date: Thu,  9 Jan 2020 16:21:33 +0100
Message-Id: <20200109152133.23649-16-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-1-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we now only use current_machine in vl.c, stop exporting
it as a global variable in "hw/board.h", and make it static
to vl.c.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/boards.h | 2 --
 vl.c                | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 61f8bb8e5a..b0c0d4376d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -59,8 +59,6 @@ void memory_region_allocate_system_memory(MemoryRegion =
*mr, Object *owner,
 #define MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(MachineClass, (klass), TYPE_MACHINE)
=20
-extern MachineState *current_machine;
-
 void machine_run_board_init(MachineState *machine);
 bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
diff --git a/vl.c b/vl.c
index 3ff3548183..7a69af4bef 100644
--- a/vl.c
+++ b/vl.c
@@ -214,6 +214,8 @@ static int default_sdcard =3D 1;
 static int default_vga =3D 1;
 static int default_net =3D 1;
=20
+static MachineState *current_machine;
+
 static struct {
     const char *driver;
     int *flag;
@@ -1164,8 +1166,6 @@ static int usb_parse(const char *cmdline)
 /***********************************************************/
 /* machine registration */
=20
-MachineState *current_machine;
-
 static MachineClass *find_machine(const char *name, GSList *machines)
 {
     GSList *el;
--=20
2.21.1


