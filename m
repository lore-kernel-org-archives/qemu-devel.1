Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A73DCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B9121925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vffGMfAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B9121925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLr3v-0005wl-Fd
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr12-00026B-5y
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr0x-0003yK-8v
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:51:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLr0v-0003xN-J1
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:51:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id i185so7681883oif.9
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qNrnxA2vw/Lnr708yyQ4QhR1mtl8yeFse8PoAzGnFtU=;
 b=vffGMfAkEtfx1ODVYka648WHUdy4Id6QNyu8gO29p0JJ3X7nS5/PZGWp4c6DEA+JC5
 aC8fLLTg3ENHP6JWT5B8uiAmrPZYXicr5MGDdq5T02P2yx7tmG5Q/2Vwe6eqNOZooMua
 gKLZ9+3QrpyaSuQ0wvhQsWFoqkQTX+oob1P374W5EFnvY3jh6q1EI2xmskZDJzu5fWwn
 wxHaUfKensrEq+3FEDzjrjJ1Lun30stNmfJ3hClWg4XT+4d8OTFebztU02i3ieR569Oc
 YBuIkbA/6TgG4T3mTQJWDcW8jeJSRI0kpMBoypGQbICelrcjTNvmI1l63+tpafaaz4l5
 Zo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qNrnxA2vw/Lnr708yyQ4QhR1mtl8yeFse8PoAzGnFtU=;
 b=W3Clx4V8CWEofb23nlgH2GouqJB8YhqXoejZ2nlPCq/SXL3YZAA0c9kE51AUDmSZot
 xngPjxLwUyucY+p3DiU3IcHpqX9SXigFug5RE5CWnRMYeZPP60ql4slxLsUeumfbEaa/
 NBBFY/mcsX4hUgA7t6+BcHyk6CYMx3ENGoSfyLTfiQWdOIAdSqOxkLZyP4swYa4ms10n
 /ZB1mQL+AJB7kjFFnXsBNBIwaj0pyFF3kzCe8wpy8KG5RgWPZ1EK6VEklI1L+snpQYit
 WEmwNOI9EYC+oCuJm5XNT+SJW5qK/6BFPs4exgQFqHn8V4tV5CiHzGOIvmw5xeyW3/bI
 uYCw==
X-Gm-Message-State: APjAAAW4qH+kmN6y6gli3hlRQGwBkOYGgeHb2KYAKdS7VKuu8PP3UzfW
 P8Ve0Uq/r6dJNyZU5rSlRk6tVWNXcy/oojGrXXU=
X-Google-Smtp-Source: APXvYqzclBizJdRViHby+imB8SxyIN8ILTcxSF+wQiUXiPX6tyHbwLWLUZKezVxdZIcJLdHyh1TkRE8zIyrTXmoPAp0=
X-Received: by 2002:a05:6808:341:: with SMTP id
 j1mr12027226oie.106.1571500292936; 
 Sat, 19 Oct 2019 08:51:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 08:51:32
 -0700 (PDT)
In-Reply-To: <20191019153437.9820-11-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
 <20191019153437.9820-11-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 17:51:32 +0200
Message-ID: <CAL1e-=j30SdZ+e_Gzq8ja2wYF49qTdfLpyfPiL3B4Mn8LVv03g@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] tests/ssh_linux_malta: Refactor how to get
 image/kernel info
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000b999ff0595456c0a"
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

