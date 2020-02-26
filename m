Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D133CC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF8221556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggb7DDzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF8221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6t4T-0001zo-BI
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j6t3l-0001Ui-Qo
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j6t3k-0008Rd-Ow
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:32:53 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:33794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j6t3i-0008Ex-FY; Wed, 26 Feb 2020 04:32:50 -0500
Received: by mail-oi1-x22d.google.com with SMTP id l136so2397325oig.1;
 Wed, 26 Feb 2020 01:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sTxTWxs9ibr9SOfGmEzWE9VTkqwAdNoBkiyD4216zPQ=;
 b=ggb7DDzPY1wcF4IR9ockCQBFCDd4XShvYIwrahtfC2y7QQkQ1k8xQIFDlrXEtuO7/r
 s7uVPr7CcK+YdDoEjRm5dVSaexFbW3r5j1rw418HLcrxDWDiDxp2gG8II2LbK49EfMte
 1i9ZxoDazk7DlTqsY0RoM0tjHTiK6zlcSdKNKacaJO5uvHJdb6XDHYTCIyhsFz/pTVOd
 4jjvtydpBQi1g1TwuNkzn7KtHnctIf4sDZ1ao7X6G11eRAyLKkTmKSHsW7u/9MUpEciv
 9tr416K74TLodXlFhE690E+YtCbRKwnX+gdbkdZ8L9Y9RMtyZJOOkqTLQ+PG/zdY9jaU
 cAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sTxTWxs9ibr9SOfGmEzWE9VTkqwAdNoBkiyD4216zPQ=;
 b=PidYDBFqEzziyJg4A1WFv7tYOgYwP/Om61+L8Skxxc4lJuI+NZqNu2vDNW+PhfjosC
 h+CcSDykVEvn648zZUUexvHCgDbBUeafWKx4yfE2lkpaTnygY8Af6UZxaamR/nuTAbOo
 xkd/iNY1q/zpjRCLzo+SXKibWI8odGId9M0HYinFEi7U/wBX2yJrivhRtli6ixl9hD5g
 /jmD8bQo4KyMUDSniKdSk0F8nH70j8uMKMih0vMieZCiUGueN+LvY90G5YJH9RlAJFnI
 BlURKWlYkjYE5Q4NwA+HyWCaX9LX7sN28qevQEXplpLQhC4cHdNpSfXKDsnQH1u0pCip
 Ceew==
X-Gm-Message-State: APjAAAUGhIjkgB91I+u+h1IFz9CGDfgrY/T736jbqLpTRcT9lIEKPFKe
 lWTHryGkgNS+AZplxKkDIognIEObs94t4Fkw3hQ=
X-Google-Smtp-Source: APXvYqxdJbx9rXVK19qPpJbv0W1xhEU8v09BZhJXZvZvIcHYNLdCDRhMwzF36Jgw2SuLORieePbbAzPh/erIy8dE3UQ=
X-Received: by 2002:a05:6808:209:: with SMTP id
 l9mr2346556oie.112.1582709569687; 
 Wed, 26 Feb 2020 01:32:49 -0800 (PST)
MIME-Version: 1.0
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <20200226101948.786be4b0@redhat.com>
In-Reply-To: <20200226101948.786be4b0@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 26 Feb 2020 10:32:38 +0100
Message-ID: <CABLmASFMv5MziuMKBdi0wydB9bKVZ-uYJ4_B_0a-YUQVk0nHYw@mail.gmail.com>
Subject: Re: Sudden slowdown of ARM emulation in master
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000af1356059f774996"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000af1356059f774996
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 26, 2020 at 10:19 AM Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 26 Feb 2020 00:07:55 +0100
> Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> > Hello Igor and Paolo,
>
> does following hack solves issue?
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a08ab11f65..ab2448c5aa 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -944,7 +944,7 @@ static inline size_t size_code_gen_buffer(size_t
> tb_size)
>          /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
>             static buffer, we could size this on RESERVED_VA, on the text
>             segment size of the executable, or continue to use the
> default.  */
> -        tb_size = (unsigned long)(ram_size / 4);
> +        tb_size = MAX_CODE_GEN_BUFFER_SIZE;
>  #endif
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>
>

Nice, for me, that brings qemu-system-ppc back up to speed. (applied to
ppc-for-5.0)

Best,
Howard

--000000000000af1356059f774996
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2020 at 10:19 AM Igor=
 Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Wed, 26 Feb 2020 00:07:55 +0100<br>
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_=
blank">nieklinnenbank@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Hello Igor and Paolo,<br>
<br>
does following hack solves issue?<br>
<br>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index a08ab11f65..ab2448c5aa 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -944,7 +944,7 @@ static inline size_t size_code_gen_buffer(size_t tb_siz=
e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ??? If we relax the requirement that C=
ONFIG_USER_ONLY use the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static buffer, we could size this=
 on RESERVED_VA, on the text<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 segment size of the executable, o=
r continue to use the default.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D (unsigned long)(ram_size / 4);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D MAX_CODE_GEN_BUFFER_SIZE;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size &lt; MIN_CODE_GEN_BUFFER_SIZE) {<br>
<br></blockquote><div>=C2=A0</div><div><br></div><div>Nice, for me, that br=
ings qemu-system-ppc back up to speed. (applied to ppc-for-5.0)<br></div><d=
iv><br></div><div>Best,</div><div>Howard<br></div></div></div>

--000000000000af1356059f774996--

