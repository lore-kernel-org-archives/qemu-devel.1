Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB317C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953BA2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi5Ir4TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953BA2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFYv-0004qt-Kf
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUM-0006S5-KL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUK-00031Y-7C
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFUJ-0002v5-Ge
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CAm/ELJG3BqWeqIODV3zHLDQPYZpESaEVU+juqiMjnQ=;
 b=Wi5Ir4TGg/OKQafn7WFKdbZ3wl6P34dMQZkuI8VgHQN9ZmBza4x06Xq0ii4E6it57fHpsV
 voxOwKl1cjGIqjORWstwF+LXdu+3Xc2jrmfTQHUt9928m0EQeEH3w8hteOTutA8PhtWOm0
 BmQWiiFZv2uIPZwteso651FbXRGyhds=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-KqyylhFFPWmGyJuae1secA-1; Wed, 22 Apr 2020 09:32:21 -0400
X-MC-Unique: KqyylhFFPWmGyJuae1secA-1
Received: by mail-wr1-f69.google.com with SMTP id v9so1044138wrt.7
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2FKpjcCgxFkJLIX2UQN4Z0uyrzf8czNZGVSlJzZoMlE=;
 b=bqy0LuSTsID8qs2k8Nvs/82R8m+OC342tC5ZDlulHTDVYpq2QjTJgqSwdeEL8fvdc/
 kRmWFk/Y3D0N8DLq98MXy2AeOzCSoQ/R2/OodJn53Vq6VuBfoI/Rp2oMDuYViMUiyG9x
 0lBlEA2PyWit7E8oF/70oOs++E+ZUKXnxraWaV3GOej2/hpDFHPDEnrMH3ndvG9ywNTk
 PF5ImDyHW4WJDbTn8NNd69tGgC7686EssuO87jzWLpeqGllRIDAwWvxW0a+QDTowyBFX
 C9um77WHzMLbHovVwVtCOhSp+gikjpeKpmnfefTAbOUHs+MNCfCS9WcFcIOeSTJ7nYcV
 DTcw==
X-Gm-Message-State: AGi0Pua2DHG6OhcGYgO3zrK15jxl3jrguKtSs2hvx65Sx280K79Df5j7
 FVgUAIybvUnS5Fwl51wCyVAWcNEHm6hxiW0Vv/NlUcn58wFkbnRxTuvlLMT6Odav3MxzNDpm+nR
 m85TKMA79evKfUXc=
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr10753410wmm.150.1587562339896; 
 Wed, 22 Apr 2020 06:32:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypKBHCxVFL6Ws9hQAYww/uSUD16SaeWprZDoQADn+KRz09ut8eE6N/X1REGfFk5aEplfb6ksWA==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr10753390wmm.150.1587562339737; 
 Wed, 22 Apr 2020 06:32:19 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y7sm8374745wmb.43.2020.04.22.06.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:32:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/9] hw/ide/sii3112: Remove dead assignment
Date: Wed, 22 Apr 2020 15:31:48 +0200
Message-Id: <20200422133152.16770-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
References: <20200422133152.16770-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "open list:IDE" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:sam460ex" <qemu-ppc@nongnu.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/ide/sii3112.o
  hw/ide/sii3112.c:204:9: warning: Value stored to 'val' is never read
          val =3D 0;
          ^     ~

Fixes: a9dd6604
Reported-by: Clang Static Analyzer
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ide/sii3112.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index d69079c3d9..94d2b57f95 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -42,7 +42,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr add=
r,
                                 unsigned int size)
 {
     SiI3112PCIState *d =3D opaque;
-    uint64_t val =3D 0;
+    uint64_t val;
=20
     switch (addr) {
     case 0x00:
@@ -126,6 +126,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr a=
ddr,
         break;
     default:
         val =3D 0;
+        break;
     }
     trace_sii3112_read(size, addr, val);
     return val;
@@ -201,7 +202,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr=
,
         d->regs[1].sien =3D (val >> 16) & 0x3eed;
         break;
     default:
-        val =3D 0;
+        break;
     }
 }
=20
--=20
2.21.1


