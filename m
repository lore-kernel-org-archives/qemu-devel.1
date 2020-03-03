Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB8BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC7A208C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqBUsGjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC7A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j946F-0004XE-32
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 04:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j945T-0003y9-SD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j945S-0002l8-Fm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:43:39 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j945S-0002l0-Ad
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:43:38 -0500
Received: by mail-ot1-x341.google.com with SMTP id v19so2336230ote.8
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 01:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t0T8dZS+FD7WOcLwP+Dts6793g7oyf//scpnHNrrWC4=;
 b=pqBUsGjJBQu8s9raJJpxz0BTmkfIptxBMcob8/+XF4cNL8fIIhWlz7H9nK4dTWbFXy
 hNP0bmAY4i8MiFcTvNXKXv+9qSJDSqgdRrEhPvpGl61DMI2AxvluW3noSlAVSndxwFZe
 pX1LNUbQxcRcyawpvQSkIDNF2nX7xtVmKG02vVYiLoypXfPWzn+VIXhNcUGXCra9o8ao
 ruqSe2nVmo10d1KOILUWWYR6A547ZmaVRvcqaqrXer0EsxEkkhaGe+AOgEbWAJzNQKIe
 KdsP8qsSUO6+i+8VZfaWg5mPAYOH3ssGHOYGYJDVnBJGbTb3x3i/185vtL1RXq9WA9iW
 wkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t0T8dZS+FD7WOcLwP+Dts6793g7oyf//scpnHNrrWC4=;
 b=ASVYIcikehZNKrgUfcRHTr7j/cXRjR+oJulmziVCUfbzjZvmxr2XGF8Wms1mV/NB/O
 6SmkyNvHWCHIVW2X0MkoTS+wdth9QTMvRSZiRJQFBVvWyUOZ6HPB33/3EpUA1V2mZqUJ
 B2gDWevCBIhYV5i6AQlLx+aEsa/acB2GzStBXSazpCXA7N78fr1gMI6Sn8IMXKl3RSRM
 Vu3vuVTTwTjiacyjCXtHERBqjGM46kPUPullO6vYGg/kQdOM60IrKmBougih2i/bCSQy
 WpXFOtvOiS9Uv7rdtCQJm89ETYOsIvx/y2djwRcVA7HEZbVueiDljNBnC/X1D9H/Qlwe
 YIlA==
X-Gm-Message-State: ANhLgQ2vNGrEOs6DuLYnNACVMcctsR8J6W7YCxB1hLYmQSVNhQzEzbjT
 cIRnm1LKvk7Dy8GDyhg4dYpeSn4iexZ/m80ucIU=
X-Google-Smtp-Source: ADFU+vsqkcC9jXZqkHI4r3CA7wObwPuEIu3miu8xcS/5QIpvbcozdhBGDC9NAa7pM9rohX2xTmslKiMlhs5jNDzCgrM=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr2574869otb.121.1583228617539; 
 Tue, 03 Mar 2020 01:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20200302232220.761-1-philmd@redhat.com>
In-Reply-To: <20200302232220.761-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 3 Mar 2020 10:42:57 +0100
Message-ID: <CAL1e-=jLe0zPCkCOYY_XXgVqAhAdAuiPqzn57mYv8YvVwDRihA@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: move @skipUnless decoration to test
 itself
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000058c374059ff02360"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000058c374059ff02360
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

12:22 AM Uto, 03.03.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> It appears ignore the decoration if just applied to the class.
>
> Fixes: 0484d9d4fbe9beacd
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> [PMD: Move decorations to each test function]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Alex, please accept this most complete version. Many thanks, Aleksandar

