Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC919C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 23:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E992075C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 23:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M24Hm80L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E992075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibCSJ-0008A5-LS
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 18:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibCRN-0007Yg-5l
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 18:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibCRK-0000kD-Np
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 18:46:17 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibCRK-0000jo-G7
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 18:46:14 -0500
Received: by mail-oi1-x243.google.com with SMTP id 6so3963600oix.7
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 15:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=kDIZGzME0paJpfLNXjJUYP5Oremr5UVC59Ye3H3vcFE=;
 b=M24Hm80LYIRLUCLDARUp5AJRWOKwFX7W1a9g0Oa2MraEgdVdV6g7yfpZNxv94W2y2b
 0B4VaF6/SQlPyxRdq4KhWzjjusuh9j3mOCfmMjyMtZVu1RS50OnJYvtIAj/ahcX+Fc2M
 AAVMXDW7W0Y+V8uLr9JwSoL2OWOo/vtJbHtlTGgxUVrtRdUFRy1yhpyQ13T5bcFrwkrp
 spDZb1CRkEveJnE0ImIrAOHa4cDfI/nbhxhhymqMk6JGV3iNqRNMv/O3yuNZerWcBx8z
 6EPtAMi6gP9g1x5PgfL/JfV7nm1bvnf0wy0hvoS74wDA+xPYxYODmpUteMs5okc3Gh1E
 NVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=kDIZGzME0paJpfLNXjJUYP5Oremr5UVC59Ye3H3vcFE=;
 b=kSrqJWJ0gIVNZ8eF2BbHIzGCPZS8J1T5Lozxno57ruXBwEqd+gM9wbJpdKSVeBCKz5
 ZIlPkPq+wSm1iMtzbd7jpOzMChPB6Udz0QL1yhquA/EIzQjO9s93quEdjUprIlGf11tV
 YwgadUdgb2mHgS7P06yXfZ/wY/LQaqdtsYI0fbNn6Yzedk6lhOvMuGEpC9NKsiQ5/aQX
 OTfXe9NFC2ZqDaDV1BiM8ynJI5GxMh5050NUgVVr7ADr3NgwNxq+0DIgNAjE05KvW1a8
 OAXvrM+G02Qsj/mj9AGTwXmtIwwRioBVdJmTAIGDvbhvlRN35HLJuJVuipUcASL5HHBP
 QncQ==
X-Gm-Message-State: APjAAAVczwW4pck9ZeV4kIooo+ezLqf5S7KODMWk0q6dTSrkD8CXkn95
 BVjsSYTt9uXTPbThdYR2ToAuB/39SSql/ethaSs=
X-Google-Smtp-Source: APXvYqwMZAdIzIjjEmXqnOMGBNyv//KAoOPYJv/jJhgNh3Qgkqbslb3qEkNK0SgDupH4Q6HG06Z6RM0+8aifsp+UuPc=
X-Received: by 2002:aca:1817:: with SMTP id h23mr10903385oih.53.1575157573341; 
 Sat, 30 Nov 2019 15:46:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 30 Nov 2019 15:46:12
 -0800 (PST)
In-Reply-To: <1574687098-26689-3-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-3-git-send-email-Filip.Bozuta@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 1 Dec 2019 00:46:12 +0100
Message-ID: <CAL1e-=jeECJRjOR+Mo79D5VA8q0gSZsf__MOtRhiU0fgDF1DRA@mail.gmail.com>
Subject: Re: [PATCH 2/5] mips: malta: Renovate coding style
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, Cleber Rosa <crosa@redhat.com>, 
 Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009fd643059898f3b9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009fd643059898f3b9
Content-Type: text/plain; charset="UTF-8"

On Monday, November 25, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote:

> The script checkpatch.pl located in scripts folder was
> used to detect all errors and warrnings in files:
>     hw/mips/mips_malta.c
>     hw/mips/gt64xxx_pci.c
>     tests/acceptance/linux_ssh_mips_malta.py
>
> All these mips malta machine files were edited and
> all the errors and warrings generated by the checkpatch.pl
> script were corrected and then the script was
> ran again to make sure there are no more errors and warnings.
>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  hw/mips/mips_malta.c                     | 139
> ++++++++++++++++---------------
>  tests/acceptance/linux_ssh_mips_malta.py |   6 +-
>  2 files changed, 75 insertions(+), 70 deletions(-)
>
>
Very good cleanup!

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

