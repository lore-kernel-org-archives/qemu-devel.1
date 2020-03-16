Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710AC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0D120679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnHk+Fa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0D120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvIf-0003PH-MW
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDupS-0000P3-Kx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDupR-0004f2-Gh
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDupR-0004as-BC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyRumdv7o8mjHGVNOOLf3anSbfYPjmYQMfiM+qbhAcE=;
 b=NnHk+Fa9Z4jR8WwkYFneLpx5iNoJ7dKay4U6R47buw3RPbDHiKEW9EDlOy+YtkZ2B7X6gL
 /O4VusGGTRha4kn4UoQqc2TMHNcSSXLVO0NbYr5LosFqOi9zrTbAxqsAlosB/751HLhYf/
 j/EUpYQdOePYHpkR3lmVZHd+0As18iY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-CMjTCkpJOsK_4a6_k2ezUg-1; Mon, 16 Mar 2020 14:51:06 -0400
X-MC-Unique: CMjTCkpJOsK_4a6_k2ezUg-1
Received: by mail-wr1-f69.google.com with SMTP id w11so9464888wrp.20
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gL3h6ZksVMeXBRgyMt6g9kMfQEpNuOznE3swIyLz84E=;
 b=kAOoyzgg04qAyIivGbNCnUnuHqRURalNFuAt0BQRVVG4CSuK/ZD/IPytk6l3RlLTzo
 JPgGkBVfbz4a7YOq6fRcwfU6tw2ve5/EcuEDPJQj/cZXa8umrCblJtmskFx6dqpq0LbN
 LJjRatuxMtkzA0YwXxOGJgXeTjYkVds2iJv4x8ivOKdlgMaHXOhrWzFhx7JJLyZNEzYe
 DmV7u3a4gGiBqf/BiuMFP6BiiFw6u6o+1UqBu5uCuKiRq4Tudm481SEIzA80303Oa6PK
 9qXclL/TFIV7L78MmrqDAcqFss2mtV8u1n1b6u7ltH+W1JZ0HDo/+FMUqyKMCqvYZvX0
 m1vw==
X-Gm-Message-State: ANhLgQ2ZnHgtkFhdFnZeAnGAW0glhYh0Bse3d7uI3ITcIz5wdRgcTM6a
 dzX1NjsF5gjJBT5eQBOimdeQ6ZDJy4qnjbqQgZmVZNWTltibojt0zv60NZ2aD22WmuKEZotEz5x
 OQubMCgMlmwoD5Dg=
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr481676wmf.35.1584384665784; 
 Mon, 16 Mar 2020 11:51:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvNaIHGQ9I8m8ytYUjaU7litKg/SGzMQ6NhVLbSVjMAg5iQYGy3QqbxmPYWBwo64dYck+gg3g==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr481640wmf.35.1584384665537; 
 Mon, 16 Mar 2020 11:51:05 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id g7sm1105206wrq.21.2020.03.16.11.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 11/25] hw/riscv: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 16 Mar 2020 19:49:52 +0100
Message-Id: <20200316185006.576-12-philmd@redhat.com>
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
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/riscv/sifive_e.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index a254cad489..a1974ef7be 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -208,9 +208,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev=
, Error **errp)
         memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
=20
     /* Flash memory */
-    memory_region_init_ram(&s->xip_mem, NULL, "riscv.sifive.e.xip",
-        memmap[SIFIVE_E_XIP].size, &error_fatal);
-    memory_region_set_readonly(&s->xip_mem, true);
+    memory_region_init_rom(&s->xip_mem, NULL, "riscv.sifive.e.xip",
+                           memmap[SIFIVE_E_XIP].size, &error_fatal);
     memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
         &s->xip_mem);
 }
--=20
2.21.1


