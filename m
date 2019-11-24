Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C9C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 15:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A8C2068F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 15:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhrKRBjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A8C2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYtfy-0001Qj-FJ
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 10:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYtf0-0000fE-0o
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 10:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYtew-0000hg-Aw
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 10:18:48 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYtew-0000hT-5k
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 10:18:46 -0500
Received: by mail-ot1-x342.google.com with SMTP id f10so10406759oto.3
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2019 07:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Z2WIBwEePziTuQ5NJ4LVMrOk74ugpdS0btxltdIPJY8=;
 b=vhrKRBjkkok2RRxzlFrAXX5KffaZoDiEbuwfHYSAx+tgCZo2DSWGGqwqD8Zk8/eZa0
 GeYdEByRVlskgw6PzUU0lNfdLJPo1mfWUDLdfZP+mlI1DmbidCfoOw6ePyuPPtWdxEqm
 KCjxIeRHFkFVgIEu6+YwNR8Ys23XoCxX92blGBjaaL/ItOrXqH+Y/UdGhW+z3HX1wfa6
 7w0ZX/x+iXdfjH5LjBxotImCJV61ifZiKrv56KCazym+uk7blZ9lYDPBpOBHPrfSc0nX
 UreraUAiC5AXoH2O07QfVHFnQS1uceXSQJSpi1iLPF9pblRQt7wlzZk3umzGqJaJs9Hp
 RA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Z2WIBwEePziTuQ5NJ4LVMrOk74ugpdS0btxltdIPJY8=;
 b=aWpKMx7vu59XPiTwKHZQMn3Zg9HHRppKUIgXLEzQ0DPv+Z26K4Zscma61WUN6xqfK6
 SFLNyyRD01hR+ugFtqPjcR4tZmFBOY9OM377nSGTE8GmpoprzWK6lOSqnBeYCOaLfBiK
 z9vmj7vr1obqgSExmb2GLModXiNWelSfqCFZ5AnTXowJ25xoBvlGkGaI1q/nWkQrEsPZ
 2kBqz0rdVpE2jSU33d0Ys19TvKgrNpw4Ih99j0KjQMJ18eTId3L75SKLVcYP3MJ8jgb8
 1QAWzfg/vY0a6gRUG3clQVx2cPXs3UfkZyDWLrGWM8jPCc3ELlEahL48kn6/ImwmZ840
 1nIw==
X-Gm-Message-State: APjAAAUr7lX5llodh/8jXHYM4cRey8Wbt9zhIs+mKSZxXPl8E5dNY75j
 tdgSqnG8lnmdkMcO0UsACQEvMjYmCXss9ULPBsM=
X-Google-Smtp-Source: APXvYqxOKZCEPTMBCL6MBE83CxBUALF0MVlG12oGCteP8eA7/utw4gMQWTPf6XuwT99ir/zkWpgjxx9uVcXIJGJLnA0=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr18447935otc.295.1574608725296; 
 Sun, 24 Nov 2019 07:18:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 24 Nov 2019 07:18:44
 -0800 (PST)
In-Reply-To: <20191124050225.30351-17-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-17-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 24 Nov 2019 16:18:44 +0100
Message-ID: <CAL1e-=h5xX0-i+jOTX371uknU3aAW7nAvubUWfB0t_P=YE+Q3w@mail.gmail.com>
Subject: Re: [PATCH v36 16/17] target/avr: Add Avocado test
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bb49dd05981929fe"
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bb49dd05981929fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> The test is based on
> https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
> demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out.
> it also demostrates that timer and IRQ are working
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---


License preamble missing.