>  tests/acceptance/machine_mips_malta.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/machine_mips_malta.py
b/tests/acceptance/machine_mips_malta.py
> index 92b4f28a11..98463f7757 100644
> --- a/tests/acceptance/machine_mips_malta.py
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -30,8 +30,6 @@
>      CV2_AVAILABLE =3D False
>
>
> -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>  class MaltaMachineFramebuffer(Test):
>
>      timeout =3D 30
> @@ -91,6 +89,8 @@ def do_test_i6400_framebuffer_logo(self,
cpu_cores_count):
>              cv2.imwrite(debug_png, screendump_bgr)
>          self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
>
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>      def test_mips_malta_i6400_framebuffer_logo_1core(self):
>          """
>          :avocado: tags=3Darch:mips64el
> @@ -99,6 +99,8 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
>          """
>          self.do_test_i6400_framebuffer_logo(1)
>
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>          """
>          :avocado: tags=3Darch:mips64el
> @@ -108,6 +110,8 @@ def
test_mips_malta_i6400_framebuffer_logo_7cores(self):
>          """
>          self.do_test_i6400_framebuffer_logo(7)
>
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>          """
>          :avocado: tags=3Darch:mips64el
> --
> 2.21.1
>
>

--00000000000058c374059ff02360
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">12:22 AM Uto, 03.03.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a=
 href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; From: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">a=
lex.bennee@linaro.org</a>&gt;<br>
&gt;<br>
&gt; It appears ignore the decoration if just applied to the class.<br>
&gt;<br>
&gt; Fixes: 0484d9d4fbe9beacd<br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org">alex.bennee@linaro.org</a>&gt;<br>
&gt; [PMD: Move decorations to each test function]<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; ---</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amark=
ovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;</p>
<p dir=3D"ltr">Alex, please accept this most complete version. Many thanks,=
 Aleksandar<br></p>
<p dir=3D"ltr">&gt; =C2=A0tests/acceptance/machine_mips_malta.py | 8 ++++++=
--<br>
&gt; =C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance=
/machine_mips_malta.py<br>
&gt; index 92b4f28a11..98463f7757 100644<br>
&gt; --- a/tests/acceptance/machine_mips_malta.py<br>
&gt; +++ b/tests/acceptance/machine_mips_malta.py<br>
&gt; @@ -30,8 +30,6 @@<br>
&gt; =C2=A0 =C2=A0 =C2=A0CV2_AVAILABLE =3D False<br>
&gt;<br>
&gt;<br>
&gt; -@skipUnless(NUMPY_AVAILABLE, &#39;Python NumPy not installed&#39;)<br=
>
&gt; -@skipUnless(CV2_AVAILABLE, &#39;Python OpenCV not installed&#39;)<br>
&gt; =C2=A0class MaltaMachineFramebuffer(Test):<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0timeout =3D 30<br>
&gt; @@ -91,6 +89,8 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_c=
ount):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cv2.imwrite(debug_png,=
 screendump_bgr)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertGreaterEqual(tuxlogo_coun=
t, cpu_cores_count)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 @skipUnless(NUMPY_AVAILABLE, &#39;Python NumPy not inst=
alled&#39;)<br>
&gt; +=C2=A0 =C2=A0 @skipUnless(CV2_AVAILABLE, &#39;Python OpenCV not insta=
lled&#39;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0def test_mips_malta_i6400_framebuffer_logo_1core(s=
elf):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Darch:mips64el<br>
&gt; @@ -99,6 +99,8 @@ def test_mips_malta_i6400_framebuffer_logo_1core(sel=
f):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.do_test_i6400_framebuffer_logo(=
1)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 @skipUnless(NUMPY_AVAILABLE, &#39;Python NumPy not inst=
alled&#39;)<br>
&gt; +=C2=A0 =C2=A0 @skipUnless(CV2_AVAILABLE, &#39;Python OpenCV not insta=
lled&#39;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0def test_mips_malta_i6400_framebuffer_logo_7cores(=
self):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Darch:mips64el<br>
&gt; @@ -108,6 +110,8 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(=
self):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.do_test_i6400_framebuffer_logo(=
7)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 @skipUnless(NUMPY_AVAILABLE, &#39;Python NumPy not inst=
alled&#39;)<br>
&gt; +=C2=A0 =C2=A0 @skipUnless(CV2_AVAILABLE, &#39;Python OpenCV not insta=
lled&#39;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0def test_mips_malta_i6400_framebuffer_logo_8cores(=
self):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Darch:mips64el<br>
&gt; -- <br>
&gt; 2.21.1<br>
&gt;<br>
&gt;<br>
</p>

--00000000000058c374059ff02360--

