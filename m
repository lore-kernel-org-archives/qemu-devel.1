Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18EDC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8847A206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEMnJ2Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8847A206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqg3-00065i-6i
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDopa-0005wI-Az
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDopX-0008GV-EC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:26:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDopX-00089C-99
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584361610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IsEhOtfUEHLbZh82RH1Mx/D+RosZjZEF7tAKuQ8stv0=;
 b=gEMnJ2IcJHXYexPcRf+Rxi3MM1BE7/7tGabYVh7l+1nx3ZSKzEYGTRjWWZfMM72lAjOaJN
 mHV0pDUuv+jseNNBkpJPlxGjbW+LkaH3SaW5ogoudIAH5SQyuyQvEhzVCLPtCsWFpfRmhM
 2zLK+vHBDxyoODo/MsolcT9ULwtptFw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-_lH9FqIYOiyjYV4c1fEz_A-1; Mon, 16 Mar 2020 08:26:46 -0400
X-MC-Unique: _lH9FqIYOiyjYV4c1fEz_A-1
Received: by mail-wm1-f70.google.com with SMTP id y7so5739095wmd.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=umFf+pk7uXmOK8hiXGHtCMsC9ObHF63KDM+dvlt9puI=;
 b=sb5kmw8D/IvjKCO6z7VKonArg2y94rlrggTzFz4Ja0dA5DJMIbXRdbWxr66R5G4wzL
 jvGqV+Mw0StAS/rDqZhupp3Ac7nhKr6X8BRTBZk2VQ4X+QaQmglLeNJSXM3tBQ+cTXMf
 o8r8SqIzoTNkPgoTsVSwmJzuecXDotXVfMvwEApcFqqL+Iu6m9H1H5uMdJUasW/pt6bo
 HHfEnErOjd8LeBUrgSe+hMdxSRJ3h84syPiwhF96DpJIZ5ua1VT4tznZkoVBFiI0FcMS
 zQ57kP/fPhZLjAC/7ZDwVnrQnhSSs8chreJmRrXzE7g4vBOCvjs8W+A7GNe+bsmgzeD9
 H+PA==
X-Gm-Message-State: ANhLgQ3MWuOfAVYLP5nTfr9RCqllOirRcMjNKl4xn4Wot7WBtUo732GR
 +PjeSgTQ0k+4FCbo0h/0h4PBNY0yUBXd9E+3IKVmlRsRSMIyt+oGfk2HJs0A3Y6rAx19qkX45SK
 MznbkvmTBX2bcrYw=
X-Received: by 2002:adf:e511:: with SMTP id j17mr17325295wrm.25.1584361604798; 
 Mon, 16 Mar 2020 05:26:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtC4hUjXDDtbtz9czFOIYU/dv/0Y7zxSvd4cL/zhTEnzh/M5Ldd7DbbFX0KNfRbVZtITLS6fw==
X-Received: by 2002:adf:e511:: with SMTP id j17mr17325266wrm.25.1584361604553; 
 Mon, 16 Mar 2020 05:26:44 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id y11sm8432650wrd.65.2020.03.16.05.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:26:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>,
 qemu-devel@nongnu.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] MAINTAINERS: Mark the LatticeMico32 target as orphan
Date: Mon, 16 Mar 2020 13:26:41 +0100
Message-Id: <20200316122641.14017-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael Walle expressed his desire to orphan the lm32 target [*]:

  I guess it is time to pull the plug. Mainly, because I have
  no time for this anymore. I've always worked on this on my
  spare time and life changed. And secondly, I guess RISC-V is
  taking over ;) It has a far better ecosystem. Also, to my
  knowledge the only (public) user of LM32 is milkymist and this
  project is dead for years now..

  So time to say goodbye. It was fun and I've learned a lot -
  technically and also how a huge open source project works.
  Thank you everyone for that :)

  Basically everything still works and there are even TCG test
  cases which covers all instructions the processor has.

Many thanks to Michael for his substantial contributions to QEMU,
and for maintaining the LM32 target for various years!

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html

Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Michael: Do you want to keep your M: entry, switch it to R: or remove?
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..5376c59581 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -184,7 +184,7 @@ F: include/hw/net/lasi_82596.h
=20
 LM32 TCG CPUs
 M: Michael Walle <michael@walle.cc>
-S: Maintained
+S: Orphan
 F: target/lm32/
 F: disas/lm32.c
 F: hw/lm32/
--=20
2.21.1


