Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C14C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCD321883
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ahofx90K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCD321883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2tgw-000179-Pl
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 04:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2tfu-0000eh-GQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2tfs-0007nV-U4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:51:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2tfs-0007n6-Mn
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:51:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id 10so1847768wmp.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8uoz9aqCD6Y5SAxlOwcwVl+807kLE1w+KtLGLp2iHks=;
 b=Ahofx90KOznFsmBlKP1nk77MqgqF9NiZ7p7FMkXQOWc9O3IGgds5wGyAH7PntSkEX8
 7Q2Siu6VSgvF/jOF5ATGdzSr83jv5lQo3kjiaoFeRAvysS9cur56rgCgNUS37RMDbks3
 pNoXmh7P/jSsy8Hr1Zj2UOPy5yFwOnBPTotoqnw4o0b9zfRFWGBoZOZuTmkIlhOQhmup
 Y3khJhNAK4xxC+DVOFWlncIUjZTvLp499n7/iqaXU/QCUrukIqGIbimoBm0IPL0yeuG7
 jsR/OD3PnOq4fvqwZ+C7HbkuejDfs1aCOS8YDiDpLsWy0SR5TY1/rlxUshFNqgI71i8W
 Letw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8uoz9aqCD6Y5SAxlOwcwVl+807kLE1w+KtLGLp2iHks=;
 b=Ln26BK8selzs2lRGsg8L4yvq1YzrL7cJ5qCJ9QsXW0JaqKFnJJI9OiugDrOHfaogms
 RzCr14Hbk2grLvNAJ+H/rCvpYirvfLPbs4RZvAUbtYZki/70weqyW9/IsnFEHoRsuPSM
 8rPszeiTnpvozTdT1Sg2QkEpt4XNpNMFD3+F6bJ9cR44A7DWzj9fTnkzsWzUXetxdAph
 r22UkRo8z5vEl5SC9dV9wzC+7UL+VTTunGLljFF/JleFO+z+BNOVbgrd/L7WZU1gQHnx
 Q6Rx8aBDoQvvvODMxInAv8D3lCnpGNYDwBvQvrrQ/1UJ2BmLMBS1Km0PdbJ327aq2Ua5
 0ZDA==
X-Gm-Message-State: APjAAAX12Vk08Pbg/466f4Q9GPZD03y5DRGD1Kb/wFvVi0nbZMOZNOeF
 WWNJdbz0B6no5OVEGEEUb1z9eA==
X-Google-Smtp-Source: APXvYqzLyavaBHKfdNoZ30UZATNIvtxrWUxDro8/dV2PrBbacGusmNk4MEpOYCgt2pH0vjEkeaX3qg==
X-Received: by 2002:a1c:c011:: with SMTP id q17mr3329775wmf.82.1566982287319; 
 Wed, 28 Aug 2019 01:51:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w125sm2859761wmg.32.2019.08.28.01.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 01:51:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01E491FF87;
 Wed, 28 Aug 2019 09:51:25 +0100 (BST)
References: <20190827223317.8614-1-sandra@codesourcery.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sandra Loosemore <sandra@codesourcery.com>
In-reply-to: <20190827223317.8614-1-sandra@codesourcery.com>
Date: Wed, 28 Aug 2019 09:51:25 +0100
Message-ID: <87lfvd65bm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH V3] gdbstub: Fix handler for 'F' packet
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Sandra Loosemore <sandra@codesourcery.com> writes:

> Handling of the 'F' packet has been broken since commit
> 4b20fab101b9e2d0fb47454209637a17fc7a13d5, which converted it to use
> the new packet parsing infrastructure.  Per the GDB RSP specification
>
> https://sourceware.org/gdb/current/onlinedocs/gdb/The-F-Reply-Packet.html
>
> the second parameter may be omitted, but the rewritten implementation
> was failing to recognize this case.  The result was that QEMU was
> repeatedly resending the fileio request and ignoring GDB's replies of
> successful completion.  This patch restores the behavior of the
> previous code in allowing the errno parameter to be omitted and
> passing 0 to the callback in that case.
>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>

Queued to gdbstub/next, thanks.

> ---
>  gdbstub.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index b92ba59..3e8bcd0 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1820,11 +1820,15 @@ static void handle_read_all_regs(GdbCmdContext *g=
db_ctx, void *user_ctx)
>
>  static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
>  {
> -    if (gdb_ctx->num_params >=3D 2 && gdb_ctx->s->current_syscall_cb) {
> +    if (gdb_ctx->num_params >=3D 1 && gdb_ctx->s->current_syscall_cb) {
>          target_ulong ret, err;
>
>          ret =3D (target_ulong)gdb_ctx->params[0].val_ull;
> -        err =3D (target_ulong)gdb_ctx->params[1].val_ull;
> +        if (gdb_ctx->num_params >=3D 2) {
> +            err =3D (target_ulong)gdb_ctx->params[1].val_ull;
> +        } else {
> +            err =3D 0;
> +        }
>          gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
>          gdb_ctx->s->current_syscall_cb =3D NULL;
>      }


--
Alex Benn=C3=A9e

