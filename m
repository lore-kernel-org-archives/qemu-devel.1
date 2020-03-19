Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2701BC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6632208D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMYXnqcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6632208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEw08-0001KN-V7
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jEvz2-0000VX-V8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jEvyz-0006pZ-FW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:17:16 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jEvyy-0006p4-O1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:17:13 -0400
Received: by mail-lj1-x241.google.com with SMTP id q19so2643860ljp.9
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c7/QvsprHvUd1QaILWMIBRt4x4TY7bftraMlO3h5Ggk=;
 b=WMYXnqcbiiHCZTb/jx2/wpgVp4528I1ssZs0Jia4gnPIzrOSGo1o1/TuXqr8Dgxbwc
 H6z0e2aVCpdtfb81EymN/ZwFisr4lyia6YHDk9+tV2Y36q/fbgWzZioLXhiyeMkU5TfW
 ypobcYhFvYvIt/SsyIJ7Zl4HLLvgYAlk3AihTfw0FoYAR9fDZASluyVZZtVYsVCgDLex
 9/Spjq43rDFbQ81+rG+z+nz0fag87Bq6LjjQ7bfUd2XKxYkr5zV9g4Pa6aWxtIpggMVO
 EdzMp6dEuOXEBBdg4xiMj9fVUAHhWbWppriQau4SEXmYXO0MDtj8HoWtrwjxxwsfPa+k
 u/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c7/QvsprHvUd1QaILWMIBRt4x4TY7bftraMlO3h5Ggk=;
 b=elu5E1dxuFsn4xOHeitDQn9co/BQTzYociwXtXMkTW/Lth+1cV0ZNabdAE0pOFkh+K
 3IZh3XnlZ8sBKUjoFzm0xau9gCsvTT391vm75hOGWisJvRKnoQBP8r+UAj9yDO4Qpu4b
 37CgFbKFsb17dtuMXy8az183FDemZRMA4xKuU73rRvXgywwTZi7j8M15+ZIWDtygboyl
 /uGqpUjckCfIGSGAC/qPee9Gx5XBOtITj44xSsD27iCYd+stV7bE8HVmXs9PxisfLbox
 ZkZR2ldI3p+dfP7jxgQuud4kZR0ZdgQs4Hau64zDnzbf4jIwsb12Bb2608sYt+fC/yVJ
 yhew==
X-Gm-Message-State: ANhLgQ0A7IidepQ5iXl3wTa50dcEU5m9F8rnXl7vZRsT54Fm9z6ZYgUz
 dNnaNyGLBzhHWJVeRQYhF9Aqy4ngyWGjyCHut7c=
X-Google-Smtp-Source: ADFU+vtLeovlmth5k+NwXb3YB8B0hryCUCux+P/PWYyNOciW6qNeDsWf3Nf4FezHyZNlY6/pdQHa7oU9RR3glxMdRyw=
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr2239541ljm.159.1584627429764; 
 Thu, 19 Mar 2020 07:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPV47zcqvNekcUN=fKu1-dN=Sip3XR3+ohaG22-oNDm1dceJkQ@mail.gmail.com>
 <CAFEAcA_CeGozr3MUA6N=cMQVXLjoLD0ca-gywm+MLU4unfgwGg@mail.gmail.com>
 <39f82991-6d80-ba42-c7e8-4f6120a196ac@redhat.com>
In-Reply-To: <39f82991-6d80-ba42-c7e8-4f6120a196ac@redhat.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Thu, 19 Mar 2020 19:46:58 +0530
Message-ID: <CAPV47zfQKCaKS3BQ4+zbFJ1KyATqgOZvtaY9n-Gh_wtFCn4trQ@mail.gmail.com>
Subject: Re: Qemu API documentation
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000000d9da205a135d312"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000d9da205a135d312
Content-Type: multipart/alternative; boundary="0000000000000d9da005a135d310"

--0000000000000d9da005a135d310
Content-Type: text/plain; charset="UTF-8"

Thanks John and Peter for guiding me, but still it will be hard to
understand from source code for a newbie.

I basically want to implement a trivial device for arm architecture which
basically contains register for read/write operation with a program.So what
are the references?

I am providing pointers about my device which I am trying to implement:
 - I am implementing a device which will be attached to *versatilepb*
board, that board has* ARM926 CPU*.
- My device name is "*soc*" , whose description is in *qemu/hw/misc/soc.c*
file attached below.
- I have written below line to make my device available to qemu in
*qemu/hw/misc/Makefile.objs*.

> *$ common-obj-$(CONFIG_SOC) += soc.o *
>
- I added following lines in *qemu/hw/arm/versatilepb.c* to attach my
device to board.

>
> *#define DES_BASEADDR        0x101f5000*
>
>
>
> *    soc=qdev_create(NULL, "soc");// +    qdev_init_nofail(soc);// +
> sysbus_mmio_map(SYS_BUS_DEVICE(soc), 0, DES_BASEADDR);// +*
>

- Run below commands to build my device

> *$ make distclean*
> *$ make -j8 -C build *
>

- Run below command to run a bare metal program on device.

> *$ ./qemu-system-arm -M versatilepb -nographic -kernel
> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf*
>

-I get following output in terminal shown below

>
>
> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
> -nographic -kernel
> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (core
> dumped)*
>

-Here des_demo.elf is our *bare metal program* executable for *arm(926ej-s)*
processor.

So how to resolve below issue to run executable

>
>
> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
> -nographic -kernel
> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (core
> dumped)*
>

test.s,test.ld,startup.S,Makefile,des_demo.c are files required for bare
> metal program
>

References:

https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-device-in-qemu/

Thanks,
Priyamvad

On Thu, 19 Mar 2020 at 01:19, John Snow <jsnow@redhat.com> wrote:

>
>
> On 3/18/20 7:09 AM, Peter Maydell wrote:
> > On Wed, 18 Mar 2020 at 09:55, Priyamvad Acharya
> > <priyamvad.agnisys@gmail.com> wrote:
> >>
> >> Hello developer community,
> >>
> >> I am working on implementing a custom device in Qemu, so to implement
> it I need documentation of functions which are used to emulate a hardware
> model in Qemu.
> >>
> >> What are the references to get it ?
> >
> > QEMU has very little documentation of its internals;
> > the usual practice is to figure things out by
> > reading the source code. What we do have is in
> > docs/devel. There are also often documentation comments
> > for specific functions in the include files where
> > those functions are declared, which form the API
> > documentation for them.
> >
>
> ^ Unfortunately true. One thing you can do is try to pick an existing
> device that's close to yours -- some donor PCI, USB etc device and start
> using that as a reference.
>
> If you can share (broad) details of what device you are trying to
> implement, we might be able to point you to relevant examples to use as
> a reference.
>
> --js
>
>

--0000000000000d9da005a135d310
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div>Thanks John and Peter for guiding me, but still it will be h=
ard to understand from source code for a newbie.<br></div><div><br></div><d=
iv>I basically want to implement a trivial device for arm architecture whic=
h basically contains register for read/write operation with a program.So wh=
at are the references?<br></div><div><br></div><div>I am providing pointers=
 about my device which I am trying to implement:<br></div><div>=C2=A0- I am=
 implementing a device which will be attached to <b>versatilepb</b> board, =
that board has<b> ARM926 CPU</b>.<br></div><div>- My device name is &quot;<=
b>soc</b>&quot; , whose description is in <b>qemu/hw/misc/soc.c</b> file at=
tached below.</div><div>- I have written below line to make my device avail=
able to qemu in <b>qemu/hw/misc/Makefile.objs</b>.<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div><b>$ common-obj-$(CONFIG_SOC) +=3D =
soc.o=C2=A0</b> <br></div></blockquote><div>- I added following lines in <b=
>qemu/hw/arm/versatilepb.c</b> to attach my device to board.<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div>=C2=A0=C2=A0=C2=A0 <b>#de=
fine DES_BASEADDR =C2=A0 =C2=A0 =C2=A0 =C2=A00x101f5000<br></b></div><div><=
b>=C2=A0=C2=A0=C2=A0 soc=3Dqdev_create(NULL, &quot;soc&quot;);// +<br>=C2=
=A0 =C2=A0 qdev_init_nofail(soc);// +<br>=C2=A0 =C2=A0 sysbus_mmio_map(SYS_=
BUS_DEVICE(soc), 0, DES_BASEADDR);// +<br></b></div></blockquote><div>=C2=
=A0</div><div>- Run below commands to build my device</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div><b>$ make distclean</b></div><div><b=
>$ make -j8 -C build </b></div></blockquote><div><br></div><div>- Run below=
 command to run a bare metal program on device.</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div><b>$ ./qemu-system-arm -M versatilepb -nog=
