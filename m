Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0480C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB58A21556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H11yiI9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB58A21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KjZ-0002gp-UE
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Kes-0001J0-1g
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Keq-0006Dd-GN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38236
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Keq-0006Cx-CQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AksPoeIdaQJuU1Oxkwgd0bzdhJ7x56x3M7zV8fEB+j0=;
 b=H11yiI9NyRyEjy607sjRRKePJ8Nx2fa8sizZY6eGVdZWX3kIumxhlUhoj/n6uLLhxuae4L
 TwETNiOPSkr/modu88LckxAhQmvaNQFRQcQZR8l5xNEdBu5ybOn9ue+ZiVOQ2RZkzqz2hx
 GtF/GNC3Mbp3RDEMZCXG3ghjyUzd/u0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-UZu4YTRyP9aDT5WZPHjJ5A-1; Mon, 24 Feb 2020 15:48:50 -0500
X-MC-Unique: UZu4YTRyP9aDT5WZPHjJ5A-1
Received: by mail-wr1-f70.google.com with SMTP id s13so6132691wru.7
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 12:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ha2K59BdbMBaPgTkM1MITzm+jr6shpDFkGmxbgwDocM=;
 b=VE5xfWS4hj/z332fBjEhkZaLkSmKRmEuyiHtip3agO2ow2b5BX7dlHHzDkelMd1bav
 N77jamJ7L3lw9ms8CqAaptaHgNXGjDM/n0q8B4jPNwKRFa4nQ6a54lp/XfI0wwfLbMSz
 oY5KYx7Igx5TTbV9k5SwbTYmGqou7xmr56KqIVGblGnkr6si21IrFC/n4IrOJhOsp23z
 gyBAS9prPyh04/4FN02IUZ5t2VChvEpp9B+lyaE08fpjhVrApMWq22JcApjihMkT/8bo
 Xj3cdKWuRjJzwyderzE7CWNHG1ahT++bq9xzl8SwLI2KpI6LZia7zXe+f14Uv9ihKUO8
 Zqgw==
X-Gm-Message-State: APjAAAUjNMYZN7H0tMdI3JoSRWExcIrgiG9woFuSiPya5iw30CVvwqvg
 6vUr/PxGsT/AtHhRfNFCkxowUOh2OqAxvaq/9/KTElh9XUZ7zignhSqqBozC2ntAynlCH1IpmBu
 NEv6cMTJ6bZl6foY=
X-Received: by 2002:a5d:4709:: with SMTP id y9mr68557423wrq.412.1582577329160; 
 Mon, 24 Feb 2020 12:48:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy94tnLOr/k7TqopZFvWggJ1kMp+bNN2jjEe23udNlHUPVJaEyhMqg9AkFDXWB9KXDZbOdnYg==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr68557395wrq.412.1582577328984; 
 Mon, 24 Feb 2020 12:48:48 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t81sm863436wmg.6.2020.02.24.12.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 12:48:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 08/32] hw/m68k: Use memory_region_init_rom() with read-only
 regions
Date: Mon, 24 Feb 2020 21:48:04 +0100
Message-Id: <20200224204828.23167-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224204828.23167-1-philmd@redhat.com>
References: <20200224204828.23167-1-philmd@redhat.com>
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/m68k/q800.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 1e32363688..8083326d37 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -402,13 +402,12 @@ static void q800_init(MachineState *machine)
         uint8_t *ptr;
         /* allocate and load BIOS */
         rom =3D g_malloc(sizeof(*rom));
-        memory_region_init_ram(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
+        memory_region_init_rom(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
                                &error_abort);
         if (bios_name =3D=3D NULL) {
             bios_name =3D MACROM_FILENAME;
         }
         filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-        memory_region_set_readonly(rom, true);
         memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom)=
;
=20
         /* Load MacROM binary */
--=20
2.21.1


