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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFBACA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32D721925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Q+/OFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32D721925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57435 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLr2Y-0003mj-SI
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr08-0001Zp-4Y
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr06-0003cL-Qi
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:50:44 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLr06-0003cF-LT
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:50:42 -0400
Received: by mail-oi1-x241.google.com with SMTP id d140so3399957oib.5
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Vp0nySnYUjEDYRGvqDuCiKgcnjpgHeMd55ERJNAxMk0=;
 b=b3Q+/OFtizYbPTwc8zCm4mmSMmHpfPNioKGzfYuZpo3MebtU6ZfdcpB3qCJK6PmDF7
 3wBsG/IAM0oxbT/iow8icPDOwS9teu9E6/CRaRUxCp6PutQEB7CK5NcBHoYnd4cWthsP
 GNQeyKEz/ExOvcZsiEQSpxZwuUN2l+Jn1ewGgiw7dx5MzpEeg31Se5pU4jqL0pQKeG8o
 LfL3HO7aOa3NhTrvAVYRfb5BuI0/F/zCHUqPTZD7eVSHyyN9xqas4sAgOyzJWQjEB1lv
 48YMheTNkbS7XrAKMhTjxNLJ48v8A5tnNvne/iMTm4tPISvL0fVQ1e2mfKUz/EX/AP+z
 QRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Vp0nySnYUjEDYRGvqDuCiKgcnjpgHeMd55ERJNAxMk0=;
 b=mq3GGu9Hhb6sy/WfLv6svl8T+9gR9gUzHghvFnveTF0ssVvMpO7nyM8qr970QbCN6N
 UXvAIfIj1cMVDTV+ydIosfPsOw/5wtCxlts3iyOhcqBa+m9K8LqDBLxysRwaGnYbhNiJ
 kRYkuj+w8I8uETzc3v6tso/vcxGGifaKeNn4a98Gr/pbAWGji8lfyqJTjrtXeFRVAhU0
 HaGC2J+veL0UVSpMrTttqByBqQLuwIeUR7GVyHi7t30DjStj0F2sYxyf1FzGqhIthyjX
 gKqi5q4pn9wGwfgMn5Adty1ij2xMm/iabARnWHBNy9MknThSSy2dNlhdvJaBZA8CaxHq
 +uLA==
X-Gm-Message-State: APjAAAWorLXSFVFLHmtU9agsXwdjzvpAa1HAdPiruLAWbIgQ+ZjursS8
 YesYSQkCqECbT/IR2KIg8ZZ1vVgnC9mgabIM8YI=
X-Google-Smtp-Source: APXvYqxtOFuI4Q010eJeOYvykqVFBliN7QxahjJ3YvSN2a4CSzirrF32x6P/Q0CxebVhhyR83BgcAhWqXSe2r0wfucw=
X-Received: by 2002:aca:4d12:: with SMTP id a18mr11916627oib.79.1571500241908; 
 Sat, 19 Oct 2019 08:50:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 08:50:41
 -0700 (PDT)
In-Reply-To: <20191019153437.9820-12-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
 <20191019153437.9820-12-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 17:50:41 +0200
