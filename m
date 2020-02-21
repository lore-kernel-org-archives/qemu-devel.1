Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C05C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB0F24653
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Kx9YyE8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB0F24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j57eq-0004cp-6o
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 07:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j57c5-00042p-13
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j57c3-0005ed-Lr
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:41:00 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:48490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j57c3-0005dZ-6L
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:40:59 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A85E996EF0;
 Fri, 21 Feb 2020 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582288856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4oAOsKxluNQcjR2kc/FmNsEGFD0balpHW5f8Xxp7zY=;
 b=Kx9YyE8Lx1aNV5GM0VuLHDfygnpFrUCUTTkaPuSQx9PbpuwrjnIIy3szjb+PJ6Mklpc5Pt
 Hc27wtrsxPrhiVRELhPj/gxR9NCtp1BEjSv+rej1LmxB34+oz2dc9k1N9HvIJmg0SSMXap
 JyMEcmhZBf/zUBCaVPrDIVHgHgenUd0=
Subject: Re: [PATCH v2] gdbstub: Fix single-step issue by confirming
 'vContSupported+' feature to gdb
To: Changbin Du <changbin.du@gmail.com>, alex.bennee@linaro.org,
 philmd@redhat.com
References: <20200221002559.6768-1-changbin.du@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <669a56c9-0c9a-5d49-1a83-185d05f7b750@greensocs.com>
Date: Fri, 21 Feb 2020 13:40:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221002559.6768-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582288857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4oAOsKxluNQcjR2kc/FmNsEGFD0balpHW5f8Xxp7zY=;
 b=KsPuLMA/EmWMdTRt5l5SbuaNB57DQ3scbkpy4uX8meM8rorYxEQDL3JX35ygmAn5KEUzSl
 8P0Up8gAwIUNdiSv+vV/YTgOmCqDf4xdH9BScFf9Uor5nnRWuHuOL6xx6U7lwoj5zKM+VX
 g2lOvJMYlL2fbUwR2G17xELQE1EcTw8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582288857; a=rsa-sha256; cv=none;
 b=Fy99uyOZ9deiO7X3IkovbK6Gi0O2050DmabtYdzvevaxg+6QblijRWFkY3ObxSVskAV/C7
 fi9E9s54KJbdZjEWU3lX6n4LyDhSwYVFkBCTmGmOaAm0C8MalxiQJz0nuBstm2HIjhp71p
 8fw653rcVoNK9QlWnMW6NKXNGGZ+DJo=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 1:25 AM, Changbin Du wrote:
> Recently when debugging an arm32 system on qemu, I found sometimes the
> single-step command (stepi) is not working. This can be reproduced by
> below steps:
>  1) start qemu-system-arm -s -S .. and wait for gdb connection.
>  2) start gdb and connect to qemu. In my case, gdb gets a wrong value
>     (0x60) for PC, which is an another bug.
>  3) After connected, type 'stepi' and expect it will stop at next ins.
>=20
> But, it has never stopped. This because:
>  1) We doesn't report =E2=80=98vContSupported=E2=80=99 feature to gdb e=
xplicitly and gdb
>     think we do not support it. In this case, gdb use a software breakp=
oint
>     to emulate single-step.
>  2) Since gdb gets a wrong initial value of PC, then gdb inserts a
>     breakpoint to wrong place (PC+4).
>=20
> Not only for the arm target, Philippe has also encountered this on MIPS=
.
> Probably gdb has different assumption for different architectures.
>=20
> Since we do support =E2=80=98vContSupported=E2=80=99 query command, so =
let's tell gdb that
> we support it.
>=20
> Before this change, gdb send below 'Z0' packet to implement single-step=
:
> gdb_handle_packet: Z0,4,4
>=20
> After this change, gdb send "vCont;s.." which is expected:
> gdb_handle_packet: vCont?
> put_packet: vCont;c;C;s;S
> gdb_handle_packet: vCont;s:p1.1;c:p1.-1
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

>=20
> ---
> v2: polish commit message.
> ---
>  gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index ce304ff482..adccd938e2 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2111,7 +2111,7 @@ static void handle_query_supported(GdbCmdContext =
*gdb_ctx, void *user_ctx)
>          gdb_ctx->s->multiprocess =3D true;
>      }
> =20
> -    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess=
+");
> +    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";vContSupport=
ed+;multiprocess+");
>      put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>  }
> =20
>=20

