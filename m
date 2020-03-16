Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8915C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B83F20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZEYh1nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B83F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvBT-000802-QQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDupZ-0000gu-Qo
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDupY-00062o-P8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDupY-0005wz-J4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sW3gH7UL9MrbkxAJw9PX37bnGNS1gH34ZmW3oFfVoTo=;
 b=BZEYh1nq1xocdSZzUUeOWtC2fzID8hXqoFJaWxbXrduX93VVJqVgaBSXhk+xgszkj0RzVu
 sp91z4Pg0Czlzs1an9e6/91FnPJrMy0cn9N6LC0za+kXd7Xpsecqk5OXVden1AKikGOaxW
 Jnr/SbBStr+xQAakVNjst9B0xZz/3Pw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Aa-Jack0PWWNT3eVWz9Ccg-1; Mon, 16 Mar 2020 14:51:12 -0400
X-MC-Unique: Aa-Jack0PWWNT3eVWz9Ccg-1
Received: by mail-wr1-f72.google.com with SMTP id t10so3162580wrp.15
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hNWi7LQpKVg6rdUUQBdGPXi6j/9C/ADRCO+rxBA6Etw=;
 b=sSVHUt3Cu1Ly3e1ducHxlsVL3/tgWF2So9Hz1Cykd4DMUwZUdNRf4TMI2io9RNGP72
 h3KFC+n1TJbXnhuW/xm/ZU79RSypxq1SnB9qLSZFvlf09ZByhEeOrRQmikxwoI0R+v1a
 6lzZBWUBw9WiLmAhQNG1dD/98UHcfsT0DPJJLbXOSuRYeVC8WlKykkVeze2rdb9TcvBl
 RnHs1drz7awINo2tOdu1ldT9caTHS0U3asQHLH0F99fUP3HxBfn89Mq+YPmHlpq+uVuO
 vLhWxf5GeLjqkNqXZqAR6XKF4IMeMp2rRWCZXHtAE6SoCZCClKw9lqb3I/ZfNvma66bi
 /xPQ==
X-Gm-Message-State: ANhLgQ1mLEd860qS5Gt8pXUHCK/GcTlWzWT+8Vd+qaIr+LNEbtXDgiUe
 2slBTJ4ElYNmv0e7GT+DGiR30BqWEjeGaBEBpy74S7AANPUqV32An7DaYofzplnjQ6sk8fH2wjP
 5WsNsOWB7LGighO8=
X-Received: by 2002:a7b:c950:: with SMTP id i16mr471308wml.97.1584384670959;
 Mon, 16 Mar 2020 11:51:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtM5WSWHcF1VIUqKXaCmF6ES2SzpH9PSOkRMzdXOffYUcUCXu53beeGadWeMQfEbxHh65RI+g==
X-Received: by 2002:a7b:c950:: with SMTP id i16mr471294wml.97.1584384670732;
 Mon, 16 Mar 2020 11:51:10 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id u7sm672496wme.43.2020.03.16.11.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 12/25] hw/sh4: Use memory_region_init_rom() with read-only
 regions
Date: Mon, 16 Mar 2020 19:49:53 +0100
Message-Id: <20200316185006.576-13-philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/sh4/shix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 68b14ee5e7..f410c08883 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -53,8 +53,7 @@ static void shix_init(MachineState *machine)
     cpu =3D SUPERH_CPU(cpu_create(machine->cpu_type));
=20
     /* Allocate memory space */
-    memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
-    memory_region_set_readonly(rom, true);
+    memory_region_init_rom(rom, NULL, "shix.rom", 0x4000, &error_fatal);
     memory_region_add_subregion(sysmem, 0x00000000, rom);
     memory_region_init_ram(&sdram[0], NULL, "shix.sdram1", 0x01000000,
                            &error_fatal);
--=20
2.21.1


