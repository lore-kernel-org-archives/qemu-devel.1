Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0832C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 22:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F5A2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 22:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijWeA1B7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F5A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz79l-0002Av-3X
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 17:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iz798-0001jz-3y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iz795-0001zT-Br
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:58:17 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iz795-0001r9-4v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:58:15 -0500
Received: by mail-ot1-x342.google.com with SMTP id 66so108296otd.9
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 14:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=MCbTWNgC8kFvpblyDHfdiG+QJfgOIZhT7bqC0WGWykg=;
 b=ijWeA1B7hxyCAs+TEE16RyMCmBdsKUb8/GbzjoVN5su8Q7GD3CSP/uiV3DBQrwwcOU
 /kM1gBMhJl2y96Trt0XWjka6ivRLrorY0QJXPap3Lkl0NdX1vSF2YLeIMSi8Ub7fl0F2
 PjFicweVSrE9+YVt+ZRjvmDUjsAf7GF70SvAHunBpxbZIZx5C3bjLOjCD+Zq68f5lWbo
 rktbvUfOaoLEQwt8R0xfLygGb91wpC2BUSqZWZ7sKgA0oASWU9RyI6uqB1zRw4SJ+HDK
 NF5/RipT311glqtyADJz/Je3lwEEw5Kxj6BVDFxKvY1eLESqOBNgHJTOh1I/Ct3xO4hm
 DiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=MCbTWNgC8kFvpblyDHfdiG+QJfgOIZhT7bqC0WGWykg=;
 b=tPadDzrm9toPy1I8XVaQTBOJgcv8trZFm7lbWN3K/RIADdCbiRjzxBQQbzRRlzsHqi
 JJXgVmdgdihI68VMadRsMPSxZyHYPnPDgHrKqGeHoXTMFQPrExBCUqHdNnKGFZFlXOEF
 znUzBms/52E40uzDQPlYAffc4D3gMJrzKYt8PPEJn9J69DK5f75BZphu10DvTx4jkyCg
 lfj8R0gvGaAFC5dRO61+JOdh+qWFEcRvYrMnWhCmZgG4uzCilzx3PSBv4RrvtUOaUyPi
 PXnxhN0N/1hZuc9u5XAWwudDe0OsLNH501IqA3h4ieSAmAQqdmVZhjV57dpOUl+v61D9
 +7dw==
X-Gm-Message-State: APjAAAU7IsKKLFoz4FwbKN9RqLIIeU44cHYWiGJIS2qFrogbNtqoeZ29
 p7o0pwEgEJi6nJKbwTlj6HcCnR/7FskcRLdn1ds=
X-Google-Smtp-Source: APXvYqykui7wysVOJm3bhVVG6Sbf2PuE75FCYhmV+ZjXQC/JeRr6/RcvqyJmE8VPiwAVYART9rglf3rW8wC5N/rq70A=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr22631018otk.64.1580857094284; 
 Tue, 04 Feb 2020 14:58:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 4 Feb 2020 14:58:13 -0800 (PST)
In-Reply-To: <1580428993-4767-27-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-27-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 4 Feb 2020 23:58:13 +0100
Message-ID: <CAL1e-=jwG=nP7TF_j1eiZM=nOZ5kx4Zkt=SxFfYUnKdPOwxgGw@mail.gmail.com>
Subject: Re: [PATCH rc4 26/29] target/avr: Update build system
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="0000000000008bac0f059dc7f9aa"
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008bac0f059dc7f9aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, January 31, 2020, Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Michael Rolnik <mrolnik@gmail.com>
>
> Make AVR support buildable.
>
> [AM: Remove word 'Atmel' from filenames and all elements of code]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>  configure                       |  7 +++++++
>  default-configs/avr-softmmu.mak |  5 +++++
>  target/avr/Makefile.objs        | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 target/avr/Makefile.objs
>
> diff --git a/configure b/configure
> index a72a5de..51f0b9e 100755
> --- a/configure
> +++ b/configure
> @@ -7640,6 +7640,10 @@ case "$target_name" in
>      mttcg=3D"yes"
>      gdb_xml_files=3D"aarch64-core.xml aarch64-fpu.xml arm-core.xml
> arm-vfp.xml arm-vfp3.xml arm-neon.xml"
>    ;;
> +  avr)
> +    gdb_xml_files=3D"avr-cpu.xml"
> +    target_compiler=3D$cross_cc_avr
> +  ;;
>    cris)
>    ;;
>    hppa)
> @@ -7859,6 +7863,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>        disas_config "ARM_A64"
>      fi
>    ;;
> +  avr)
> +    disas_config "AVR"
> +  ;;
>    cris)
>      disas_config "CRIS"
>    ;;
> diff --git a/default-configs/avr-softmmu.mak
> b/default-configs/avr-softmmu.mak
> new file mode 100644
> index 0000000..80218ad
> --- /dev/null
> +++ b/default-configs/avr-softmmu.mak
> @@ -0,0 +1,5 @@
> +# Default configuration for avr-softmmu
> +
> +# Boards:
> +#
> +CONFIG_ARDUINO=3Dy
> diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
> new file mode 100644
> index 0000000..7523e0c
> --- /dev/null
> +++ b/target/avr/Makefile.objs
> @@ -0,0 +1,34 @@
> +#
> +#  QEMU AVR CPU
> +#
> +#  Copyright (c) 2019 Michael Rolnik
> +#
> +#  This library is free software; you can redistribute it and/or
> +#  modify it under the terms of the GNU Lesser General Public
> +#  License as published by the Free Software Foundation; either
> +#  version 2.1 of the License, or (at your option) any later version.
> +#
> +#  This library is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +#  Lesser General Public License for more details.
> +#
> +#  You should have received a copy of the GNU Lesser General Public
> +#  License along with this library; if not, see
> +#  <http://www.gnu.org/licenses/lgpl-2.1.html>
> +#
> +
> +DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
> +decode-y =3D $(SRC_PATH)/target/avr/insn.decode
> +
> +target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
> +       $(call quiet-command, \
> +         $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth
> 16 $<, \
> +         "GEN", $(TARGET_DIR)$@)
> +
> +target/avr/translate.o: target/avr/decode_insn.inc.c
> +
> +obj-y +=3D translate.o cpu.o helper.o
> +obj-y +=3D gdbstub.o
> +obj-y +=3D disas.o
> +obj-$(CONFIG_SOFTMMU) +=3D machine.o


