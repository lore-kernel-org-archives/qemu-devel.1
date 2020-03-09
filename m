Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26575C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37DE2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxZonJKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37DE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJh6-0001e9-49
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBJdo-00062i-Dh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBJdn-0005mG-Fj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBJdm-0005l2-Ow
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583765062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9+vgh2euI+Dmqqtc/kbt6PdfOhRZd20+tUCvyB95MY=;
 b=ZxZonJKX3LbCwJTZYWY6BN9sUoWb1fneBXyomP4LnYE5wvN6GPxlxukxHTF0UEyRfBJBnO
 r1092v52PR9DJRGvG3/JMhknliCBLUnyStgm+vPPU5qlXfP/FpFU+Z99sXmkY2CM+VFs2X
 3edZjBE7K3AkZdoNOgCcPXvukCIKJq0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-hK_RvZEBOyaoN_453utUsQ-1; Mon, 09 Mar 2020 10:44:21 -0400
X-MC-Unique: hK_RvZEBOyaoN_453utUsQ-1
Received: by mail-wm1-f69.google.com with SMTP id t2so2535099wmj.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qHr/DzfB6J+jo6ln0ZP0olKu4gW+fEwhnKJ5rlEi9x8=;
 b=IYa6K0NSe/9TKD3ntBU2OfLezp1FHz+z+g7xdnCAAwgjK5kd/hNztCdaNDXZ3eptDt
 hZGQ791+c7TXDrxr2o9Eu+sRX+2Zi+4Tifj4bQ38HT8vMateFAwZ2SGSJ1zL5nlMOp4D
 YFP4XJn7gPyJDZOfCaBvFqf2J2hF0yOFQw5Rl1vTa3bQ69dE9O1TgjJqCdDGEhle4a4r
 zVndjOp6jtxTEK4nNNDDjBHM/0yIFDK8vcgxunfi0sIassdAcjDK0gwzLybQ5hSTz2Hj
 Iwkyny6V8PaHkXFMBGwX+jKvP3d7B2Q6rXn09QgMmQz7FwQJaQhxpX1/6Wgkv6FIh4Yb
 djbw==
X-Gm-Message-State: ANhLgQ0zxBY4tE3IghuTYGat7H8l3SrhgTgouc+fGuhNmk8v97yOUHpD
 msypRDtXyAUQQ1jWbvj4kMcTO+6bPuGbNmyvYNPtyYZ5/yyvX28kCYvQFl5UcL72SUaeM4TJOiY
 L44peQPe6HGym/sg=
X-Received: by 2002:a1c:4604:: with SMTP id t4mr19791976wma.164.1583765059520; 
 Mon, 09 Mar 2020 07:44:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu8sYnBb1NaFzH5s/sen8uO42g7X2inHd4yqY1m8VxWFX1t1kOOeKJgTtcQklEXdgumb+BiKg==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr19791951wma.164.1583765059281; 
 Mon, 09 Mar 2020 07:44:19 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id 61sm11902260wrd.58.2020.03.09.07.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 07:44:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/core/loader: Restrict rom_add_file_mr() to available
 region size
Date: Mon,  9 Mar 2020 15:43:52 +0100
Message-Id: <20200309144353.26457-5-philmd@redhat.com>
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
X-Received-From: 205.139.110.120
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

Use the ''max_size' argument recently added to rom_add_file() to
not load ROMs bigger than the underlying memory region.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/loader.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 99d690a628..34ac630eb1 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -297,7 +297,7 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict);
 #define rom_add_blob_fixed(_f, _b, _l, _a)      \
     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL, true)
 #define rom_add_file_mr(_f, _mr, _i)            \
-    rom_add_file(_f, NULL, 0, -1, _i, false, _mr, NULL)
+    rom_add_file(_f, NULL, 0, memory_region_size(_mr), _i, false, _mr, NUL=
L)
 #define rom_add_file_as(_f, _as, _i)            \
     rom_add_file(_f, NULL, 0, -1, _i, false, NULL, _as)
 #define rom_add_file_fixed_as(_f, _a, _i, _as)          \
--=20
2.21.1


