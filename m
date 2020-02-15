Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB71AC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827A02083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNlpnn41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827A02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3086-0003Hs-MH
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j306w-00029q-Rf
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j306v-0005bA-NS
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j306v-0005Zj-Jv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581783365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2UBuAZivxQ/t2LSYWdCfVvdvGAny5juqMvDOKi7+08=;
 b=YNlpnn41v51SHNGdA2nFXgR0x/oRIOxmxj7rGAMgTtP9VeI968fh54qsa4lQXIwngQTUT6
 NGRG4Cl4ngtrWkbrTzDGDbhZM7/wqJRfMpjR8TGsDyoOpy9TjMfqxnSPMTSvlOlMZ2L1JG
 MA/azoHWF0gITp7hcCd7s+A90gq99sc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-Uyx69B92Pc2ZYxHDdjVEDA-1; Sat, 15 Feb 2020 11:16:03 -0500
Received: by mail-wm1-f72.google.com with SMTP id w12so4854684wmc.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 08:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1vNqWmtTfqRpFkSvpFeliBtBQdDhN9OVYIDlRsAhO9E=;
 b=jl+gSiCsHl3JYt5momQsQXVCNwHlEzWqOwEH7uT3wVvt0llmKoKX1gO7Rxst7c1VJQ
 8qNlm06ODJuB2Km/NFQo9oKZ6sGQCLSw7NH40GtqM/Q5Pk6EMbcm/CA35UbP3Sx0LHb2
 7JOVu3FliazEbouNu0qlBAmXALQgQVp0D/FBYboPQuO//Apxs8uV93pG8qbpsenoeN0m
 nSht1f4H5EeNVU7+x+x2eMKogYHHX6xtZsgdv4H84Ir5rsilJqhqZE2bEs0iTbFkyQzM
 H6zK+9c6e529cXNHQj1zyTbFNL5lW0zMbLOuX7GYBrIEYBIaHpLjh4si1UN5v64m8iWl
 Ye8w==
X-Gm-Message-State: APjAAAVWykPiO/itoW0NynkW3knix+qxCcpubRrd2cu0fJy6xuJ1rWw7
 XzZ52S+yIubLz7pCCi4O6V6tl+Eaw9jb1JI9vGcTEWfWYdF15XKKV/P2tFZ6ND0lA3KaRUgsGEE
 i3Bc8R2pi11jziWU=
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr11469963wmc.188.1581783361888; 
 Sat, 15 Feb 2020 08:16:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHKeFfmpvOVz4HkZc7Il/FeQ6MQBGmlkbYvmqQyW1P76z6ZX7+OATJk6WrR8Udh7QO5nTWmA==
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr11469954wmc.188.1581783361731; 
 Sat, 15 Feb 2020 08:16:01 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w26sm11855872wmi.8.2020.02.15.08.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:16:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] block/qcow2-bitmap: Remove unneeded variable assignment
Date: Sat, 15 Feb 2020 17:15:55 +0100
Message-Id: <20200215161557.4077-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215161557.4077-1-philmd@redhat.com>
References: <20200215161557.4077-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Uyx69B92Pc2ZYxHDdjVEDA-1
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

    CC      block/qcow2-bitmap.o
  block/qcow2-bitmap.c:650:5: warning: Value stored to 'ret' is never read
      ret =3D -EINVAL;
      ^     ~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/qcow2-bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index d41f5d049b..8cccc2c9f3 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -647,7 +647,6 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverSta=
te *bs, uint64_t offset,
     return bm_list;
=20
 broken_dir:
-    ret =3D -EINVAL;
     error_setg(errp, "Broken bitmap directory");
=20
 fail:
--=20
2.21.1


