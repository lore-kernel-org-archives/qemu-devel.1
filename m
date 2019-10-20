Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE30CA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E9A20869
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 23:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCZJC8OZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E9A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMKPi-0006vu-KG
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 19:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMKBS-0001iT-RL
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMKBR-0001XA-2l
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:00:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMKBQ-0001Ws-T9
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 19:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571612420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LBfcXdZi7rmaayMUIJe621EviYh+sNbuG1duBKXRdNY=;
 b=SCZJC8OZ3ADs7OYyklSAdLQboARsYvBuWE2Lpmv/JX4xhiWwaDMLXcQnqz1zfqVzKoxkKm
 Mcth87pAzT/Wy9xZJndLuSNMEqTCsyEnzo31z1SAVbhZrM2COmA1EvCUBv6Ql9CZQS9u2p
 ve2LBvHrokzyM0fbMlEHxRgjOqoHpGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-8yE4KQl8NF6B_y0XkBCCtQ-1; Sun, 20 Oct 2019 19:00:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 999DB800D41;
 Sun, 20 Oct 2019 23:00:12 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BFD860C18;
 Sun, 20 Oct 2019 22:59:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 09/21] hw: Let memory_region_allocate_system_memory take
 MachineState argument
Date: Mon, 21 Oct 2019 00:56:38 +0200
Message-Id: <20191020225650.3671-10-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8yE4KQl8NF6B_y0XkBCCtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All the codebase calls memory_region_allocate_system_memory() with
a NULL 'owner' from the board_init() function.
Let pass a MachineState argument, and enforce the QOM ownership of
the system memory.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/numa.c      | 11 +++++++----
 include/hw/boards.h |  6 ++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 038c96d4ab..2e29e4bfe0 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -520,21 +520,24 @@ static void allocate_system_memory_nonnuma(MemoryRegi=
on *mr, Object *owner,
     vmstate_register_ram_global(mr);
 }
=20
-void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
+void memory_region_allocate_system_memory(MemoryRegion *mr, MachineState *=
ms,
                                           const char *name,
                                           uint64_t ram_size)
 {
     uint64_t addr =3D 0;
     int i;
-    MachineState *ms =3D MACHINE(qdev_get_machine());
+
+    if (!ms) {
+        ms =3D MACHINE(qdev_get_machine());
+    }
=20
     if (ms->numa_state =3D=3D NULL ||
         ms->numa_state->num_nodes =3D=3D 0 || !have_memdevs) {
-        allocate_system_memory_nonnuma(mr, owner, name, ram_size);
+        allocate_system_memory_nonnuma(mr, OBJECT(ms), name, ram_size);
         return;
     }
=20
-    memory_region_init(mr, owner, name, ram_size);
+    memory_region_init(mr, OBJECT(ms), name, ram_size);
     for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
         uint64_t size =3D ms->numa_state->nodes[i].node_mem;
         HostMemoryBackend *backend =3D ms->numa_state->nodes[i].node_memde=
v;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index de45087f34..3b6cb82b6c 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -14,7 +14,7 @@
 /**
  * memory_region_allocate_system_memory - Allocate a board's main memory
  * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count
+ * @ms: the #MachineState object that own the system memory
  * @name: name of the memory region
  * @ram_size: size of the region in bytes
  *
@@ -38,8 +38,10 @@
  * Smaller pieces of memory (display RAM, static RAMs, etc) don't need
  * to be backed via the -mem-path memory backend and can simply
  * be created via memory_region_init_ram().
+ *
+ * The #MachineState object will track the region's reference count.
  */
-void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
+void memory_region_allocate_system_memory(MemoryRegion *mr, MachineState *=
ms,
                                           const char *name,
                                           uint64_t ram_size);
=20
--=20
2.21.0


