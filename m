Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60FDC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9132D21655
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBCAYwGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9132D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJfA-0007Qd-M3
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBJde-0005ny-PF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBJdd-0005cu-OY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBJdd-0005cQ-Kz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583765053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjVDiMvKaocl8Din+nc7mp/r/0My9dmefhQMvzlaVNo=;
 b=gBCAYwGBD9qqpK1x3lrEMOwsu3vzZFbz+jLHggP0PC1QggpwXl7a1Vk6OG5+/VsTu2iqzd
 Ny3gIcoVwGfOZ/BjKrI5YWkzH3npqTpEYGeRUbNlG/WY3myZsWJ2/1Y+Ti2/rri00JQms3
 ZRQd4MqyhfHFD34ISO7Go/tUaLlB/To=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-gpHsFjWHPOu7fYDjj8K2rw-1; Mon, 09 Mar 2020 10:44:09 -0400
X-MC-Unique: gpHsFjWHPOu7fYDjj8K2rw-1
Received: by mail-wr1-f71.google.com with SMTP id t15so2455664wro.6
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P8KuP9OrG8BtXrx/fzHj4UNagOs/po4VT0J9aKDZx98=;
 b=h3WJ+AtYpxUb0eP+Rsqmsfboo3eCCYQsqqdpXLaB6m80G+6Qj7ls5aALDGgIT/Pkyp
 Uj4nsg3TYDtrEQX9WDGE4ufsWZEN0AD1ucozqLiHlRPgMX7lkK77aAPvvxdcl1xO3HMj
 lyD5UpE4eYjGuoNXRDVms3iHrYUkAOFoTDGhP4AlEdMcipd0bReWmWyEyHG1PZrjeerO
 hJjdlswxbOIqggApWx/kQv/3Vehf6KQqXvRs9V6pVRMRIK4VzpL7iMLb720ilRX+axl9
 mcA9d0crfc91GK2eI5RF3OJ3dtPfgKVumU8aYVvW4zF7itBez6R76Td9iYUqKb+yb916
 WNIA==
X-Gm-Message-State: ANhLgQ1V3EEqRAIZCk7GmqNlKzpPjeQlwm4vZ/IMIfgjl+BWi69fCW6w
 S9Rz5t8B/dazWn00M1MewudRCIwSjF6x5ogcDaO3NerlsyJDHmNI40PNkmPDoHOimwWEmMFf7vi
 o+ZjcebvliiT9PiI=
X-Received: by 2002:a5d:484e:: with SMTP id n14mr315145wrs.258.1583765048309; 
 Mon, 09 Mar 2020 07:44:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuFLzBxcEcBbAiOkEQ55iscV1EOeNz/i8+Ro53byf8egHcw40SBqvlC6aMOg3OxoN9BEA4hNQ==
X-Received: by 2002:a5d:484e:: with SMTP id n14mr315128wrs.258.1583765048160; 
 Mon, 09 Mar 2020 07:44:08 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id n13sm25648491wmd.21.2020.03.09.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 07:44:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/core/loader: Prohibit loading ROMs bigger than memory
 region
Date: Mon,  9 Mar 2020 15:43:50 +0100
Message-Id: <20200309144353.26457-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309144353.26457-1-philmd@redhat.com>
References: <20200309144353.26457-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must not write more data than the memory region size.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/loader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index d1b78f60cd..c67c483936 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1136,7 +1136,10 @@ static void rom_reset(void *unused)
             continue;
         }
         if (rom->mr) {
-            void *host =3D memory_region_get_ram_ptr(rom->mr);
+            void *host;
+
+            assert(memory_region_size(rom->mr) >=3D rom->datasize);
+            host =3D memory_region_get_ram_ptr(rom->mr);
             memcpy(host, rom->data, rom->datasize);
         } else {
             address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPECI=
FIED,
--=20
2.21.1


