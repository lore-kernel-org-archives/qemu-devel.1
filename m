Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A783C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CA62072D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIp5SluX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CA62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37727 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfQl-0007Vr-Vm
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFfKX-0006Qp-UY
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFfKV-000859-Uw
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFfKV-00084m-RO
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584801747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEdgbG/luCssALBIqG8TygafayDXTkEa0M3aN0ohCNI=;
 b=cIp5SluX0y6SYadZfm4elMxH1AqbOHUsOt7nvn8wQPeAXviD+qC2AmiV0llvNvEJbwLesG
 pt7DE/6RdaHQ51569nra/GvikVAyv1kftzz7fum9098KQKmvF1E5DUYOkXbyPanq/JN+7E
 KUGrWDZ4+71AhhBv/StlS9nQF+ifxoE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Luqkr_GVP6GEeIhEFks8Jw-1; Sat, 21 Mar 2020 10:42:25 -0400
X-MC-Unique: Luqkr_GVP6GEeIhEFks8Jw-1
Received: by mail-wr1-f69.google.com with SMTP id v7so4414691wrp.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RNYtNktAqDdDAs+EFJozo/fN2JmmaPRaAB7IeiBu7pw=;
 b=p+bYtzVNOWkHTXvsHJEyMFrEM+4HN2MxUN9+M5ysX9cdVG+FSeOSfuFfo6bsftTi9+
 mAhwrcvRF781VHtpKQWisBuiHOxQhK78esNlHieOkw6xgP4cd3RkYeI6rERJZZppU94B
 9QgfDKYNMzN9S+hhKUWqUh4gGwMYJJWQ+WC5+XV48ukPs8cSLT7qIg+G4pXWknowN4Cy
 WR31f3AkJWGWzLMNS5TSlK4Xf8QdePthMo0iGbG19S80rP5mj7cm2FLhUIWXz+PdiEbI
 hFlW8wtqtfR8dAo5UEdydMk/Vgm4GGVWQqlSXqKPX3UECXyR+LsShyig14qm0gFysRVe
 3Kdw==
X-Gm-Message-State: ANhLgQ1AgYoTeGqlV0PQbQW/2iKkpRAb5oI4LniYHKQnYMcXvL/dYfEs
 qLPRMxZC0R8nifGeCmBfLKXCBjEfeKpuE/Ebnt+jtlaEYyM41gscSzawUU+Gby0dWFuKWzJO3D3
 4PER80HdVwWLhNvM=
X-Received: by 2002:a1c:5502:: with SMTP id j2mr16751344wmb.93.1584801744191; 
 Sat, 21 Mar 2020 07:42:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsKPDyLXi8pa8eig6PFPmkwgoDRyetmzS36AEYiO2EqK8vpko5c519XDDmnXRQ0gyQY3H9VPw==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr16751309wmb.93.1584801743946; 
 Sat, 21 Mar 2020 07:42:23 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id v7sm13472822wml.18.2020.03.21.07.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 07:42:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 11/11] hw/scsi/esp-pci: Remove dead assignment
Date: Sat, 21 Mar 2020 15:41:10 +0100
Message-Id: <20200321144110.5010-12-philmd@redhat.com>
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

    CC      hw/scsi/esp-pci.o
  hw/scsi/esp-pci.c:198:9: warning: Value stored to 'size' is never read
          size =3D 4;
          ^      ~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/esp-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index d5a1f9e017..2e6cc07d4e 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -195,7 +195,6 @@ static void esp_pci_io_write(void *opaque, hwaddr addr,
         val <<=3D shift;
         val |=3D current & ~(mask << shift);
         addr &=3D ~3;
-        size =3D 4;
     }
=20
     if (addr < 0x40) {
--=20
2.21.1


