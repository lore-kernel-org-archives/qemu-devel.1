Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C0C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9852A20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ie/mczwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9852A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgY6-0007jD-PR
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izgXK-0006nu-8U
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izgXI-00022I-UU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:45:37 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izgXI-0001yP-Lc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:45:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so7026196wrh.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 04:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hYKVDDnLkIb4korsbU1DIAO8nK8iHZ0NEk0p10/SQ1k=;
 b=Ie/mczwVjSwBuFnQ7fmDku7jex302OT3gY6FDsWSUWquyGcoIKwp8+4ml6CicKnsYH
 TXCRX2gCU3EC6AkhjCiVhP7nXb47LU03/viMp4eYpDTyRsfUYCd+QHYES09t12//LADy
 GBqb6rw9YGp//d/8COSqfpqLKlYnTkmrqr4OXgJU0f3nesnNOdtuTQ9Mykj/WU8uUVsr
 X0JN9S06k9bBRukpQdScrlABMbngeX8TY5zeGYucR5dQ1pUlgayyKb4VDPnRzeEWMySg
 UDAbxnYoFUioGhwqDVkAmgOx8pFTPLl+eNMtLbWLhkkqff7tnzZ/906tIAdSto+BYxlJ
 CGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hYKVDDnLkIb4korsbU1DIAO8nK8iHZ0NEk0p10/SQ1k=;
 b=PyWvfaSpHXradD4Q56VWQ8q1s82felFc0PozLSogL7R+oPQyeOzNk5YqlwpIVVPOOp
 tgvOuMTeKN1Z6kUIFbe+VFUt5WWRLh5sLXfa2jGuM6N0e8OtY0oY44nTbIsIcsp4WdpM
 gst7ol5Np4LgzfMRCMlVIkmB271a7NuE5Gl2b+gSahFJGcBKhfA2tUwg+E3vHi2M+Gfz
 GlTLgDss9ma6+6yrg+7QPJaL32fNHaSRBo+N3JtRa4FeoAVohohJ90n07D8UmsomrWdT
 2yFM7wN5mKQ0I7R+37q0ocgj/7GENsCEuyd+xLrXxhv5TdTMqQmFcs+sjkPG/Ci47h/h
 KiWA==
X-Gm-Message-State: APjAAAWKLoSwU3Shk0FYpm+JJkgLGstRZgRyh3ET7n/tam22zF6uLjcK
 HxK3h7Q9k/5FOno+yCnRudI7HQ==
X-Google-Smtp-Source: APXvYqzpzCbyDfUBZrSkZTVyclSOFPXOXf8MX+l1rWTf7GzIDyR3+JrJ1KhGKKUPUz5Jpq7MxmHGYA==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr3609457wrp.321.1580993135299; 
 Thu, 06 Feb 2020 04:45:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g18sm3405662wmh.48.2020.02.06.04.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 04:45:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 33C291FF87;
 Thu,  6 Feb 2020 12:45:33 +0000 (GMT)
References: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: kuhn.chenqun@huawei.com
Subject: Re: [PATCH] tests/plugin: prevent uninitialized warning
In-reply-to: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
Date: Thu, 06 Feb 2020 12:45:33 +0000
Message-ID: <87d0ar995e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: qemu-trivial@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


kuhn.chenqun@huawei.com writes:

> From: Chen Qun <kuhn.chenqun@huawei.com>
>
> According to the glibc function requirements, we need initialise
>  the variable. Otherwise there will be compilation warnings:
>
> glib-autocleanups.h:28:3: warning: =E2=80=98out=E2=80=99 may be
> used uninitialized in this function [-Wmaybe-uninitialized]
>    g_free (*pp);
>    ^~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Queued to plugins/next with Thomas' single line suggestion, thanks.

> ---
>  tests/plugin/bb.c   | 2 +-
>  tests/plugin/insn.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index f30bea08dc..8b9da23a04 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -22,7 +22,7 @@ static bool do_inline;
>=20=20
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
> -    g_autofree gchar *out;
> +    g_autofree gchar *out =3D NULL;
>      out =3D g_strdup_printf("bb's: %" PRIu64", insns: %" PRIu64 "\n",
>                            bb_count, insn_count);
>      qemu_plugin_outs(out);
> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
> index 0a8f5a0000..c83b1c0157 100644
> --- a/tests/plugin/insn.c
> +++ b/tests/plugin/insn.c
> @@ -44,7 +44,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct q=
emu_plugin_tb *tb)
>=20=20
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
> -    g_autofree gchar *out;
> +    g_autofree gchar *out =3D NULL;
>      out =3D g_strdup_printf("insns: %" PRIu64 "\n", insn_count);
>      qemu_plugin_outs(out);
>  }


--=20
Alex Benn=C3=A9e

