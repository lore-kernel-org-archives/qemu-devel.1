Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0927C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C107208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IbtJ8Ha+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C107208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxBrD-0008QU-Va
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxBqn-0007tT-D7
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxBqm-0002o6-9d
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:03:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxBqm-0002nj-34
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:03:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id k18so27781196otr.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tC6Srj74zjvGWIhfZf4qft75KEFoF39M0w32NpsseYk=;
 b=IbtJ8Ha+oIhXenXWNMHwttWMaA/Q4Y0Fe/oXENFY30UHKM7nMDx/VnVqTk5T5JAILZ
 sAp+8Jwhht1mwAeZu5pn7ph7lQRJvqJCakrOQmqE9ZQxjsVRC2NIM5EqQi2eJKMqKAG7
 LsvGrgy2qoa75+Q34M8xkBcVmr/DNR7uwcCsGU2nLR+5pu1LOv5WnLypd8SFgr2ipEva
 ym4AXYBbvzjT4FrYND719C/CCdLXvWcapwLXCZZfLQW9aejIufjhwN0uF4nELA8TKwJu
 lAWXqjCzJ+FlPaoFprTHpNQlVDKTDR7RwRHaXThucI2yk+J7EN+PjatrbsJJAi5W5ZSI
 wuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tC6Srj74zjvGWIhfZf4qft75KEFoF39M0w32NpsseYk=;
 b=rQYAn+cpPws1uPKLGQp1QY4MXV+QGL85jCBrc16OjeACKlkuuW6Npt7EAa7z1wAnRt
 8uSXQke/lVI4M7lNcAn3AN+Djv0pxdFVzIF9wqgsZ0YxGD2ssp1SwQ3NOVC3YGh7hk8o
 VsqizLh15S672zuIVuHy4QUUvoK34XJ4OaR5uqX+7s1WoOBSk/jSAbo1chRWnABi+rxV
 +31i2fDNnm8vUfT/dZi8RyAzdeq0v8tm5R5rjOOcZC+drlejxmFlYVwqhJwUju6RNKkN
 TlkBSA3g+5VGbPgRVfvSk2OAwNAkMmEvqibbWTRKkUaXOxXY5kq9fKxssPJTw8F14H2B
 EAyg==
X-Gm-Message-State: APjAAAWEBZfhNon5QnNKwkPUI5/xB79Op261f+dw2VRntlIuGM0oksTa
 7GJNMNLKAK+gup1JjidlitbMxDqC43SCLQRDtbrKhw==
X-Google-Smtp-Source: APXvYqwxlNiDZeeZmOXzvUM+aOJoxivdHyhg3WkzTfg1jw1PnjH30ZfHISsC4mQbnMzaWrmtiHhwF1ScrhLG9dHpP6w=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr15868637oib.163.1565622187184; 
 Mon, 12 Aug 2019 08:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190812144442.30027-1-aaron@os.amperecomputing.com>
In-Reply-To: <20190812144442.30027-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2019 16:02:55 +0100
Message-ID: <CAFEAcA-GnPAL41MQouLxs_7y9Xj_E30k4Agx20eWObau2p02AA@mail.gmail.com>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] elf: Allow loading AArch64 ELF
 files
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
Cc: Peter Crosthwaite <crosthwaitepeter@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 at 15:46, Aaron Lindsay OS via Qemu-arm
<qemu-arm@nongnu.org> wrote:
>
> Treat EM_AARCH64 as a valid value when checking the ELF's machine-type
> header.
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  include/hw/elf_ops.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 690f9238c8..f12faa90a1 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -381,6 +381,12 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                  goto fail;
>              }
>              break;
> +        case EM_AARCH64:
> +            if (ehdr.e_machine != EM_AARCH64) {
> +                ret = ELF_LOAD_WRONG_ARCH;
> +                goto fail;
> +            }
> +            break;
>          default:
>              if (elf_machine != ehdr.e_machine) {
>                  ret = ELF_LOAD_WRONG_ARCH;
> --
> 2.17.1

What problem are we trying to solve here ? If I'm reading your patch
correctly then it makes no difference to execution, because we're
switching on 'elf_machine', and so this extra case is saying
"if elf_machine is EM_AARCH64, insist that ehdr.e_machine
is also EM_AARCH64", which is exactly what the default
case would do anyway. The only reason to add extra cases in
this switch is to handle the situation where a target's board/loader
code says "I can handle elf files of type X" but actually this
implicitly means it can handle both X and Y (so for EM_X86_64 we
need to accept both EM_X86_64 and EM_386, for EM_PPC64 we need to
accept both EM_PPC64 and EM_PPC, and so on). We don't have a
case like that for aarch64/arm because the boot loader code has
to deal with the 32 bit and 64 bit code separately anyway, so
we can pass in the correct value depending on whether the CPU
is 32-bit or 64-bit.

The code in hw/arm/boot.c passes in an elf_machine value of
EM_AARCH64 when it wants to load an AArch64 ELF file, so
for that the default case is OK. The code in hw/core/generic-loader.c
passes in 0 (EM_NONE) which will be handled by the check just
before this switch statement, so the default case should
work there too. Presumably there's some other code path
for ELF file loading that doesn't work that you're trying to fix?

thanks
-- PMM

