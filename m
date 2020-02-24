Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD7C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711B3218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqVLEnns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711B3218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kfr-0003Oe-Ig
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Kej-0000vS-H2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Kei-000646-Cc
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Kei-00063j-91
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxC+1Wm7lZTcIVTNIaK8R7xk0TXOBYBpGoQjSWP/PII=;
 b=NqVLEnnsg78r+aABrJoVQazeHYfj/FgReavidfMKwPl03+0yYKgULibBPkEeix0UO55Ecw
 wsbeqGHbYLW+CHdmidz53OmnIk53yjrwf/j6dtBabwYDtSoGzrxpnNMER3a72IV1nGTbqB
 Lsn+8G7r6MdNi5igTtCBzNQkPJrxB4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-razanunqNReFVWwEx6iCgw-1; Mon, 24 Feb 2020 15:48:39 -0500
X-MC-Unique: razanunqNReFVWwEx6iCgw-1
Received: by mail-wm1-f70.google.com with SMTP id g26so236093wmk.6
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 12:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gxYYROcVaswdAAx61tJuJg4MU34WxQsacT4wWudpNIs=;
 b=jMaWAx/tOE9fGHG3SCstUFg12aKMQYVvSeZxhQZI39awhm9TCHg314ncQPfZAYFxv8
 uHlwMAmw/gnpoJS25zaaVvshS93JaQkzVh1jhD55iEq4WMHhltpOmMFcvgLISlProo99
 sU1hcQ0XIyRY63u7fB9wTWNy1xwrGrmpIaDDFV6PHtBhs7eoE7iCAwmLPeLz5F5xb4o4
 +2l6bx559+JBwLwoQprbHadGljwRzEkdc4ZBnUQMhWFEN3vb+zZBYAii1h0Ef7GM8y38
 v6PwaB3xAVQKbTlYD3IP/AtlISzbibeSRe4wA298vy6Jl1MqeckG794s3WtaMaQXWwBs
 q/ew==
X-Gm-Message-State: APjAAAWW6gIItTrbC9P7xYqz1nlF3F592bgf7ZOho163CMibg0GuA3z+
 kBYJPuQvmzzOWwKD7a3pWAaWfwBX3FPEbZE36X/FXkke9bkxR3g4ZwHEnvs2gOk9XbXfRG6Z33C
 K2Xf/C2cFPERUJmI=
X-Received: by 2002:a1c:988c:: with SMTP id a134mr754281wme.163.1582577318815; 
 Mon, 24 Feb 2020 12:48:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzF5UQ/qMSypEffTZ4LT2TIQPI6VnHE6rztTv1MazMcJxwUbIcYMiiwSsJE1b22ph9AcNyntA==
X-Received: by 2002:a1c:988c:: with SMTP id a134mr754255wme.163.1582577318492; 
 Mon, 24 Feb 2020 12:48:38 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t81sm863436wmg.6.2020.02.24.12.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 12:48:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 03/32] scripts/cocci: Rename memory-region-{init-ram ->
 housekeeping}
Date: Mon, 24 Feb 2020 21:47:59 +0100
Message-Id: <20200224204828.23167-4-philmd@redhat.com>
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

As we are going to add various semantic changes related to the memory
region API, rename this script to be more generic.
Add a 'usage' header, and an entry in MAINTAINERS to avoid checkpatch
warning.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 ...t-ram.cocci =3D> memory-region-housekeeping.cocci} | 13 +++++++++++++
 MAINTAINERS                                         |  1 +
 2 files changed, 14 insertions(+)
 rename scripts/coccinelle/{memory-region-init-ram.cocci =3D> memory-region=
-housekeeping.cocci} (84%)

diff --git a/scripts/coccinelle/memory-region-init-ram.cocci b/scripts/cocc=
inelle/memory-region-housekeeping.cocci
similarity index 84%
rename from scripts/coccinelle/memory-region-init-ram.cocci
rename to scripts/coccinelle/memory-region-housekeeping.cocci
index d290150872..3699c1017e 100644
--- a/scripts/coccinelle/memory-region-init-ram.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -1,3 +1,16 @@
+/*
+  Usage:
+
+    spatch \
+        --macro-file scripts/cocci-macro-file.h \
+        --sp-file scripts/coccinelle/memory-region-housekeeping.cocci \
+        --keep-comments \
+        --in-place \
+        --dir .
+
+*/
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
diff --git a/MAINTAINERS b/MAINTAINERS
index 195dd58cac..316a8edbb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1998,6 +1998,7 @@ F: include/exec/ramblock.h
 F: memory.c
 F: include/exec/memory-internal.h
 F: exec.c
+F: scripts/coccinelle/memory-region-housekeeping.cocci
=20
 SPICE
 M: Gerd Hoffmann <kraxel@redhat.com>
--=20
2.21.1


