Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6AC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5F220409
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se5ImLpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5F220409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfKy-0006ai-Ge
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFfJV-0004UH-8c
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFfJU-0007C7-79
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFfJU-0007Bn-3W
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584801683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MeQLKCK+LuR97mOw2w6FbyM0pW3k0RrlHbblQ2lvrE=;
 b=Se5ImLpPLNWX68roFRPISAkU2sGO3HGRaPdwXRZy6BmXC0C3Cy2iAvExGOH6s6Uu1CFX9+
 SKQCb0ZmJ4O6IIF7ygGwV/kSbbrHeN/SMvsLUOvh1J3RIEivkvS32g/UK/jAYgoh1kw8zh
 yvD1WdeOJYb7QGRcOZzNaenwDUPPCiI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Ni6M4TW7PSSCA7qqZN1-BQ-1; Sat, 21 Mar 2020 10:41:22 -0400
X-MC-Unique: Ni6M4TW7PSSCA7qqZN1-BQ-1
Received: by mail-wr1-f71.google.com with SMTP id j12so520898wrr.18
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rRfIK8MnVsl+DYnTbm2DpmqG3rx4tJjk7CYNvTrwi2Q=;
 b=YJQMNo+TUR4OrJet425bdWw37I/1uwcsCdw2Rh69cgQzNOyfgdZea4fTbp6q0lTDpp
 fcp9YJWZuCKtTsVtOM61drf0GI6ALTZ61kPO9LnBemHfaS0GprXWJrn9nhyd/Y/B9x/1
 EFLeysnf6YSTIiokr6YNAuCbTPbJXk9J271ONbVnUgJ/njzn22lN004lW/1Ly6tEnygQ
 DY01FjLpShA1f6yShO3AKo7Tps16Lnk+sxikc8hJEhajQhNF0hqxWBzHFXTISel9UN7p
 k94R5AxlA3/ursXOkSH9G11QnZF0F+XSJmxLykkXIaIfTOIVYL2Jgw44pa5cmk7V4dBv
 JetQ==
X-Gm-Message-State: ANhLgQ1Qp/tnyQz/4rs28rjVml6dK3FY8Lu22Ji81PaYQdSsVMBXtHAY
 hlMWb6QESNnoRCBU31jzm3GT6/CN43H+KggYWD8BYOd7Qr/UxE4SkjRon/h4g5Ku7XtGigLTydH
 SjbVlzGH/AiEf9T8=
X-Received: by 2002:a1c:9a82:: with SMTP id c124mr14832226wme.22.1584801680629; 
 Sat, 21 Mar 2020 07:41:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vucmBxxcI1me0oyxUGVj0nozGfJ5SenYW+m04rwHPopLbF6as7MiEM9Um8gxGayKY1KpNfIBw==
X-Received: by 2002:a1c:9a82:: with SMTP id c124mr14832189wme.22.1584801680439; 
 Sat, 21 Mar 2020 07:41:20 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id g8sm12548446wmk.26.2020.03.21.07.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 07:41:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 01/11] block: Avoid dead assignment
Date: Sat, 21 Mar 2020 15:41:00 +0100
Message-Id: <20200321144110.5010-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200321144110.5010-1-philmd@redhat.com>
References: <20200321144110.5010-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
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

  block.c:3167:5: warning: Value stored to 'ret' is never read
      ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 462f5bcf6
Reported-by: Clang Static Analyzer
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Keep 'ret' assigned and check it (Markus)
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index a2542c977b..a6f069d8bd 100644
--- a/block.c
+++ b/block.c
@@ -3165,7 +3165,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
     }
=20
     ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
-    if (local_err) {
+    if (ret < 0) {
         goto fail;
     }
=20
--=20
2.21.1


