Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A69EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4566B21734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mbeww9PY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4566B21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueb3-0002zS-0q
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrH-0004qK-KG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrG-0003EL-D6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrG-0003D5-7C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:18 -0500
Received: by mail-wr1-x434.google.com with SMTP id w15so3165037wru.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EB6B/is9mQvDGkoPXZc/Kbfawg7I6UbaVwup9pSP1Q0=;
 b=Mbeww9PYzevWo8wEmP649qJ27+8jn6fCjX1zK6o4MUdfQSKY9FkWhUYoLBjpd5502S
 AF8BuwrXJ/08XhlkGF2odnGirCffgGTt9PI03EZ8pQaY5/vQ0RPaNm3klirz28kfDf4u
 1+dkWtu407+p/543PjmCqw3VFPlVjz7bjlPc4xT+swbFEBEioXKT7QI6DJfBAJBRnBaR
 ZX3ncr8R4atFj13yldo1hSBEBo3+nLpc6bUS/iZDL/rA5idEUpQ0T/+E8nzwZ4k/EShr
 RA5L2mU1SYTH/bFLCfUuHPclxK+O4+ABTPaLh8YVRbL/hSvnZEOD6Ra7OywDhsnudhuj
 IP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EB6B/is9mQvDGkoPXZc/Kbfawg7I6UbaVwup9pSP1Q0=;
 b=kSBlpms+umNbiWFEyn44+N1S3UHTIWHrQ5TL2kLCvNZbgXSnMYLMNfEjh7tRKViNBP
 2u4ZMZrsahgwM5c3Q0arDYMYkLkCL6d+78TfYpBYO4Rhp8HhSi8NTeexxdNxsBJhz85M
 YXFe2Da6VKQRqZUnjbbgwMIm3VvkBmze1GL2E2gRrFN7VYJlqtjKDdqVSXxwgKrYqsov
 n+t1mbTseZBpLak9a7TvzikZfsp6JbrNS/sHVbChA7Ftjcs/bz0Vdhf8nti6ytQxvESM
 fW+XQAu30whh5GnfzNe1Zkzz8GLvLWVeqQ8eLZ/6CrkFtw2vF1vOTtYF6t5+yOHg7Sfm
 peew==
X-Gm-Message-State: APjAAAXDm6jjGjJgfwr8xmnQ6nyoaPyutk7tpzhPdgnxzaR6DwsdcXBc
 5iEuiyL97SSNJPLds6FKb51b6B+/
X-Google-Smtp-Source: APXvYqwkX7Ypg5lVR4Sj3Cr9Iz84FYkfOEkUceH1+2Gr1T5uXXG8eNTpbLtiFZsMfmpb5SijWBaKJA==
X-Received: by 2002:adf:df03:: with SMTP id y3mr17891512wrl.260.1579787356878; 
 Thu, 23 Jan 2020 05:49:16 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/59] configure: Do not build libfdt if not required
Date: Thu, 23 Jan 2020 14:48:15 +0100
Message-Id: <1579787342-27146-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

We only require libfdt for system emulation, in a small set
of architecture:

4077  # fdt support is mandatory for at least some target architectures,
4078  # so insist on it if we're building those system emulators.
4079  fdt_required=no
4080  for target in $target_list; do
4081    case $target in
4082      aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv*-softmmu)
4083        fdt_required=yes

Do not build libfdt if we did not manually specified --enable-fdt,
or have one of the platforms that require it in our target list.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200118140619.26333-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 557e438..c67a7e7 100755
--- a/configure
+++ b/configure
@@ -4095,6 +4095,8 @@ if test "$fdt_required" = "yes"; then
       "targets which need it (by specifying a cut down --target-list)."
   fi
   fdt=yes
+elif test "$fdt" != "yes" ; then
+  fdt=no
 fi
 
 if test "$fdt" != "no" ; then
-- 
1.8.3.1



