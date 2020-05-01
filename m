Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B10EC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6895208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="a+zV0LPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6895208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUze-0003Qa-Tp
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1jUUyl-0001eP-Mk
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1jUUyl-0000ft-27
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:41:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jUUyk-0000fg-Ei
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:41:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id d17so11371733wrg.11
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PK2iNFhfwANQTlrmQYIg27in7DXM4adVWh0GkmGvUkw=;
 b=a+zV0LPmmU/IzxvyybEVB88qyU+OqUliSEwZFMm9EjIGrFqnCvEYdeLX/PTYVaB/ZS
 Hoe+kb2RkdhZYwvxKsvAou2Bo+VKSCCXHE5GLVfCq052MvZVCd+2gUMAH7yYZwhpduFk
 8/h7SYVsLVVYdlD917/qhirCnzK2EtnTWQ1NQnKxxeFP5elfq1bdnCBJTzj7iqi+x+lO
 g1B9SHCZEK4hdDYXXG+qkpnov9DIE22ETWdNQFg151Pl7Zlwec6MaXn7zS3XHY9PMHro
 E5asXA0J66eleOgy7kvQrBPK4KoS8l7+ceDxDCirnUJvXtATXGcOYVF+57qnowD+xaIj
 dacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PK2iNFhfwANQTlrmQYIg27in7DXM4adVWh0GkmGvUkw=;
 b=qOdvxzOOG3bb1VEtgPvTf2UBt1V7yz1kqzHYdU65Ws9WUsFduYe2BkiyuggVI5cpz9
 GWFth+PyBkuurxRkg2f5w2LBtCt7QQDun20C7mHrA/94QI7ZsjyNxEVHA4A8GQE5Y1Ag
 qNUGSAO/4vToH2kRiNJrFsVd4EzL7T7NNsDJMnexR8hIOWyh5XPuK6svRQpyuGAjiv8d
 b2+EF1rq1U+/CZMJzXrYKPDg1uWlbtPkCH7qFAntM/TYEAepZY1dXI05SPXkmZrmakGm
 NuP4GarG6RYXkTp6ODdLs0pqDxFvDw67F1K98jOHbanxSGBxmncLkn7s1Z4E+BLGs3yH
 YiSw==
X-Gm-Message-State: AGi0PuawiEPgC4IFb8Eho0gJdwNh1wawl1hHVuQHq1IYZqKpOvhG6rAq
 dmYm3NGGW47ysj0nGbW5PuqtaqoQQpKCtwkYelXM+g==
X-Google-Smtp-Source: APiQypLVXGrzLPGMXDkZANDmWWAZcXcGEE05PynWb1ZKETB/7bF0muVJYO215yigh3IuwOvaH4vO466aFyFx6k57ezg=
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr4281412wrq.358.1588336876514; 
 Fri, 01 May 2020 05:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <1588336185-1051-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588336185-1051-1-git-send-email-bmeng.cn@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 May 2020 18:11:05 +0530
Message-ID: <CAAhSdy23Xrjfp4NxbwETsd6gG7mbhT5NOjFza6gpd-Rd=RbHEw@mail.gmail.com>
Subject: Re: [PATCH] riscv/spike: Change the default bios to use plain binary
 image
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=anup@brainfault.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 6:01 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> To keep sync with other RISC-V machines, change the default bios
> to use .bin instead of the .elf images.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  hw/riscv/spike.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index d0c4843..611a741 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -46,9 +46,9 @@
>  #include <libfdt.h>
>
>  #if defined(TARGET_RISCV32)
> -# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
> +# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.bin"
>  #else
> -# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
> +# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.bin"
>  #endif

This change breaks the console on the spike machine because
HTIF emulation depends on ELF parsing.

Keeping here ELF files was intentional because BIN files dont
work for Spike the machine.

Also, now that OpenSBI generic platform is available. We can
use same OpenSBI firmware binaries/elfs on virt, sifive_u, and
spike machines of QEMU. I think:
1. The QEMU build/makefile scripts for OpenSBI should be
updated to only build OpenSBI generic platform firmwares
2. The default BIOS_FILENAME in for virt, sifive_u, and
spike machines should be changed to use OpenSBI generic
platform firmwares.

It would be great if you can drop this patch and instead do
above two changes. Agree ??

Regards,
Anup

