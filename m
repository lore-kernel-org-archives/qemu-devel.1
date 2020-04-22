Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B938C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BAC2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OY2XgS2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BAC2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFYx-0004vY-Ix
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFV0-0007Vy-34
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUz-00052T-Kg
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:33:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFUz-0004zk-6L
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2U6ARuvMvLKS+fqGTEoijz7r0B3fBwOwTnOOBFQNRAw=;
 b=OY2XgS2sSon8MK7t/t+L497su4hFSAPjGI0EmCC34Lz4w3ssEBV2uN+WPMRr/hNTW7y6Mr
 EKRZ4uS59y5/o8q0DIT4p+YOPRXF7pv+GpT05IYxRPqqMNrDH+iGhDA7Cb6NLCplgRm1El
 c1ObA63NWUqQefo12cwXxx3XJkPY61Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-ncgil7nSOyGfb95W5BY1kA-1; Wed, 22 Apr 2020 09:33:07 -0400
X-MC-Unique: ncgil7nSOyGfb95W5BY1kA-1
Received: by mail-wm1-f72.google.com with SMTP id q5so792372wmc.9
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ez+E9s5mwrT8B9y8nVUYgFPf3iN6ckUcWWVa90evmD4=;
 b=MGL6xv/UYM6ocje2c4Nx4IP8PiAVhWtTdxKdKXyW4j5Eqa6+aGuHa/Sjp0BR5xnWFM
 RsXrdxeCR4phE/5kVKEEk8drNMIWoIRbEY7PWNlCdHAD8XP584dZME3FG6WJGyWPG3u2
 DS2qZRezuFl7RXGfk+iGctBor6n4Cx2hcPiMOrOVodO1Mgf+B0KGqRvHP0q3VTlF6Dy7
 P3cTGfkYle3EsyN35KujCZB6skKrZkAIpZbMuLUxQ/gdKocUmeFZw6oytvGosDa1zCPf
 1SQ7GjU0jJ0/h3cPICaZjyn5CSH2gq+wYjPu6banlzurjoAylro4PvCVMcego0JMPprJ
 UIPA==
X-Gm-Message-State: AGi0PuarPNrkFk7WiuPBEDu4Z2pK/MohHb6BBIKD6MflU2M7ohZBDH1u
 W/hregOy4JebNetRRQjs6/zzBgAA1LizpcZ/XdlqieNq9sK3lS6LteJ/N2E646xh7IvLN/2GW9f
 W17MMhwvbMEBt2IE=
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr11344951wmg.65.1587562325424; 
 Wed, 22 Apr 2020 06:32:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypLEMtqlGM7tlPDkeJxSPb7125x+W85cCCPYOZelLyU8UzBj4cOszGUa++XN2tBEWSaTPl4QZQ==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr11344924wmg.65.1587562325181; 
 Wed, 22 Apr 2020 06:32:05 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b82sm8326135wmh.1.2020.04.22.06.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:32:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] blockdev: Remove dead assignment
Date: Wed, 22 Apr 2020 15:31:45 +0200
Message-Id: <20200422133152.16770-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
References: <20200422133152.16770-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      blockdev.o
  blockdev.c:2744:5: warning: Value stored to 'ret' is never read
      ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index fa8630cb41..6effd5afaa 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2741,7 +2741,7 @@ void qmp_block_resize(bool has_device, const char *de=
vice,
     }
=20
     bdrv_drained_begin(bs);
-    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
+    blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
     bdrv_drained_end(bs);
=20
 out:
--=20
2.21.1


