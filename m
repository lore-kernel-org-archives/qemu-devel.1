Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6206BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3E420722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIGOF4tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3E420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zGz-000818-KM
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zEy-00066z-Mj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zEx-00019H-KE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:32:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35902
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zEx-00017y-GI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582018346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btZAH3Xrx0pyrx59uFmBzC/cYn5q/bWIwtOk/dCCUTM=;
 b=LIGOF4tQUl1KwVLrL0mt3CUwhEO/Hdu0ZXugUiVNSIbpidhpy6VMfd7hP26C1nLwJZhaJW
 H/LCMi2clSupxn9dVFmrWq5CHictSoJCZMd61PGFTMecjda8MBtChd+QjXuTtm25kUjeog
 IrFsJcDVTqOZpHD5G46y9UzMUdnTz9s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-RFU9mo1wODuOI0iapohUCw-1; Tue, 18 Feb 2020 04:32:24 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so10439492wrm.18
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fOzWP1vq62G/ytTmsfycrX2X8S1L1HhF+6M2xyNPCUI=;
 b=Km6Iwujb8jhegwxFGg7YnuTNuFSQ3VtYSEp1ysK0XEtVdarZ+e/OEXRfIAG99Xq+Tl
 ZogRikwbQrmu7240QJPjH7JYVI3l0MWQg4n3NqxZWW97SUiVdnHd5aCn80hVNniZ6Ycz
 fgo4CxDXqiEA1PPojnqW3Lg7xHYj8cQpJG/n6XzYPs9pMffAkxc+cDoLlQAo7Yh7hLwH
 Usn/M3Heirp+DpHs/XT9VNp1bRO3BpOfIfRYcBG3WrIcoAkvsUhxEJxtAJS3lwaGBiVY
 At6WK+GaF+kGa3QQoePE9twvlcu/MjVYXPuTmG7qEDioMOq5jynBaNFcya/duBHjZiJD
 PbnA==
X-Gm-Message-State: APjAAAWR3ndTMqxMuHZm9ZeK5cutdG4Uq9x4ZTGMud7vt0K99JrB60b6
 1YR10D7/l1Ii6ZnK70s/x9tZRAccGbrUfCgS0E6rcwWUoIOmu7L+bRpdscSTgrwdAQTiWSy5pGy
 QGUgkWR5KnnRNFuQ=
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr2078139wmg.151.1582018343334; 
 Tue, 18 Feb 2020 01:32:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKzJTCtuZVY4mihsMSTwp6sfDROIwMS84Cw40XeYLboxOguDl8FpNkBtltMeBXHcHoTYZifA==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr2078014wmg.151.1582018342204; 
 Tue, 18 Feb 2020 01:32:22 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v8sm5146891wrw.2.2020.02.18.01.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:32:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/13] scripts/checkpatch.pl: Detect superfluous semicolon in
 C code
Date: Tue, 18 Feb 2020 10:32:05 +0100
Message-Id: <20200218093217.25156-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218093217.25156-1-philmd@redhat.com>
References: <20200218093217.25156-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: RFU9mo1wODuOI0iapohUCw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Display error when a commit contains superfluous semicolon:

  $ git show 6663a0a3376 | scripts/checkpatch.pl -q -
  ERROR: superfluous trailing semicolon
  #276: FILE: block/io_uring.c:186:
  +                ret =3D -ENOSPC;;
  total: 1 errors, 1 warnings, 485 lines checked

Reported-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ce43a306f8..11512a8a09 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1830,6 +1830,11 @@ sub process {
 =09=09=09ERROR("suspicious ; after while (0)\n" . $herecurr);
 =09=09}
=20
+# Check superfluous trailing ';'
+=09=09if ($line =3D~ /;;$/) {
+=09=09=09ERROR("superfluous trailing semicolon\n" . $herecurr);
+=09=09}
+
 # Check relative indent for conditionals and blocks.
 =09=09if ($line =3D~ /\b(?:(?:if|while|for)\s*\(|do\b)/ && $line !~ /^.\s*=
#/ && $line !~ /\}\s*while\s*/) {
 =09=09=09my ($s, $c) =3D ($stat, $cond);
--=20
2.21.1


