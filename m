Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0CCC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C0120679
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uc5+RcJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C0120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHohw-0001aH-KS
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iHofZ-0000M8-5v
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iHofY-0004vR-1O
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:32:49 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:33316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iHofX-0004iK-Po; Tue, 08 Oct 2019 08:32:47 -0400
Received: by mail-yw1-xc42.google.com with SMTP id w140so4701798ywd.0;
 Tue, 08 Oct 2019 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=laQZPpYCWvsVBz1PuAewm2U9OUXfUMXrTOy5aXh8xIQ=;
 b=uc5+RcJAWT+x9DkD4X/LVe2Adi63siBZPBy7u3ZyUsweoc7pKq6cFOHwn1IrL7V5Z0
 EblbHmRilKMG2KVaehdj6Nru5bhSuhjBElSWZE7V5aRuYCaBOROkFk1f6QOYIjHNn334
 5+AJBZUUWY6HenfX6w+XgyWDPVaIPK2GFuKjgMiLTgVWEhPliGl0xa917s8NAuzFLl/7
 rshXvckNnbtpmaIwwmoPVIZwTTuQBaQ4/MBHGOIaqD5BYAw63h6DnyXpEBHJTX8SJSdt
 qsuSjJp5feZqlBoewjTyPUvfxeuWmcEqDTMAhHnN7vPpF3ZZDJgS0xhIlsoCk0ApLIPR
 e/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=laQZPpYCWvsVBz1PuAewm2U9OUXfUMXrTOy5aXh8xIQ=;
 b=YBqdSBcWnKIkXQUyfNVoR9c+cTe72sIyq+vW9zbZvalDtNcoRc2vm3OUcC8ziecp62
 LwQhB0VHhMnCtzZoEMu3Q1BqMvD2Qvm78KPWRIuaenKxl/6t33mbG1XsX3xHKsgAX7NV
 o9SmY3ft92Jqrt60P+B5a9eDl7EhCYQuUJRJ8zsiwufIbbdkNULS6+rmYZ6bbxWYdEgR
 yQaYjNwCQNDYQE4r5FgPnslmUuYGYPWkkgFfbvnCuNgMS6kd+yhMp0owu8u9MNqpycO7
 5OgTDiFdNcjQZMQyxKEPyfmjG9wC8fIKJ8zboWbeNwtQlYvWkKJvQksKSHEWYPVUx4CS
 4SeQ==
X-Gm-Message-State: APjAAAVXyRFGGygrjhsa8kl0XrqWrHJtulE1CRjIrN+gMPeogrbrU47q
 dvUlFx7prcDTSO9x+ZrCD7X2WG8L05fOHoP7ve8=
X-Google-Smtp-Source: APXvYqwcfxlxKUxOGCOs9SwCenXSO0fm/JPEb6i9apLSOyzSYXtmE1gj8uLyxFRFZX+hbbYbYOqimHj3mkgOn0PlyRM=
X-Received: by 2002:a81:4b41:: with SMTP id y62mr22951344ywa.67.1570537963429; 
 Tue, 08 Oct 2019 05:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191008001318.219367-1-jonathan@fintelia.io>
 <20191008001318.219367-4-jonathan@fintelia.io>
In-Reply-To: <20191008001318.219367-4-jonathan@fintelia.io>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 8 Oct 2019 20:32:30 +0800
Message-ID: <CAEUhbmVGnVi_5LKFXYL3fMoPLHrLMYK0p_8MvnugiNkyh35TtQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv: Make the priv register writable by
 GDB
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 8:20 AM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> Currently only PRV_U, PRV_S and PRV_M are supported, so this patch ensures that
> the privilege mode is set to one of them. Once support for the H-extension is
> added, this code will also need to properly update the virtualization status
> when switching between VU/VS-modes and M-mode.
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> ---
>  target/riscv/gdbstub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

