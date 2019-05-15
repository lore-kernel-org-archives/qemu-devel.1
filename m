Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC001C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FFC2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xs/hhPCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FFC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQpNG-00076z-Ub
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:34:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQpMU-0006ma-DR
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQpMS-0005Vo-IA
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:34:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQpMQ-0005QS-Qk
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:34:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id e15so1643814wrs.4
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=bdY0P6ZgVJQfOhGOj72uiQUJ1QzQTauNRouRQdHptUY=;
	b=Xs/hhPCtrTnJvpZRsSgYKHBHIUYmj+ixz6juFhcrZHk1YMAVMW7QrXg2S3/g0GS2Vj
	WsCKSFbtvQuJK3LW/dkFLfjWl2QOW1+7MiyQWaFE3yexrT9lYT0VFaF+p97MeJf/4vWj
	zB0vV3RMoJMKf1Tjs3kjY1HefV232zKJib1t/ptJPLd/UgazvsXejGRzjv4M6TgNAiVl
	/du1ThL3nS705T+9PM5J+sGX58TEztGpJcRLaPuDS59kRT2aWbFLabRxmdSV3WJDlNcu
	qnqQzNshrAslz4zXYs9F39GBDiEeBCp1/8lA83wkHeuIQr+l8WPwz9OJZJ1UlX+UaP8t
	l9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=bdY0P6ZgVJQfOhGOj72uiQUJ1QzQTauNRouRQdHptUY=;
	b=nyMTTyxgkpkuvCJMwGim36FFy3CJu8M+eIo9xofgRwcvNZPFKRSyaTGlwg5qnR44PA
	wtJpGs0+VSoVpCFuqjSXx6KUL20lgma1wN/EbrvY/wuqQe+XVYzh2l1Da8e3ksLvelY3
	EyRCRHkmhVg7vvO46VpEGYsTAzlsiMyce8LunqGLvYjNc8qYyry5h/qxKPQySjVaTMOk
	he0KRMT199iyboB4hNPLQvF/qvDj021ja1imPWrb5UVBfkXqfbDHQwMp8DzP4tEH+JCF
	PXVImnikV4xRoPzspkC63pmB07qdgei/Z6XIJx/JJ3lyCkQVjb5AOUlKd6m/iNGxlnQ+
	N+oA==
X-Gm-Message-State: APjAAAX3cTaGcXtOiMoGOkjaf/u+CCqGliu+t9NuJyzmxZWSWTOVWwjX
	FIYW1hHzupbc27HEDsRtwODwjQ==
X-Google-Smtp-Source: APXvYqw4hL30qwZjMq87d63t4xYUnKVtjmROmAiVZBHX9vWfJj6vBRRCsO7JBltML90s6aQsl1acSA==
X-Received: by 2002:a5d:638a:: with SMTP id p10mr25467533wru.273.1557909240047;
	Wed, 15 May 2019 01:34:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c131sm1696935wma.31.2019.05.15.01.33.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 01:33:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 157161FF87;
	Wed, 15 May 2019 09:33:59 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-4-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-4-arilou@gmail.com>
Date: Wed, 15 May 2019 09:33:59 +0100
Message-ID: <874l5wnmko.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v9 03/27] gdbstub: Implement thread_alive
 (T pkt) with new infra
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
>  gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 621d689868..c47ef7dd9c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1498,6 +1498,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, =
void *user_ctx)
>      put_packet(s, "OK");
>  }
>
> +static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    CPUState *cpu;
> +
> +    if (!gdb_ctx->num_params) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    if (gdb_ctx->params[0].thread_id.kind =3D=3D GDB_READ_THREAD_ERR) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    cpu =3D gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
> +                      gdb_ctx->params[0].thread_id.tid);
> +    if (!cpu) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    put_packet(gdb_ctx->s, "OK");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1798,17 +1822,14 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'T':
> -        thread_kind =3D read_thread_id(p, &p, &pid, &tid);
> -        if (thread_kind =3D=3D GDB_READ_THREAD_ERR) {
> -            put_packet(s, "E22");
> -            break;
> -        }
> -        cpu =3D gdb_get_cpu(s, pid, tid);
> -
> -        if (cpu !=3D NULL) {
> -            put_packet(s, "OK");
> -        } else {
> -            put_packet(s, "E22");
> +        {
> +            static const GdbCmdParseEntry thread_alive_cmd_desc =3D {
> +                .handler =3D handle_thread_alive,
> +                .cmd =3D "T",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "t0"
> +            };
> +            cmd_parser =3D &thread_alive_cmd_desc;
>          }
>          break;
>      case 'q':


--
Alex Benn=C3=A9e

