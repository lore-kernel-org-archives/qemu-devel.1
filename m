Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8676C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DE82077B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5/Xvs6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DE82077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5xL-00021e-GU
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is5vZ-00008s-Ve
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is5vY-0006iv-DO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:15:17 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is5vY-0006hX-5J
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:15:16 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so19232954wro.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 06:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2vYF/4fmY7dZ9cFlkXYTdoV/gf/dTlcMfrNDaRXvM8k=;
 b=J5/Xvs6A8p2Scu0OA6Lb49PAm9y2VmlCwzwXkWj9yOwx30T13HG1jp/MKl1wex6YWm
 wz5KRVzW7pBjmCGKU/AyC9w4E+gjfZkpGAQ1VSC2jvnV1Ha7l8qiXBoeUX3SiJXx9qx1
 H6IvHN8v16CsQpO/qA1Cp62D/QYlRLZynft4pbD1R7F95VeDWpxO97QuCIoG2Gzc82rF
 pAJm8yLMlpc2bFxssZPHPk+uMoSVd5pcm5u6XGAPfDVxtNrfSnsS1B1EYHJE+BHD3x/v
 BhP+FOoYmg7Sh59fFK3Yu90VUb78SqHg+bCwjkehVXLdMu/FjvfaPrPV9cuFRNjMVTZz
 Fj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2vYF/4fmY7dZ9cFlkXYTdoV/gf/dTlcMfrNDaRXvM8k=;
 b=l+CAUw6+u3RwmIO9HtxHtpgjdSf8NcVl26IpxmRx6sAkbP6BWi/CCSXXhPR2HAHxTv
 jDTO7bmKh7VnNGhYf+8a5kwOVEALSs6Rg2R7qUBwpYuwT8sq5/NCXOYz94jC+ldsVA6Q
 PqSYMgJBDerZn0cBy5sLxPVQgUzSm2BrjLKVhzibD69EhMc0Cb3ckHG+EcPg4LGLvcMW
 IBFqGwStVpqpi6zYtcLNOk6Iix/xvywtryksbh+UFF6SaIMP8pCnFxW4JI7ko0WTqpLG
 qNzfWJpbsakakbMp9KlCOfHqmTQ4Qbz8JxaSrJnzGX2MNp++4NRipLoiswIPqnrJkzOU
 o8hw==
X-Gm-Message-State: APjAAAX+Lta0bZgJe9OtwL0dI22lzLB1xQLmVZNexAA4kCVRdI2wEwn4
 zCx5qkqvewjCHYzyPSWMyW9tEG8aHkDB1A==
X-Google-Smtp-Source: APXvYqzEtSr+KwKiGqoBogCQ3+MAPa0k3RcDrHv5KQdWu8t1kUCgcifNRmuirNUSH/QRXV1CEgKpLA==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr3491561wrv.197.1579184114553; 
 Thu, 16 Jan 2020 06:15:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 25sm4584169wmi.32.2020.01.16.06.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 06:15:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] convert qemu-nbd, qemu-block-drivers to rST
Date: Thu, 16 Jan 2020 14:15:08 +0000
Message-Id: <20200116141511.16849-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the qemu-nbd and qemu-block-drivers
documentation from texinfo to rST. For both of these,
currently the documentation is in texinfo, which we present
to the user as:
 * a manpage
 * a section of the qemu-doc HTML documentation

The conversion results in the docs being in rST format,
presented to the user as:
 * a manpage
 * a section of one of the Sphinx manuals (interop/
   for qemu-nbd, and system/ for qemu-block-drivers)

The first patch is the same as the "qemu-nbd: Convert invocation
documentation to rST" patch I sent a couple of days ago, except that
I have folded some of the long Makefile lines as Eric suggested.

Patch 2 creates the new 'system' manual; this has always
been in our plan for the docs as described in
https://wiki.qemu.org/Features/Documentation
but this is the first point where we have some actual
content for it.

Patch 3 converts the qemu-block-drivers docs/manpage.  As noted in
the commit message for that patch, this requires dropping a minor
cross-reference from the '-cdrom' option documentation to this
(because they're no longer in the same big texinfo document).  There
is also a slightly ugly compromise in the manpage output in order to
provide better HTML output, which is forced on us by limitations in
Sphinx.

Apologies for the size of patch 3, but a single big-bang conversion
of this 1000 page document seemed better than artificially trying to
split it somehow, since only one of the two formats can actually
produce the manpage at once.

PS: the old docs/qemu-block-drivers.texi is not covered by
any MAINTAINERS section, so I haven't added the new
docs/system/qemu-block-drivers.rst anywhere either.
Perhaps it should go in the "Block layer core" section?

thanks
-- PMM

Peter Maydell (3):
  qemu-nbd: Convert invocation documentation to rST
  docs: Create stub system manual
  qemu-block-drivers: Convert to rST

 Makefile                               |  37 +-
 MAINTAINERS                            |   1 +
 docs/interop/conf.py                   |   4 +-
 docs/interop/index.rst                 |   1 +
 docs/interop/qemu-nbd.rst              | 263 +++++++
 docs/interop/qemu-option-trace.rst.inc |  30 +
 docs/qemu-block-drivers.texi           | 889 ----------------------
 docs/{interop => system}/conf.py       |  10 +-
 docs/system/index.rst                  |  17 +
 docs/system/qemu-block-drivers.rst     | 985 +++++++++++++++++++++++++
 qemu-doc.texi                          |  18 -
 qemu-nbd.texi                          | 214 ------
 qemu-option-trace.texi                 |   4 +
 qemu-options.hx                        |   2 +-
 14 files changed, 1336 insertions(+), 1139 deletions(-)
 create mode 100644 docs/interop/qemu-nbd.rst
 create mode 100644 docs/interop/qemu-option-trace.rst.inc
 delete mode 100644 docs/qemu-block-drivers.texi
 copy docs/{interop => system}/conf.py (64%)
 create mode 100644 docs/system/index.rst
 create mode 100644 docs/system/qemu-block-drivers.rst
 delete mode 100644 qemu-nbd.texi

-- 
2.20.1


