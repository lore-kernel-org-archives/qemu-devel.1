Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8733C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738CB206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/9xGxpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738CB206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAcu-0005Lo-8g
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWO-0003mb-8x
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWN-0004KX-7z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:12 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWN-0004KE-28
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:11 -0500
Received: by mail-wr1-x42e.google.com with SMTP id b6so3248858wrq.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/zR/PnmoD2vd+SET2VXoclQZXazuwhpa+44UehtkdK8=;
 b=e/9xGxpZhSInAdrJvK2/xA1/nCbKQF8BTgToTkTsFGigZ4tLiTWGKyks8gtVK4Onyq
 AsYaizx1ORrNa4MLtQ5XYYhxIDFOGpUlt7vogwiXJVNNjpN2rTcxKA3K3sRCsXkTJxsC
 0ifVsdXbDYccn9KjUcnDG8A1YBaKIA51imV+p+MNSyAAYhG046cZPzDnpX0Fe5dhBmkd
 3WU5x3lEelQ8ccuep+djKh5K7OMH0q2MuKPXkyLPXpKc8Yew2WPTV1Ohe+x8VyYuj33a
 ufPAwUb0OPqbc04kEyjlq2PMp2mbxdu1fjkEbWrOkCNS0hDyHMCMHdz+SJR432FN9f2Z
 qTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/zR/PnmoD2vd+SET2VXoclQZXazuwhpa+44UehtkdK8=;
 b=soBTwWGSF+bIOBURksMLj/GJ6kGXc1W8WQa9Lr7sDSWRuu6sbNorDwXQgTGBnScrEo
 HO3QfD89frV3nT5kOPV7pfZN7Scz2NucDA4VkLoGEUZo/lbnE5VjER8LQ/qYDp50oTcw
 ekRgxLaWDWIZ3h0J5V3A/wKQOsPqXO9rAjO8i4yOUpa20IARjY0Mvp1xahdxsHnvaOHH
 bvyaj3v0A8zJWXX37xa1bN/6tWKvAmKo/FhT+WNaLhpjCciY7IZmOWfAxB0C7N8G0cRS
 +0bxWYB/nnRV+GqccWH9Vrepu7hJvZzdb02JZ2zkYDgj/YXKbc6J4w+V1DXVEsJjhAlV
 Xi4g==
X-Gm-Message-State: APjAAAWS5i+pvpQjB5tzYxarr6z+yJBy5Ez8Q84Scg8BYkIXv+UhTdVb
 J5MtBqXu3b4Q9sXbHWRll82R99+4
X-Google-Smtp-Source: APXvYqzWaXSEOIoet9f/MiRNa+2M775XLjBMxv22hh45jdkSAvUjywr3EwIEBSi8DA+Vq6TIDw5E7Q==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr4500502wrj.357.1578486789987; 
 Wed, 08 Jan 2020 04:33:09 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/38] hw/ppc/Kconfig: Let the Sam460ex board use the PowerPC
 405 devices
Date: Wed,  8 Jan 2020 13:32:30 +0100
Message-Id: <1578486775-52247-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When configured with --without-default-devices, the build fails:

    LINK    ppc-softmmu/qemu-system-ppc
  /usr/bin/ld: hw/ppc/sam460ex.o: in function `sam460ex_init':
  hw/ppc/sam460ex.c:313: undefined reference to `ppc4xx_plb_init'
  /usr/bin/ld: hw/ppc/sam460ex.c:353: undefined reference to `ppc405_ebc_init'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:206: qemu-system-ppc] Error 1

Fix by selecting the PPC405 config.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-8-philmd@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 0cd8d40..004b7d5 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -50,6 +50,7 @@ config PPC4XX
 
 config SAM460EX
     bool
+    select PPC405
     select PFLASH_CFI01
     select IDE_SII3112
     select M41T80
-- 
1.8.3.1



