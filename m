Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32581C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC9320575
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwwSXjzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC9320575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDphr-0007vB-2B
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoQm-0004jF-0G
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoQf-0006kj-5O
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoQe-0006Sa-Vi
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNdjDlt0eHUHq6lIkC6ThZH13eQCGbkKP8jPgUh0FmI=;
 b=iwwSXjzyvH9N9rwk+dWol3/w5lQ7CQh6+JZBZVVFD2vLt/b3vwwDNHcZ2aGe1rR+CfHkZl
 re83gp/kL9pnEldja72vdI+Lc3cudBFxXVlv/+fYFvMwZ1tv9NVqBtHSVtb1ChDO6dbwOv
 1Hlo+cRco+lp2e54vx40z1IFQ/Y+cmE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-EIfBnAexPs29MbG808HLmw-1; Mon, 16 Mar 2020 08:01:05 -0400
X-MC-Unique: EIfBnAexPs29MbG808HLmw-1
Received: by mail-wr1-f71.google.com with SMTP id l16so8204606wrr.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iflwkf/3HAKpvXRIEINiZerUEj5X1ktJtfvGmSgXiYA=;
 b=dFMetzvXPV+VI05YArYkhWieHfg2cH36Y6aF3SH1B5BNZ2K8SGx1AANYIA+QpI8YXs
 s72mrCgsgh4Ky8ILascBDYZ3MmpH4R1JjmrR+nsmn+0sutYCfLgMObgv21DvXbBhgE0Z
 yD7kp9MnuS5SKwIGIycwgDKtyQxh1/KO4i+CS0hRJ52ud52nsY/fLl0vfn8Nsg/lbnF8
 ms8lfOlDBdm7cZF/7isXz2r0xnXK3IQF5xLgJVH3c1ey8d1LwZ6YsLujTI78Tdzgwaof
 NsKxySR5C9T5vC4jyQnhpm1iYQ4l6vepH9BUOuIW/R0D1ILddRbmqs52h2igNy8gNsW7
 IXEg==
X-Gm-Message-State: ANhLgQ2kidM2AOaPBXJHey0detR/8FIGTk0JtROV4dYSNQs1o9e70X6f
 2D0dLqBtrnNiNL+id5eEdNZpHNP0hgX9DFUzGgrRXL0KQ/flqaHX4ke+MwGJYQQfhcnCn8DZmfC
 +xxHgMrbfum94wg8=
X-Received: by 2002:a7b:c758:: with SMTP id w24mr28561281wmk.155.1584360063650; 
 Mon, 16 Mar 2020 05:01:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvdKCoPGKQgGYi0w6vNmKX+oBK955Isn2B9Au6xNmypl996obsvejGEWhNb6hVdGXqEW4F9fQ==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr28561260wmk.155.1584360063491; 
 Mon, 16 Mar 2020 05:01:03 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id z19sm30983710wma.41.2020.03.16.05.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:01:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] MAINTAINERS: Add an 'overall' entry for accelerators
Date: Mon, 16 Mar 2020 13:00:40 +0100
Message-Id: <20200316120049.11225-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316120049.11225-1-philmd@redhat.com>
References: <20200316120049.11225-1-philmd@redhat.com>
MIME-Version: 1.0
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7898e338f6..08d9556ab2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -405,6 +405,15 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
=20
+Guest CPU Cores (other accelerators)
+------------------------------------
+Overall
+M: Richard Henderson <rth@twiddle.net>
+R: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: include/sysemu/accel.h
+F: accel/stubs/Makefile.objs
+
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
--=20
2.21.1