Message-ID: <CAL1e-=gBnztxV95V_BM5-7roLwr=TPrRmYizqi+YX2PbanwrAw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] tests/ssh_linux_malta: Fix 64-bit target tests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000aef78305954569ad"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aef78305954569ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Commit 9090d3332cdcc added tests for specific to the 32-bit
> machines, which inadvertently make the 64-bit tests failing.
> Now than we have this information available in the CPU_INFO
> array, use it to have the 64-bit tests back.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2: do not include Aleksandar Rikalo mailmap change
> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
> index 2139c80f5f..fc13f9e4d4 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -44,8 +44,8 @@ class LinuxSSH(Test):
>                }
>          }
>      CPU_INFO =3D {
> -        32: {'kernel_release': '3.2.0-4-4kc-malta'},
> -        64: {'kernel_release': '3.2.0-4-5kc-malta'}
> +        32: {'cpu': 'MIPS 24Kc', 'kernel_release': '3.2.0-4-4kc-malta'},
> +        64: {'cpu': 'MIPS 20Kc', 'kernel_release': '3.2.0-4-5kc-malta'}
>          }
>
>      def get_url(self, endianess, path=3D''):
> @@ -143,16 +143,16 @@ class LinuxSSH(Test):
>          else:
>              self.fail('"%s" output does not contain "%s"' % (cmd, exp))
>
> -    def run_common_commands(self):
> +    def run_common_commands(self, wordsize):
>          self.ssh_command_output_contains(
>              'cat /proc/cpuinfo',
> -            '24Kc')
> +            self.CPU_INFO[wordsize]['cpu'])
>          self.ssh_command_output_contains(
>              'uname -m',
>              'mips')
>          self.ssh_command_output_contains(
>              'uname -r',
> -            '3.2.0-4-4kc-malta')
> +            self.CPU_INFO[wordsize]['kernel_release'])
>          self.ssh_command_output_contains(
>              'cat /proc/interrupts',
>              'XT-PIC  timer')
> @@ -209,7 +209,7 @@ class LinuxSSH(Test):
>          stdout, _ =3D self.ssh_command('uname -a')
>          self.assertIn(True, [uname_m + " GNU/Linux" in line for line in
> stdout])
>
> -        self.run_common_commands()
> +        self.run_common_commands(wordsize)
>          self.shutdown_via_ssh()
>
>      def test_mips_malta32eb_kernel3_2_0(self):
> --
> 2.21.0
>
>
>

--000000000000aef78305954569ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Commit 9090d3332cdcc added tests for specific to the 3=
2-bit<br>
machines, which inadvertently make the 64-bit tests failing.<br>
Now than we have this information available in the CPU_INFO<br>
array, use it to have the 64-bit tests back.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---<br>
v2: do not include Aleksandar Rikalo mailmap change<br>
---<br>
=C2=A0tests/acceptance/linux_ssh_<wbr>mips_malta.py | 12 ++++++------<br>
=C2=A01 file changed, 6 insertions(+), 6 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:1=
4px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;=
</span><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/tests/acceptance/linux_ssh_<wbr>mips_malta.py b/tests/acceptan=
ce/linux_ssh_<wbr>mips_malta.py<br>
index 2139c80f5f..fc13f9e4d4 100644<br>
--- a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
+++ b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
@@ -44,8 +44,8 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0CPU_INFO =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 32: {&#39;kernel_release&#39;: &#39;3.2.0-4-4k=
c-malta&#39;},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 64: {&#39;kernel_release&#39;: &#39;3.2.0-4-5k=
c-malta&#39;}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 32: {&#39;cpu&#39;: &#39;MIPS 24Kc&#39;, &#39;=
kernel_release&#39;: &#39;3.2.0-4-4kc-malta&#39;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 64: {&#39;cpu&#39;: &#39;MIPS 20Kc&#39;, &#39;=
kernel_release&#39;: &#39;3.2.0-4-5kc-malta&#39;}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_url(self, endianess, path=3D&#39;&#39;):<br>
@@ -143,16 +143,16 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(&#39;&quot;%s&quo=
t; output does not contain &quot;%s&quot;&#39; % (cmd, exp))<br>
<br>
-=C2=A0 =C2=A0 def run_common_commands(self):<br>
+=C2=A0 =C2=A0 def run_common_commands(self, wordsize):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/cpuinfo&#39;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;24Kc&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.CPU_INFO[wordsize][&#39;cpu=
&#39;]<wbr>)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;uname -m&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mips&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;uname -r&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;3.2.0-4-4kc-malta&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.CPU_INFO[wordsize][&#39;<wb=
r>kernel_release&#39;])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/interrupts&#=
39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;XT-PIC=C2=A0 timer&#39=
;)<br>
@@ -209,7 +209,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout, _ =3D self.ssh_command(&#39;uname=
 -a&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertIn(True, [uname_m + &quot; GNU=
/Linux&quot; in line for line in stdout])<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_common_commands()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_common_commands(<wbr>wordsize)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.shutdown_via_ssh()<br>
<br>
=C2=A0 =C2=A0 =C2=A0def test_mips_malta32eb_kernel3_2_<wbr>0(self):<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000aef78305954569ad--

