Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E48C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030D4206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrh8mOo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030D4206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNXj-0005BC-2p
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieNX6-0004k8-PZ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieNX5-00052k-Oh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:13:20 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ieNX5-00052C-It
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:13:19 -0500
Received: by mail-oi1-x241.google.com with SMTP id b8so7200343oiy.5
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 10:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=PFJ5EPu8tqeVW6zDhGM/QhXW/xXFq2JhNuZo+QcpDC8=;
 b=Vrh8mOo1DDaIJJti6TN6FJiqEuTf6YktirIa9wlhK6/7RgkETBNwCnoFpoU5uAhVcb
 2guQsGfHylDiUH2nMCKDQchPpKQ1aE1yrjNwyaXBHinDbQD7MEun0Kw+PsY3IFbT5nXs
 d8SmO1B3ppCAsc1fHj8FhlQTUqLs1KeF3Sb+08r5BIj/RIvZAdYr0IayvvX+NRAWXp4M
 65XDHKpjzlozUKLbr5eFLMogRzqGbnpBvGBghvwkHu4IDzH5MpYvY4ogbkwyDw4xb6cv
 d1OoK+9oSvMwUM0XUwOgI9DGLmTWojcNIXmI5cmsgJIONnrb8JJGhrW9N/Z4J/zufLZ/
 oUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=PFJ5EPu8tqeVW6zDhGM/QhXW/xXFq2JhNuZo+QcpDC8=;
 b=jf3oXtZGbAO+IHzi6Zpgmkms9dg3T6YQRyIp1/h+5d36M04UwBb1kzcPiqJDXWq6lW
 2+pnXGmETRsqguPYblE/iqPtuIMkIQvbazcwqS5hNxkQrrA7jsSPIr827ewM66uvsY8p
 cdPqQjNy0xwK3lMDno8GedbABGXKVZ7oLuX+IIj7ig3HePrEV0Nj1HZGkOFw5viZkNM7
 zAsiDBZmsxpTc+brGo+nl0qj/SAHnN98XFU9uKWz34hxr8M8kz3/t7zyi+GBNNO0iRzy
 3iwedXAp9aX+bO1Q1eOGJna/DPaUa//lZCUZOEy2kzxfqz/aot/cfUYsjiqwuxLt7A6K
 vakA==
X-Gm-Message-State: APjAAAX67+Ne+23ro2mrioqoe8FnRKhFlc/Y+0N0hjoXCF6V2LYr2vRi
 dEVwJMuV80nnrshVoDhfRwnncJV4WHD5cOt3P8E=
X-Google-Smtp-Source: APXvYqzQt900zj0W3X9JZh3jtqxTa/ynujfZYSwLRoPstO6Pph9JPihNetNPKxyK+qQ6Iy/OEyosEytMcpgyjuja54A=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr298336oif.53.1575915199027; 
 Mon, 09 Dec 2019 10:13:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 9 Dec 2019 10:13:18 -0800 (PST)
In-Reply-To: <20191208183922.13757-19-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-19-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Dec 2019 19:13:18 +0100
Message-ID: <CAL1e-=jN=Z+zzsyq3OuVAZ=WwqU05oFX=F8nkGn1Xt8PHe=brg@mail.gmail.com>
Subject: Re: [PATCH v38 18/22] target/avr: Add machine none test
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a25ec605994959ae"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a25ec605994959ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tests/machine-none-test.c | 1 +
>  1 file changed, 1 insertion(+)
>
>
You need to add a commit message explaining how adding a test is achieved
with this single line.



> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 5953d31755..3e5c74e73e 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {
>      /* tested targets list */
>      { "arm", "cortex-a15" },
>      { "aarch64", "cortex-a57" },
> +    { "avr", "avr6-avr-cpu" },
>      { "x86_64", "qemu64,apic-id=3D0" },
>      { "i386", "qemu32,apic-id=3D0" },
>      { "alpha", "ev67" },
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000a25ec605994959ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 8, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail=
.com">mrolnik@gmail.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om">amarkovic@wavecomp.com</a>&gt;<br>
---<br>
=C2=A0tests/machine-none-test.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br></blockquote><div><br></div><div>You need to add a commit message expla=
ining how adding a test is achieved with this single line.</div><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c<br>
index 5953d31755..3e5c74e73e 100644<br>
--- a/tests/machine-none-test.c<br>
+++ b/tests/machine-none-test.c<br>
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0/* tested targets list */<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;arm&quot;, &quot;cortex-a15&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;aarch64&quot;, &quot;cortex-a57&quot; },<br>
+=C2=A0 =C2=A0 { &quot;avr&quot;, &quot;avr6-avr-cpu&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;x86_64&quot;, &quot;qemu64,apic-id=3D0&quot; },=
<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;i386&quot;, &quot;qemu32,apic-id=3D0&quot; },<b=
r>
=C2=A0 =C2=A0 =C2=A0{ &quot;alpha&quot;, &quot;ev67&quot; },<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000a25ec605994959ae--

