Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1313CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 10:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F3C21D7C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 10:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F3C21D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLmPf-0004vM-KU
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 06:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1iLmII-0000n0-5R
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1iLmIF-0003VY-W9
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:49:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1iLmIF-0003Tq-Pb
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:49:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so8790315wrs.0
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=veywx1Lkzs7K8V94mg6/UcBT2Azm7al3GNNzW0XQBMo=;
 b=FnaaQivxVY5MyOmM316mnDKdGsEJOuDuBONcXz1Zw+6RhrxmIxTA6AhKQKTJIuRu2l
 rUffBk0HE39AYwFQqOhHYER7yDnJSQZz1YoaUYrJ4cNnXzkqWOyaKdi0yunxYFaEsM2T
 pfslwJwiifeVisbO3kXJvtzZFx0bD0WbVS77bbx5wTvA1WDhSZggpfyOGu1nf3NnG5yZ
 wY9GzOXNwUpjV2kmRzqiOR8omIueP5SR69+epKYFwelK/VGlVass+yKQdPUcqi3+5EUS
 y4TE3FemS34jcjxnVW3qfLaZdzCfgU72imBMnJyN7ZDBZkE2Rd1Vypz0e+wsCLsWegk4
 Ahgg==
X-Gm-Message-State: APjAAAVuWEhHPYT4+hmO73B7YYlTfb6h6dDYwHqVXpwDYbS7uWQqC6OC
 VCUwfKFvmkjEOzu6cLmplTs=
X-Google-Smtp-Source: APXvYqxAHBi7+560uszTiDA3EH0QMhzCsRET6DATAmszQyytbtVGRRncu7teqMQOMFZ1rUa3JuTYNQ==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr8132747wrv.215.1571482145493; 
 Sat, 19 Oct 2019 03:49:05 -0700 (PDT)
Received: from thl530 (x2f7f4ae.dyn.telefonica.de. [2.247.244.174])
 by smtp.gmail.com with ESMTPSA id b62sm11491523wmc.13.2019.10.19.03.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 03:49:04 -0700 (PDT)
Date: Sat, 19 Oct 2019 12:48:59 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 7/8] hw/m68k/mcf5206.c: Switch to transaction-based
 ptimer API
Message-ID: <20191019124859.6a85e220@thl530>
In-Reply-To: <20191017132905.5604-8-peter.maydell@linaro.org>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-8-peter.maydell@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Thu, 17 Oct 2019 14:29:04 +0100
schrieb Peter Maydell <peter.maydell@linaro.org>:

> Switch the mcf5206 code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/mcf5206.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

After applying the patch, I now get an assertion:

$ qemu-system-m68k -nographic -kernel
~/tmp/images/image-an5206-big-20000706.bin -M an5206

uClinux/COLDFIRE(m5206)
COLDFIRE port done by Greg Ungerer, gerg@moreton.com.au
Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne
KERNEL -> TEXT=0x010000-0x077cb8 DATA=0x077cb8-0x08b0d0 BSS=0x08b0d0-0x0a2d58
KERNEL -> ROMFS=0x0a2d58-0x183b10 MEM=0x183b10-0x1fff000 STACK=0x1fff000-0x2000000
qemu-system-m68k: hw/core/ptimer.c:410: ptimer_transaction_begin: Assertion `!s->in_transaction || !s->callback' failed.

Looks like something is still wrong here...

 Thomas

