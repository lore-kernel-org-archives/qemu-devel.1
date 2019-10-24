Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B4BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C208F20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPbIzcEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C208F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZrP-0000Sp-4o
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNZKt-0001ft-0K
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNZKr-0002AA-RO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:23:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iNZKr-0002A0-M7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:23:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id u13so1275932ote.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=+XJ4Cv/T9MrwXNsXCajk8jJpFQcyKBN1wz8SsXLS2ak=;
 b=bPbIzcEU5qEv0A9oe5kG+CjeJGwXlIS1lc4PFb2U2IrkwxntACMD+vRHXb5lGZ4sNi
 Taqp38zz1dombd2CYvhj6VNXSV7vZ170HWWgvtMlUb6GMhLpcx0TAEeLyisru1fdzb2u
 4TnG6bBeJW2/1PjZ8hNjwznQg/y3mYnzJ7LiHjtoMyaQu1DXANtvA9n3tplS6WxagA6R
 EMXEhLYbDXwBkx81Nm5oadZlacvJjOEzgWlo3WldGN/pKkVXxcNdr0ZZtMIAoF8WuKlf
 HexQN2Hr8fUyMa4cpFoIhAwLoi4lC817RWGq9MqftsaO2Q9+PNZPzMyftXfkwNuf6sIY
 KOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=+XJ4Cv/T9MrwXNsXCajk8jJpFQcyKBN1wz8SsXLS2ak=;
 b=NaxMjSVeItjIcijdl+TV9E0ROAzOuJOZIpSxDWo3B2vUtr9qcQI/45QLchtjJiCXv+
 KNiwvyBe/yFecjwPf+nB8kRmJkJ/7DDLKbENUxVKnNtigsto3Ma1TY4NME4/zAhzHhMP
 eMDfTHN4tCn/FgmKl7g0s754fr2luSvgb+o0TtYLFHxzQnxLsHTtKMiS6GJkYoG6baJr
 7ucoV23vofCdZ98a3+dWKOCKmvRcWieRRlCujcN/Zn+LonH/ZuSor2D1lSXkfTmvfwiQ
 TZzIJFreHilxj2nb3I2ttkxgKlucgIVCTWUupVE94Ep3GK7GKToTmJLC7ShbaCgUiQKd
 MMFQ==
X-Gm-Message-State: APjAAAUohSLBHSqp751QrOp6OUOl79dOhTOvOFCOP3pAFqXeh73sSK2K
 B9IvTupb0JUov83AVWdZnQE3iIK2MGT+4qMZ5I+OfA==
X-Google-Smtp-Source: APXvYqw4TV2KacXFl1PgtY/cUeYLpoXC4x1fvRZ7LQynWxlBIO0KLVLWm+NejH+xc4/k3JNjMbI9WH7DKrr751Gz0T8=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr10793065oth.306.1571908993008; 
 Thu, 24 Oct 2019 02:23:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 24 Oct 2019 02:23:12
 -0700 (PDT)
In-Reply-To: <20191019153437.9820-3-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
 <20191019153437.9820-3-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 24 Oct 2019 11:23:12 +0200
Message-ID: <CAL1e-=jxproknNBjJcD6zWku8-tJtQr4gZG_+o1CPYbycv9TWA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] tests/acceptance: Fixe wait_for_console_pattern()
 hangs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000025cee80595a49553"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000025cee80595a49553
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Because of a possible deadlock (QEMU waiting for the socket to
> become writable) let's close the console socket as soon as we
> stop to use it.
>
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 1 +
>  1 file changed, 1 insertion(+)
>
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/tests/acceptance/avocado_qemu/__init__.py
> b/tests/acceptance/avocado_qemu/__init__.py
> index e3101cba30..a0450e5263 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -74,6 +74,7 @@ def wait_for_console_pattern(test, success_message,
> failure_message=3DNone):
>          if success_message in msg:
>              break
>          if failure_message and failure_message in msg:
> +            console.close()
>              fail =3D 'Failure message found in console: %s' %
> failure_message
>              test.fail(fail)
>
> --
> 2.21.0
>
>
>

--00000000000025cee80595a49553
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:philmd@redhat.com">philmd@redhat.com</a>&gt;<br>
<br>
Because of a possible deadlock (QEMU waiting for the socket to<br>
become writable) let&#39;s close the console socket as soon as we<br>
stop to use it.<br>
<br>
Suggested-by: Cleber Rosa &lt;<a href=3D"mailto:crosa@redhat.com">crosa@red=
hat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/avocado_qemu/<wbr>__init__.py | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br></blockquote><div><br></div><div><br></div><div id=3D"cvcmsg_16de4b6417=
ee4d84" class=3D"yh  " style=3D"border-top-left-radius:0px;border-top-right=
-radius:0px;margin-bottom:11px;overflow:visible"><div class=3D"Vh" id=3D"cv=
cfullmsg_16de4b6417ee4d84"><div id=3D"cvcmsgbod_16de4b6417ee4d84" class=3D"=
aj"><div class=3D"Ni"><div class=3D"ni pi " dir=3D"ltr"><div><span style=3D=
"color:rgb(34,34,34)">Reviewed-by: Aleksandar Markovic &lt;</span><a href=
=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank">amarkovic@wavecomp.com=
</a><span style=3D"color:rgb(34,34,34)">&gt;</span></div><div style=3D"clea=
r:both"></div></div><div style=3D"clear:both"></div><div><div class=3D"M j =
T b hc Aj S" tabindex=3D"0"><div class=3D"V j hf"></div></div></div><div st=
yle=3D"clear:both"></div></div></div></div></div><div id=3D"cvcmsg_16de4b7a=
4e116812" class=3D"yh" style=3D"margin-bottom:11px"><div class=3D"Vh" id=3D=
"cvcfullmsg_16de4b7a4e116812"><div class=3D"M j Zi Mi  " tabindex=3D"0"><di=
v id=3D"cvcreply_16de4b7a4e116812" class=3D"M j T b hc xh S  " tabindex=3D"=
0"><div class=3D"V j td"></div></div></div></div></div><div>=C2=A0<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
diff --git a/tests/acceptance/avocado_<wbr>qemu/__init__.py b/tests/accepta=
nce/avocado_<wbr>qemu/__init__.py<br>
index e3101cba30..a0450e5263 100644<br>
--- a/tests/acceptance/avocado_<wbr>qemu/__init__.py<br>
+++ b/tests/acceptance/avocado_<wbr>qemu/__init__.py<br>
@@ -74,6 +74,7 @@ def wait_for_console_pattern(test, success_message, failu=
re_message=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if success_message in msg:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if failure_message and failure_message in=
 msg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 console.close()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail =3D &#39;Failure messa=
ge found in console: %s&#39; % failure_message<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test.fail(fail)<br>
=C2=A0<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--00000000000025cee80595a49553--