raphic -kernel /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_dem=
o.elf</b></div></blockquote><div><br></div><div>-I get following output in =
terminal shown below</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div><b>[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb=
 -nographic -kernel /lhome/priyamvad/debian_qemu_arm32/c_application/DES/de=
s_demo.elf <br>qemu-system-arm: Unknown device &#39;soc&#39; for default sy=
sbus<br>Aborted (core dumped)</b></div></blockquote><div><br></div><div>-He=
re des_demo.elf is our <b>bare metal program</b> executable for <b>arm(926e=
j-s)</b> processor. <br></div><div><br></div><div>So how to resolve below i=
ssue to run executable</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div><b>[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatile=
pb -nographic -kernel /lhome/priyamvad/debian_qemu_arm32/c_application/DES/=
des_demo.elf <br>qemu-system-arm: Unknown device &#39;soc&#39; for default =
sysbus<br>Aborted (core dumped)</b></div></blockquote><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div>test.s,test.ld,startup.S,M=
akefile,des_demo.c are files required for bare metal program<br></div></blo=
ckquote><div><br></div><div>References:</div><div><br></div><div><a href=3D=
"https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-devic=
e-in-qemu/">https://devkail.wordpress.com/2014/12/16/emulation-of-des-encry=
ption-device-in-qemu/</a></div><div><br></div><div>Thanks,</div><div>Priyam=
vad<br></div></div></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, 19 Mar 2020 at 01:19, John Sno=
w &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 3/18/20 7:09 AM, Peter Maydell wrote:<br>
&gt; On Wed, 18 Mar 2020 at 09:55, Priyamvad Acharya<br>
&gt; &lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=3D"_blank">p=
riyamvad.agnisys@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hello developer community,<br>
&gt;&gt;<br>
&gt;&gt; I am working on implementing a custom device in Qemu, so to implem=
ent it I need documentation of functions which are used to emulate a hardwa=
re model in Qemu.<br>
&gt;&gt;<br>
&gt;&gt; What are the references to get it ?<br>
&gt; <br>
&gt; QEMU has very little documentation of its internals;<br>
&gt; the usual practice is to figure things out by<br>
&gt; reading the source code. What we do have is in<br>
&gt; docs/devel. There are also often documentation comments<br>
&gt; for specific functions in the include files where<br>
&gt; those functions are declared, which form the API<br>
&gt; documentation for them.<br>
&gt; <br>
<br>
^ Unfortunately true. One thing you can do is try to pick an existing<br>
device that&#39;s close to yours -- some donor PCI, USB etc device and star=
t<br>
using that as a reference.<br>
<br>
If you can share (broad) details of what device you are trying to<br>
implement, we might be able to point you to relevant examples to use as<br>
a reference.<br>
<br>
--js<br>
<br>
</blockquote></div>

--0000000000000d9da005a135d310--

--0000000000000d9da205a135d312
Content-Type: text/x-csrc; charset="US-ASCII"; name="soc.c"
Content-Disposition: attachment; filename="soc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k7ytuqsl0>
X-Attachment-Id: f_k7ytuqsl0

LyoKICogRGF0YSBFbmNyeXB0aW9uIFN0YW5kYXJkIChERVMpIGRldmljZQogKiBmb3IgdmlydGV4
LW1sNTA3CiAqIFdyaXR0ZW4gYnkgTGlhbmcgS2FpeXVhbiA8a2FpeXVhbmxAdGp1LmVkdS5jbj4K
ICogZm9yIHRlc3RpbmcgYW5kIHJlc2VhcmNoCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKICogbW9kaWZ5IGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQTHYyIGFzIHB1Ymxpc2hlZCBieQogKiBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb24sIG9yIGFueSBsYXRlciB2ZXJzaW9uLiBTZWUgdGhlIENPUElORwogKiBm
aWxlIGluIHRoZSB0b3AtbGV2ZWwgZGlyZWN0b3J5LgogKi8KIAojaW5jbHVkZSA8c3RkaW8uaD4K
I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlICJody9ody5o
IgojaW5jbHVkZSAiaHcvc3lzYnVzLmgiCiNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgojaW5j
bHVkZSAicWVtdS9vc2RlcC5oIgojaW5jbHVkZSAicWVtdS91bml0cy5oIgojaW5jbHVkZSAiaHcv
cGNpL21zaS5oIgojaW5jbHVkZSAicWVtdS90aW1lci5oIgojaW5jbHVkZSAicWVtdS9tb2R1bGUu
aCIKI2luY2x1ZGUgInFhcGkvdmlzaXRvci5oIgoKdHlwZWRlZiBzdHJ1Y3QgewogICAgdW5zaWdu
ZWQgY2hhciBrWzhdOwogICAgdW5zaWduZWQgY2hhciBjWzRdOwogICAgdW5zaWduZWQgY2hhciBk
WzRdOwp9IGtleV9zZXQ7Cgp2b2lkIGdlbmVyYXRlX2tleSh1bnNpZ25lZCBjaGFyKiBrZXkpOwp2
b2lkIGdlbmVyYXRlX3N1Yl9rZXlzKHVuc2lnbmVkIGNoYXIqIG1haW5fa2V5LCBrZXlfc2V0KiBr
ZXlfc2V0cyk7CnZvaWQgcHJvY2Vzc19tZXNzYWdlKHVuc2lnbmVkIGNoYXIqIG1lc3NhZ2VfcGll
Y2UsIHVuc2lnbmVkIGNoYXIqIHByb2Nlc3NlZF9waWVjZSwga2V5X3NldCoga2V5X3NldHMsIGlu
dCBtb2RlKTsKdm9pZCBwcmludF9jaGFyX2FzX2JpbmFyeShjaGFyIGlucHV0KTsKdm9pZCBwcmlu
dF9rZXlfc2V0KGtleV9zZXQga2V5X3NldCk7CgoKaW50IGJyZWFkKHVuc2lnbmVkIGNoYXIqIGJs
b2NrLCBpbnQgc2l6ZSwgdW5zaWduZWQgY2hhciogc3RyLCBpbnQgKmluZGV4KTsKaW50IGJ3cml0
ZSh1bnNpZ25lZCBjaGFyKiBibG9jaywgaW50IHNpemUsIHVuc2lnbmVkIGNoYXIqIHN0ciwgaW50
ICppbmRleCk7CmludCBic3RybGVuKHVuc2lnbmVkIGNoYXIqIHN0cik7CgojZGVmaW5lIEVOQ1JZ
UFRJT05fTU9ERSAxCiNkZWZpbmUgREVDUllQVElPTl9NT0RFIDAKI2RlZmluZSBHRU5FUkFURUtF
WV9NT0RFIDIKI2RlZmluZSBET05FX01PREUgMwojZGVmaW5lIFJFR1NfT0ZGU0VUIDB4MTAwMAoj
ZGVmaW5lIFJFR19LRVlfQUREUl9PRkZTRVQgMHgwMDAwCiNkZWZpbmUgUkVHX0lOX0FERFJfT0ZG
U0VUIDB4MDAwNAojZGVmaW5lIFJFR19PVVRfQUREUl9PRkZTRVQgMHgwMDA4CiNkZWZpbmUgUkVH
X01PREVfT0ZGU0VUIDB4MDAwQwoKLyojZGVmaW5lIERFU19ERUJVRyovCgp0eXBlZGVmIHN0cnVj
dCBTb0NERVNTdGF0ZXsKICAgIFN5c0J1c0RldmljZSBwYXJlbnRfb2JqOwogICAgTWVtb3J5UmVn
aW9uIG1taW87CiAgICBRRU1VQkggKmJoOwogICAgcWVtdV9pcnEgaXJxOwogICAgCiAgICB1aW50
MzJfdCByZWdfa2V5X2FkZHI7CiAgICB1aW50MzJfdCByZWdfaW5fYWRkcjsKICAgIHVpbnQzMl90
IHJlZ19vdXRfYWRkcjsKICAgIHVpbnQzMl90IHJlZ19tb2RlOwp9U29DREVTU3RhdGU7CgojZGVm
aW5lIFRZUEVfU09DX0RFUyAic29jIgojZGVmaW5lIFNPQ19ERVMob2JqKSBcCiAgICBPQkpFQ1Rf
Q0hFQ0soU29DREVTU3RhdGUsIChvYmopLCBUWVBFX1NPQ19ERVMpCiAgICAKCnN0YXRpYyB1aW50
NjRfdCBzb2NfZGVzX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LCB1bnNpZ25lZCBz
aXplKQp7CiNpZmRlZiBERVNfREVCVUcKICAgIHByaW50ZigiYmVnaW4gc29jX2Rlc19yZWFkXG4i
KTsKICAgIHByaW50Zigib2Zmc2V0IDB4JXhcdCBzaXplIDB4JXhcbiIsICh1bnNpZ25lZCBpbnQp
b2Zmc2V0LCBzaXplKTsKI2VuZGlmCgogICAgU29DREVTU3RhdGUgKnMgPSBvcGFxdWU7CiAgICB1
aW50MzJfdCByZXQgPSAwOwogICAgc3dpdGNoKG9mZnNldCkKICAgIHsKICAgIGNhc2UgUkVHX0tF
WV9BRERSX09GRlNFVDoKICAgICAgICByZXQgPSBzLT5yZWdfa2V5X2FkZHI7CiAgICAgICAgYnJl
YWs7CiAgICBjYXNlIFJFR19PVVRfQUREUl9PRkZTRVQ6CiAgICAgICAgcmV0ID0gcy0+cmVnX291
dF9hZGRyOwogICAgICAgIGJyZWFrOwogICAgY2FzZSBSRUdfTU9ERV9PRkZTRVQ6CiAgICAgICAg
cmV0ID0gcy0+cmVnX21vZGU7CiAgICAgICAgYnJlYWs7CiAgICBkZWZhdWx0OgogICAgICAgIHBy
aW50ZigiYmFkIG9mZnNldCAweCV4XG4iLCAoaW50KW9mZnNldCk7CiAgICB9CiAgICAKI2lmZGVm
IERFU19ERUJVRwogICAgcHJpbnRmKCJvZmZzZXQgMHgleCwgdmFsdWUgMHgleFxuIiwgKGludClv
ZmZzZXQsIHJldCk7CiAgICBwcmludGYoImZpbmlzaCBzb2NfZGVzX3JlYWRcbiIpOwojZW5kaWYK
CiAgICByZXR1cm4gcmV0Owp9CgpzdGF0aWMgdm9pZCBzb2NfZGVzX3dyaXRlKHZvaWQgKm9wYXF1
ZSwgaHdhZGRyIG9mZnNldCwgdWludDY0X3QgdmFsdWUsIHVuc2lnbmVkIHNpemUpCnsKI2lmZGVm
IERFU19ERUJVRwogICAgcHJpbnRmKCJiZWdpbiBzb2NfZGVzX3dyaXRlXG4iKTsKICAgIHByaW50
Zigib2Zmc2V0IDB4JXhcdCBzaXplIDB4JXhcbiIsICh1bnNpZ25lZClvZmZzZXQsIHNpemUpOwog
ICAgcHJpbnRmKCJ2YWx1ZSB4MCV4XG4iLCAodW5zaWduZWQpdmFsdWUpOwojZW5kaWYKCiAgICBT
b0NERVNTdGF0ZSAqcyA9IG9wYXF1ZTsKCiAgICBzd2l0Y2gob2Zmc2V0KQogICAgewogICAgY2Fz
ZSBSRUdfS0VZX0FERFJfT0ZGU0VUOgogICAgICAgIHMtPnJlZ19rZXlfYWRkciA9IHZhbHVlOwog
ICAgICAgIGJyZWFrOwogICAgY2FzZSBSRUdfSU5fQUREUl9PRkZTRVQ6CiAgICAgICAgcy0+cmVn
X2luX2FkZHIgPSB2YWx1ZTsKICAgICAgICBicmVhazsKICAgIGNhc2UgUkVHX09VVF9BRERSX09G
RlNFVDoKICAgICAgICBzLT5yZWdfb3V0X2FkZHIgPSB2YWx1ZTsKICAgICAgICBicmVhazsKICAg
IGNhc2UgUkVHX01PREVfT0ZGU0VUOgogICAgICAgIHMtPnJlZ19tb2RlID0gdmFsdWU7ICAgICAg
IAoKICAgICAgICB1bnNpZ25lZCBjaGFyKiBkZXNfa2V5ID0gKHVuc2lnbmVkIGNoYXIqKW1hbGxv
Yyg4KnNpemVvZihjaGFyKSk7ICAgIAogICAgICAgIHVuc2lnbmVkIGNoYXIqIGRhdGFfYmxvY2sg
PSBOVUxMOwogICAgICAgIHVuc2lnbmVkIGNoYXIqIHByb2Nlc3NlZF9ibG9jayA9IE5VTEw7CiAg
ICAgICAga2V5X3NldCoga2V5X3NldHM7CiAgICAgICAgCiAgICAgICAgaW50IGluZGV4X2tleSA9
IDA7CiAgICAgICAgaW50IGluZGV4X2luID0gMDsKICAgICAgICBpbnQgaW5kZXhfb3V0ID0gMDsK
ICAgICAgICBjaGFyIHR6ID0gJ1wwJzsKCiAgICAgICAgc3dpdGNoKHMtPnJlZ19tb2RlKQogICAg
ICAgIHsKICAgICAgICBjYXNlIEdFTkVSQVRFS0VZX01PREU6ICAgICAgICAgCiAgICAgICAgICAg
IGdlbmVyYXRlX2tleShkZXNfa2V5KTsKICAgICAgICAgICAgYndyaXRlKGRlc19rZXksIDgsICh1
bnNpZ25lZCBjaGFyKilzLT5yZWdfa2V5X2FkZHIsICZpbmRleF9rZXkpOwogICAgICAgICAgICBi
d3JpdGUoJnR6LCAxLCAodW5zaWduZWQgY2hhciopcy0+cmVnX2tleV9hZGRyLCAmaW5kZXhfa2V5
KTsKICAgICAgICAgICAgcy0+cmVnX21vZGUgPSBET05FX01PREU7CiAgICAgICAgICAgIGJyZWFr
OwogICAgICAgICAgICAKICAgICAgICBjYXNlIEVOQ1JZUFRJT05fTU9ERToKICAgICAgICAgICAg
CiAgICAgICAgY2FzZSBERUNSWVBUSU9OX01PREU6CiAgICAgICAgICAgIGJyZWFkKGRlc19rZXks
IDgsICh1bnNpZ25lZCBjaGFyKilzLT5yZWdfa2V5X2FkZHIsICZpbmRleF9rZXkpOwogICAgICAg
ICAgICBrZXlfc2V0cyA9IChrZXlfc2V0KiltYWxsb2MoMTcqc2l6ZW9mKGtleV9zZXQpKTsKICAg
ICAgICAgICAgZ2VuZXJhdGVfc3ViX2tleXMoZGVzX2tleSwga2V5X3NldHMpOwogICAgICAgICAg
ICAKICAgICAgICAgICAgZGF0YV9ibG9jayA9ICh1bnNpZ25lZCBjaGFyKiltYWxsb2MoOCpzaXpl
b2YoY2hhcikpOwogICAgICAgICAgICBwcm9jZXNzZWRfYmxvY2sgPSAodW5zaWduZWQgY2hhciop
bWFsbG9jKDgqc2l6ZW9mKGNoYXIpKTsKICAgICAgICAgICAgCiAgICAgICAgICAgIGludCBkYXRh
X3NpemUgPSBic3RybGVuKCh1bnNpZ25lZCBjaGFyKilzLT5yZWdfaW5fYWRkcik7CiAgICAgICAg
ICAgIGludCBudW1iZXJfb2ZfYmxvY2tzID0gZGF0YV9zaXplLzggKyAoKGRhdGFfc2l6ZSU4KT8x
OjApOwogICAgICAgICAgICBpbnQgYmxvY2tfY291bnQgPSAwOwogICAgICAgICAgICB1bnNpZ25l
ZCBzaG9ydCBpbnQgcGFkZGluZzsKICAgICAgICAgICAgCiAgICAgICAgICAgIHdoaWxlKGJyZWFk
KGRhdGFfYmxvY2ssIDgsICh1bnNpZ25lZCBjaGFyKilzLT5yZWdfaW5fYWRkciwgJmluZGV4X2lu
KSkKICAgICAgICAgICAgewogICAgICAgICAgICAgICAgYmxvY2tfY291bnQrKzsKICAgICAgICAg
ICAgICAgIGlmKGJsb2NrX2NvdW50ID09IG51bWJlcl9vZl9ibG9ja3MpCiAgICAgICAgICAgICAg
ICB7CiAgICAgICAgICAgICAgICAgICAgaWYocy0+cmVnX21vZGUgPT0gRU5DUllQVElPTl9NT0RF
KQogICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgcGFkZGluZyA9
IDggLSBkYXRhX3NpemUlODsKICAgICAgICAgICAgICAgICAgICAgICAgaWYocGFkZGluZyA8IDgp
CiAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1l
bXNldCgoZGF0YV9ibG9jayArIDggLSBwYWRkaW5nKSwgKHVuc2lnbmVkIGNoYXIpcGFkZGluZywg
cGFkZGluZyk7CiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgIHByb2Nlc3NfbWVzc2FnZShkYXRhX2Jsb2NrLCBw
cm9jZXNzZWRfYmxvY2ssIGtleV9zZXRzLCBzLT5yZWdfbW9kZSk7CiAgICAgICAgICAgICAgICAg
ICAgICAgIGJ3cml0ZShwcm9jZXNzZWRfYmxvY2ssIDgsICh1bnNpZ25lZCBjaGFyKilzLT5yZWdf
b3V0X2FkZHIsICZpbmRleF9vdXQpOwogICAgICAgICAgICAgICAgICAgICAgICBpZihwYWRkaW5n
ID09IDgpCiAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG1lbXNldChkYXRhX2Jsb2NrLCAodW5zaWduZWQgY2hhcilwYWRkaW5nLCA4KTsKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHByb2Nlc3NfbWVzc2FnZShkYXRhX2Jsb2NrLCBwcm9jZXNz
ZWRfYmxvY2ssIGtleV9zZXRzLCBzLT5yZWdfbW9kZSk7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBid3JpdGUocHJvY2Vzc2VkX2Jsb2NrLCA4LCAodW5zaWduZWQgY2hhciopcy0+cmVnX291
dF9hZGRyLCAmaW5kZXhfb3V0KTsKICAgICAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAg
ICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICBlbHNlCiAgICAgICAgICAgICAgICAgICAg
ewogICAgICAgICAgICAgICAgICAgICAgICBwcm9jZXNzX21lc3NhZ2UoZGF0YV9ibG9jaywgcHJv
Y2Vzc2VkX2Jsb2NrLCBrZXlfc2V0cywgcy0+cmVnX21vZGUpOwogICAgICAgICAgICAgICAgICAg
ICAgICBwYWRkaW5nID0gcHJvY2Vzc2VkX2Jsb2NrWzddOwogICAgICAgICAgICAgICAgICAgICAg
ICAKICAgICAgICAgICAgICAgICAgICAgICAgaWYocGFkZGluZyA8IDgpCiAgICAgICAgICAgICAg
ICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ3cml0ZShwcm9jZXNzZWRf
YmxvY2ssIDgsICh1bnNpZ25lZCBjaGFyKilzLT5yZWdfb3V0X2FkZHIsICZpbmRleF9vdXQpOwog
ICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAg
ICAgICAgfQogICAgICAgICAgICAgICAgZWxzZQogICAgICAgICAgICAgICAgewogICAgICAgICAg
ICAgICAgICAgIHByb2Nlc3NfbWVzc2FnZShkYXRhX2Jsb2NrLCBwcm9jZXNzZWRfYmxvY2ssIGtl
eV9zZXRzLCBzLT5yZWdfbW9kZSk7CiAgICAgICAgICAgICAgICAgICAgYndyaXRlKHByb2Nlc3Nl
ZF9ibG9jaywgOCwgKHVuc2lnbmVkIGNoYXIqKXMtPnJlZ19vdXRfYWRkciwgJmluZGV4X291dCk7
CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBtZW1zZXQoZGF0YV9ibG9jaywgMCwg
OCk7CiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIGZyZWUoa2V5X3NldHMpOwogICAgICAgICAg
ICBmcmVlKGRhdGFfYmxvY2spOwogICAgICAgICAgICBmcmVlKHByb2Nlc3NlZF9ibG9jayk7CiAg
ICAgICAgICAgIHMtPnJlZ19tb2RlID0gRE9ORV9NT0RFOwogICAgICAgICAgICBicmVhazsKICAg
ICAgICB9CiAgICAgICAgCiAgICAgICAgZnJlZShkZXNfa2V5KTsKICAgICAgICBicmVhazsKICAg
IGRlZmF1bHQ6CiAgICAgICAgcHJpbnRmKCJiYWQgb2Zmc2V0IDB4JXhcbiIsIChpbnQpb2Zmc2V0
KTsKICAgIH0KICAgIAojaWZkZWYgREVTX0RFQlVHCiAgICBwcmludGYoImZpbmlzaCBzb2NfZGVz
X3dyaXRlXG4iKTsKI2VuZGlmCgp9CgoKc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyBzb2Nf
ZGVzX29wcyA9IHsKICAgIC5yZWFkID0gc29jX2Rlc19yZWFkLAogICAgLndyaXRlID0gc29jX2Rl
c193cml0ZSwKICAgIC5lbmRpYW5uZXNzID0gREVWSUNFX05BVElWRV9FTkRJQU4sCiAgICAudmFs
aWQgPSB7CiAgICAgICAgLm1pbl9hY2Nlc3Nfc2l6ZSA9IDQsCiAgICAgICAgLm1heF9hY2Nlc3Nf
c2l6ZSA9IDQKICAgIH0KfTsKCnN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0
ZV9zb2NfZGVzID0gewogICAgLm5hbWUgPSAic29jIiwKICAgIC52ZXJzaW9uX2lkID0gMCwKICAg
IC5taW5pbXVtX3ZlcnNpb25faWQgPSAwLAogICAgLmZpZWxkcyA9IChWTVN0YXRlRmllbGRbXSkg
ewogICAgICAgIFZNU1RBVEVfVUlOVDMyKHJlZ19rZXlfYWRkciwgU29DREVTU3RhdGUpLAogICAg
ICAgIFZNU1RBVEVfVUlOVDMyKHJlZ19pbl9hZGRyLCBTb0NERVNTdGF0ZSksCiAgICAgICAgVk1T
VEFURV9VSU5UMzIocmVnX291dF9hZGRyLCBTb0NERVNTdGF0ZSksCiAgICAgICAgVk1TVEFURV9V
SU5UMzIocmVnX21vZGUsIFNvQ0RFU1N0YXRlKSwgICAgICAgIAogICAgICAgIFZNU1RBVEVfRU5E
X09GX0xJU1QoKQogICAgfQp9OwoKc3RhdGljIGludCBzb2NfZGVzX2luaXQoU3lzQnVzRGV2aWNl
ICpkZXYpCnsKI2lmZGVmIERFU19ERUJVRwogICAgcHJpbnRmKCJiZWdpbiBzb2NfZGVzX2luaXRc
biIpOwojZW5kaWYKICAgIAogICAgU29DREVTU3RhdGUgKmQgPSBTT0NfREVTKGRldik7CiAgICBk
LT5yZWdfa2V5X2FkZHIgPSAweDAwMDA7CiAgICBkLT5yZWdfaW5fYWRkcj0gMHgwMDAwOwogICAg
ZC0+cmVnX291dF9hZGRyID0gMHgwMDAwOwogICAgZC0+cmVnX21vZGUgPSAweDAwMDA7CiAgICAK
ICAgIHN5c2J1c19pbml0X2lycShkZXYsICZkLT5pcnEpOwogICAgbWVtb3J5X3JlZ2lvbl9pbml0
X2lvKCZkLT5tbWlvLCBPQkpFQ1QoZCksICZzb2NfZGVzX29wcywgZCwgVFlQRV9TT0NfREVTLCBS
RUdTX09GRlNFVCk7CiAgICBzeXNidXNfaW5pdF9tbWlvKGRldiwgJmQtPm1taW8pOwojaWZkZWYg
REVTX0RFQlVHCiAgICBwcmludGYoImZpbmlzaCBzb2NfZGVzX2luaXRcbiIpOwojZW5kaWYKCiAg
ICByZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQgc29jX2Rlc19jbGFzc19pbml0KE9iamVjdENsYXNz
ICprbGFzcywgdm9pZCAqZGF0YSkKewojaWZkZWYgREVTX0RFQlVHCiAgICBwcmludGYoImJlZ2lu
IHNvY19kZXNfY2xhc3NfaW5pdFxuIik7CiNlbmRpZgoKICAgIERldmljZUNsYXNzICpkID0gREVW
SUNFX0NMQVNTKGtsYXNzKTsKICAgIFN5c0J1c0RldmljZUNsYXNzICprID0gU1lTX0JVU19ERVZJ
Q0VfQ0xBU1Moa2xhc3MpOwogICAgCiAgICBrLT5pbml0ID0gc29jX2Rlc19pbml0OwogICAgZC0+
dm1zZCA9ICZ2bXN0YXRlX3NvY19kZXM7CiAgICAKI2lmZGVmIERFU19ERUJVRwogICAgcHJpbnRm
KCJmaW5pc2ggc29jX2Rlc19jbGFzc19pbml0XG4iKTsKI2VuZGlmCgp9CgpzdGF0aWMgY29uc3Qg
VHlwZUluZm8gc29jX2Rlc19pbmZvID0gewogICAgLm5hbWUgPSBUWVBFX1NPQ19ERVMsCiAgICAu
cGFyZW50ID0gVFlQRV9TWVNfQlVTX0RFVklDRSwKICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9m
KFNvQ0RFU1N0YXRlKSwKICAgIC5jbGFzc19pbml0ID0gc29jX2Rlc19jbGFzc19pbml0LAp9OwoK
c3RhdGljIHZvaWQgc29jX2Rlc19yZWdpc3Rlcl90eXBlcyh2b2lkKQp7CiNpZmRlZiBERVNfREVC
VUcKICAgIHByaW50ZigiYmVnaW4gc29jX2Rlc19yZWdpc3Rlcl90eXBlc1xuIik7CiNlbmRpZgoK
ICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGljKCZzb2NfZGVzX2luZm8pOwogICAgCiNpZmRlZiBERVNf
REVCVUcKICAgIHByaW50ZigiZmluaXNoIHNvY19kZXNfcmVnaXN0ZXJfdHlwZXNcbiIpOwojZW5k
aWYKCn0KCnR5cGVfaW5pdChzb2NfZGVzX3JlZ2lzdGVyX3R5cGVzKQoKCgovKgogKiBGdW5jdGlv
bnMgcmVsYXRlZCB0byBERVMgYWxnb3JpdGhtCiAqIEltcGxlbWVudGVkIGJ5IHRhcmVxdWVoCiAq
IGh0dHBzOi8vZ2l0aHViLmNvbS90YXJlcXVlaC9ERVMKICovCgppbnQgaW5pdGlhbF9rZXlfcGVy
bXV0YWlvbltdID0gezU3LCA0OSwgIDQxLCAzMywgIDI1LCAgMTcsICA5LAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAxLCA1OCwgIDUwLCA0MiwgIDM0LCAgMjYsIDE4LAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDEwLCAgMiwgIDU5LCA1MSwgIDQzLCAgMzUsIDI3LAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE5LCAxMSwgICAzLCA2MCwgIDUyLCAgNDQs
IDM2LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDYzLCA1NSwgIDQ3LCAzOSwgIDMx
LCAgMjMsIDE1LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA3LCA2MiwgIDU0LCA0
NiwgIDM4LCAgMzAsIDIyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE0LCAgNiwg
IDYxLCA1MywgIDQ1LCAgMzcsIDI5LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIx
LCAxMywgICA1LCAyOCwgIDIwLCAgMTIsICA0fTsKCmludCBpbml0aWFsX21lc3NhZ2VfcGVybXV0
YXRpb25bXSA9ICAgIHs1OCwgNTAsIDQyLCAzNCwgMjYsIDE4LCAxMCwgMiwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDYwLCA1MiwgNDQsIDM2LCAyOCwgMjAsIDEyLCA0
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNjIsIDU0LCA0NiwgMzgs
IDMwLCAyMiwgMTQsIDYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA2
NCwgNTYsIDQ4LCA0MCwgMzIsIDI0LCAxNiwgOCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDU3LCA0OSwgNDEsIDMzLCAyNSwgMTcsICA5LCAxLAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgNTksIDUxLCA0MywgMzUsIDI3LCAxOSwgMTEsIDMs
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA2MSwgNTMsIDQ1LCAzNywg
MjksIDIxLCAxMywgNSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDYz
LCA1NSwgNDcsIDM5LCAzMSwgMjMsIDE1LCA3fTsKCmludCBrZXlfc2hpZnRfc2l6ZXNbXSA9IHst
MSwgMSwgMSwgMiwgMiwgMiwgMiwgMiwgMiwgMSwgMiwgMiwgMiwgMiwgMiwgMiwgMX07CgppbnQg
c3ViX2tleV9wZXJtdXRhdGlvbltdID0gICAgezE0LCAxNywgMTEsIDI0LCAgMSwgIDUsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDMsIDI4LCAxNSwgIDYsIDIxLCAxMCwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAyMywgMTksIDEyLCAgNCwgMjYsICA4LAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDE2LCAgNywgMjcsIDIwLCAxMywgIDIsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgNDEsIDUyLCAzMSwgMzcsIDQ3LCA1NSwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAzMCwgNDAsIDUxLCA0NSwgMzMsIDQ4LAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDQ0LCA0OSwgMzksIDU2LCAzNCwgNTMsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgNDYsIDQyLCA1MCwgMzYsIDI5LCAzMn07CgppbnQgbWVzc2Fn
ZV9leHBhbnNpb25bXSA9ICB7MzIsICAxLCAgMiwgIDMsICA0LCAgNSwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA0LCAgNSwgIDYsICA3LCAgOCwgIDksCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgOCwgIDksIDEwLCAxMSwgMTIsIDEzLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMTIsIDEzLCAxNCwgMTUsIDE2LCAxNywKICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE2
LCAxNywgMTgsIDE5LCAyMCwgMjEsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAyMCwgMjEs
IDIyLCAyMywgMjQsIDI1LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgMjQsIDI1LCAyNiwg
MjcsIDI4LCAyOSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIDI4LCAyOSwgMzAsIDMxLCAz
MiwgIDF9OwoKaW50IFMxW10gPSB7MTQsICA0LCAxMywgIDEsICAyLCAxNSwgMTEsICA4LCAgMywg
MTAsICA2LCAxMiwgIDUsICA5LCAgMCwgIDcsCiAgICAgICAgICAgICAwLCAxNSwgIDcsICA0LCAx
NCwgIDIsIDEzLCAgMSwgMTAsICA2LCAxMiwgMTEsICA5LCAgNSwgIDMsICA4LAogICAgICAgICAg
ICAgNCwgIDEsIDE0LCAgOCwgMTMsICA2LCAgMiwgMTEsIDE1LCAxMiwgIDksICA3LCAgMywgMTAs
ICA1LCAgMCwKICAgICAgICAgICAgMTUsIDEyLCAgOCwgIDIsICA0LCAgOSwgIDEsICA3LCAgNSwg
MTEsICAzLCAxNCwgMTAsICAwLCAgNiwgMTN9OwoKaW50IFMyW10gPSB7MTUsICAxLCAgOCwgMTQs
ICA2LCAxMSwgIDMsICA0LCAgOSwgIDcsICAyLCAxMywgMTIsICAwLCAgNSwgMTAsCiAgICAgICAg
ICAgICAzLCAxMywgIDQsICA3LCAxNSwgIDIsICA4LCAxNCwgMTIsICAwLCAgMSwgMTAsICA2LCAg
OSwgMTEsICA1LAogICAgICAgICAgICAgMCwgMTQsICA3LCAxMSwgMTAsICA0LCAxMywgIDEsICA1
LCAgOCwgMTIsICA2LCAgOSwgIDMsICAyLCAxNSwKICAgICAgICAgICAgMTMsICA4LCAxMCwgIDEs
ICAzLCAxNSwgIDQsICAyLCAxMSwgIDYsICA3LCAxMiwgIDAsICA1LCAxNCwgIDl9OwoKaW50IFMz
W10gPSB7MTAsICAwLCAgOSwgMTQsICA2LCAgMywgMTUsICA1LCAgMSwgMTMsIDEyLCAgNywgMTEs
ICA0LCAgMiwgIDgsCiAgICAgICAgICAgIDEzLCAgNywgIDAsICA5LCAgMywgIDQsICA2LCAxMCwg
IDIsICA4LCAgNSwgMTQsIDEyLCAxMSwgMTUsICAxLAogICAgICAgICAgICAxMywgIDYsICA0LCAg
OSwgIDgsIDE1LCAgMywgIDAsIDExLCAgMSwgIDIsIDEyLCAgNSwgMTAsIDE0LCAgNywKICAgICAg
ICAgICAgIDEsIDEwLCAxMywgIDAsICA2LCAgOSwgIDgsICA3LCAgNCwgMTUsIDE0LCAgMywgMTEs
ICA1LCAgMiwgMTJ9OwoKaW50IFM0W10gPSB7IDcsIDEzLCAxNCwgIDMsICAwLCAgNiwgIDksIDEw
LCAgMSwgIDIsICA4LCAgNSwgMTEsIDEyLCAgNCwgMTUsCiAgICAgICAgICAgIDEzLCAgOCwgMTEs
ICA1LCAgNiwgMTUsICAwLCAgMywgIDQsICA3LCAgMiwgMTIsICAxLCAxMCwgMTQsICA5LAogICAg
ICAgICAgICAxMCwgIDYsICA5LCAgMCwgMTIsIDExLCAgNywgMTMsIDE1LCAgMSwgIDMsIDE0LCAg
NSwgIDIsICA4LCAgNCwKICAgICAgICAgICAgIDMsIDE1LCAgMCwgIDYsIDEwLCAgMSwgMTMsICA4
LCAgOSwgIDQsICA1LCAxMSwgMTIsICA3LCAgMiwgMTR9OwoKaW50IFM1W10gPSB7IDIsIDEyLCAg
NCwgIDEsICA3LCAxMCwgMTEsICA2LCAgOCwgIDUsICAzLCAxNSwgMTMsICAwLCAxNCwgIDksCiAg
ICAgICAgICAgIDE0LCAxMSwgIDIsIDEyLCAgNCwgIDcsIDEzLCAgMSwgIDUsICAwLCAxNSwgMTAs
ICAzLCAgOSwgIDgsICA2LAogICAgICAgICAgICAgNCwgIDIsICAxLCAxMSwgMTAsIDEzLCAgNywg
IDgsIDE1LCAgOSwgMTIsICA1LCAgNiwgIDMsICAwLCAxNCwKICAgICAgICAgICAgMTEsICA4LCAx
MiwgIDcsICAxLCAxNCwgIDIsIDEzLCAgNiwgMTUsICAwLCAgOSwgMTAsICA0LCAgNSwgIDN9OwoK
aW50IFM2W10gPSB7MTIsICAxLCAxMCwgMTUsICA5LCAgMiwgIDYsICA4LCAgMCwgMTMsICAzLCAg
NCwgMTQsICA3LCAgNSwgMTEsCiAgICAgICAgICAgIDEwLCAxNSwgIDQsICAyLCAgNywgMTIsICA5
LCAgNSwgIDYsICAxLCAxMywgMTQsICAwLCAxMSwgIDMsICA4LAogICAgICAgICAgICAgOSwgMTQs
IDE1LCAgNSwgIDIsICA4LCAxMiwgIDMsICA3LCAgMCwgIDQsIDEwLCAgMSwgMTMsIDExLCAgNiwK
ICAgICAgICAgICAgIDQsICAzLCAgMiwgMTIsICA5LCAgNSwgMTUsIDEwLCAxMSwgMTQsICAxLCAg
NywgIDYsICAwLCAgOCwgMTN9OwoKaW50IFM3W10gPSB7IDQsIDExLCAgMiwgMTQsIDE1LCAgMCwg
IDgsIDEzLCAgMywgMTIsICA5LCAgNywgIDUsIDEwLCAgNiwgIDEsCiAgICAgICAgICAgIDEzLCAg
MCwgMTEsICA3LCAgNCwgIDksICAxLCAxMCwgMTQsICAzLCAgNSwgMTIsICAyLCAxNSwgIDgsICA2
LAogICAgICAgICAgICAgMSwgIDQsIDExLCAxMywgMTIsICAzLCAgNywgMTQsIDEwLCAxNSwgIDYs
ICA4LCAgMCwgIDUsICA5LCAgMiwKICAgICAgICAgICAgIDYsIDExLCAxMywgIDgsICAxLCAgNCwg
MTAsICA3LCAgOSwgIDUsICAwLCAxNSwgMTQsICAyLCAgMywgMTJ9OwoKaW50IFM4W10gPSB7MTMs
ICAyLCAgOCwgIDQsICA2LCAxNSwgMTEsICAxLCAxMCwgIDksICAzLCAxNCwgIDUsICAwLCAxMiwg
IDcsCiAgICAgICAgICAgICAxLCAxNSwgMTMsICA4LCAxMCwgIDMsICA3LCAgNCwgMTIsICA1LCAg
NiwgMTEsICAwLCAxNCwgIDksICAyLAogICAgICAgICAgICAgNywgMTEsICA0LCAgMSwgIDksIDEy
LCAxNCwgIDIsICAwLCAgNiwgMTAsIDEzLCAxNSwgIDMsICA1LCAgOCwKICAgICAgICAgICAgIDIs
ICAxLCAxNCwgIDcsICA0LCAxMCwgIDgsIDEzLCAxNSwgMTIsICA5LCAgMCwgIDMsICA1LCAgNiwg
MTF9OwoKaW50IHJpZ2h0X3N1Yl9tZXNzYWdlX3Blcm11dGF0aW9uW10gPSAgICB7MTYsICA3LCAy
MCwgMjEsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDI5LCAxMiwgMjgsIDE3
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSwgMTUsIDIzLCAyNiwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUsIDE4LCAzMSwgMTAsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyLCAgOCwgMjQsIDE0LAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAzMiwgMjcsICAzLCAgOSwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgMTksIDEzLCAzMCwgIDYsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDIyLCAxMSwgIDQsIDI1fTsKCmludCBmaW5hbF9tZXNzYWdlX3Blcm11dGF0
aW9uW10gPSAgezQwLCAgOCwgNDgsIDE2LCA1NiwgMjQsIDY0LCAzMiwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMzksICA3LCA0NywgMTUsIDU1LCAyMywgNjMsIDMxLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAzOCwgIDYsIDQ2LCAxNCwgNTQsIDIyLCA2
MiwgMzAsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDM3LCAgNSwgNDUsIDEz
LCA1MywgMjEsIDYxLCAyOSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMzYs
ICA0LCA0NCwgMTIsIDUyLCAyMCwgNjAsIDI4LAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAzNSwgIDMsIDQzLCAxMSwgNTEsIDE5LCA1OSwgMjcsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDM0LCAgMiwgNDIsIDEwLCA1MCwgMTgsIDU4LCAyNiwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMzMsICAxLCA0MSwgIDksIDQ5LCAxNywgNTcs
IDI1fTsKCgp2b2lkIHByaW50X2NoYXJfYXNfYmluYXJ5KGNoYXIgaW5wdXQpIHsKICAgIGludCBp
OwogICAgZm9yIChpPTA7IGk8ODsgaSsrKSB7CiAgICAgICAgY2hhciBzaGlmdF9ieXRlID0gMHgw
MSA8PCAoNy1pKTsKICAgICAgICBpZiAoc2hpZnRfYnl0ZSAmIGlucHV0KSB7CiAgICAgICAgICAg
IHByaW50ZigiMSIpOwogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIHByaW50ZigiMCIpOwog
ICAgICAgIH0KICAgIH0KfQoKaW50IGJyZWFkKHVuc2lnbmVkIGNoYXIqIGJsb2NrLCBpbnQgc2l6
ZSwgdW5zaWduZWQgY2hhciogc3RyLCBpbnQqIGluZGV4KQp7CiAgICBpbnQgaTsKICAgIGNoYXIg
YzsKICAgIGZvcihpID0gMDsgaSA8IHNpemU7IGkrKykKICAgIHsKICAgICAgICBjcHVfcGh5c2lj
YWxfbWVtb3J5X3JlYWQoc3RyICsgKmluZGV4ICsgaSwgJmMsIDEpOwogICAgICAgIGlmKCFjKQog
ICAgICAgICAgICBicmVhazsKICAgICAgICBibG9ja1tpXSA9IGM7CiAgICB9CiAgICAqaW5kZXgg
Kz0gaTsKICAgIHJldHVybiBpOwp9CgppbnQgYndyaXRlKHVuc2lnbmVkIGNoYXIqIGJsb2NrLCBp
bnQgc2l6ZSwgdW5zaWduZWQgY2hhciogc3RyLCBpbnQqIGluZGV4KQp7CiAgICBpbnQgaTsKICAg
IGNoYXIgYzsKICAgIGZvcihpID0gMDsgaSA8IHNpemU7IGkrKykKICAgIHsKICAgICAgICBjID0g
YmxvY2tbaV07CiAgICAgICAgY3B1X3BoeXNpY2FsX21lbW9yeV93cml0ZShzdHIgKyAqaW5kZXgg
KyBpLCAmYywgMSk7CiAgICB9CiAgICAqaW5kZXggKz0gaTsKICAgIHJldHVybiBpOwp9CgppbnQg
YnN0cmxlbih1bnNpZ25lZCBjaGFyKiBzdHIpCnsKICAgIGludCBpOwogICAgY2hhciBjOwogICAg
Zm9yKGkgPSAwOyA7IGkrKykKICAgIHsKICAgICAgICBjcHVfcGh5c2ljYWxfbWVtb3J5X3JlYWQo
c3RyICsgaSwgJmMsIDEpOwogICAgICAgIGlmKCFjKQogICAgICAgICAgICBicmVhazsKICAgIH0K
ICAgIHJldHVybiBpOwp9Cgp2b2lkIGdlbmVyYXRlX2tleSh1bnNpZ25lZCBjaGFyKiBrZXkpIHsK
ICAgIGludCBpOwogICAgZm9yIChpPTA7IGk8ODsgaSsrKSB7CiAgICAgICAga2V5W2ldID0gcmFu
ZCgpJTI1NTsKICAgIH0KfQoKdm9pZCBwcmludF9rZXlfc2V0KGtleV9zZXQga2V5X3NldCl7CiAg
ICBpbnQgaTsKICAgIHByaW50ZigiSzogXG4iKTsKICAgIGZvciAoaT0wOyBpPDg7IGkrKykgewog
ICAgICAgIHByaW50ZigiJTAyWCA6ICIsIGtleV9zZXQua1tpXSk7CiAgICAgICAgcHJpbnRfY2hh
cl9hc19iaW5hcnkoa2V5X3NldC5rW2ldKTsKICAgICAgICBwcmludGYoIlxuIik7CiAgICB9CiAg
ICBwcmludGYoIlxuQzogXG4iKTsKCiAgICBmb3IgKGk9MDsgaTw0OyBpKyspIHsKICAgICAgICBw
cmludGYoIiUwMlggOiAiLCBrZXlfc2V0LmNbaV0pOwogICAgICAgIHByaW50X2NoYXJfYXNfYmlu
YXJ5KGtleV9zZXQuY1tpXSk7CiAgICAgICAgcHJpbnRmKCJcbiIpOwogICAgfQogICAgcHJpbnRm
KCJcbkQ6IFxuIik7CgogICAgZm9yIChpPTA7IGk8NDsgaSsrKSB7CiAgICAgICAgcHJpbnRmKCIl
MDJYIDogIiwga2V5X3NldC5kW2ldKTsKICAgICAgICBwcmludF9jaGFyX2FzX2JpbmFyeShrZXlf
c2V0LmRbaV0pOwogICAgICAgIHByaW50ZigiXG4iKTsKICAgIH0KICAgIHByaW50ZigiXG4iKTsK
fQoKdm9pZCBnZW5lcmF0ZV9zdWJfa2V5cyh1bnNpZ25lZCBjaGFyKiBtYWluX2tleSwga2V5X3Nl
dCoga2V5X3NldHMpIHsKICAgIGludCBpLCBqOwogICAgaW50IHNoaWZ0X3NpemU7CiAgICB1bnNp
Z25lZCBjaGFyIHNoaWZ0X2J5dGUsIGZpcnN0X3NoaWZ0X2JpdHMsIHNlY29uZF9zaGlmdF9iaXRz
LCB0aGlyZF9zaGlmdF9iaXRzLCBmb3VydGhfc2hpZnRfYml0czsKCiAgICBmb3IgKGk9MDsgaTw4
OyBpKyspIHsKICAgICAgICBrZXlfc2V0c1swXS5rW2ldID0gMDsKICAgIH0KCiAgICBmb3IgKGk9
MDsgaTw1NjsgaSsrKSB7CiAgICAgICAgc2hpZnRfc2l6ZSA9IGluaXRpYWxfa2V5X3Blcm11dGFp
b25baV07CiAgICAgICAgc2hpZnRfYnl0ZSA9IDB4ODAgPj4gKChzaGlmdF9zaXplIC0gMSklOCk7
CiAgICAgICAgc2hpZnRfYnl0ZSAmPSBtYWluX2tleVsoc2hpZnRfc2l6ZSAtIDEpLzhdOwogICAg
ICAgIHNoaWZ0X2J5dGUgPDw9ICgoc2hpZnRfc2l6ZSAtIDEpJTgpOwoKICAgICAgICBrZXlfc2V0
c1swXS5rW2kvOF0gfD0gKHNoaWZ0X2J5dGUgPj4gaSU4KTsKICAgIH0KCiAgICBmb3IgKGk9MDsg
aTwzOyBpKyspIHsKICAgICAgICBrZXlfc2V0c1swXS5jW2ldID0ga2V5X3NldHNbMF0ua1tpXTsK
ICAgIH0KCiAgICBrZXlfc2V0c1swXS5jWzNdID0ga2V5X3NldHNbMF0ua1szXSAmIDB4RjA7Cgog
ICAgZm9yIChpPTA7IGk8MzsgaSsrKSB7CiAgICAgICAga2V5X3NldHNbMF0uZFtpXSA9IChrZXlf
c2V0c1swXS5rW2krM10gJiAweDBGKSA8PCA0OwogICAgICAgIGtleV9zZXRzWzBdLmRbaV0gfD0g
KGtleV9zZXRzWzBdLmtbaSs0XSAmIDB4RjApID4+IDQ7CiAgICB9CgogICAga2V5X3NldHNbMF0u
ZFszXSA9IChrZXlfc2V0c1swXS5rWzZdICYgMHgwRikgPDwgNDsKCgogICAgZm9yIChpPTE7IGk8
MTc7IGkrKykgewogICAgICAgIGZvciAoaj0wOyBqPDQ7IGorKykgewogICAgICAgICAgICBrZXlf
c2V0c1tpXS5jW2pdID0ga2V5X3NldHNbaS0xXS5jW2pdOwogICAgICAgICAgICBrZXlfc2V0c1tp
XS5kW2pdID0ga2V5X3NldHNbaS0xXS5kW2pdOwogICAgICAgIH0KCiAgICAgICAgc2hpZnRfc2l6
ZSA9IGtleV9zaGlmdF9zaXplc1tpXTsKICAgICAgICBpZiAoc2hpZnRfc2l6ZSA9PSAxKXsKICAg
ICAgICAgICAgc2hpZnRfYnl0ZSA9IDB4ODA7CiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAg
c2hpZnRfYnl0ZSA9IDB4QzA7CiAgICAgICAgfQoKICAgICAgICAvLyBQcm9jZXNzIEMKICAgICAg
ICBmaXJzdF9zaGlmdF9iaXRzID0gc2hpZnRfYnl0ZSAmIGtleV9zZXRzW2ldLmNbMF07CiAgICAg
ICAgc2Vjb25kX3NoaWZ0X2JpdHMgPSBzaGlmdF9ieXRlICYga2V5X3NldHNbaV0uY1sxXTsKICAg
ICAgICB0aGlyZF9zaGlmdF9iaXRzID0gc2hpZnRfYnl0ZSAmIGtleV9zZXRzW2ldLmNbMl07CiAg
ICAgICAgZm91cnRoX3NoaWZ0X2JpdHMgPSBzaGlmdF9ieXRlICYga2V5X3NldHNbaV0uY1szXTsK
CiAgICAgICAga2V5X3NldHNbaV0uY1swXSA8PD0gc2hpZnRfc2l6ZTsKICAgICAgICBrZXlfc2V0
c1tpXS5jWzBdIHw9IChzZWNvbmRfc2hpZnRfYml0cyA+PiAoOCAtIHNoaWZ0X3NpemUpKTsKCiAg
ICAgICAga2V5X3NldHNbaV0uY1sxXSA8PD0gc2hpZnRfc2l6ZTsKICAgICAgICBrZXlfc2V0c1tp
XS5jWzFdIHw9ICh0aGlyZF9zaGlmdF9iaXRzID4+ICg4IC0gc2hpZnRfc2l6ZSkpOwoKICAgICAg
ICBrZXlfc2V0c1tpXS5jWzJdIDw8PSBzaGlmdF9zaXplOwogICAgICAgIGtleV9zZXRzW2ldLmNb
Ml0gfD0gKGZvdXJ0aF9zaGlmdF9iaXRzID4+ICg4IC0gc2hpZnRfc2l6ZSkpOwoKICAgICAgICBr
ZXlfc2V0c1tpXS5jWzNdIDw8PSBzaGlmdF9zaXplOwogICAgICAgIGtleV9zZXRzW2ldLmNbM10g
fD0gKGZpcnN0X3NoaWZ0X2JpdHMgPj4gKDQgLSBzaGlmdF9zaXplKSk7CgogICAgICAgIC8vIFBy
b2Nlc3MgRAogICAgICAgIGZpcnN0X3NoaWZ0X2JpdHMgPSBzaGlmdF9ieXRlICYga2V5X3NldHNb
aV0uZFswXTsKICAgICAgICBzZWNvbmRfc2hpZnRfYml0cyA9IHNoaWZ0X2J5dGUgJiBrZXlfc2V0
c1tpXS5kWzFdOwogICAgICAgIHRoaXJkX3NoaWZ0X2JpdHMgPSBzaGlmdF9ieXRlICYga2V5X3Nl
dHNbaV0uZFsyXTsKICAgICAgICBmb3VydGhfc2hpZnRfYml0cyA9IHNoaWZ0X2J5dGUgJiBrZXlf
c2V0c1tpXS5kWzNdOwoKICAgICAgICBrZXlfc2V0c1tpXS5kWzBdIDw8PSBzaGlmdF9zaXplOwog
ICAgICAgIGtleV9zZXRzW2ldLmRbMF0gfD0gKHNlY29uZF9zaGlmdF9iaXRzID4+ICg4IC0gc2hp
ZnRfc2l6ZSkpOwoKICAgICAgICBrZXlfc2V0c1tpXS5kWzFdIDw8PSBzaGlmdF9zaXplOwogICAg
ICAgIGtleV9zZXRzW2ldLmRbMV0gfD0gKHRoaXJkX3NoaWZ0X2JpdHMgPj4gKDggLSBzaGlmdF9z
aXplKSk7CgogICAgICAgIGtleV9zZXRzW2ldLmRbMl0gPDw9IHNoaWZ0X3NpemU7CiAgICAgICAg
a2V5X3NldHNbaV0uZFsyXSB8PSAoZm91cnRoX3NoaWZ0X2JpdHMgPj4gKDggLSBzaGlmdF9zaXpl
KSk7CgogICAgICAgIGtleV9zZXRzW2ldLmRbM10gPDw9IHNoaWZ0X3NpemU7CiAgICAgICAga2V5
X3NldHNbaV0uZFszXSB8PSAoZmlyc3Rfc2hpZnRfYml0cyA+PiAoNCAtIHNoaWZ0X3NpemUpKTsK
CiAgICAgICAgZm9yIChqPTA7IGo8NDg7IGorKykgewogICAgICAgICAgICBzaGlmdF9zaXplID0g
c3ViX2tleV9wZXJtdXRhdGlvbltqXTsKICAgICAgICAgICAgaWYgKHNoaWZ0X3NpemUgPD0gMjgp
IHsKICAgICAgICAgICAgICAgIHNoaWZ0X2J5dGUgPSAweDgwID4+ICgoc2hpZnRfc2l6ZSAtIDEp
JTgpOwogICAgICAgICAgICAgICAgc2hpZnRfYnl0ZSAmPSBrZXlfc2V0c1tpXS5jWyhzaGlmdF9z
aXplIC0gMSkvOF07CiAgICAgICAgICAgICAgICBzaGlmdF9ieXRlIDw8PSAoKHNoaWZ0X3NpemUg
LSAxKSU4KTsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIHNoaWZ0X2J5dGUg
PSAweDgwID4+ICgoc2hpZnRfc2l6ZSAtIDI5KSU4KTsKICAgICAgICAgICAgICAgIHNoaWZ0X2J5
dGUgJj0ga2V5X3NldHNbaV0uZFsoc2hpZnRfc2l6ZSAtIDI5KS84XTsKICAgICAgICAgICAgICAg
IHNoaWZ0X2J5dGUgPDw9ICgoc2hpZnRfc2l6ZSAtIDI5KSU4KTsKICAgICAgICAgICAgfQoKICAg
ICAgICAgICAga2V5X3NldHNbaV0ua1tqLzhdIHw9IChzaGlmdF9ieXRlID4+IGolOCk7CiAgICAg
ICAgfQogICAgfQp9Cgp2b2lkIHByb2Nlc3NfbWVzc2FnZSh1bnNpZ25lZCBjaGFyKiBtZXNzYWdl
X3BpZWNlLCB1bnNpZ25lZCBjaGFyKiBwcm9jZXNzZWRfcGllY2UsIGtleV9zZXQqIGtleV9zZXRz
LCBpbnQgbW9kZSkgewogICAgaW50IGksIGs7CiAgICBpbnQgc2hpZnRfc2l6ZTsKICAgIHVuc2ln
bmVkIGNoYXIgc2hpZnRfYnl0ZTsKCiAgICB1bnNpZ25lZCBjaGFyIGluaXRpYWxfcGVybXV0YXRp
b25bOF07CiAgICBtZW1zZXQoaW5pdGlhbF9wZXJtdXRhdGlvbiwgMCwgOCk7CiAgICBtZW1zZXQo
cHJvY2Vzc2VkX3BpZWNlLCAwLCA4KTsKCiAgICBmb3IgKGk9MDsgaTw2NDsgaSsrKSB7CiAgICAg
ICAgc2hpZnRfc2l6ZSA9IGluaXRpYWxfbWVzc2FnZV9wZXJtdXRhdGlvbltpXTsKICAgICAgICBz
aGlmdF9ieXRlID0gMHg4MCA+PiAoKHNoaWZ0X3NpemUgLSAxKSU4KTsKICAgICAgICBzaGlmdF9i
eXRlICY9IG1lc3NhZ2VfcGllY2VbKHNoaWZ0X3NpemUgLSAxKS84XTsKICAgICAgICBzaGlmdF9i
eXRlIDw8PSAoKHNoaWZ0X3NpemUgLSAxKSU4KTsKCiAgICAgICAgaW5pdGlhbF9wZXJtdXRhdGlv
bltpLzhdIHw9IChzaGlmdF9ieXRlID4+IGklOCk7CiAgICB9CgogICAgdW5zaWduZWQgY2hhciBs
WzRdLCByWzRdOwogICAgZm9yIChpPTA7IGk8NDsgaSsrKSB7CiAgICAgICAgbFtpXSA9IGluaXRp
YWxfcGVybXV0YXRpb25baV07CiAgICAgICAgcltpXSA9IGluaXRpYWxfcGVybXV0YXRpb25baSs0
XTsKICAgIH0KCiAgICB1bnNpZ25lZCBjaGFyIGxuWzRdLCBybls0XSwgZXJbNl0sIHNlcls0XTsK
CiAgICBpbnQga2V5X2luZGV4OwogICAgZm9yIChrPTE7IGs8PTE2OyBrKyspIHsKICAgICAgICBt
ZW1jcHkobG4sIHIsIDQpOwoKICAgICAgICBtZW1zZXQoZXIsIDAsIDYpOwoKICAgICAgICBmb3Ig
KGk9MDsgaTw0ODsgaSsrKSB7CiAgICAgICAgICAgIHNoaWZ0X3NpemUgPSBtZXNzYWdlX2V4cGFu
c2lvbltpXTsKICAgICAgICAgICAgc2hpZnRfYnl0ZSA9IDB4ODAgPj4gKChzaGlmdF9zaXplIC0g
MSklOCk7CiAgICAgICAgICAgIHNoaWZ0X2J5dGUgJj0gclsoc2hpZnRfc2l6ZSAtIDEpLzhdOwog
ICAgICAgICAgICBzaGlmdF9ieXRlIDw8PSAoKHNoaWZ0X3NpemUgLSAxKSU4KTsKCiAgICAgICAg
ICAgIGVyW2kvOF0gfD0gKHNoaWZ0X2J5dGUgPj4gaSU4KTsKICAgICAgICB9CgogICAgICAgIGlm
IChtb2RlID09IERFQ1JZUFRJT05fTU9ERSkgewogICAgICAgICAgICBrZXlfaW5kZXggPSAxNyAt
IGs7CiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAga2V5X2luZGV4ID0gazsKICAgICAgICB9
CgogICAgICAgIGZvciAoaT0wOyBpPDY7IGkrKykgewogICAgICAgICAgICBlcltpXSBePSBrZXlf
c2V0c1trZXlfaW5kZXhdLmtbaV07CiAgICAgICAgfQoKICAgICAgICB1bnNpZ25lZCBjaGFyIHJv
dywgY29sdW1uOwoKICAgICAgICBmb3IgKGk9MDsgaTw0OyBpKyspIHsKICAgICAgICAgICAgc2Vy
W2ldID0gMDsKICAgICAgICB9CgogICAgICAgIC8vIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAw
MDAwCiAgICAgICAgLy8gcmNjYyBjcnJjIGNjY3IgcmNjYyBjcnJjIGNjY3IKCiAgICAgICAgLy8g
Qnl0ZSAxCiAgICAgICAgcm93ID0gMDsKICAgICAgICByb3cgfD0gKChlclswXSAmIDB4ODApID4+
IDYpOwogICAgICAgIHJvdyB8PSAoKGVyWzBdICYgMHgwNCkgPj4gMik7CgogICAgICAgIGNvbHVt
biA9IDA7CiAgICAgICAgY29sdW1uIHw9ICgoZXJbMF0gJiAweDc4KSA+PiAzKTsKCiAgICAgICAg
c2VyWzBdIHw9ICgodW5zaWduZWQgY2hhcilTMVtyb3cqMTYrY29sdW1uXSA8PCA0KTsKCiAgICAg
ICAgcm93ID0gMDsKICAgICAgICByb3cgfD0gKGVyWzBdICYgMHgwMik7CiAgICAgICAgcm93IHw9
ICgoZXJbMV0gJiAweDEwKSA+PiA0KTsKCiAgICAgICAgY29sdW1uID0gMDsKICAgICAgICBjb2x1
bW4gfD0gKChlclswXSAmIDB4MDEpIDw8IDMpOwogICAgICAgIGNvbHVtbiB8PSAoKGVyWzFdICYg
MHhFMCkgPj4gNSk7CgogICAgICAgIHNlclswXSB8PSAodW5zaWduZWQgY2hhcilTMltyb3cqMTYr
Y29sdW1uXTsKCiAgICAgICAgLy8gQnl0ZSAyCiAgICAgICAgcm93ID0gMDsKICAgICAgICByb3cg
fD0gKChlclsxXSAmIDB4MDgpID4+IDIpOwogICAgICAgIHJvdyB8PSAoKGVyWzJdICYgMHg0MCkg
Pj4gNik7CgogICAgICAgIGNvbHVtbiA9IDA7CiAgICAgICAgY29sdW1uIHw9ICgoZXJbMV0gJiAw
eDA3KSA8PCAxKTsKICAgICAgICBjb2x1bW4gfD0gKChlclsyXSAmIDB4ODApID4+IDcpOwoKICAg
ICAgICBzZXJbMV0gfD0gKCh1bnNpZ25lZCBjaGFyKVMzW3JvdyoxNitjb2x1bW5dIDw8IDQpOwoK
ICAgICAgICByb3cgPSAwOwogICAgICAgIHJvdyB8PSAoKGVyWzJdICYgMHgyMCkgPj4gNCk7CiAg
ICAgICAgcm93IHw9IChlclsyXSAmIDB4MDEpOwoKICAgICAgICBjb2x1bW4gPSAwOwogICAgICAg
IGNvbHVtbiB8PSAoKGVyWzJdICYgMHgxRSkgPj4gMSk7CgogICAgICAgIHNlclsxXSB8PSAodW5z
aWduZWQgY2hhcilTNFtyb3cqMTYrY29sdW1uXTsKCiAgICAgICAgLy8gQnl0ZSAzCiAgICAgICAg
cm93ID0gMDsKICAgICAgICByb3cgfD0gKChlclszXSAmIDB4ODApID4+IDYpOwogICAgICAgIHJv
dyB8PSAoKGVyWzNdICYgMHgwNCkgPj4gMik7CgogICAgICAgIGNvbHVtbiA9IDA7CiAgICAgICAg
Y29sdW1uIHw9ICgoZXJbM10gJiAweDc4KSA+PiAzKTsKCiAgICAgICAgc2VyWzJdIHw9ICgodW5z
aWduZWQgY2hhcilTNVtyb3cqMTYrY29sdW1uXSA8PCA0KTsKCiAgICAgICAgcm93ID0gMDsKICAg
ICAgICByb3cgfD0gKGVyWzNdICYgMHgwMik7CiAgICAgICAgcm93IHw9ICgoZXJbNF0gJiAweDEw
KSA+PiA0KTsKCiAgICAgICAgY29sdW1uID0gMDsKICAgICAgICBjb2x1bW4gfD0gKChlclszXSAm
IDB4MDEpIDw8IDMpOwogICAgICAgIGNvbHVtbiB8PSAoKGVyWzRdICYgMHhFMCkgPj4gNSk7Cgog
ICAgICAgIHNlclsyXSB8PSAodW5zaWduZWQgY2hhcilTNltyb3cqMTYrY29sdW1uXTsKCiAgICAg
ICAgLy8gQnl0ZSA0CiAgICAgICAgcm93ID0gMDsKICAgICAgICByb3cgfD0gKChlcls0XSAmIDB4
MDgpID4+IDIpOwogICAgICAgIHJvdyB8PSAoKGVyWzVdICYgMHg0MCkgPj4gNik7CgogICAgICAg
IGNvbHVtbiA9IDA7CiAgICAgICAgY29sdW1uIHw9ICgoZXJbNF0gJiAweDA3KSA8PCAxKTsKICAg
ICAgICBjb2x1bW4gfD0gKChlcls1XSAmIDB4ODApID4+IDcpOwoKICAgICAgICBzZXJbM10gfD0g
KCh1bnNpZ25lZCBjaGFyKVM3W3JvdyoxNitjb2x1bW5dIDw8IDQpOwoKICAgICAgICByb3cgPSAw
OwogICAgICAgIHJvdyB8PSAoKGVyWzVdICYgMHgyMCkgPj4gNCk7CiAgICAgICAgcm93IHw9IChl
cls1XSAmIDB4MDEpOwoKICAgICAgICBjb2x1bW4gPSAwOwogICAgICAgIGNvbHVtbiB8PSAoKGVy
WzVdICYgMHgxRSkgPj4gMSk7CgogICAgICAgIHNlclszXSB8PSAodW5zaWduZWQgY2hhcilTOFty
b3cqMTYrY29sdW1uXTsKCiAgICAgICAgZm9yIChpPTA7IGk8NDsgaSsrKSB7CiAgICAgICAgICAg
IHJuW2ldID0gMDsKICAgICAgICB9CgogICAgICAgIGZvciAoaT0wOyBpPDMyOyBpKyspIHsKICAg
ICAgICAgICAgc2hpZnRfc2l6ZSA9IHJpZ2h0X3N1Yl9tZXNzYWdlX3Blcm11dGF0aW9uW2ldOwog
ICAgICAgICAgICBzaGlmdF9ieXRlID0gMHg4MCA+PiAoKHNoaWZ0X3NpemUgLSAxKSU4KTsKICAg
ICAgICAgICAgc2hpZnRfYnl0ZSAmPSBzZXJbKHNoaWZ0X3NpemUgLSAxKS84XTsKICAgICAgICAg
ICAgc2hpZnRfYnl0ZSA8PD0gKChzaGlmdF9zaXplIC0gMSklOCk7CgogICAgICAgICAgICBybltp
LzhdIHw9IChzaGlmdF9ieXRlID4+IGklOCk7CiAgICAgICAgfQoKICAgICAgICBmb3IgKGk9MDsg
aTw0OyBpKyspIHsKICAgICAgICAgICAgcm5baV0gXj0gbFtpXTsKICAgICAgICB9CgogICAgICAg
IGZvciAoaT0wOyBpPDQ7IGkrKykgewogICAgICAgICAgICBsW2ldID0gbG5baV07CiAgICAgICAg
ICAgIHJbaV0gPSBybltpXTsKICAgICAgICB9CiAgICB9CgogICAgdW5zaWduZWQgY2hhciBwcmVf
ZW5kX3Blcm11dGF0aW9uWzhdOwogICAgZm9yIChpPTA7IGk8NDsgaSsrKSB7CiAgICAgICAgcHJl
X2VuZF9wZXJtdXRhdGlvbltpXSA9IHJbaV07CiAgICAgICAgcHJlX2VuZF9wZXJtdXRhdGlvbls0
K2ldID0gbFtpXTsKICAgIH0KCiAgICBmb3IgKGk9MDsgaTw2NDsgaSsrKSB7CiAgICAgICAgc2hp
ZnRfc2l6ZSA9IGZpbmFsX21lc3NhZ2VfcGVybXV0YXRpb25baV07CiAgICAgICAgc2hpZnRfYnl0
ZSA9IDB4ODAgPj4gKChzaGlmdF9zaXplIC0gMSklOCk7CiAgICAgICAgc2hpZnRfYnl0ZSAmPSBw
cmVfZW5kX3Blcm11dGF0aW9uWyhzaGlmdF9zaXplIC0gMSkvOF07CiAgICAgICAgc2hpZnRfYnl0
ZSA8PD0gKChzaGlmdF9zaXplIC0gMSklOCk7CgogICAgICAgIHByb2Nlc3NlZF9waWVjZVtpLzhd
IHw9IChzaGlmdF9ieXRlID4+IGklOCk7CiAgICB9Cn0K
--0000000000000d9da205a135d312
Content-Type: application/octet-stream; name="test.s"
Content-Disposition: attachment; filename="test.s"
Content-Transfer-Encoding: base64
Content-ID: <f_k7ytw1321>
X-Attachment-Id: f_k7ytw1321

CS5jcHUgYXJtN3RkbWkKCS5lYWJpX2F0dHJpYnV0ZSAyMCwgMQoJLmVhYmlfYXR0cmlidXRlIDIx
LCAxCgkuZWFiaV9hdHRyaWJ1dGUgMjMsIDMKCS5lYWJpX2F0dHJpYnV0ZSAyNCwgMQoJLmVhYmlf
YXR0cmlidXRlIDI1LCAxCgkuZWFiaV9hdHRyaWJ1dGUgMjYsIDEKCS5lYWJpX2F0dHJpYnV0ZSAz
MCwgNgoJLmVhYmlfYXR0cmlidXRlIDM0LCAwCgkuZWFiaV9hdHRyaWJ1dGUgMTgsIDQKCS5maWxl
CSJkZXNfZGVtby5jIgoJLnRleHQKLkx0ZXh0MDoKCS5jZmlfc2VjdGlvbnMJLmRlYnVnX2ZyYW1l
CgkuZ2xvYmFsCVVBUlQwRFIKCS5zZWN0aW9uCS5yb2RhdGEKCS5hbGlnbgkyCgkudHlwZQlVQVJU
MERSLCAlb2JqZWN0Cgkuc2l6ZQlVQVJUMERSLCA0ClVBUlQwRFI6Cgkud29yZAkyNzA0NzExNjgK
CS50ZXh0CgkuYWxpZ24JMgoJLmdsb2JhbAlwcmludF91YXJ0MAoJLmFyY2ggYXJtdjR0Cgkuc3lu
dGF4IHVuaWZpZWQKCS5hcm0KCS5mcHUgc29mdHZmcAoJLnR5cGUJcHJpbnRfdWFydDAsICVmdW5j
dGlvbgpwcmludF91YXJ0MDoKLkxGQjA6CgkuZmlsZSAxICJkZXNfZGVtby5jIgoJLmxvYyAxIDIw
IDEKCS5jZmlfc3RhcnRwcm9jCglAIEZ1bmN0aW9uIHN1cHBvcnRzIGludGVyd29ya2luZy4KCUAg
YXJncyA9IDAsIHByZXRlbmQgPSAwLCBmcmFtZSA9IDgKCUAgZnJhbWVfbmVlZGVkID0gMSwgdXNl
c19hbm9ueW1vdXNfYXJncyA9IDAKCUAgbGluayByZWdpc3RlciBzYXZlIGVsaW1pbmF0ZWQuCglz
dHIJZnAsIFtzcCwgIy00XSEKCS5jZmlfZGVmX2NmYV9vZmZzZXQgNAoJLmNmaV9vZmZzZXQgMTEs
IC00CglhZGQJZnAsIHNwLCAjMAoJLmNmaV9kZWZfY2ZhX3JlZ2lzdGVyIDExCglzdWIJc3AsIHNw
LCAjMTIKCXN0cglyMCwgW2ZwLCAjLThdCgkubG9jIDEgMjEgMTAKCWIJLkwyCi5MMzoKCS5sb2Mg
MSAyMyAzNQoJbGRyCXIzLCBbZnAsICMtOF0KCWxkcmIJcjMsIFtyM10KCWFuZAlyMiwgcjMsICMy
NTUKCS5sb2MgMSAyMyA5CglsZHIJcjMsIC5MNAoJLmxvYyAxIDIzIDE4CglzdHIJcjIsIFtyM10K
CS5sb2MgMSAyNCAxMAoJbGRyCXIzLCBbZnAsICMtOF0KCWFkZAlyMywgcjMsICMxCglzdHIJcjMs
IFtmcCwgIy04XQouTDI6CgkubG9jIDEgMjEgMTEKCWxkcglyMywgW2ZwLCAjLThdCglsZHJiCXIz
LCBbcjNdCglhbmQJcjMsIHIzLCAjMjU1CgkubG9jIDEgMjEgMTAKCWNtcAlyMywgIzAKCWJuZQku
TDMKCS5sb2MgMSAyNiAxCglub3AKCW5vcAoJYWRkCXNwLCBmcCwgIzAKCS5jZmlfZGVmX2NmYV9y
ZWdpc3RlciAxMwoJQCBzcCBuZWVkZWQKCWxkcglmcCwgW3NwXSwgIzQKCS5jZmlfcmVzdG9yZSAx
MQoJLmNmaV9kZWZfY2ZhX29mZnNldCAwCglieAlscgouTDU6CgkuYWxpZ24JMgouTDQ6Cgkud29y
ZAkyNzA0NzExNjgKCS5jZmlfZW5kcHJvYwouTEZFMDoKCS5zaXplCXByaW50X3VhcnQwLCAuLXBy
aW50X3VhcnQwCgkuc2VjdGlvbgkucm9kYXRhCgkuYWxpZ24JMgouTEMwOgoJLmFzY2lpCSJoZWxs
bywgd29ybGRcMDAwIgoJLmFsaWduCTIKLkxDMToKCS5hc2NpaQkiaGVsbG8sIGRlc1wwMTJcMDAw
IgoJLmFsaWduCTIKLkxDMjoKCS5hc2NpaQkicGxhaW4gdGV4dCBpcyBcMDAwIgoJLmFsaWduCTIK
LkxDMzoKCS5hc2NpaQkiXDAxMlwwMDAiCgkuYWxpZ24JMgouTEM0OgoJLmFzY2lpCSJzdGFydCBn
ZW5lcmF0aW5nIGtleVwwMTJcMDAwIgoJLmFsaWduCTIKLkxDNToKCS5hc2NpaQkia2V5IGlzIFww
MDAiCgkuYWxpZ24JMgouTEM2OgoJLmFzY2lpCSJzdGFydCBlbmNyeXB0aW5nXDAxMlwwMDAiCgku
YWxpZ24JMgouTEM3OgoJLmFzY2lpCSJjaXBoZXIgdGV4dCBpcyBcMDAwIgoJLmFsaWduCTIKLkxD
ODoKCS5hc2NpaQkic3RhcnQgZGVjcnlwdGlvblwwMTJcMDAwIgoJLmFsaWduCTIKLkxDOToKCS5h
c2NpaQkiZGVjcnlwdGVkIHRleHQgaXMgXDAwMCIKCS50ZXh0CgkuYWxpZ24JMgoJLmdsb2JhbAlt
YWluCgkuc3ludGF4IHVuaWZpZWQKCS5hcm0KCS5mcHUgc29mdHZmcAoJLnR5cGUJbWFpbiwgJWZ1
bmN0aW9uCm1haW46Ci5MRkIxOgoJLmxvYyAxIDI5IDEKCS5jZmlfc3RhcnRwcm9jCglAIEZ1bmN0
aW9uIHN1cHBvcnRzIGludGVyd29ya2luZy4KCUAgYXJncyA9IDAsIHByZXRlbmQgPSAwLCBmcmFt
ZSA9IDI0MAoJQCBmcmFtZV9uZWVkZWQgPSAxLCB1c2VzX2Fub255bW91c19hcmdzID0gMAoJcHVz
aAl7ZnAsIGxyfQoJLmNmaV9kZWZfY2ZhX29mZnNldCA4CgkuY2ZpX29mZnNldCAxMSwgLTgKCS5j
Zmlfb2Zmc2V0IDE0LCAtNAoJYWRkCWZwLCBzcCwgIzQKCS5jZmlfZGVmX2NmYSAxMSwgNAoJc3Vi
CXNwLCBzcCwgIzI0MAoJLmxvYyAxIDMwIDI4CglsZHIJcjMsIC5MMTAKCXN0cglyMywgW2ZwLCAj
LThdCgkubG9jIDEgMzEgMjgKCWxkcglyMywgLkwxMCs0CglzdHIJcjMsIFtmcCwgIy0xMl0KCS5s
b2MgMSAzMiAyOAoJbGRyCXIzLCAuTDEwKzgKCXN0cglyMywgW2ZwLCAjLTE2XQoJLmxvYyAxIDMz
IDI4CglsZHIJcjMsIC5MMTArMTIKCXN0cglyMywgW2ZwLCAjLTIwXQoJLmxvYyAxIDM2IDIwCgls
ZHIJcjMsIC5MMTArMTYKCXN0cglyMywgW2ZwLCAjLTI0XQoJLmxvYyAxIDQxIDUKCWxkcglyMCwg
LkwxMCsyMAoJYmwJcHJpbnRfdWFydDAKCS5sb2MgMSA0MiA1CglsZHIJcjAsIC5MMTArMjQKCWJs
CXByaW50X3VhcnQwCgkubG9jIDEgNDMgNQoJbGRyCXIwLCBbZnAsICMtMjRdCglibAlwcmludF91
YXJ0MAoJLmxvYyAxIDQ0IDUKCWxkcglyMCwgLkwxMCsyOAoJYmwJcHJpbnRfdWFydDAKCS5sb2Mg
MSA0OCA1CglsZHIJcjAsIC5MMTArMzIKCWJsCXByaW50X3VhcnQwCgkubG9jIDEgNDkgMTkKCXN1
YglyMiwgZnAsICM0MAoJbGRyCXIzLCBbZnAsICMtOF0KCXN0cglyMiwgW3IzXQoJLmxvYyAxIDUw
IDE1CglsZHIJcjMsIFtmcCwgIy0yMF0KCW1vdglyMiwgIzIKCXN0cglyMiwgW3IzXQoJLmxvYyAx
IDUxIDEwCglub3AKLkw3OgoJLmxvYyAxIDUxIDExIGRpc2NyaW1pbmF0b3IgMQoJbGRyCXIzLCBb
ZnAsICMtMjBdCglsZHIJcjMsIFtyM10KCS5sb2MgMSA1MSAxMCBkaXNjcmltaW5hdG9yIDEKCWNt
cAlyMywgIzMKCWJuZQkuTDcKCS5sb2MgMSA1MiAyOQoJbGRyCXIzLCBbZnAsICMtOF0KCWxkcgly
MywgW3IzXQoJLmxvYyAxIDUyIDEwCglzdHIJcjMsIFtmcCwgIy0yOF0KCS5sb2MgMSA1MyA1Cgls
ZHIJcjAsIC5MMTArMzYKCWJsCXByaW50X3VhcnQwCgkubG9jIDEgNTQgNQoJbGRyCXIwLCBbZnAs
ICMtMjhdCglibAlwcmludF91YXJ0MAoJLmxvYyAxIDU1IDUKCWxkcglyMCwgLkwxMCsyOAoJYmwJ
cHJpbnRfdWFydDAKCS5sb2MgMSA1OCA1CglsZHIJcjAsIC5MMTArNDAKCWJsCXByaW50X3VhcnQw
CgkubG9jIDEgNTkgMTgKCWxkcglyMiwgW2ZwLCAjLTI0XQoJbGRyCXIzLCBbZnAsICMtMTJdCglz
dHIJcjIsIFtyM10KCS5sb2MgMSA2MCAxOQoJc3ViCXIyLCBmcCwgIzE0MAoJbGRyCXIzLCBbZnAs
ICMtMTZdCglzdHIJcjIsIFtyM10KCS5sb2MgMSA2MSAxNQoJbGRyCXIzLCBbZnAsICMtMjBdCglt
b3YJcjIsICMxCglzdHIJcjIsIFtyM10KCS5sb2MgMSA2MiAxMAoJbm9wCi5MODoKCS5sb2MgMSA2
MiAxMSBkaXNjcmltaW5hdG9yIDEKCWxkcglyMywgW2ZwLCAjLTIwXQoJbGRyCXIzLCBbcjNdCgku
bG9jIDEgNjIgMTAgZGlzY3JpbWluYXRvciAxCgljbXAJcjMsICMzCglibmUJLkw4CgkubG9jIDEg
NjMgMjkKCWxkcglyMywgW2ZwLCAjLTE2XQoJbGRyCXIzLCBbcjNdCgkubG9jIDEgNjMgMTAKCXN0
cglyMywgW2ZwLCAjLTI4XQoJLmxvYyAxIDY0IDUKCWxkcglyMCwgLkwxMCs0NAoJYmwJcHJpbnRf
dWFydDAKCS5sb2MgMSA2NSA1CglsZHIJcjAsIFtmcCwgIy0yOF0KCWJsCXByaW50X3VhcnQwCgku
bG9jIDEgNjYgNQoJbGRyCXIwLCAuTDEwKzI4CglibAlwcmludF91YXJ0MAoJLmxvYyAxIDY5IDUK
CWxkcglyMCwgLkwxMCs0OAoJYmwJcHJpbnRfdWFydDAKCS5sb2MgMSA3MCAxOAoJc3ViCXIyLCBm
cCwgIzE0MAoJbGRyCXIzLCBbZnAsICMtMTJdCglzdHIJcjIsIFtyM10KCS5sb2MgMSA3MSAxOQoJ
c3ViCXIyLCBmcCwgIzI0MAoJbGRyCXIzLCBbZnAsICMtMTZdCglzdHIJcjIsIFtyM10KCS5sb2Mg
MSA3MiAxNQoJbGRyCXIzLCBbZnAsICMtMjBdCgltb3YJcjIsICMwCglzdHIJcjIsIFtyM10KCS5s
b2MgMSA3MyAxMAoJbm9wCi5MOToKCS5sb2MgMSA3MyAxMSBkaXNjcmltaW5hdG9yIDEKCWxkcgly
MywgW2ZwLCAjLTIwXQoJbGRyCXIzLCBbcjNdCgkubG9jIDEgNzMgMTAgZGlzY3JpbWluYXRvciAx
CgljbXAJcjMsICMzCglibmUJLkw5CgkubG9jIDEgNzQgMjkKCWxkcglyMywgW2ZwLCAjLTE2XQoJ
bGRyCXIzLCBbcjNdCgkubG9jIDEgNzQgMTAKCXN0cglyMywgW2ZwLCAjLTI4XQoJLmxvYyAxIDc1
IDUKCWxkcglyMCwgLkwxMCs1MgoJYmwJcHJpbnRfdWFydDAKCS5sb2MgMSA3NiA1CglsZHIJcjAs
IFtmcCwgIy0yOF0KCWJsCXByaW50X3VhcnQwCgkubG9jIDEgNzcgNQoJbGRyCXIwLCAuTDEwKzI4
CglibAlwcmludF91YXJ0MAoJLmxvYyAxIDc4IDEKCW5vcAoJc3ViCXNwLCBmcCwgIzQKCS5jZmlf
ZGVmX2NmYSAxMywgOAoJQCBzcCBuZWVkZWQKCXBvcAl7ZnAsIGxyfQoJLmNmaV9yZXN0b3JlIDE0
CgkuY2ZpX3Jlc3RvcmUgMTEKCS5jZmlfZGVmX2NmYV9vZmZzZXQgMAoJYngJbHIKLkwxMToKCS5h
bGlnbgkyCi5MMTA6Cgkud29yZAkyNzA0ODc1NTIKCS53b3JkCTI3MDQ4NzU1NgoJLndvcmQJMjcw
NDg3NTYwCgkud29yZAkyNzA0ODc1NjQKCS53b3JkCS5MQzAKCS53b3JkCS5MQzEKCS53b3JkCS5M
QzIKCS53b3JkCS5MQzMKCS53b3JkCS5MQzQKCS53b3JkCS5MQzUKCS53b3JkCS5MQzYKCS53b3Jk
CS5MQzcKCS53b3JkCS5MQzgKCS53b3JkCS5MQzkKCS5jZmlfZW5kcHJvYwouTEZFMToKCS5zaXpl
CW1haW4sIC4tbWFpbgouTGV0ZXh0MDoKCS5zZWN0aW9uCS5kZWJ1Z19pbmZvLCIiLCVwcm9nYml0
cwouTGRlYnVnX2luZm8wOgoJLjRieXRlCTB4MTRlCgkuMmJ5dGUJMHg0CgkuNGJ5dGUJLkxkZWJ1
Z19hYmJyZXYwCgkuYnl0ZQkweDQKCS51bGViMTI4IDB4MQoJLjRieXRlCS5MQVNGMTEKCS5ieXRl
CTB4YwoJLjRieXRlCS5MQVNGMTIKCS40Ynl0ZQkuTEFTRjEzCgkuNGJ5dGUJLkx0ZXh0MAoJLjRi
eXRlCS5MZXRleHQwLS5MdGV4dDAKCS40Ynl0ZQkuTGRlYnVnX2xpbmUwCgkudWxlYjEyOCAweDIK
CS40Ynl0ZQkuTEFTRjE0CgkuYnl0ZQkweDEKCS5ieXRlCTB4MTEKCS5ieXRlCTB4MWYKCS40Ynl0
ZQkweDNkCgkudWxlYjEyOCAweDUKCS5ieXRlCTB4MwoJLjRieXRlCVVBUlQwRFIKCS51bGViMTI4
IDB4MwoJLmJ5dGUJMHg0CgkuNGJ5dGUJMHg0OQoJLnVsZWIxMjggMHg0CgkuNGJ5dGUJMHgzNwoJ
LnVsZWIxMjggMHg1CgkuYnl0ZQkweDQKCS5ieXRlCTB4NwoJLjRieXRlCS5MQVNGOAoJLnVsZWIx
MjggMHg2CgkuNGJ5dGUJMHg0MgoJLnVsZWIxMjggMHg3CgkuNGJ5dGUJLkxBU0YxNQoJLmJ5dGUJ
MHgxCgkuYnl0ZQkweDFjCgkuYnl0ZQkweDYKCS40Ynl0ZQkuTEZCMQoJLjRieXRlCS5MRkUxLS5M
RkIxCgkudWxlYjEyOCAweDEKCS5ieXRlCTB4OWMKCS40Ynl0ZQkweGVlCgkudWxlYjEyOCAweDgK
CS40Ynl0ZQkuTEFTRjAKCS5ieXRlCTB4MQoJLmJ5dGUJMHgxZQoJLmJ5dGUJMHgxYwoJLjRieXRl
CTB4MzcKCS51bGViMTI4IDB4MgoJLmJ5dGUJMHg5MQoJLnNsZWIxMjggLTEyCgkudWxlYjEyOCAw
eDgKCS40Ynl0ZQkuTEFTRjEKCS5ieXRlCTB4MQoJLmJ5dGUJMHgxZgoJLmJ5dGUJMHgxYwoJLjRi
eXRlCTB4MzcKCS51bGViMTI4IDB4MgoJLmJ5dGUJMHg5MQoJLnNsZWIxMjggLTE2CgkudWxlYjEy
OCAweDgKCS40Ynl0ZQkuTEFTRjIKCS5ieXRlCTB4MQoJLmJ5dGUJMHgyMAoJLmJ5dGUJMHgxYwoJ
LjRieXRlCTB4MzcKCS51bGViMTI4IDB4MgoJLmJ5dGUJMHg5MQoJLnNsZWIxMjggLTIwCgkudWxl
YjEyOCAweDgKCS40Ynl0ZQkuTEFTRjMKCS5ieXRlCTB4MQoJLmJ5dGUJMHgyMQoJLmJ5dGUJMHgx
YwoJLjRieXRlCTB4MzcKCS51bGViMTI4IDB4MgoJLmJ5dGUJMHg5MQoJLnNsZWIxMjggLTI0Cgku
dWxlYjEyOCAweDkKCS5hc2NpaQkia2V5XDAwMCIKCS5ieXRlCTB4MQoJLmJ5dGUJMHgyMwoJLmJ5
dGUJMHgxMwoJLjRieXRlCTB4ZWUKCS51bGViMTI4IDB4MgoJLmJ5dGUJMHg5MQoJLnNsZWIxMjgg
LTQ0CgkudWxlYjEyOCAweDgKCS40Ynl0ZQkuTEFTRjQKCS5ieXRlCTB4MQoJLmJ5dGUJMHgyNAoJ
LmJ5dGUJMHgxNAoJLjRieXRlCTB4MTA1CgkudWxlYjEyOCAweDIKCS5ieXRlCTB4OTEKCS5zbGVi
MTI4IC0yOAoJLnVsZWIxMjggMHg4CgkuNGJ5dGUJLkxBU0Y1CgkuYnl0ZQkweDEKCS5ieXRlCTB4
MjUKCS5ieXRlCTB4MTMKCS40Ynl0ZQkweDEwYgoJLnVsZWIxMjggMHgzCgkuYnl0ZQkweDkxCgku
c2xlYjEyOCAtMTQ0CgkudWxlYjEyOCAweDgKCS40Ynl0ZQkuTEFTRjYKCS5ieXRlCTB4MQoJLmJ5
dGUJMHgyNgoJLmJ5dGUJMHgxMwoJLjRieXRlCTB4MTBiCgkudWxlYjEyOCAweDMKCS5ieXRlCTB4
OTEKCS5zbGViMTI4IC0yNDQKCS51bGViMTI4IDB4OAoJLjRieXRlCS5MQVNGNwoJLmJ5dGUJMHgx
CgkuYnl0ZQkweDI3CgkuYnl0ZQkweDE0CgkuNGJ5dGUJMHgxMDUKCS51bGViMTI4IDB4MgoJLmJ5
dGUJMHg5MQoJLnNsZWIxMjggLTMyCgkuYnl0ZQkwCgkudWxlYjEyOCAweGEKCS40Ynl0ZQkweGZl
CgkuNGJ5dGUJMHhmZQoJLnVsZWIxMjggMHhiCgkuNGJ5dGUJMHg0MgoJLmJ5dGUJMHg4CgkuYnl0
ZQkwCgkudWxlYjEyOCAweDUKCS5ieXRlCTB4MQoJLmJ5dGUJMHg4CgkuNGJ5dGUJLkxBU0Y5Cgku
dWxlYjEyOCAweDMKCS5ieXRlCTB4NAoJLjRieXRlCTB4ZmUKCS51bGViMTI4IDB4YQoJLjRieXRl
CTB4ZmUKCS40Ynl0ZQkweDExYgoJLnVsZWIxMjggMHhiCgkuNGJ5dGUJMHg0MgoJLmJ5dGUJMHg2
MwoJLmJ5dGUJMAoJLnVsZWIxMjggMHhjCgkuNGJ5dGUJLkxBU0YxNgoJLmJ5dGUJMHgxCgkuYnl0
ZQkweDEzCgkuYnl0ZQkweDYKCS40Ynl0ZQkuTEZCMAoJLjRieXRlCS5MRkUwLS5MRkIwCgkudWxl
YjEyOCAweDEKCS5ieXRlCTB4OWMKCS40Ynl0ZQkweDEzZgoJLnVsZWIxMjggMHhkCgkuYXNjaWkJ
InNcMDAwIgoJLmJ5dGUJMHgxCgkuYnl0ZQkweDEzCgkuYnl0ZQkweDIxCgkuNGJ5dGUJMHgxM2YK
CS51bGViMTI4IDB4MgoJLmJ5dGUJMHg5MQoJLnNsZWIxMjggLTEyCgkuYnl0ZQkwCgkudWxlYjEy
OCAweDMKCS5ieXRlCTB4NAoJLjRieXRlCTB4MTRjCgkudWxlYjEyOCAweDUKCS5ieXRlCTB4MQoJ
LmJ5dGUJMHg4CgkuNGJ5dGUJLkxBU0YxMAoJLnVsZWIxMjggMHg2CgkuNGJ5dGUJMHgxNDUKCS5i
eXRlCTAKCS5zZWN0aW9uCS5kZWJ1Z19hYmJyZXYsIiIsJXByb2diaXRzCi5MZGVidWdfYWJicmV2
MDoKCS51bGViMTI4IDB4MQoJLnVsZWIxMjggMHgxMQoJLmJ5dGUJMHgxCgkudWxlYjEyOCAweDI1
CgkudWxlYjEyOCAweGUKCS51bGViMTI4IDB4MTMKCS51bGViMTI4IDB4YgoJLnVsZWIxMjggMHgz
CgkudWxlYjEyOCAweGUKCS51bGViMTI4IDB4MWIKCS51bGViMTI4IDB4ZQoJLnVsZWIxMjggMHgx
MQoJLnVsZWIxMjggMHgxCgkudWxlYjEyOCAweDEyCgkudWxlYjEyOCAweDYKCS51bGViMTI4IDB4
MTAKCS51bGViMTI4IDB4MTcKCS5ieXRlCTAKCS5ieXRlCTAKCS51bGViMTI4IDB4MgoJLnVsZWIx
MjggMHgzNAoJLmJ5dGUJMAoJLnVsZWIxMjggMHgzCgkudWxlYjEyOCAweGUKCS51bGViMTI4IDB4
M2EKCS51bGViMTI4IDB4YgoJLnVsZWIxMjggMHgzYgoJLnVsZWIxMjggMHhiCgkudWxlYjEyOCAw
eDM5CgkudWxlYjEyOCAweGIKCS51bGViMTI4IDB4NDkKCS51bGViMTI4IDB4MTMKCS51bGViMTI4
IDB4M2YKCS51bGViMTI4IDB4MTkKCS51bGViMTI4IDB4MgoJLnVsZWIxMjggMHgxOAoJLmJ5dGUJ
MAoJLmJ5dGUJMAoJLnVsZWIxMjggMHgzCgkudWxlYjEyOCAweGYKCS5ieXRlCTAKCS51bGViMTI4
IDB4YgoJLnVsZWIxMjggMHhiCgkudWxlYjEyOCAweDQ5CgkudWxlYjEyOCAweDEzCgkuYnl0ZQkw
CgkuYnl0ZQkwCgkudWxlYjEyOCAweDQKCS51bGViMTI4IDB4MjYKCS5ieXRlCTAKCS51bGViMTI4
IDB4NDkKCS51bGViMTI4IDB4MTMKCS5ieXRlCTAKCS5ieXRlCTAKCS51bGViMTI4IDB4NQoJLnVs
ZWIxMjggMHgyNAoJLmJ5dGUJMAoJLnVsZWIxMjggMHhiCgkudWxlYjEyOCAweGIKCS51bGViMTI4
IDB4M2UKCS51bGViMTI4IDB4YgoJLnVsZWIxMjggMHgzCgkudWxlYjEyOCAweGUKCS5ieXRlCTAK
CS5ieXRlCTAKCS51bGViMTI4IDB4NgoJLnVsZWIxMjggMHgzNQoJLmJ5dGUJMAoJLnVsZWIxMjgg
MHg0OQoJLnVsZWIxMjggMHgxMwoJLmJ5dGUJMAoJLmJ5dGUJMAoJLnVsZWIxMjggMHg3CgkudWxl
YjEyOCAweDJlCgkuYnl0ZQkweDEKCS51bGViMTI4IDB4M2YKCS51bGViMTI4IDB4MTkKCS51bGVi
MTI4IDB4MwoJLnVsZWIxMjggMHhlCgkudWxlYjEyOCAweDNhCgkudWxlYjEyOCAweGIKCS51bGVi
MTI4IDB4M2IKCS51bGViMTI4IDB4YgoJLnVsZWIxMjggMHgzOQoJLnVsZWIxMjggMHhiCgkudWxl
YjEyOCAweDExCgkudWxlYjEyOCAweDEKCS51bGViMTI4IDB4MTIKCS51bGViMTI4IDB4NgoJLnVs
ZWIxMjggMHg0MAoJLnVsZWIxMjggMHgxOAoJLnVsZWIxMjggMHgyMTE2CgkudWxlYjEyOCAweDE5
CgkudWxlYjEyOCAweDEKCS51bGViMTI4IDB4MTMKCS5ieXRlCTAKCS5ieXRlCTAKCS51bGViMTI4
IDB4OAoJLnVsZWIxMjggMHgzNAoJLmJ5dGUJMAoJLnVsZWIxMjggMHgzCgkudWxlYjEyOCAweGUK
CS51bGViMTI4IDB4M2EKCS51bGViMTI4IDB4YgoJLnVsZWIxMjggMHgzYgoJLnVsZWIxMjggMHhi
CgkudWxlYjEyOCAweDM5CgkudWxlYjEyOCAweGIKCS51bGViMTI4IDB4NDkKCS51bGViMTI4IDB4
MTMKCS51bGViMTI4IDB4MgoJLnVsZWIxMjggMHgxOAoJLmJ5dGUJMAoJLmJ5dGUJMAoJLnVsZWIx
MjggMHg5CgkudWxlYjEyOCAweDM0CgkuYnl0ZQkwCgkudWxlYjEyOCAweDMKCS51bGViMTI4IDB4
OAoJLnVsZWIxMjggMHgzYQoJLnVsZWIxMjggMHhiCgkudWxlYjEyOCAweDNiCgkudWxlYjEyOCAw
eGIKCS51bGViMTI4IDB4MzkKCS51bGViMTI4IDB4YgoJLnVsZWIxMjggMHg0OQoJLnVsZWIxMjgg
MHgxMwoJLnVsZWIxMjggMHgyCgkudWxlYjEyOCAweDE4CgkuYnl0ZQkwCgkuYnl0ZQkwCgkudWxl
YjEyOCAweGEKCS51bGViMTI4IDB4MQoJLmJ5dGUJMHgxCgkudWxlYjEyOCAweDQ5CgkudWxlYjEy
OCAweDEzCgkudWxlYjEyOCAweDEKCS51bGViMTI4IDB4MTMKCS5ieXRlCTAKCS5ieXRlCTAKCS51
bGViMTI4IDB4YgoJLnVsZWIxMjggMHgyMQoJLmJ5dGUJMAoJLnVsZWIxMjggMHg0OQoJLnVsZWIx
MjggMHgxMwoJLnVsZWIxMjggMHgyZgoJLnVsZWIxMjggMHhiCgkuYnl0ZQkwCgkuYnl0ZQkwCgku
dWxlYjEyOCAweGMKCS51bGViMTI4IDB4MmUKCS5ieXRlCTB4MQoJLnVsZWIxMjggMHgzZgoJLnVs
ZWIxMjggMHgxOQoJLnVsZWIxMjggMHgzCgkudWxlYjEyOCAweGUKCS51bGViMTI4IDB4M2EKCS51
bGViMTI4IDB4YgoJLnVsZWIxMjggMHgzYgoJLnVsZWIxMjggMHhiCgkudWxlYjEyOCAweDM5Cgku
dWxlYjEyOCAweGIKCS51bGViMTI4IDB4MjcKCS51bGViMTI4IDB4MTkKCS51bGViMTI4IDB4MTEK
CS51bGViMTI4IDB4MQoJLnVsZWIxMjggMHgxMgoJLnVsZWIxMjggMHg2CgkudWxlYjEyOCAweDQw
CgkudWxlYjEyOCAweDE4CgkudWxlYjEyOCAweDIxMTcKCS51bGViMTI4IDB4MTkKCS51bGViMTI4
IDB4MQoJLnVsZWIxMjggMHgxMwoJLmJ5dGUJMAoJLmJ5dGUJMAoJLnVsZWIxMjggMHhkCgkudWxl
YjEyOCAweDUKCS5ieXRlCTAKCS51bGViMTI4IDB4MwoJLnVsZWIxMjggMHg4CgkudWxlYjEyOCAw
eDNhCgkudWxlYjEyOCAweGIKCS51bGViMTI4IDB4M2IKCS51bGViMTI4IDB4YgoJLnVsZWIxMjgg
MHgzOQoJLnVsZWIxMjggMHhiCgkudWxlYjEyOCAweDQ5CgkudWxlYjEyOCAweDEzCgkudWxlYjEy
OCAweDIKCS51bGViMTI4IDB4MTgKCS5ieXRlCTAKCS5ieXRlCTAKCS5ieXRlCTAKCS5zZWN0aW9u
CS5kZWJ1Z19hcmFuZ2VzLCIiLCVwcm9nYml0cwoJLjRieXRlCTB4MWMKCS4yYnl0ZQkweDIKCS40
Ynl0ZQkuTGRlYnVnX2luZm8wCgkuYnl0ZQkweDQKCS5ieXRlCTAKCS4yYnl0ZQkwCgkuMmJ5dGUJ
MAoJLjRieXRlCS5MdGV4dDAKCS40Ynl0ZQkuTGV0ZXh0MC0uTHRleHQwCgkuNGJ5dGUJMAoJLjRi
eXRlCTAKCS5zZWN0aW9uCS5kZWJ1Z19saW5lLCIiLCVwcm9nYml0cwouTGRlYnVnX2xpbmUwOgoJ
LnNlY3Rpb24JLmRlYnVnX3N0ciwiTVMiLCVwcm9nYml0cywxCi5MQVNGMzoKCS5hc2NpaQkicmVn
X21vZGVcMDAwIgouTEFTRjg6CgkuYXNjaWkJInVuc2lnbmVkIGludFwwMDAiCi5MQVNGMjoKCS5h
c2NpaQkicmVnX291dF9hZGRyXDAwMCIKLkxBU0YxMzoKCS5hc2NpaQkiL2xob21lL3ByaXlhbXZh
ZC9kZWJpYW5fcWVtdV9hcm0zMi9jX2FwcGxpY2F0aW9uL0RFIgoJLmFzY2lpCSJTXDAwMCIKLkxB
U0YxOgoJLmFzY2lpCSJyZWdfaW5fYWRkclwwMDAiCi5MQVNGOToKCS5hc2NpaQkidW5zaWduZWQg
Y2hhclwwMDAiCi5MQVNGNzoKCS5hc2NpaQkicHN0clwwMDAiCi5MQVNGMTU6CgkuYXNjaWkJIm1h
aW5cMDAwIgouTEFTRjQ6CgkuYXNjaWkJInBsYWluXDAwMCIKLkxBU0YwOgoJLmFzY2lpCSJyZWdf
a2V5X2FkZHJcMDAwIgouTEFTRjExOgoJLmFzY2lpCSJHTlUgQzE3IDkuMi4xIDIwMTkxMDI1IChy
ZWxlYXNlKSBbQVJNL2FybS05LWJyYW5jaCAiCgkuYXNjaWkJInJldmlzaW9uIDI3NzU5OV0gLW1j
cHU9YXJtN3RkbWkgLW1mbG9hdC1hYmk9c29mdCAtbSIKCS5hc2NpaQkiYXJtIC1tYXJjaD1hcm12
NHQgLWdcMDAwIgouTEFTRjY6CgkuYXNjaWkJImRlY3J5cHRlZFwwMDAiCi5MQVNGMTI6CgkuYXNj
aWkJImRlc19kZW1vLmNcMDAwIgouTEFTRjEwOgoJLmFzY2lpCSJjaGFyXDAwMCIKLkxBU0YxNDoK
CS5hc2NpaQkiVUFSVDBEUlwwMDAiCi5MQVNGNToKCS5hc2NpaQkiY2lwaGVyXDAwMCIKLkxBU0Yx
NjoKCS5hc2NpaQkicHJpbnRfdWFydDBcMDAwIgoJLmlkZW50CSJHQ0M6IChHTlUgVG9vbHMgZm9y
IEFybSBFbWJlZGRlZCBQcm9jZXNzb3JzIDktMjAxOS1xNC1tYWpvcikgOS4yLjEgMjAxOTEwMjUg
KHJlbGVhc2UpIFtBUk0vYXJtLTktYnJhbmNoIHJldmlzaW9uIDI3NzU5OV0iCg==
--0000000000000d9da205a135d312
Content-Type: application/octet-stream; name=Makefile
Content-Disposition: attachment; filename=Makefile
Content-Transfer-Encoding: base64
Content-ID: <f_k7ytw1384>
X-Attachment-Id: f_k7ytw1384

I1BSRUZJWD1wb3dlcnBjLWVsZgpQUkVGSVg9YXJtLW5vbmUtZWFiaQoKI1BSRUZJWD1hcm0tbm9u
ZS1saW51eC1nbnVlYWJpCgojZXhwb3J0IExEX0xJQlJBUllfUEFUSD0vaG9tZS9zdW5taW5nemUv
cHBjL3BwY190b29sY2hhaW4vbGliCiNleHBvcnQgTERfTElCUkFSWV9QQVRIPS9ob21lL3N1bm1p
bmd6ZS9wcGMvcHBjX3Rvb2xjaGFpbl9saW51eC9saWIKCkNDPSQoUFJFRklYKS1nY2MKQVM9JChQ
UkVGSVgpLWFzCkxEPSQoUFJFRklYKS1sZApPQkpDT1BZPSQoUFJFRklYKS1vYmpjb3B5CgpPUFQ9
LW5vc3RkbGliCgpMRF9TQ1JJUFQ9dGVzdC5sZAoKb2JqID0gc3RhcnR1cC5vIHRlc3QubwoKdGVz
dDokKG9iaikKCSQoTEQpIC1UICQoTERfU0NSSVBUKSAkKG9iaikgLW8gZGVzX2RlbW8uZWxmCgkk
KE9CSkNPUFkpIC1PIGJpbmFyeSBkZXNfZGVtby5lbGYgZGVzX2RlbW8uYmluCgpzdGFydHVwLm86
c3RhcnR1cC5TCgkkKEFTKSAtZyBzdGFydHVwLlMgLW8gc3RhcnR1cC5vIC1tY3B1PWFybTkyNmVq
LXMKCnRlc3Qubzp0ZXN0LnMKCSQoQVMpIC1nIHRlc3QucyAtbyB0ZXN0Lm8gLW1jcHU9YXJtOTI2
ZWotcwp0ZXN0LnM6ZGVzX2RlbW8uYwoJJChDQykgLVMgLXN0YXRpYyAtbm9zdGRsaWIgLWcgZGVz
X2RlbW8uYyAtbyB0ZXN0LnMKCmNsZWFuOgoJcm0gLWYgKi5vICouZWxmICouYmluICoucwkK
--0000000000000d9da205a135d312
Content-Type: application/octet-stream; name="startup.S"
Content-Disposition: attachment; filename="startup.S"
Content-Transfer-Encoding: base64
Content-ID: <f_k7ytw1363>
X-Attachment-Id: f_k7ytw1363

Lmdsb2JhbCBfUmVzZXQKX1Jlc2V0OgoKIEJMIG1haW4KLkw0OgogO2IgLkw0Cgo=
--0000000000000d9da205a135d312
Content-Type: application/octet-stream; name="test.ld"
Content-Disposition: attachment; filename="test.ld"
Content-Transfer-Encoding: base64
Content-ID: <f_k7ytw1342>
X-Attachment-Id: f_k7ytw1342

RU5UUlkoX1Jlc2V0KQpTRUNUSU9OUwp7CiAuID0gMHgwMDA7CiAuc3RhcnR1cCAuIDogeyBzdGFy
dHVwLm8oLnRleHQpIH0KIC50ZXh0IDogeyAqKC50ZXh0KSB9CiAuZGF0YSA6IHsgKiguZGF0YSkg
fQogLmJzcyA6IHsgKiguYnNzKSB9CiAuID0gLiArIDB4MTAwMDsgLyogNGtCIG9mIHN0YWNrIG1l
bW9yeSAqLwogc3RhY2tfdG9wID0gLjsKfQo=
--0000000000000d9da205a135d312
Content-Type: text/x-csrc; charset="US-ASCII"; name="des_demo.c"
Content-Disposition: attachment; filename="des_demo.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k7ytw13a5>
X-Attachment-Id: f_k7ytw13a5

LyoKICogVGhpcyBpcyBhIGRlbW8gcHJvZ3JhbSB0byB2ZXJpZnkgdGhlIGZ1bmN0aW9uIG9mIERF
UyBkZXZpY2UKICovIAoKI2RlZmluZSBVQVJUMF9CQVNFQUREUiAgMHgxMDFmMTAwMAojZGVmaW5l
IERFU19CQVNFQUREUiAweDEwMWY1MDAwCiNkZWZpbmUgRU5DUllQVElPTl9NT0RFIDEKI2RlZmlu
ZSBERUNSWVBUSU9OX01PREUgMAojZGVmaW5lIEdFTkVSQVRFS0VZX01PREUgMgojZGVmaW5lIERP
TkVfTU9ERSAzCiNkZWZpbmUgUkVHX0tFWV9BRERSX09GRlNFVCAweDAwMDAKI2RlZmluZSBSRUdf
SU5fQUREUl9PRkZTRVQgMHgwMDA0CiNkZWZpbmUgUkVHX09VVF9BRERSX09GRlNFVCAweDAwMDgK
I2RlZmluZSBSRUdfTU9ERV9PRkZTRVQgMHgwMDBDCiNkZWZpbmUgT1VUX1NJWkVfTUFYIDEwMAoK
dm9sYXRpbGUgdW5zaWduZWQgaW50ICogY29uc3QgVUFSVDBEUiA9ICh1bnNpZ25lZCBpbnQgKikg
VUFSVDBfQkFTRUFERFI7Cgp2b2lkIHByaW50X3VhcnQwKHZvbGF0aWxlIGNoYXIgKnMpCnsKICAg
IHdoaWxlKCpzICE9ICdcMCcpIAogICAgewogICAgICAgICpVQVJUMERSID0gKHVuc2lnbmVkIGlu
dCkoKnMpOwogICAgICAgIHMrKzsKICAgIH0KfQoKdm9pZCBtYWluKCkKewogICAgdm9sYXRpbGUg
dW5zaWduZWQgaW50KiByZWdfa2V5X2FkZHIgPSAodm9sYXRpbGUgdW5zaWduZWQgaW50KikoREVT
X0JBU0VBRERSICsgUkVHX0tFWV9BRERSX09GRlNFVCk7CiAgICB2b2xhdGlsZSB1bnNpZ25lZCBp
bnQqIHJlZ19pbl9hZGRyID0gKHZvbGF0aWxlIHVuc2lnbmVkIGludCopKERFU19CQVNFQUREUiAr
IFJFR19JTl9BRERSX09GRlNFVCk7CiAgICB2b2xhdGlsZSB1bnNpZ25lZCBpbnQqIHJlZ19vdXRf
YWRkciA9ICh2b2xhdGlsZSB1bnNpZ25lZCBpbnQqKShERVNfQkFTRUFERFIgKyBSRUdfT1VUX0FE
RFJfT0ZGU0VUKTsKICAgIHZvbGF0aWxlIHVuc2lnbmVkIGludCogcmVnX21vZGUgPSAodm9sYXRp
bGUgdW5zaWduZWQgaW50KikoREVTX0JBU0VBRERSICsgUkVHX01PREVfT0ZGU0VUKTsKICAgIAog
ICAgdW5zaWduZWQgY2hhciBrZXlbOV07CiAgICB1bnNpZ25lZCBjaGFyKiBwbGFpbiA9ICJoZWxs
bywgd29ybGQiOwogICAgdW5zaWduZWQgY2hhciBjaXBoZXJbT1VUX1NJWkVfTUFYXTsKICAgIHVu
c2lnbmVkIGNoYXIgZGVjcnlwdGVkW09VVF9TSVpFX01BWF07CiAgICB1bnNpZ25lZCBjaGFyKiBw
c3RyOwoKICAgIHByaW50X3VhcnQwKCJoZWxsbywgZGVzXG4iKTsKICAgIHByaW50X3VhcnQwKCJw
bGFpbiB0ZXh0IGlzICIpOwogICAgcHJpbnRfdWFydDAocGxhaW4pOwogICAgcHJpbnRfdWFydDAo
IlxuIik7CgoKICAgIC8qR2VuZXJhdGUga2V5Ki8KICAgIHByaW50X3VhcnQwKCJzdGFydCBnZW5l
cmF0aW5nIGtleVxuIik7CiAgICAqcmVnX2tleV9hZGRyID0ga2V5OwogICAgKnJlZ19tb2RlID0g
R0VORVJBVEVLRVlfTU9ERTsKICAgIHdoaWxlKCpyZWdfbW9kZSAhPSBET05FX01PREUgKSB7fQog
ICAgcHN0ciA9ICh1bnNpZ25lZCBjaGFyKikoKnJlZ19rZXlfYWRkcik7CiAgICBwcmludF91YXJ0
MCgia2V5IGlzICIpOwogICAgcHJpbnRfdWFydDAocHN0cik7CiAgICBwcmludF91YXJ0MCgiXG4i
KTsKCiAgICAvKkVuY3J5cHRpb24qLwogICAgcHJpbnRfdWFydDAoInN0YXJ0IGVuY3J5cHRpbmdc
biIpOwogICAgKnJlZ19pbl9hZGRyID0gcGxhaW47CiAgICAqcmVnX291dF9hZGRyID0gY2lwaGVy
OwogICAgKnJlZ19tb2RlID0gRU5DUllQVElPTl9NT0RFOwogICAgd2hpbGUoKnJlZ19tb2RlICE9
IERPTkVfTU9ERSkge30KICAgIHBzdHIgPSAodW5zaWduZWQgY2hhciopKCpyZWdfb3V0X2FkZHIp
OwogICAgcHJpbnRfdWFydDAoImNpcGhlciB0ZXh0IGlzICIpOwogICAgcHJpbnRfdWFydDAocHN0
cik7CiAgICBwcmludF91YXJ0MCgiXG4iKTsKICAgIAogICAgLypEZWNyeXB0aW9uKi8KICAgIHBy
aW50X3VhcnQwKCJzdGFydCBkZWNyeXB0aW9uXG4iKTsKICAgICpyZWdfaW5fYWRkciA9IGNpcGhl
cjsKICAgICpyZWdfb3V0X2FkZHIgPSBkZWNyeXB0ZWQ7CiAgICAqcmVnX21vZGUgPSBERUNSWVBU
SU9OX01PREU7CiAgICB3aGlsZSgqcmVnX21vZGUgIT0gRE9ORV9NT0RFKSB7fQogICAgcHN0ciA9
ICh1bnNpZ25lZCBjaGFyKikoKnJlZ19vdXRfYWRkcik7CiAgICBwcmludF91YXJ0MCgiZGVjcnlw
dGVkIHRleHQgaXMgIik7CiAgICBwcmludF91YXJ0MChwc3RyKTsKICAgIHByaW50X3VhcnQwKCJc
biIpOwp9Cg==
--0000000000000d9da205a135d312--

