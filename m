Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AD3FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252D420578
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9xjPhLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252D420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4zO-0007P4-06
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iT4xn-0006CK-VX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iT4xm-0004je-FH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:10:11 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iT4xm-0004hC-55
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:10:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id q130so6379208wme.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 06:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/pn2Iv+e8/6OQk51iVo3eORg6hRd6yNId8amn99GTLo=;
 b=d9xjPhLdkRYUdWCZsvbejyyzjdW1h2UlJFYqyI6LtRuwynxXCwn3RkkgpR+daG+7uf
 6YDXATvfa7Km2pleTbCIqQRtnqqf6Vo7VSspFFL/+rRpyuHs0F3UhIdk6u0zS8ghFst+
 HcyxL7iVlyyaNXLlOw/U0uh3N0aSIKoKwF3VCuh+tKI4ZPrPixs89MBdOlmrojZ0fks9
 xGpK58Ze7rgvaSvJpj1RBVAASi94evq43Og25SuXQpIy2I21gG5lMT8UyKUPVG0WtuN3
 cEkqSFe1856QwjJRughE8Jp1xHyeG2BnoHqiB9/vzZaqyhH3q9bGv08z+2xt/ryg3djg
 JYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/pn2Iv+e8/6OQk51iVo3eORg6hRd6yNId8amn99GTLo=;
 b=s2MlhYej/QIzYqV0wiyKjl7NICSOum2BYaiDUjHGSx15yJntjNtdFA3yRnRs8zjS7L
 wwbNNigwDP+Cf1lcisxv8r8/5IDp4I3liDw6zrDL4b/AqLAudixNuyMWKg9vma4VqyLF
 dQ607Z2IkmyGlBGO5xQ/DasmzG7cHVHeAbr5YuIDlL/B4PVljmGPvEyhT5P8NSZLgtVP
 Csai+6SETMTePoEHuvt7PoBXj2A3cXvMy004xRSpBcPD0MWb7KB6l3977DWsJzNMK+wT
 7CFwgY8ikTIUep1Hhdj/n/XJIXn/rM+7TbAuCzID6BjiEicfSU6cCIoKK1mOxWE43/xO
 MxEQ==
X-Gm-Message-State: APjAAAVaQ6fzfMqixOOxe9vhilSRp5R4RDNWSpIgEqzUMrYqelLh4Jry
 8qwaNOiZE6LIczEs9BSGFbgyGQ==
X-Google-Smtp-Source: APXvYqz+uGIXZy/HpMZE5KsusnVJwXwUGPUJK5S//E2p25WD1BJHwNmFGa5MDdrDxkXU4pyI9pI6HQ==
X-Received: by 2002:a1c:7701:: with SMTP id t1mr9096306wmi.113.1573222208388; 
 Fri, 08 Nov 2019 06:10:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t134sm6395165wmt.24.2019.11.08.06.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 06:09:56 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C9EA71FF87;
 Fri,  8 Nov 2019 14:09:52 +0000 (GMT)
References: <20191108125534.114474-1-damien.hedde@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH] gdbstub: Fix buffer overflow in handle_read_all_regs
In-reply-to: <20191108125534.114474-1-damien.hedde@greensocs.com>
Date: Fri, 08 Nov 2019 14:09:52 +0000
Message-ID: <877e4ah32n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Damien Hedde <damien.hedde@greensocs.com> writes:

> Ensure we don't put too much register data in buffers. This avoids
> a buffer overflow (and stack corruption) when a target has lots
> of registers.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>
> Hi all,
>
> While working on a target with many registers. I found out the gdbstub
> may do buffer overflows when receiving a 'g' query (to read general
> registers). This patch prevents that.
>
> Gdb is pretty happy with a partial set of registers and queries
> remaining registers one by one when needed.

Heh I was just looking at this code with regards to SVE (which can get
quite big).

>
> Regards,
> Damien
> ---
>  gdbstub.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 4cf8af365e..dde0cfe0fe 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1810,8 +1810,17 @@ static void handle_read_all_regs(GdbCmdContext *gd=
b_ctx, void *user_ctx)
>      cpu_synchronize_state(gdb_ctx->s->g_cpu);
>      len =3D 0;
>      for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
> -        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf +=
 len,
> -                                 addr);
> +        int size =3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_b=
uf + len,
> +                                     addr);
> +        if (len + size > MAX_PACKET_LENGTH / 2) {
> +            /*
> +             * Prevent gdb_ctx->str_buf overflow in memtohex() below.
> +             * As a consequence, send only the first registers content.
> +             * Gdb will query remaining ones if/when needed.
> +             */

Haven't we already potentially overflowed gdb_ctx->mem_buf though? I
suspect the better fix is for str_buf is to make it growable with
g_string and be able to handle arbitrary size conversions (unless the
spec limits us). But we still don't want a hostile gdbstub to be able to
spam memory by asking for registers that might be bigger than
MAX_PACKET_LENGTH bytes.

> +            break;
> +        }
> +        len +=3D size;
>      }
>
>      memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);


--
Alex Benn=C3=A9e

