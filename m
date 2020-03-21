Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8A0C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7702F20637
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hG0rl2bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7702F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcc8-0003n3-JU
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcaQ-0000fN-AI
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcaP-0006MT-8t
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcaP-0006M2-4o
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2U6ARuvMvLKS+fqGTEoijz7r0B3fBwOwTnOOBFQNRAw=;
 b=hG0rl2bjnZjvxE4P50y5Ax9avstqt+14e6VKPuifVfdsJmMbHwnwA8mnytOUZ8uCHC0XF6
 AuC3kiLod4yzLfr5p9ID183qnCizLkHOUUXufosbiP/VT7j7DaOuTnTJ1rFSE9jQ18yXH0
 RyNxrcSnUmn9azrARJnwHwPW5nlGTeQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-ejGea2KcNeS8ugV50Xp4-g-1; Sat, 21 Mar 2020 07:46:39 -0400
X-MC-Unique: ejGea2KcNeS8ugV50Xp4-g-1
Received: by mail-wr1-f70.google.com with SMTP id e10so2409633wru.6
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ez+E9s5mwrT8B9y8nVUYgFPf3iN6ckUcWWVa90evmD4=;
 b=h1HXJq6o/kWdlm1TUOUYqbKYW84Eu6HeARjkBCrMoQO0JDUX0RWk96GvsvyFWW6cJy
 6yfbi/eI7opMcaFW7/oeogLVK4codu/a0wTjokedRNQ1zj/1cPfZ9bSWyzsOiCk0J/Y+
 p6hq8jutRJP7LEPcXOmOxSPYIk9XMVsmlmAWY6+xVjNHUFXAyfchc2CR6vi9k7Qxngmn
 j9d9+ZcbcpreCwN/mAlhNc4VbibXtMlIPG5aW48mfkq+BiquHuiFNVyWNla8I0mIrpLS
 Olya3+c2LFzun+cCRKj1c1n/HiUfNk9nDP5U4hvjed6GUBFuNZZywyCxOddwC8P9kQ77
 idDw==
X-Gm-Message-State: ANhLgQ1OBrY97SqE3VA92y+QDjn01ViQnpcYOWZl0TR6gE7BhzowFVHf
 e9z886qMbX8zeaGRWIkwohYFts2hqAN6RMJ29seLmebrwEX8D3sbnpjNjEGKW59AewydEdELyja
 DmWIdlrFZzAejg8o=
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr17443690wrs.96.1584791197954; 
 Sat, 21 Mar 2020 04:46:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vve8rRdAc9j+mXkmu1X1eacNa+hVewhm4BXzBkCSSJNfv/v/it6Xfe4h3p5TbOBoIKzQ44UBQ==
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr17443653wrs.96.1584791197777; 
 Sat, 21 Mar 2020 04:46:37 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id c5sm15737698wma.3.2020.03.21.04.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:46:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 02/11] blockdev: Remove dead assignment
Date: Sat, 21 Mar 2020 12:46:06 +0100
Message-Id: <20200321114615.5360-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200321114615.5360-1-philmd@redhat.com>
References: <20200321114615.5360-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
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


