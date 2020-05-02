Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 23:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFEEC20787
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 23:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyPBD1PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEEC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV1no-0005IU-4C
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 19:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jV1n3-0004gh-MA
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <johnnymarler@gmail.com>) id 1jV1n2-0006T4-Uf
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:43:25 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jV1n2-0006Sr-IB
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:43:24 -0400
Received: by mail-lj1-x243.google.com with SMTP id j3so6052893ljg.8
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 16:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=sMZ9QvpeQYNPVekn9kgOPIxFhZ6ybtI3VyLQ3ZX7Mw4=;
 b=RyPBD1PRxG54ZZF+YXZukgIycuiGDEIQjBuPsHEuz1gOjY2EULgWp0Zujt0RkimjJG
 +5kEu3Mq9WXGQ0ZUhoZ6g62aS2zAz3+z7ctZncwp0yBfNgXmCvvHhATwNs92t+CHMkz7
 uu2MXttZ/vJeiPK9hs5xsV0gqnGtV7LPhOR6ziGNIl+2OCfgpavBtLiUp15EYTk1aYXs
 EH8iDOT12q/tbnKBKFjGoBrqzZgic4/P8mWpUCNfJ9o0dB1icaJugx11d9subrx5USBV
 YHi0bEsFC6OQHxktPHJR42wGmJY9MgHWlNSy7yjtuxe9QVnQsvJbQ5YNDMsVGxw32Aps
 TGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=sMZ9QvpeQYNPVekn9kgOPIxFhZ6ybtI3VyLQ3ZX7Mw4=;
 b=rfVXc8UI2CtspfgrwsLbvh2JRoJ/OyxlbORedu6y8mbPALq8kFf+xbJdHtJJa04klS
 dZDqIj1jPx271f439VGLxT7kinV5TZwWUh1M5ExD0N8Vc/qoHJDjdRa4eE2Qmdwah0/4
 wv6bOrETkC8tXTLCk42z/rn1jpRZVxD4hOrPdAKCk1tqHbuSI47b4y9YRxwC0UICmlNx
 8EOT/FveITvVaWi84q0PImnm3AFcYY9NbfPQz232eoM0WsubWYUFe3tBaxU58zbshstI
 xdkUfMTffK5aHlubQaEY5P5gQTNcawfFzmkSmJxFwR6HljEVxgl2N3cOlQBiVG/vavDf
 GIKQ==
X-Gm-Message-State: AGi0PuZE31qLVla513rhQ5Zy38QA0kbZjE4+7aYv94uRiGpygivNH4AZ
 l/PI2F7nS4BWpsaHH/eu7f7EYhw+2fdTUZo/188w+wec+zlXpw==
X-Google-Smtp-Source: APiQypLPi5S6VQ8GjqSo+KS30yA6WHYd9iqmLc7Ys0Ym0VTJAYYgDT1BIsN+/BARKzlYEvJ+BmcO9dvEmer4UvU6RUQ=
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr6196459lji.272.1588463002316; 
 Sat, 02 May 2020 16:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200502161225.14346-1-johnnymarler@gmail.com>
In-Reply-To: <20200502161225.14346-1-johnnymarler@gmail.com>
From: Jonathan Marler <johnnymarler@gmail.com>
Date: Sat, 2 May 2020 17:43:12 -0600
Message-ID: <CACKT+Ao+hRRuSarAcWy0PDzV8u5CF9KQq07dgVsLmQddSTfj6Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mmap.c: fix integer underflow in target_mremap
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fdf19605a4b2dc84"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=johnnymarler@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fdf19605a4b2dc84
Content-Type: text/plain; charset="UTF-8"

FYI, I applied this patch to the qemu build that zig uses to run non-native
tests (
https://github.com/ziglang/qemu-static/blob/master/patch/mremap-underflow.diff
)

After applying it, my new code that calls mremap now passes, whereas before
the fix I was getting a segfault.

On Sat, May 2, 2020 at 10:12 AM Jonathan Marler <johnnymarler@gmail.com>
wrote:

> Fixes: https://bugs.launchpad.net/bugs/1876373
>
> This code path in mmap occurs when a page size is decreased with mremap.
> When a section of pages is shrunk, qemu calls mmap_reserve on the pages
> that were released.  However, it has the diff operation reversed,
> subtracting the larger old_size from the smaller new_size.  Instead, it
> should be subtracting the smaller new_size from the larger old_size.  You
> can also see in the previous line of the change that this mmap_reserve call
> only occurs when old_size > new_size.
>
> Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
> ---
>  linux-user/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index e378033797..caab62909e 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong
> old_size,
>          if (prot == 0) {
>              host_addr = mremap(g2h(old_addr), old_size, new_size, flags);
>              if (host_addr != MAP_FAILED && reserved_va && old_size >
> new_size) {
> -                mmap_reserve(old_addr + old_size, new_size - old_size);
> +                mmap_reserve(old_addr + old_size, old_size - new_size);
>              }
>          } else {
>              errno = ENOMEM;
> --
> 2.23.1
>
>

--000000000000fdf19605a4b2dc84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FYI, I applied this patch to the qemu build that zig uses=
=C2=A0to run non-native tests (

<a href=3D"https://github.com/ziglang/qemu-static/blob/master/patch/mremap-=
underflow.diff">https://github.com/ziglang/qemu-static/blob/master/patch/mr=
emap-underflow.diff</a>)<div><br><div>After applying it, my new code that c=
alls mremap now passes, whereas=C2=A0before the fix I was getting a segfaul=
t.</div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sat, May 2, 2020 at 10:12 AM Jonathan Marler &lt;<a href=
=3D"mailto:johnnymarler@gmail.com">johnnymarler@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Fixes: <a href=3D"=
https://bugs.launchpad.net/bugs/1876373" rel=3D"noreferrer" target=3D"_blan=
k">https://bugs.launchpad.net/bugs/1876373</a><br>
<br>
This code path in mmap occurs when a page size is decreased with mremap.=C2=
=A0 When a section of pages is shrunk, qemu calls mmap_reserve on the pages=
 that were released.=C2=A0 However, it has the diff operation reversed, sub=
tracting the larger old_size from the smaller new_size.=C2=A0 Instead, it s=
hould be subtracting the smaller new_size from the larger old_size.=C2=A0 Y=
ou can also see in the previous line of the change that this mmap_reserve c=
all only occurs when old_size &gt; new_size.<br>
<br>
Signed-off-by: Jonathan Marler &lt;<a href=3D"mailto:johnnymarler@gmail.com=
" target=3D"_blank">johnnymarler@gmail.com</a>&gt;<br>
---<br>
=C2=A0linux-user/mmap.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
index e378033797..caab62909e 100644<br>
--- a/linux-user/mmap.c<br>
+++ b/linux-user/mmap.c<br>
@@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong ol=
d_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_addr =3D mremap(g2h(ol=
d_addr), old_size, new_size, flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host_addr !=3D MAP_FAIL=
ED &amp;&amp; reserved_va &amp;&amp; old_size &gt; new_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_reserve(old_a=
ddr + old_size, new_size - old_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_reserve(old_a=
ddr + old_size, old_size - new_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOMEM;<br>
-- <br>
2.23.1<br>
<br>
</blockquote></div>

--000000000000fdf19605a4b2dc84--