--000000000000b999ff0595456c0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> The qcow and kernel images use a similar pattern regarding they
> are for big/little endianess, or 32/64 bit.
> Refactor using more dictionary keys.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 75 ++++++++++++++----------
>  1 file changed, 44 insertions(+), 31 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
> index 822b0553ff..2139c80f5f 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -26,15 +26,44 @@ class LinuxSSH(Test):
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>      VM_IP =3D '127.0.0.1'
>
> +    BASE_URL =3D 'https://people.debian.org/~aurel32/qemu/'
>      IMAGE_INFO =3D {
> -        'be': {'image_url': ('https://people.debian.org/~
> aurel32/qemu/mips/'
> -                             'debian_wheezy_mips_standard.qcow2'),
> -               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5'}=
,
> -        'le': {'image_url': ('https://people.debian.org/~
> aurel32/qemu/mipsel/'
> -                             'debian_wheezy_mipsel_standard.qcow2'),
> -               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802'}
> +        'be': {'base_url': 'mips',
> +               'image_name': 'debian_wheezy_mips_standard.qcow2',
> +               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
> +               'kernel_hash': {
> +                   32: '592e384a4edc16dade52a6cd5c785c637bcbc9ad',
> +                   64: 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'}
> +              },
> +        'le': {'base_url': 'mipsel',
> +               'image_name': 'debian_wheezy_mipsel_standard.qcow2',
> +               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
> +               'kernel_hash': {
> +                   32: 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a',
> +                   64: '6a7f77245acf231415a0e8b725d91ed2f3487794'}
> +              }
> +        }
> +    CPU_INFO =3D {
> +        32: {'kernel_release': '3.2.0-4-4kc-malta'},
> +        64: {'kernel_release': '3.2.0-4-5kc-malta'}
>          }
>
> +    def get_url(self, endianess, path=3D''):
> +        qkey =3D {'le': 'el', 'be': ''}
> +        return '%s/mips%s/%s' % (self.BASE_URL, qkey[endianess], path)
> +
> +    def get_image_info(self, endianess):
> +        dinfo =3D self.IMAGE_INFO[endianess]
> +        image_url =3D self.get_url(endianess, dinfo['image_name'])
> +        image_hash =3D dinfo['image_hash']
> +        return (image_url, image_hash)
> +
> +    def get_kernel_info(self, endianess, wordsize):
> +        minfo =3D self.CPU_INFO[wordsize]
> +        kernel_url =3D self.get_url(endianess,
> +                                  'vmlinux-%s' % minfo['kernel_release']=
)
> +        kernel_hash =3D self.IMAGE_INFO[endianess]['kernel_hash'][wordsi=
ze]
> +        return kernel_url, kernel_hash
>
>      @skipUnless(ssh.SSH_CLIENT_BINARY, 'No SSH client available')
>      @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might
> timeout')
> @@ -79,8 +108,7 @@ class LinuxSSH(Test):
>          return stdout_lines, stderr_lines
>
>      def boot_debian_wheezy_image_and_ssh_login(self, endianess,
> kernel_path):
> -        image_url =3D self.IMAGE_INFO[endianess]['image_url']
> -        image_hash =3D self.IMAGE_INFO[endianess]['image_hash']
> +        image_url, image_hash =3D self.get_image_info(endianess)
>          image_path =3D self.fetch_asset(image_url, asset_hash=3Dimage_ha=
sh)
>
>          self.vm.set_machine('malta')
> @@ -172,7 +200,10 @@ class LinuxSSH(Test):
>              'md5sum /dev/mtd2ro',
>              '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
>
> -    def check_mips_malta(self, endianess, kernel_path, uname_m):
> +    def check_mips_malta(self, uname_m, endianess):
> +        wordsize =3D 64 if '64' in uname_m else 32
> +        kernel_url, kernel_hash =3D self.get_kernel_info(endianess,
> wordsize)
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
>          self.boot_debian_wheezy_image_and_ssh_login(endianess,
> kernel_path)
>
>          stdout, _ =3D self.ssh_command('uname -a')
> @@ -188,12 +219,7 @@ class LinuxSSH(Test):
>          :avocado: tags=3Dendian:big
>          :avocado: tags=3Ddevice:pcnet32
>          """
> -        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mips/'
> -                      'vmlinux-3.2.0-4-4kc-malta')
> -        kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
> -        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> -
> -        self.check_mips_malta('be', kernel_path, 'mips')
> +        self.check_mips_malta('mips', 'be')
>
>      def test_mips_malta32el_kernel3_2_0(self):
>          """
> @@ -202,12 +228,7 @@ class LinuxSSH(Test):
>          :avocado: tags=3Dendian:little
>          :avocado: tags=3Ddevice:pcnet32
>          """
> -        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mipsel/=
'
> -                      'vmlinux-3.2.0-4-4kc-malta')
> -        kernel_hash =3D 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
> -        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> -
> -        self.check_mips_malta('le', kernel_path, 'mips')
> +        self.check_mips_malta('mips', 'le')
>
>      def test_mips_malta64eb_kernel3_2_0(self):
>          """
> @@ -216,11 +237,7 @@ class LinuxSSH(Test):
>          :avocado: tags=3Dendian:big
>          :avocado: tags=3Ddevice:pcnet32
>          """
> -        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mips/'
> -                      'vmlinux-3.2.0-4-5kc-malta')
> -        kernel_hash =3D 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
> -        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> -        self.check_mips_malta('be', kernel_path, 'mips64')
> +        self.check_mips_malta('mips64', 'be')
>
>      def test_mips_malta64el_kernel3_2_0(self):
>          """
> @@ -229,8 +246,4 @@ class LinuxSSH(Test):
>          :avocado: tags=3Dendian:little
>          :avocado: tags=3Ddevice:pcnet32
>          """
> -        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mipsel/=
'
> -                      'vmlinux-3.2.0-4-5kc-malta')
> -        kernel_hash =3D '6a7f77245acf231415a0e8b725d91ed2f3487794'
> -        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> -        self.check_mips_malta('le', kernel_path, 'mips64')
> +        self.check_mips_malta('mips64', 'le')
> --
> 2.21.0
>
>
>

--000000000000b999ff0595456c0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">The qcow and kernel images use a similar pattern regar=
ding they<br>
are for big/little endianess, or 32/64 bit.<br>
Refactor using more dictionary keys.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/linux_ssh_<wbr>mips_malta.py | 75 ++++++++++++++----=
------<br>
=C2=A01 file changed, 44 insertions(+), 31 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:1=
4px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;=
</span><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/tests/acceptance/linux_ssh_<wbr>mips_malta.py b/tests/acceptan=
ce/linux_ssh_<wbr>mips_malta.py<br>
index 822b0553ff..2139c80f5f 100644<br>
--- a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
+++ b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
@@ -26,15 +26,44 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0KERNEL_COMMON_COMMAND_LINE =3D &#39;printk.time=3D0 &#3=
9;<br>
=C2=A0 =C2=A0 =C2=A0VM_IP =3D &#39;127.0.0.1&#39;<br>
<br>
+=C2=A0 =C2=A0 BASE_URL =3D &#39;<a href=3D"https://people.debian.org/~aure=
l32/qemu/" target=3D"_blank">https://people.debian.org/~<wbr>aurel32/qemu/<=
/a>&#39;<br>
=C2=A0 =C2=A0 =C2=A0IMAGE_INFO =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;be&#39;: {&#39;image_url&#39;: (&#39;<a h=
ref=3D"https://people.debian.org/~aurel32/qemu/mips/" target=3D"_blank">htt=
ps://people.debian.org/~<wbr>aurel32/qemu/mips/</a>&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;debian_wheezy_mips_standard.<wbr>qcow2&=
#39;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;image_hash&#39=
;: &#39;<wbr>8987a63270df67345b2135a6b7a488<wbr>5a35e392d5&#39;},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;le&#39;: {&#39;image_url&#39;: (&#39;<a h=
ref=3D"https://people.debian.org/~aurel32/qemu/mipsel/" target=3D"_blank">h=
ttps://people.debian.org/~<wbr>aurel32/qemu/mipsel/</a>&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;debian_wheezy_mipsel_<wbr>standard.qcow=
2&#39;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;image_hash&#39=
;: &#39;<wbr>7866764d9de3ef536ffca24c9fb9f0<wbr>4ffdb45802&#39;}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;be&#39;: {&#39;base_url&#39;: &#39;mips&#=
39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;image_name&#39=
;: &#39;debian_wheezy_mips_standard.<wbr>qcow2&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;image_hash&#39=
;: &#39;<wbr>8987a63270df67345b2135a6b7a488<wbr>5a35e392d5&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;kernel_hash&#3=
9;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032: &=
#39;<wbr>592e384a4edc16dade52a6cd5c785c<wbr>637bcbc9ad&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064: &=
#39;<wbr>db6eea7de35d36c77d8c165b6bcb22<wbr>2e16eb91db&#39;}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;le&#39;: {&#39;base_url&#39;: &#39;mipsel=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;image_name&#39=
;: &#39;debian_wheezy_mipsel_<wbr>standard.qcow2&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;image_hash&#39=
;: &#39;<wbr>7866764d9de3ef536ffca24c9fb9f0<wbr>4ffdb45802&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;kernel_hash&#3=
9;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032: &=
#39;<wbr>a66bea5a8adaa2cb3d36a1d4e0ccdb<wbr>01be8f6c2a&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064: &=
#39;<wbr>6a7f77245acf231415a0e8b725d91e<wbr>d2f3487794&#39;}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 CPU_INFO =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 32: {&#39;kernel_release&#39;: &#39;3.2.0-4-4k=
c-malta&#39;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 64: {&#39;kernel_release&#39;: &#39;3.2.0-4-5k=
c-malta&#39;}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 def get_url(self, endianess, path=3D&#39;&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qkey =3D {&#39;le&#39;: &#39;el&#39;, &#39;be&=
#39;: &#39;&#39;}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &#39;%s/mips%s/%s&#39; % (self.BASE_URL=
, qkey[endianess], path)<br>
+<br>
+=C2=A0 =C2=A0 def get_image_info(self, endianess):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dinfo =3D self.IMAGE_INFO[endianess]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url =3D self.get_url(endianess, dinfo[&#=
39;image_name&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_hash =3D dinfo[&#39;image_hash&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (image_url, image_hash)<br>
+<br>
+=C2=A0 =C2=A0 def get_kernel_info(self, endianess, wordsize):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 minfo =3D self.CPU_INFO[wordsize]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D self.get_url(endianess,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vmlinux-%s&#39; % minfo[=
&#39;kernel_release&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D self.IMAGE_INFO[endianess][&#3=
9;<wbr>kernel_hash&#39;][wordsize]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return kernel_url, kernel_hash<br>
<br>
=C2=A0 =C2=A0 =C2=A0@skipUnless(ssh.SSH_CLIENT_<wbr>BINARY, &#39;No SSH cli=
ent available&#39;)<br>
=C2=A0 =C2=A0 =C2=A0@skipUnless(os.getenv(&#39;<wbr>AVOCADO_TIMEOUT_EXPECTE=
D&#39;), &#39;Test might timeout&#39;)<br>
@@ -79,8 +108,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return stdout_lines, stderr_lines<br>
<br>
=C2=A0 =C2=A0 =C2=A0def boot_debian_wheezy_image_and_<wbr>ssh_login(self, e=
ndianess, kernel_path):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url =3D self.IMAGE_INFO[endianess][&#39;=
<wbr>image_url&#39;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_hash =3D self.IMAGE_INFO[endianess][&#39=
;<wbr>image_hash&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url, image_hash =3D self.get_image_info(=
endianess)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_path =3D self.fetch_asset(image_url=
, asset_hash=3Dimage_hash)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.set_machine(&#39;malta&#39;)<br>
@@ -172,7 +200,10 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;md5sum /dev/mtd2ro&#39=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;<wbr>0dfbe8aa4c20b52e1=
b8bf3cb6cbdf1<wbr>93&#39;)<br>
<br>
-=C2=A0 =C2=A0 def check_mips_malta(self, endianess, kernel_path, uname_m):=
<br>
+=C2=A0 =C2=A0 def check_mips_malta(self, uname_m, endianess):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wordsize =3D 64 if &#39;64&#39; in uname_m els=
e 32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url, kernel_hash =3D self.get_kernel_in=
fo(<wbr>endianess, wordsize)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.fetch_asset(kernel_url, a=
sset_hash=3Dkernel_hash)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.boot_debian_wheezy_image_<wbr>and_ss=
h_login(endianess, kernel_path)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout, _ =3D self.ssh_command(&#39;uname=
 -a&#39;)<br>
@@ -188,12 +219,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Dendian:big<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Ddevice:pcnet32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D (&#39;<a href=3D"https://people=
.debian.org/~aurel32/qemu/mips/" target=3D"_blank">https://people.debian.or=
g/~<wbr>aurel32/qemu/mips/</a>&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;vmlinux-3.2.0-4-4kc-malta&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D &#39;<wbr>592e384a4edc16dade52=
a6cd5c785c<wbr>637bcbc9ad&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.fetch_asset(kernel_url, a=
sset_hash=3Dkernel_hash)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_mips_malta(&#39;be&#39;, kernel_pat=
h, &#39;mips&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_mips_malta(&#39;mips&#39;, &#39;be&=
#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def test_mips_malta32el_kernel3_2_<wbr>0(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -202,12 +228,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Dendian:little<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Ddevice:pcnet32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D (&#39;<a href=3D"https://people=
.debian.org/~aurel32/qemu/mipsel/" target=3D"_blank">https://people.debian.=
org/~<wbr>aurel32/qemu/mipsel/</a>&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;vmlinux-3.2.0-4-4kc-malta&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D &#39;<wbr>a66bea5a8adaa2cb3d36=
a1d4e0ccdb<wbr>01be8f6c2a&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.fetch_asset(kernel_url, a=
sset_hash=3Dkernel_hash)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_mips_malta(&#39;le&#39;, kernel_pat=
h, &#39;mips&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_mips_malta(&#39;mips&#39;, &#39;le&=
#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def test_mips_malta64eb_kernel3_2_<wbr>0(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -216,11 +237,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Dendian:big<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Ddevice:pcnet32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D (&#39;<a href=3D"https://people=
.debian.org/~aurel32/qemu/mips/" target=3D"_blank">https://people.debian.or=
g/~<wbr>aurel32/qemu/mips/</a>&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;vmlinux-3.2.0-4-5kc-malta&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D &#39;<wbr>db6eea7de35d36c77d8c=
165b6bcb22<wbr>2e16eb91db&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.fetch_asset(kernel_url, a=
sset_hash=3Dkernel_hash)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_mips_malta(&#39;be&#39;, kernel_pat=
h, &#39;mips64&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_mips_malta(&#39;mips64&#39;<wbr>, &=
#39;be&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def test_mips_malta64el_kernel3_2_<wbr>0(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -229,8 +246,4 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Dendian:little<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Ddevice:pcnet32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D (&#39;<a href=3D"https://people=
.debian.org/~aurel32/qemu/mipsel/" target=3D"_blank">https://people.debian.=
org/~<wbr>aurel32/qemu/mipsel/</a>&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;vmlinux-3.2.0-4-5kc-malta&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D &#39;<wbr>6a7f77245acf231415a0=
e8b725d91e<wbr>d2f3487794&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.fetch_asset(kernel_url, a=
sset_hash=3Dkernel_hash)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_mips_malta(&#39;le&#39;, kernel_pat=
h, &#39;mips64&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_mips_malta(&#39;mips64&#39;<wbr>, &=
#39;le&#39;)<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000b999ff0595456c0a--