>  tests/acceptance/machine_avr6.py | 36 ++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 tests/acceptance/machine_avr6.py
>
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_
> avr6.py
> new file mode 100644
> index 0000000000..0601080b01
> --- /dev/null
> +++ b/tests/acceptance/machine_avr6.py
> @@ -0,0 +1,36 @@
> +import logging
> +import time
> +import distutils.spawn
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado.utils import process
> +
> +class AVR6Machine(Test):
> +    timeout =3D 5
> +
> +    def test_freertos(self):
> +        """
> +        :avocado: tags=3Darch:avr
> +        :avocado: tags=3Dmachine:sample
> +        """
> +        """
> +        https://github.com/seharris/qemu-avr-tests/raw/master/
> free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
> +        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEF
> GHIJKLMNOPQRSTUVWX'
> +        """
> +        rom_url =3D 'https://github.com/seharris/qemu-avr-tests'
> +        rom_url +=3D '/raw/master/free-rtos/Demo/
> AVR_ATMega2560_GCC/demo.elf'
> +        rom_hash =3D '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
> +        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
> +
> +        self.vm.set_machine('sample')
> +        self.vm.add_args('-bios', rom_path)
> +        self.vm.add_args('-nographic')
> +        self.vm.launch()
> +
> +        time.sleep(2)
> +        self.vm.shutdown()
> +
> +        match =3D 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> +
> +        self.assertIn(match, self.vm.get_log())
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000bb49dd05981929fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, November 24, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">The test is based on<br>
<a href=3D"https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos=
/Demo" target=3D"_blank">https://github.com/seharris/<wbr>qemu-avr-tests/tr=
ee/master/<wbr>free-rtos/Demo</a><br>
demo which. If working correctly, prints &#39;ABCDEFGHIJKLMNOPQRSTUVWX&#39;=
 out.<br>
it also demostrates that timer and IRQ are working<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com">philmd@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
Acked-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.=
com</a>&gt;<br>
---</blockquote><div><br></div><div>License preamble missing.</div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
=C2=A0tests/acceptance/machine_avr6.<wbr>py | 36 ++++++++++++++++++++++++++=
++++<wbr>++<br>
=C2=A01 file changed, 36 insertions(+)<br>
=C2=A0create mode 100644 tests/acceptance/machine_avr6.<wbr>py<br>
<br>
diff --git a/tests/acceptance/machine_<wbr>avr6.py b/tests/acceptance/machi=
ne_<wbr>avr6.py<br>
new file mode 100644<br>
index 0000000000..0601080b01<br>
--- /dev/null<br>
+++ b/tests/acceptance/machine_<wbr>avr6.py<br>
@@ -0,0 +1,36 @@<br>
+import logging<br>
+import time<br>
+import distutils.spawn<br>
+<br>
+from avocado import skipUnless<br>
+from avocado_qemu import Test<br>
+from avocado.utils import process<br>
+<br>
+class AVR6Machine(Test):<br>
+=C2=A0 =C2=A0 timeout =3D 5<br>
+<br>
+=C2=A0 =C2=A0 def test_freertos(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:avr<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:sample<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/seharris/qemu-av=
r-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf" target=3D"_b=
lank">https://github.com/seharris/<wbr>qemu-avr-tests/raw/master/<wbr>free-=
rtos/Demo/AVR_ATMega2560_<wbr>GCC/demo.elf</a><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 constantly prints out &#39;<wbr>ABCDEFGHIJKLMN=
OPQRSTUVWXABCDEF<wbr>GHIJKLMNOPQRSTUVWX&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_url =3D &#39;<a href=3D"https://github.com=
/seharris/qemu-avr-tests" target=3D"_blank">https://github.com/seharris/<wb=
r>qemu-avr-tests</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_url +=3D &#39;/raw/master/free-rtos/Demo/<=
wbr>AVR_ATMega2560_GCC/demo.elf&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_hash =3D &#39;<wbr>7eb521f511ca8f2622e0a3c=
5e8dd68<wbr>6efbb911d4&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_path =3D self.fetch_asset(rom_url, asset_h=
ash=3Drom_hash)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;sample&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-bios&#39;, rom_path)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-nographic&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.shutdown()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D &#39;<wbr>ABCDEFGHIJKLMNOPQRSTUVWXAB=
CDEF<wbr>GHIJKLMNOPQRSTUVWX&#39;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(match, self.vm.get_log())<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000bb49dd05981929fe--

