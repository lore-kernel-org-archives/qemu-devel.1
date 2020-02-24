Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A93C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A0C218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWIGHcEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A0C218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kfn-00038W-3l
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Kef-0000mc-Mr
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Kee-0005zb-IU
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Kee-0005xJ-EF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHdRJiFy2+sRYmNBB/Zm10M7PeGOon/0i7FrH36WST8=;
 b=ZWIGHcEUiZDuNwtg2v2GKwV08cJ9n44qA5LPGWwETzkCswIojgjIFjdqml6F4BedXbVJGp
 wv58biN3Y+EIlp00JaExc9sUKOPFX7oyXFHCaeKRnj8kxULaRTtOVDTjWnFLcoYto5e60y
 SBp3BJt3RkV4OIvL2tax/SgUrpZosTo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464--QQwS5XwMqGtUEUlKIRSuA-1; Mon, 24 Feb 2020 15:48:37 -0500
X-MC-Unique: -QQwS5XwMqGtUEUlKIRSuA-1
Received: by mail-wm1-f70.google.com with SMTP id p26so237291wmg.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 12:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZClVMiunKveJxIk817JDRiraYdietQ4sjQAY6VMZbY4=;
 b=BX09sAXseuS9WyuZbLNG+xmMNqBKVDBuX4rDv7M3/yrBe6UdDVyxN6SffRMWs5H+SB
 6s/gS6dWl4h5BwRacHrT7FUKqi3MBWYnhcBb2lTBxLmRVLRIzXbgO/KsKesKOJJ3PbM9
 hBbyIYyT6i/1qmulz8EXmDja3C75D3RMDbntXmZZMPxCmlcDgUN00HWMwv7yi4EDJ5F2
 d+sswT53NVxc30/QgdRoWBRlRTMPWyB0xucQvHHs3u3+AATD8K2TPfqBGEMIPNpwS6y1
 oWDAxeshhALRFgbLC1ovFnOgNRu+CpkQ0QWUCp8JCxsK1zxqNnlxJcv1ZrsxDvQ5VlNB
 fYVw==
X-Gm-Message-State: APjAAAWuUkorluQBksnwAZ4UGxfOhim8E04xTk6nCEQFLeE4KJl9s+R/
 QoZHjTHSi+pEF7eWGgBq+Gjjvj7ig5gizw49w6pRqCPFGsfDe1X89umSNuKSpTMjlo7d3ggMnQB
 /Yyau38AumXAwcoU=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr68380866wrs.365.1582577316141; 
 Mon, 24 Feb 2020 12:48:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxB+Vm+i34MxlUQyPhCSr3BdJbqkJu1QAmnjdIH/eqSCWOoIPFgzbAU0Q5gnonM9PI843rig==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr68380843wrs.365.1582577315965; 
 Mon, 24 Feb 2020 12:48:35 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t81sm863436wmg.6.2020.02.24.12.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 12:48:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 02/32] memory: Simplify memory_region_init_rom_nomigrate()
 to ease review
Date: Mon, 24 Feb 2020 21:47:58 +0100
Message-Id: <20200224204828.23167-3-philmd@redhat.com>
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

memory_region_init_rom_nomigrate() has the same content than
memory_region_init_ram_shared_nomigrate(), with setting the
readonly mode. The code is easier to review as creating a
readonly ram/shared/nomigrate region.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 memory.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/memory.c b/memory.c
index ce1179874e..6a327a54ed 100644
--- a/memory.c
+++ b/memory.c
@@ -1659,19 +1659,8 @@ void memory_region_init_rom_nomigrate(MemoryRegion *=
mr,
                                       uint64_t size,
                                       Error **errp)
 {
-    Error *err =3D NULL;
-    memory_region_init(mr, owner, name, size);
-    mr->ram =3D true;
+    memory_region_init_ram_shared_nomigrate(mr, owner, name, size, false, =
errp);
     mr->readonly =3D true;
-    mr->terminates =3D true;
-    mr->destructor =3D memory_region_destructor_ram;
-    mr->ram_block =3D qemu_ram_alloc(size, false, mr, &err);
-    mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
-    if (err) {
-        mr->size =3D int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-    }
 }
=20
 void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
--=20
2.21.1


