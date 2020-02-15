Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A123C7114E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECCB2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik/OA6Fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECCB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j308Q-0003wA-39
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3071-0002Ey-F7
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3070-0005gk-DQ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3070-0005fi-9s
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581783369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pthG4sX1WmuDcM1pYL7nuZk6uLcNUXuiJV60qYY0Cuc=;
 b=ik/OA6FxrSQdfe2gIjtCbZAsrlXRFq3RXKHw0Tom2wwgg1EQ3J1cGzwrK+QctnCF3zU23m
 28Mc8t32EIbUT1FIknBq2s3HEZLTOALgiDl7MIn2DRgoRMqKYVULrE04kqCfomjYvNQJyr
 7oh+N51IzFZbUKF7iqO1V4H2QPTGaJs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-T1FtHXOdOReZoR-8xe3pzA-1; Sat, 15 Feb 2020 11:16:06 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so5932122wrb.21
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 08:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FnvdgJ+pULlElBjPbypj5ZtQBic6wsKotYOG0wxZcb4=;
 b=G/EqiyhQezSBBK4Gma1wIpeTO5DeQHES/8u/wFsBFGWaw1Y+vkT9KpAy9WAa7pTpds
 vYR3KI4u6k2mZUX++n7GVuSkNpQdugU5wB7XZQKxxiwQXNVtNlqtpsoqGIF1WaVBL7rM
 wuHgrHFQmUtoS4fzIJCJTbJzhJYD1fKpGnTqkOWhN4AzONqESvo76cCaKCLFg7v0BFRI
 jBylJPg7lBobyhm9PHiCYDHY6CaaOlcKJGcYRNXv46irP+CQZ01kz7YQm2iPdkgakCWA
 cGNEKqFJIoCIA7RvVKTNtr0uPwg/cmdVUp5AgnsBSpMbrHwC4/RS1ivWYCslrTPj0y+x
 nmdA==
X-Gm-Message-State: APjAAAU0lxGUhb0ZOyW0xlf753j4N0lxIZwatmwI10QYTAeP604hS0Lw
 HdFcx2A+xG+8l26XoR4g+hVU6pP2swtPefuNFxbYWvwZ5vxSqpoS/2MCzMz12wZ4rjHwwo2Whao
 pQmTfOenaNlIlvbs=
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr10590725wrr.127.1581783364859; 
 Sat, 15 Feb 2020 08:16:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/QDpZRjslcyFsFHRjtLnaMikvruJ3gCZAD8x7auXnoxru3hRQh1UJq8R17PhP9hIZE7mF9A==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr10590704wrr.127.1581783364655; 
 Sat, 15 Feb 2020 08:16:04 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w26sm11855872wmi.8.2020.02.15.08.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:16:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/block/pflash_cfi02: Remove unneeded variable assignment
Date: Sat, 15 Feb 2020 17:15:57 +0100
Message-Id: <20200215161557.4077-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215161557.4077-1-philmd@redhat.com>
References: <20200215161557.4077-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: T1FtHXOdOReZoR-8xe3pzA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/block/pflash_cfi02.o
  hw/block/pflash_cfi02.c:311:5: warning: Value stored to 'ret' is never re=
ad
      ret =3D -1;
      ^     ~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 7c4744c020..12f18d401a 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -308,7 +308,6 @@ static uint64_t pflash_read(void *opaque, hwaddr offset=
, unsigned int width)
     hwaddr boff;
     uint64_t ret;
=20
-    ret =3D -1;
     /* Lazy reset to ROMD mode after a certain amount of read accesses */
     if (!pfl->rom_mode && pfl->wcycle =3D=3D 0 &&
         ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
--=20
2.21.1