I think this snippet is good, but I am just in case cc-ing Cleber and
Eduardo to check if it is in accordance with any applicable guidelines of
our test framework:


> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
> index fc13f9e..44e1118 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -99,10 +99,12 @@ class LinuxSSH(Test):
>      def ssh_command(self, command, is_root=True):
>          self.ssh_logger.info(command)
>          result = self.ssh_session.cmd(command)
> -        stdout_lines = [line.rstrip() for line in
> result.stdout_text.splitlines()]
> +        stdout_lines = [line.rstrip() for line
> +        in result.stdout_text.splitlines()]
>          for line in stdout_lines:
>              self.ssh_logger.info(line)
> -        stderr_lines = [line.rstrip() for line in
> result.stderr_text.splitlines()]
> +        stderr_lines = [line.rstrip() for line
> +        in result.stderr_text.splitlines()]
>          for line in stderr_lines:
>              self.ssh_logger.warning(line)
>          return stdout_lines, stderr_lines
> --
> 2.7.4
>
>
>

--0000000000009fd643059898f3b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 25, 2019, Filip Bozuta &lt;<a href=3D"mailto:Fi=
lip.Bozuta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">The script <a href=3D"http://checkpatch.pl" target=3D"_b=
lank">checkpatch.pl</a> located in scripts folder was<br>
used to detect all errors and warrnings in files:<br>
=C2=A0 =C2=A0 hw/mips/mips_malta.c<br>
=C2=A0 =C2=A0 hw/mips/gt64xxx_pci.c<br>
=C2=A0 =C2=A0 tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
<br>
All these mips malta machine files were edited and<br>
all the errors and warrings generated by the <a href=3D"http://checkpatch.p=
l" target=3D"_blank">checkpatch.pl</a><br>
script were corrected and then the script was<br>
ran again to make sure there are no more errors and warnings.<br>
<br>
Signed-off-by: Filip Bozuta &lt;<a href=3D"mailto:Filip.Bozuta@rt-rk.com">F=
ilip.Bozuta@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 139 ++++++++++++++++--------------<wbr>-<br>
=C2=A0tests/acceptance/linux_ssh_<wbr>mips_malta.py |=C2=A0 =C2=A06 +-<br>
=C2=A02 files changed, 75 insertions(+), 70 deletions(-)<br>
<br></blockquote><div><br></div><div>Very good cleanup!</div><div><br></div=
><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200=
008392334px">Reviewed-by: Aleksandar Markovic &lt;</span><a href=3D"mailto:=
amarkovic@wavecomp.com" style=3D"font-size:14px;line-height:22.120000839233=
4px">amarkovic@wavecomp.com</a><span style=3D"color:rgb(34,34,34);font-size=
:14px;line-height:22.1200008392334px">&gt;</span></div><div><span style=3D"=
color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"><br></sp=
an></div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height=
:22.1200008392334px">I think this snippet is good, but I am just in case cc=
-ing Cleber and Eduardo to check if it is in accordance with any applicable=
 guidelines of our test framework:</span></div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
diff --git a/tests/acceptance/linux_ssh_<wbr>mips_malta.py b/tests/acceptan=
ce/linux_ssh_<wbr>mips_malta.py<br>
index fc13f9e..44e1118 100644<br>
--- a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
+++ b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
@@ -99,10 +99,12 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0def ssh_command(self, command, is_root=3DTrue):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.ssh_logger.info" t=
arget=3D"_blank">self.ssh_logger.info</a>(command)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D self.ssh_session.cmd(command)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout_lines =3D [line.rstrip() for line in re=
sult.stdout_text.splitlines(<wbr>)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout_lines =3D [line.rstrip() for line<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 in result.stdout_text.splitlines(<wbr>)]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for line in stdout_lines:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.ssh_=
logger.info" target=3D"_blank">self.ssh_logger.info</a>(line)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr_lines =3D [line.rstrip() for line in re=
sult.stderr_text.splitlines(<wbr>)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stderr_lines =3D [line.rstrip() for line<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 in result.stderr_text.splitlines(<wbr>)]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for line in stderr_lines:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_logger.warning(lin=
e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return stdout_lines, stderr_lines<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--0000000000009fd643059898f3b9--