The last line should not contain "-$(CONFIG_SOFTMMU)", since there is only
softmmu case for avr. I will remove it in rc5, unless somebody tell me not
to do so.

Aleksandar


> --
> 2.7.4
>
>

--0000000000008bac0f059dc7f9aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 31, 2020, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.markovic@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">From: Michael Rolnik &lt;<a href=3D"=
mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt;<br>
<br>
Make AVR support buildable.<br>
<br>
[AM: Remove word &#39;Atmel&#39; from filenames and all elements of code]<b=
r>
Suggested-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@g=
mail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om">amarkovic@wavecomp.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
---<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++++++<br>
=C2=A0default-configs/avr-softmmu.<wbr>mak |=C2=A0 5 +++++<br>
=C2=A0target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 34 ++++++++++++=
++++++++++++++++++<wbr>++++<br>
=C2=A03 files changed, 46 insertions(+)<br>
=C2=A0create mode 100644 default-configs/avr-softmmu.<wbr>mak<br>
=C2=A0create mode 100644 target/avr/Makefile.objs<br>
<br>
diff --git a/configure b/configure<br>
index a72a5de..51f0b9e 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -7640,6 +7640,10 @@ case &quot;$target_name&quot; in<br>
=C2=A0 =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>
=C2=A0 =C2=A0 =C2=A0gdb_xml_files=3D&quot;aarch64-core.<wbr>xml aarch64-fpu=
.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml&quot;<br>
=C2=A0 =C2=A0;;<br>
+=C2=A0 avr)<br>
+=C2=A0 =C2=A0 gdb_xml_files=3D&quot;avr-cpu.xml&quot;<br>
+=C2=A0 =C2=A0 target_compiler=3D$cross_cc_avr<br>
+=C2=A0 ;;<br>
=C2=A0 =C2=A0cris)<br>
=C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0hppa)<br>
@@ -7859,6 +7863,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0disas_config &quot;ARM_A64&quot;<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0;;<br>
+=C2=A0 avr)<br>
+=C2=A0 =C2=A0 disas_config &quot;AVR&quot;<br>
+=C2=A0 ;;<br>
=C2=A0 =C2=A0cris)<br>
=C2=A0 =C2=A0 =C2=A0disas_config &quot;CRIS&quot;<br>
=C2=A0 =C2=A0;;<br>
diff --git a/default-configs/avr-softmmu.<wbr>mak b/default-configs/avr-sof=
tmmu.<wbr>mak<br>
new file mode 100644<br>
index 0000000..80218ad<br>
--- /dev/null<br>
+++ b/default-configs/avr-softmmu.<wbr>mak<br>
@@ -0,0 +1,5 @@<br>
+# Default configuration for avr-softmmu<br>
+<br>
+# Boards:<br>
+#<br>
+CONFIG_ARDUINO=3Dy<br>
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs<br>
new file mode 100644<br>
index 0000000..7523e0c<br>
--- /dev/null<br>
+++ b/target/avr/Makefile.objs<br>
@@ -0,0 +1,34 @@<br>
+#<br>
+#=C2=A0 QEMU AVR CPU<br>
+#<br>
+#=C2=A0 Copyright (c) 2019 Michael Rolnik<br>
+#<br>
+#=C2=A0 This library is free software; you can redistribute it and/or<br>
+#=C2=A0 modify it under the terms of the GNU Lesser General Public<br>
+#=C2=A0 License as published by the Free Software Foundation; either<br>
+#=C2=A0 version 2.1 of the License, or (at your option) any later version.=
<br>
+#<br>
+#=C2=A0 This library is distributed in the hope that it will be useful,<br=
>
+#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
+#=C2=A0 Lesser General Public License for more details.<br>
+#<br>
+#=C2=A0 You should have received a copy of the GNU Lesser General Public<b=
r>
+#=C2=A0 License along with this library; if not, see<br>
+#=C2=A0 &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=
=3D"_blank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+#<br>
+<br>
+DECODETREE =3D $(SRC_PATH)/scripts/<wbr>decodetree.py<br>
+decode-y =3D $(SRC_PATH)/target/avr/insn.<wbr>decode<br>
+<br>
+target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call quiet-command, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(PYTHON) $(DECODETREE) -o $@ --decode d=
ecode_insn --insnwidth 16 $&lt;, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;GEN&quot;, $(TARGET_DIR)$@)<br>
+<br>
+target/avr/translate.o: target/avr/decode_insn.inc.c<br>
+<br>
+obj-y +=3D translate.o cpu.o helper.o<br>
+obj-y +=3D gdbstub.o<br>
+obj-y +=3D disas.o<br>
+obj-$(CONFIG_SOFTMMU) +=3D machine.o</blockquote><div><br></div><div>The l=
ast line should not contain &quot;-$(CONFIG_SOFTMMU)&quot;, since there is =
only softmmu case for avr. I will remove it in rc5, unless somebody tell me=
 not to do so.</div><div><br></div><div>Aleksandar</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
-- <br>
2.7.4<br>
<br>
</blockquote>

--0000000000008bac0f059dc7f9aa--

