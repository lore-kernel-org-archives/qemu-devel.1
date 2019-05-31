Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D7C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF2E24349
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2G6SMVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF2E24349
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhny-0006YB-00
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:42:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhmT-0005eS-37
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhmR-0005yf-WB
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:41:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWhmR-0005xv-Q1
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:41:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id d17so6107872wmb.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Lzlpq1HkhnpaPvn6nX8cdPTXodg+GdTp1awQk0BxCng=;
	b=K2G6SMVTHeCiz4aqpnBzjWpmbNAzrfoEGvRZ0Xd8Shfe+rILmISijvway1oVTU2vJh
	qud36rl4gSuROyZ/KyK98mwlEz/MwTL0f1ZCVEMrFBO6VjSI5ggZkl8pZNrkTDWgATWK
	iGcu66b2jZPMxYMs6uv4zr8ovH9rluoCVvb1VxCZP63nKd3ExwP96xgQQ2N3qUhJX70H
	C9DujzU7QbE9knFB93RyvmIF1DMrISfRwNy2v9H/uMii0sGieZDl+Va9Zjj9zDhRVtBW
	yKv/OwLgKe4YIMWAo69Pp+1BZ5909zYhNdh3Zcv8qbdzBoIV6htvIsFqvZKy3ZA/KLoA
	1RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Lzlpq1HkhnpaPvn6nX8cdPTXodg+GdTp1awQk0BxCng=;
	b=KMnY4IOLjEi5CFY/TUFBNnGQosh5K0GQnPaRtS0hjfgtUcr1uQi2+jgavkLLy9tHcN
	OKCa5ucl99j+PM8o3Y7teObbYLDfJBO0UOk6++kaUruOkZQJjeoOWPLfGqd5/HgR5xpp
	U30m7G/hW/MCXc1jqv2Rn2dSYZ7UpOI6GDxpZmopIgmB92nFnvn5bRt2PwzLj0lXppH3
	y5GcJ1oKl6B4cuNq+TO5QT5zAekZFdQ8/2WWmTgk87owg9N2hDLawi3tUUUBoGfPWCq3
	5o5MLPxAGMdsrkxg2XR1llDnV65MuSwbm6sdOp4U2WmQiPROLJQmeEKFB9fT9Xdun8YK
	1lkQ==
X-Gm-Message-State: APjAAAU+VIuh2zaFVH9gBacRKvZXtYrpiWDexn+Ne80DBFYkjybLU+1Y
	8m8JipgnSSyJ6tp/SXfX18xxqHssEtw=
X-Google-Smtp-Source: APXvYqzQuFIDNxey4ZmRus6fQjKgfPBAf0MBIxDDSIWWr/8QheXYC8gmQGWACvWSR+ljvLau6bKr9A==
X-Received: by 2002:a05:600c:506:: with SMTP id
	i6mr5925065wmc.57.1559310070671; 
	Fri, 31 May 2019 06:41:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id p2sm4029527wmp.40.2019.05.31.06.41.09
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 06:41:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5F5C21FF87;
	Fri, 31 May 2019 14:41:09 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
	<20190529064148.19856-15-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-15-arilou@gmail.com>
Date: Fri, 31 May 2019 14:41:09 +0100
Message-ID: <87v9xq91xm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v12 14/20] gdbstub: Implement file io (F
 pkt) with new infra
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 48 ++++++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 8a401e6527..ea85966b27 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1789,6 +1789,25 @@ static void handle_read_all_regs(GdbCmdContext *gd=
b_ctx, void *user_ctx)
>      put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>  }
>
> +static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (gdb_ctx->num_params >=3D 2 && gdb_ctx->s->current_syscall_cb) {
> +        target_ulong ret, err;
> +
> +        ret =3D (target_ulong)gdb_ctx->params[0].val_ull;
> +        err =3D (target_ulong)gdb_ctx->params[1].val_ull;
> +        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
> +        gdb_ctx->s->current_syscall_cb =3D NULL;
> +    }
> +
> +    if (gdb_ctx->num_params >=3D 3 && gdb_ctx->params[2].opcode =3D=3D (=
uint8_t)'C') {
> +        put_packet(gdb_ctx->s, "T02");
> +        return;
> +    }
> +
> +    gdb_continue(gdb_ctx->s);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1930,28 +1949,13 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          return RS_IDLE;
>      case 'F':
>          {
> -            target_ulong ret;
> -            target_ulong err;
> -
> -            ret =3D strtoull(p, (char **)&p, 16);
> -            if (*p =3D=3D ',') {
> -                p++;
> -                err =3D strtoull(p, (char **)&p, 16);
> -            } else {
> -                err =3D 0;
> -            }
> -            if (*p =3D=3D ',')
> -                p++;
> -            type =3D *p;
> -            if (s->current_syscall_cb) {
> -                s->current_syscall_cb(s->c_cpu, ret, err);
> -                s->current_syscall_cb =3D NULL;
> -            }
> -            if (type =3D=3D 'C') {
> -                put_packet(s, "T02");
> -            } else {
> -                gdb_continue(s);
> -            }
> +            static const GdbCmdParseEntry file_io_cmd_desc =3D {
> +                .handler =3D handle_file_io,
> +                .cmd =3D "F",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L,L,o0"
> +            };
> +            cmd_parser =3D &file_io_cmd_desc;
>          }
>          break;
>      case 'g':


--
Alex Benn=C3=A9e

