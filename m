Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471AECA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1251B21925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6wYtBJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1251B21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLr2e-0003vS-Ph
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr1X-0002eZ-Dc
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr1V-0004F0-IQ
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:52:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLr1U-0004EY-Gx
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:52:09 -0400
Received: by mail-ot1-x342.google.com with SMTP id s22so7523686otr.6
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=rMvTHWSOELfGobs11eDl0bpoEmKZrHWotVbs9e1qf+g=;
 b=f6wYtBJbcmuHjhI11SbCM/acPcShGDpBI6sdi6tn3DbJLu6JxZrtnx8xtEZLP+llZi
 4sVW+4o4qgtc9GUX3QCLA0SL4O9NpptR9WL4BeQqGsXxJAvHPhNl8iSzaxKtEaKOMMq8
 ZsxPWV5c4rsVZXX8436jxoeqIucFbr4nrKyFDqOzMEzpbUVvHCp0OpTXKBvEFeTFB1x2
 a9YPUty+mp4o5HJS3pMbq2JzBsIzD3G0Z2yQpEakX+JAlmINYfxhZZKDpTT8mEAg3t2g
 7vyCbRmbW7hqyIjfoD+Q06GQZzH2an81DGNn7wlpmHR+jIeUMJY1ZB0ENpZWY4T58z2f
 uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=rMvTHWSOELfGobs11eDl0bpoEmKZrHWotVbs9e1qf+g=;
 b=ZnXkbpLUvUg4AYx0f8PsLmTxCJvi59j36BCd3UKgAILLuFqqw31PvFT5VepW6V0Ppn
 1lO2VPPuD6D+b9P7HLJXWwhzGgIdtsIN637wNKpKRYIkfPqSxRzEoTtZ1LI2KsLO1we2
 wioO+t3kaEkXMIolqrDJlwbSZArvKWvp9sD5HQSXMsh6nKjpXxrpQg/eho2Ov6HxI9Q/
 elZxcLUXmg6IMhIfXcrOTOuM6lUF4Mtma1wuAl303dcZWuHB0tFc6Gqt2u/6NQafwOp7
 4Kr53iysFyOxhuJQTWLlh0p0ifdbHQ/VfcCEmw+bhpfLvW3iXUqILPdTBOMIcEtRK6W3
 UmEw==
X-Gm-Message-State: APjAAAUp+TccGmfak5lXAkSrAOmfnK+Lh7MCM64nCUi9Pdl1Ka/dd/9I
 vBqcLhws1vXXTgfLYt7mhHylSKQLLmhVTwlB3En5rA==
X-Google-Smtp-Source: APXvYqxiyP4lT3uFIQgpcWBFsekbGtMz8TQr4kNlJ7Hwnbb3sMAHEU1NmMRj/QBw8Bj9YPnQX+yaNpkBirL5AbygxRE=
X-Received: by 2002:a05:6830:1d8f:: with SMTP id
 y15mr11346602oti.121.1571500327906; 
 Sat, 19 Oct 2019 08:52:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 08:52:07
 -0700 (PDT)
In-Reply-To: <20191019153437.9820-8-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
 <20191019153437.9820-8-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 17:52:07 +0200
Message-ID: <CAL1e-=gbYePGuLdXv836YwYJ7Tt_GZ2mFUbqGorDPnXuF-38fA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] tests/ssh_linux_malta: Run tests using a
 snapshot image
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000cf33230595456e94"
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
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cf33230595456e94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> If a test fails, it can corrupt the underlying QCow2 image,
> making further tests failing.
> Fix this by running each test with a snapshot.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
> index ffbb06f846..27907e8fbd 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -90,7 +90,7 @@ class LinuxSSH(Test):
>          self.vm.add_args('-no-reboot',
>                           '-kernel', kernel_path,
>                           '-append', kernel_command_line,
> -                         '-hda', image_path,
> +                         '-drive', 'file=3D%s,snapshot=3Don' % image_pat=
h,
>                           '-netdev', 'user,id=3Dvnet,hostfwd=3D:127.0.
> 0.1:0-:22',
>                           '-device', 'pcnet,netdev=3Dvnet')
>          self.vm.launch()
> --
> 2.21.0
>
>
>

--000000000000cf33230595456e94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">If a test fails, it can corrupt the underlying QCow2 i=
mage,<br>
making further tests failing.<br>
Fix this by running each test with a snapshot.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/linux_ssh_<wbr>mips_malta.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:1=
4px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;=
</span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/tests/acceptance/linux_ssh_<wbr>mips_malta.py b/tests/acceptan=
ce/linux_ssh_<wbr>mips_malta.py<br>
index ffbb06f846..27907e8fbd 100644<br>
--- a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
+++ b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
@@ -90,7 +90,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.add_args(&#39;-no-reboot&#39;,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;-kernel&#39;, kernel_path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;-append&#39;, kernel_command_line,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-hda&#39;, image_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-drive&#39;, &#39;file=3D%s,snapshot=3Don&#39; % imag=
e_path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;-netdev&#39;, &#39;user,id=3Dvnet,hostfwd=3D:127.0.<=
wbr>0.1:0-:22&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;-device&#39;, &#39;pcnet,netdev=3Dvnet&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.launch()<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000cf33230595456e94--

