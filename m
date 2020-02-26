Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16785C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40BA20658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n91aUiDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40BA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75Ry-0006oy-3G
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j75Qj-0005ZJ-8z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j75Qh-0006qJ-QI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:45:25 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:34471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j75Qh-0006nI-KY; Wed, 26 Feb 2020 17:45:23 -0500
Received: by mail-io1-xd41.google.com with SMTP id 13so1043276iou.1;
 Wed, 26 Feb 2020 14:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5d1CV6r8BklASQY1Jw4Nc/D3ajahverohW7nU9wCTOk=;
 b=n91aUiDrlq6g4XBz8gLfsch1Sdv0yb/AxWVYPvsZfFrAioQumPPxE6SRR1Pdd8hOHV
 SIygIrQ3bM3uuoqr10vKef+XWFrPndPSkdpmeIrX3ZR2QlLmbne+ZtabsH4EZB15WYg7
 WOM0hWGp8AFXdaR0XTBAyh7XZ5QPOQhkotgOpncNaxFjlDXYLBx2fPpm1tZjvFwVJ94+
 p1bAsCuUsSXZxy/6bDhnYkUpges7GeaKZJ7VjMUcygaKC+e6XEnbc1ZOHRPOHrIyashs
 YL3tZIzHw+AXIlNi3ODLlttWCImseRcsLWJVwxMm8QX6VcvecMttxVeEN5GVlFjEBNU6
 daXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5d1CV6r8BklASQY1Jw4Nc/D3ajahverohW7nU9wCTOk=;
 b=jQ7DtDW2/KpxFyZ+lsG0QRrjlF6DERL+JRd9NwiC32j8H0tfeI4zX65qgC+/SA6ary
 dzPF/8hMaVzCI6vpyEpeKsfwK/F4dbJ6pvx9fsREA6VZErXd+qPGYPL72c6z2laaKQxq
 2AvwUy9gf7PVlYXC1Hs8eU1SDsd7mvfYm5JAimAYNBl57MKnBlYpTIDVuJCbTgT1ZQcF
 AJVx7xg8tGD1bUIsob9UnHJAGnTKL7PBf+SMErYeXdpK6iU7g+28mKhnb+x/zHd54Rwn
 u+KA5kDFxgS5b+FaVm27ZZW53McG9rcbzmVxhMrk3fS2hJ1D1OIvX34Ao1ZHKITRtVXO
 80DA==
X-Gm-Message-State: APjAAAWdWKRUManBxoKq3gjpqwTt4V0A9q82FHfd0JNg3APnMCUnkPCJ
 aL8cBig4O3092mUMyZYAScQ0XzCubSa7JY5eXcs=
X-Google-Smtp-Source: APXvYqys2shB5B44WqTI79gVgZGmWe6rf78IBGLvPcwvI5LpvV5z93EFK5WmZ4RQvmt7Lvt5FcIZkW43Onx3AtBA0yU=
X-Received: by 2002:a05:6602:158e:: with SMTP id
 e14mr993421iow.217.1582757122279; 
 Wed, 26 Feb 2020 14:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
In-Reply-To: <20200226181020.19592-5-alex.bennee@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 26 Feb 2020 23:45:11 +0100
Message-ID: <CAPan3WqTdC9+Vc3SvUEs+KUW7Ow-MuyJ0PewUH6aPNs44LdJsg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000a3d9f059f825cf4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000a3d9f059f825cf4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Wed, Feb 26, 2020 at 7:13 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> While 32mb is certainly usable a full system boot ends up flushing the
> codegen buffer nearly 100 times. Increase the default on 64 bit hosts
> to take advantage of all that spare memory. After this change I can
> boot my tests system without any TB flushes.
>

That great, with this change I'm seeing a performance improvement when
running the avocado tests for cubieboard.
It runs about 4-5 seconds faster. My host is Ubuntu 18.04 on 64-bit.

I don't know much about the internals of TCG nor how it actually uses the
cache,
but it seems logical to me that increasing the cache size would improve
performance.

What I'm wondering is: will this also result in TCG translating larger
chunks in one shot, so potentially
taking more time to do the translation? If so, could it perhaps affect more
latency sensitive code?


>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>


> ---
>  accel/tcg/translate-all.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 4ce5d1b3931..f7baa512059 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -929,7 +929,11 @@ static void page_lock_pair(PageDesc **ret_p1,
> tb_page_addr_t phys1,
>  # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
>  #endif
>
> +#if TCG_TARGET_REG_BITS =3D=3D 32
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
> +#else
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2 * GiB)
> +#endif
>

The qemu process now takes up more virtual memory, about ~2.5GiB in my
test, which can be expected with this change.

Is it very likely that the TCG cache will be filled quickly and completely?
I'm asking because I also use Qemu to do automated testing
where the nodes are 64-bit but each have only 2GiB physical RAM.

Regards,
Niek


>
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE \
>    (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
> --
> 2.20.1
>
>
>

--=20
Niek Linnenbank

--0000000000000a3d9f059f825cf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alex,<br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2020 at 7:13 PM Alex Benn=
=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>While 32mb is certainly usable a full system boot ends up flushing the<br>
codegen buffer nearly 100 times. Increase the default on 64 bit hosts<br>
to take advantage of all that spare memory. After this change I can<br>
boot my tests system without any TB flushes.<br></blockquote><div><br></div=
><div>That great, with this change I&#39;m seeing a performance improvement=
 when running the avocado tests for cubieboard.</div><div>It runs about 4-5=
 seconds faster. My host is Ubuntu 18.04 on 64-bit.</div><div><br></div><di=
v>I don&#39;t know much about the internals of TCG nor how it actually uses=
 the cache,</div><div>but it seems logical to me that increasing the cache =
size would improve performance.</div><div><br></div><div>What I&#39;m wonde=
ring is: will this also result in TCG translating larger chunks in one shot=
, so potentially</div><div>taking more time to do the translation? If so, c=
ould it perhaps affect more latency sensitive code?</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br></blockquote><div>Te=
sted-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">ni=
eklinnenbank@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
---<br>
=C2=A0accel/tcg/translate-all.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index 4ce5d1b3931..f7baa512059 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -929,7 +929,11 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_=
addr_t phys1,<br>
=C2=A0# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 ((size_t)-1)<br>
=C2=A0#endif<br>
<br>
+#if TCG_TARGET_REG_BITS =3D=3D 32<br>
=C2=A0#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)<br>
+#else<br>
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2 * GiB)<br>
+#endif<br></blockquote><div><br></div><div><div>The qemu process now takes=
 up more virtual memory, about ~2.5GiB in my test, which can be expected wi=
th this change.</div><div><br></div><div>Is it very likely that the TCG cac=
he will be filled quickly and completely? I&#39;m asking because I also use=
 Qemu to do automated testing</div><div>where the nodes are 64-bit but each=
 have only 2GiB physical RAM.</div><div><br></div><div>Regards,</div><div>N=
iek<br></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
=C2=A0#define DEFAULT_CODE_GEN_BUFFER_SIZE \<br>
=C2=A0 =C2=A0(DEFAULT_CODE_GEN_BUFFER_SIZE_1 &lt; MAX_CODE_GEN_BUFFER_SIZE =
\<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000000a3d9f059f825cf4--

