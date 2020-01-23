Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350ADC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBDD21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rv7YyKkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBDD21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueC2-0002GD-IZ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrI-0004rf-Ju
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrH-0003GH-IN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:20 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrH-0003Eu-AV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:19 -0500
Received: by mail-wr1-x444.google.com with SMTP id b6so3192938wrq.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eTr7REOAleaAyfl/HuxFmf5p5T5F7PayCyv/OCMj0WQ=;
 b=rv7YyKkVDjJpDA6wkmE/VA+FMWclXUowiWMkryXzuRero5HwlTUvNHMPY24MEjuVXl
 XXMhOhxHB4pWSpMpCSnOv4dVA00Dd3B1lofx8ei5R1S+SrUX5fjLvAx9uyDHivlGy3N1
 TAjpYyXjWSuR5gJ3ejNJxU/qbzPf4bgHfOt1zpKyGqg37Xrw+Ggt0WzAXhMaSYA0YhAY
 m0E5ZNJnBEHd2BX8LPCHybdfnOSPlpldFgz5OZzG7yUZ38GqlwJjOuLtomwCHeS9RxeF
 MVMwNSvXBh4jg6Z3Tyig/F59dB9h3h/7xJh9UX4IvXIO5di2Hc1L2SRySsZpI/pf6EyV
 yDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eTr7REOAleaAyfl/HuxFmf5p5T5F7PayCyv/OCMj0WQ=;
 b=cLIlcreyS/J9/bFliDKqEdO6gNvqzajHShnen27utUrmM+shb4wYTYA4wh+QvmdF2p
 oE4hdjxN5tGrSZDRbZwLR8DfHDJXs6IBB1mYorRRb4WlPvvpJ8wGSr+sNCqgmYfh1rSU
 5PPYFME9EpEqUG3CFJqAKAiC0JjLhV9vJ0OO6PVehdRRY1GBgy/b+/JcTTM+8iRj+QLM
 XYL14nzusuGNfuAwVfgGM2IX9H2dNzad9/XGD1RjSdBPA0jL+A6m6sgzGqjm/FXZ34Ep
 PGJ9sJOnfR97+ZNnGEwEEw7vXP3bwW3hfmtntvgtgpuB3/oAHjLX4Ng554lXFekCVqMb
 BK7A==
X-Gm-Message-State: APjAAAW7ki9U0h5hVCfbytdvhT7nJ3cZ1PZWyt/L48nZ0RDHJ5DFEnQc
 QVE934495bYRLp/YV5Gt39ET9mcK
X-Google-Smtp-Source: APXvYqwfqD1KgnmTr1Cnzw25AFVZMF0V8tdquqWZbYWFga/U9aIg4PtVJGqKsEUXyIe46jkhRhK7tw==
X-Received: by 2002:adf:f581:: with SMTP id f1mr17815471wro.264.1579787358106; 
 Thu, 23 Jan 2020 05:49:18 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/59] Makefile: Clarify all the codebase requires qom/ objects
Date: Thu, 23 Jan 2020 14:48:16 +0100
Message-Id: <1579787342-27146-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

QEMU user-mode also requires the qom/ objects, it is not only
used by "system emulation and qemu-img". As we will use a big
if() block, move it upper in the "Common libraries for tools
and emulators" section.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200118140619.26333-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 7c1e50f..5aae561 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,6 +2,7 @@
 # Common libraries for tools and emulators
 stub-obj-y = stubs/
 util-obj-y = crypto/ util/ qobject/ qapi/
+qom-obj-y = qom/
 
 chardev-obj-y = chardev/
 
@@ -27,11 +28,6 @@ block-obj-m = block/
 crypto-obj-y = crypto/
 
 #######################################################################
-# qom-obj-y is code used by both qemu system emulation and qemu-img
-
-qom-obj-y = qom/
-
-#######################################################################
 # io-obj-y is code used by both qemu system emulation and qemu-img
 
 io-obj-y = io/
-- 
1.8.3.1



