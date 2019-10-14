Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212922067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLQ7i4Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212922067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4ji-0002CC-8s
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iK4hf-0000ZO-Lg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iK4hd-00021Z-QK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:04:19 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iK4hd-00020G-JB; Mon, 14 Oct 2019 14:04:17 -0400
Received: by mail-lj1-x243.google.com with SMTP id f5so17538027ljg.8;
 Mon, 14 Oct 2019 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rhdrg81D3zFb/5jPiNttaG5jl5przVJq6yYoJEQEoZQ=;
 b=QLQ7i4Gf0Yeoxl7HlMx2eq7/1Hqi8jnLcvhxkFugP2X/0ea4utTCL3cCmvSy9ryNc2
 9dNMgGlNz9mmmPllGkOTkiWvoYDTszjKloWTBd0ROBiVFcpT8A0jIfboTnT5JtgCuu0y
 Ckkk5+6LOLyEYCESu/NyBOS/kNtwy3k+Liyhqt0EAszE6wQt/s2qaDxfgrXuj9CAcyl1
 IlijkljTuIuN1re+meWkEMQJkleoZKAnGJZ5ngihzPRYGGeomTw2nst5SXlheDTQRFPq
 8et2MQDOzNkWhNgpx+J3y98kOXgpwZpFLmH8Dw1FDMpIsGwWAfrT67YacTdKfa+SOp3y
 5PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rhdrg81D3zFb/5jPiNttaG5jl5przVJq6yYoJEQEoZQ=;
 b=W4+3VX6poNlj2whrgS1EE0qnARcdsbBgBo23wj1eNuuj2TXhTNNZ11A+LRL4I4n1Rm
 LLxygbC+vPuNt7zWmDVUZxO5Ol8RER/fst6SKvLZynLUq3iIjsHUe2jJdhuynIE1HKBh
 S1KMGobL4Ps7d1WhQF9ordwzIgNm8PgTYuW2CQXTOXc0jYQy7fV0pNkqNSKf38xTEwaj
 yvDdAWRYZwvVHe7s8T6pGWqzMEsRTT24Rxo5tr9G2XIeREZRvwd75FKPkW5dTO266zzP
 xoZrxoj7VSGUBPyQr3njkEZBRRIdSTHXZnWBAqoL2cB3vP1XDxG4NvZ5eHMSYuSeozJs
 rBDg==
X-Gm-Message-State: APjAAAUFqPGpLlt9hbyxHpdecMJlU1jKVbKr6QWCJx0cah8e3YTuJ85w
 e3H09jAv+v9qVs9x6ZgNfCVGxK1z9gwLReilCWo=
X-Google-Smtp-Source: APXvYqxBHIMMYSmafcCHSzgVK7CAZ9NnrhSYQXsHXRyzzILtza+boqtIAtQVbdU+YZrK0TCf5GQLixnyKz50cMhXXxY=
X-Received: by 2002:a2e:82cd:: with SMTP id n13mr19661355ljh.156.1571076254296; 
 Mon, 14 Oct 2019 11:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-32-alex.bennee@linaro.org>
In-Reply-To: <20191014104948.4291-32-alex.bennee@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 14 Oct 2019 10:59:07 -0700
Message-ID: <CAKmqyKPCYwYvD3hqJ1OW0KH3SjGpG7cypJw9V5sCg6bZ9ueUfw@mail.gmail.com>
Subject: Re: [PATCH v5 31/55] target/riscv: fetch code with translator_ld
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 robert.foley@futurewei.com, Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com,
 "Emilio G. Cota" <cota@braap.org>, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 14, 2019 at 4:20 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> From: "Emilio G. Cota" <cota@braap.org>
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index adeddb85f6..b26533d4fd 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -779,7 +779,7 @@ static void riscv_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cpu)
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>      CPURISCVState *env =3D cpu->env_ptr;
>
> -    ctx->opcode =3D cpu_ldl_code(env, ctx->base.pc_next);
> +    ctx->opcode =3D translator_ldl(env, ctx->base.pc_next);
>      decode_opc(ctx);
>      ctx->base.pc_next =3D ctx->pc_succ_insn;
>
> --
> 2.20.1
>
>

