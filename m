Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7437C34034
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8215221D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWjEZ/H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8215221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zKh-00042Y-Mt
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zJr-0002sf-9Y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zJq-00030R-71
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:37:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36592
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zJq-0002zr-3W
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582018649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btZAH3Xrx0pyrx59uFmBzC/cYn5q/bWIwtOk/dCCUTM=;
 b=iWjEZ/H5DkubydGMflWCJgcS8qTTzEHHjWeXQpFayE5/tRiWkMq5Ri9MTgHE/j7mYqGctv
 SrPsq1YczQwdZoNO1lWNQ3SI8GuD8J7SLdwXBmHRqY4ASBNm6AwZ6Rlv23okL5eYMtE8Us
 fKwqcgCWzVWnwEAEyyVGH3npVSkCd0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-7fyqJTh7N3yON_r2m89LqA-1; Tue, 18 Feb 2020 04:37:27 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so10430856wrm.17
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fOzWP1vq62G/ytTmsfycrX2X8S1L1HhF+6M2xyNPCUI=;
 b=sv2Q1XKUj8PArGueeGsyDIsLceBxrvg/i2Er7kX/4kSZeEd54KV6/E6ZIHbHRa3h8I
 jY9EQ6rGHLsXCOWZpX2oTvNrLnLEQVAY0wMIdz6N5KQfXs7x8QzEyWKr3kMnMRXXzXUZ
 AaYfNvFSgzxo3BfQeIO3AQh10aJRF8AtgXBfrN/hEHkBNZHWG1XqayhCvO+yQZcUpmRk
 8kl8zZkc2B8kYrt/7J8FQO37nsPvI3u/W2Kzd17HLz0dTwNumUFPGnpIQ2upswBRgLM/
 jA0k4Y0PLd7HylHAgBwI0Bz6J+HgUi6W2DpMHzwDbpi2pQxbPkhO9AARXdo+b7ydbjiY
 w6mQ==
X-Gm-Message-State: APjAAAVFDvxQLC48kKyxDPuV0AjkDK5T+QelqtWUfuwrfA/PrIaAAgnL
 gmjhnNdq753/5Y52z4+/RsDDoOpkOzbHKwRC3f/Mihg8b0UmW5/Q/pMhUud92f/t2pHoaesF8lB
 F7Is2TXs9ici5sE4=
X-Received: by 2002:adf:fa86:: with SMTP id h6mr27392517wrr.418.1582018645870; 
 Tue, 18 Feb 2020 01:37:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTg70OncI5YQkA8HrTBP7wvax5CL6p4INAKPHOMRyenWyW1nb1mw2qqwkl+HY6l0u2kie1Pw==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr27392492wrr.418.1582018645661; 
 Tue, 18 Feb 2020 01:37:25 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id 133sm2817232wme.32.2020.02.18.01.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:37:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/13] scripts/checkpatch.pl: Detect superfluous semicolon in
 C code
Date: Tue, 18 Feb 2020 10:37:08 +0100
Message-Id: <20200218093720.25640-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218093720.25640-1-philmd@redhat.com>
References: <20200218093720.25640-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 7fyqJTh7N3yON_r2m89LqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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


