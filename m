Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CAC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137B72073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcRkH0fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137B72073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j96w8-00013m-8u
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 07:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j96vL-0000Rs-Ca
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j96vJ-0003wL-JI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:45:23 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:40903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1j96vJ-0003vh-5R
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:45:21 -0500
Received: by mail-lf1-x143.google.com with SMTP id p5so2610670lfc.7
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 04:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EWZMZUn4u7MXn/RjQmM8fUvsuLdlPL7FWFi77YgUC6Q=;
 b=GcRkH0fz8Chsp7+Nrg4E5TuCqvMoR7n99nYpisgFGyQU+VAfMCiyDWaj6biNWzr4e1
 VrFWA/JrL/Le5qA4H6oi7N4pgX0oCVf177+RwM59xgB49hpnqtTkUMEGmLndVbHsxpEk
 1JTdrLzTalOs5g0tuvnXg0MtRaU151R7ix+8HA6oVrjOmwv43ZUCBQR1mO39z2beTMQ4
 TwljL7YCJEUHBm529ZfvjvL0m3eRHVcIAAi4782TAMff44T99hx+FrJ5GYxjrSpb82bD
 5KsqeoM1SgBGmw4aSl0dRoG0lM7bIepHLKZlyoIaER3hI51XHVxAMvUBQZpbgMpjc+GE
 pCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EWZMZUn4u7MXn/RjQmM8fUvsuLdlPL7FWFi77YgUC6Q=;
 b=qXBGS3P9faRwFdDPxE14Pm/+sStNjSmyXWcubDQLFXLL2Cdoe/+8Y+4C0v0QbS+Jct
 nR5zJhz80Df2NviZQlaTgMHyQvD4eVJMijKV/rUdYKja/pGmCvN7yr3WvNXqY1gNoFSM
 AXZmrncJDkcAJDqDne2CRkoeIj+iSD9h3jnchigCRzCfDKllrTsIdQ5zfClbQATX0VDQ
 W4BW/GnstoKFY4LHMZfjJ6OS4Nyr+x6Sr4BDz+pLhsJFUsXvBiDYq0Z4jUPsx6wt9Pzo
 B10joAzrOeQeerJf5Av9JF2I7/mtyUPmpinr6spe79XTbNbyoryeqEpdzWwvJfJDsAUG
 ZOgA==
X-Gm-Message-State: ANhLgQ2vFgCQ5h6Epzx1cK4aKzGQjS4975Fan/nItPBRWMRgiNGSXdVZ
 JFB5CIuAFPeO9FK2x0svmNd088kR0jIvLpJ1GaU=
X-Google-Smtp-Source: ADFU+vvob4xzgZG4D7jGSitXhIW7v439wp9JrAYaI8oeJywVdtYi9fHgCEYlS+oAKewHL6iNsreOM4ezfWj94dzpUJk=
X-Received: by 2002:ac2:4c82:: with SMTP id d2mr2790085lfl.78.1583239519312;
 Tue, 03 Mar 2020 04:45:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
In-Reply-To: <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Tue, 3 Mar 2020 18:15:07 +0530
Message-ID: <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000024b235059ff2ad51"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000024b235059ff2ad51
Content-Type: multipart/alternative; boundary="00000000000024b233059ff2ad4f"

--00000000000024b233059ff2ad4f
Content-Type: text/plain; charset="UTF-8"

Thanks Stefan for explaining the method.
After following above method when I run below command to compile my custom
device in Qemu source code , I get the output on terminal which is attached
in a file for your reference.

Command:- make -j8 -C build

Most of the lines in attached file indicate that error might be due to
helper.c file.

How to resolve it?

My qemu version:4.2.50


Thanks,
Priyamvad Acharya

On Tue, 3 Mar 2020 at 16:16, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Mar 3, 2020 at 7:45 AM Priyamvad Acharya
> <priyamvad.agnisys@gmail.com> wrote:
>
> Please use Reply-All when replying to mailing list emails so that
> qemu-devel@nongnu.org is included in the CC list.  That way the
> discussion stays on the mailing list.
>
> > Hi,
> > I have written code to emulate a custom PCI device.
> > Now I want to run custom device with Qemu, so that user application can
> perform read/write operation with custom PCI device.
> > So what is the method to do it?
>
> 1. Add the source file somewhere below hw/.
> 2. Add a make rule to build the object file in Makefile.objs in the
> same directory as the source file.
> 3. Compile QEMU and run with -device testpci.
>
> > I am new to emulating a custom device model in Qemu, so request you to
> explain me in that way.
>
> Reading the source code is necessary to understand how things work.
> You can find many examples of devices in the hw/ directory.  Using
> git-log(1) can be helpful because it shows how new devices were
> introduced.
>
> Stefan
>

--00000000000024b233059ff2ad4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Stefan for explaining the method.</div><div>Af=
ter following above method when I run below command to compile my custom de=
vice in Qemu source code , I get the output on terminal which is attached i=
n a file for your reference.</div><div><br></div><div>Command:- make -j8 -C=
 build</div><div><br></div><div>Most of the lines in attached file indicate=
 that error might be due to helper.c file.</div><div><br></div><div>How to =
resolve it?</div><div><br></div><div>My qemu version:4.2.50<br></div><div><=
br></div><div><br></div><div>Thanks,</div><div>Priyamvad Acharya<br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, 3 Mar 2020 at 16:16, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@=
gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Tue, Mar 3, 2020 at 7:45 AM Priyamvad Achar=
ya<br>
&lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=3D"_blank">priyam=
vad.agnisys@gmail.com</a>&gt; wrote:<br>
<br>
Please use Reply-All when replying to mailing list emails so that<br>
<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongn=
u.org</a> is included in the CC list.=C2=A0 That way the<br>
discussion stays on the mailing list.<br>
<br>
&gt; Hi,<br>
&gt; I have written code to emulate a custom PCI device.<br>
&gt; Now I want to run custom device with Qemu, so that user application ca=
n perform read/write operation with custom PCI device.<br>
&gt; So what is the method to do it?<br>
<br>
1. Add the source file somewhere below hw/.<br>
2. Add a make rule to build the object file in Makefile.objs in the<br>
same directory as the source file.<br>
3. Compile QEMU and run with -device testpci.<br>
<br>
&gt; I am new to emulating a custom device model in Qemu, so request you to=
 explain me in that way.<br>
<br>
Reading the source code is necessary to understand how things work.<br>
You can find many examples of devices in the hw/ directory.=C2=A0 Using<br>
git-log(1) can be helpful because it shows how new devices were<br>
introduced.<br>
<br>
Stefan<br>
</blockquote></div>

--00000000000024b233059ff2ad4f--

--00000000000024b235059ff2ad51
Content-Type: text/plain; charset="US-ASCII"; name="qemu_arm_build_hello_err1.txt"
Content-Disposition: attachment; filename="qemu_arm_build_hello_err1.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k7bvq3tc0>
X-Attachment-Id: f_k7bvq3tc0

dGFyZ2V0L2FybS9hcm0tc2VtaS5vOiBJbiBmdW5jdGlvbiBgZG9fYXJtX3NlbWlob3N0aW5nJzoK
L2xob21lL3ByaXlhbXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91cGRhdGVkL3FlbXUvdGFyZ2V0L2Fy
bS9hcm0tc2VtaS5jOjc4NDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcWVtdV9zZW1paG9zdGlu
Z19jb25zb2xlX291dGMnCi9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRl
ZC9xZW11L3RhcmdldC9hcm0vYXJtLXNlbWkuYzo3ODc6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YHFlbXVfc2VtaWhvc3RpbmdfY29uc29sZV9vdXRzJwovbGhvbWUvcHJpeWFtdmFkL2RlYmlhbl9x
ZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90YXJnZXQvYXJtL2FybS1zZW1pLmM6ODE1OiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBxZW11X3NlbWlob3N0aW5nX2NvbnNvbGVfaW5jJwp0YXJnZXQvYXJt
L2NwdS5vOiBJbiBmdW5jdGlvbiBgYXJtX3Y3bV9jcHVfZXhlY19pbnRlcnJ1cHQnOgovbGhvbWUv
cHJpeWFtdmFkL2RlYmlhbl9xZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90YXJnZXQvYXJtL2NwdS5j
OjQ4MzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYXJtdjdtX252aWNfY2FuX3Rha2VfcGVuZGlu
Z19leGNlcHRpb24nCnRhcmdldC9hcm0vbV9oZWxwZXIubzogSW4gZnVuY3Rpb24gYHY3bV9zdGFj
a193cml0ZSc6Ci9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11
L3RhcmdldC9hcm0vbV9oZWxwZXIuYzoyNjA6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFybXY3
bV9udmljX3NldF9wZW5kaW5nX2Rlcml2ZWQnCi9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVf
YXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9hcm0vbV9oZWxwZXIuYzoyNjM6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYGFybXY3bV9udmljX3NldF9wZW5kaW5nX2xhenlmcCcKdGFyZ2V0L2FybS9t
X2hlbHBlci5vOiBJbiBmdW5jdGlvbiBgdjdtX3N0YWNrX3JlYWQnOgovbGhvbWUvcHJpeWFtdmFk
L2RlYmlhbl9xZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90YXJnZXQvYXJtL21faGVscGVyLmM6MzI5
OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12N21fbnZpY19zZXRfcGVuZGluZycKdGFyZ2V0
L2FybS9tX2hlbHBlci5vOiBJbiBmdW5jdGlvbiBgaGVscGVyX3Y3bV9wcmVzZXJ2ZV9mcF9zdGF0
ZSc6Ci9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3Rhcmdl
dC9hcm0vbV9oZWxwZXIuYzozNTY6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFybXY3bV9udmlj
X3NldF9wZW5kaW5nX2xhenlmcCcKL2xob21lL3ByaXlhbXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91
cGRhdGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjM2MDogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgYXJtdjdtX252aWNfc2V0X3BlbmRpbmdfbGF6eWZwJwovbGhvbWUvcHJpeWFtdmFkL2Rl
Ymlhbl9xZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90YXJnZXQvYXJtL21faGVscGVyLmM6Mzk5OiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12N21fbnZpY19jYW5fdGFrZV9wZW5kaW5nX2V4Y2Vw
dGlvbicKdGFyZ2V0L2FybS9tX2hlbHBlci5vOiBJbiBmdW5jdGlvbiBgYXJtX3Y3bV9sb2FkX3Zl
Y3Rvcic6Ci9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3Rh
cmdldC9hcm0vbV9oZWxwZXIuYzo3Mjg6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFybXY3bV9u
dmljX3NldF9wZW5kaW5nX2Rlcml2ZWQnCnRhcmdldC9hcm0vbV9oZWxwZXIubzogSW4gZnVuY3Rp
b24gYHY3bV9wdXNoX2NhbGxlZV9zdGFjayc6Ci9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVf
YXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9hcm0vbV9oZWxwZXIuYzo3OTY6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYGFybXY3bV9udmljX3NldF9wZW5kaW5nJwp0YXJnZXQvYXJtL21faGVscGVy
Lm86IEluIGZ1bmN0aW9uIGB2N21fZXhjZXB0aW9uX3Rha2VuJzoKL2xob21lL3ByaXlhbXZhZC9k
ZWJpYW5fcWVtdV9hcm0zMl91cGRhdGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjgzODog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYXJtdjdtX252aWNfZ2V0X3BlbmRpbmdfaXJxX2luZm8n
Ci9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9h
cm0vbV9oZWxwZXIuYzo5NDY6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFybXY3bV9udmljX2Fj
a25vd2xlZGdlX2lycScKdGFyZ2V0L2FybS9tX2hlbHBlci5vOiBJbiBmdW5jdGlvbiBgdjdtX3Vw
ZGF0ZV9mcGNjcic6Ci9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9x
ZW11L3RhcmdldC9hcm0vbV9oZWxwZXIuYzo5ODg6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFy
bXY3bV9udmljX25lZ19wcmlvX3JlcXVlc3RlZCcKL2xob21lL3ByaXlhbXZhZC9kZWJpYW5fcWVt
dV9hcm0zMl91cGRhdGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjEwMDQ6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYGFybXY3bV9udmljX2dldF9yZWFkeV9zdGF0dXMnCi9saG9tZS9wcml5
YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9hcm0vbV9oZWxwZXIu
YzoxMDA3OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12N21fbnZpY19nZXRfcmVhZHlfc3Rh
dHVzJwovbGhvbWUvcHJpeWFtdmFkL2RlYmlhbl9xZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90YXJn
ZXQvYXJtL21faGVscGVyLmM6MTAxMDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYXJtdjdtX252
aWNfZ2V0X3JlYWR5X3N0YXR1cycKL2xob21lL3ByaXlhbXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91
cGRhdGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjEwMTM6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8gYGFybXY3bV9udmljX2dldF9yZWFkeV9zdGF0dXMnCi9saG9tZS9wcml5YW12YWQvZGVi
aWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9hcm0vbV9oZWxwZXIuYzoxMDE2OiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12N21fbnZpY19nZXRfcmVhZHlfc3RhdHVzJwp0YXJn
ZXQvYXJtL21faGVscGVyLm86L2xob21lL3ByaXlhbXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91cGRh
dGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjEwMjA6IG1vcmUgdW5kZWZpbmVkIHJlZmVy
ZW5jZXMgdG8gYGFybXY3bV9udmljX2dldF9yZWFkeV9zdGF0dXMnIGZvbGxvdwp0YXJnZXQvYXJt
L21faGVscGVyLm86IEluIGZ1bmN0aW9uIGB2N21fcHVzaF9zdGFjayc6Ci9saG9tZS9wcml5YW12
YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9hcm0vbV9oZWxwZXIuYzox
MjA0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12N21fbnZpY19zZXRfcGVuZGluZycKL2xo
b21lL3ByaXlhbXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91cGRhdGVkL3FlbXUvdGFyZ2V0L2FybS9t
X2hlbHBlci5jOjEyNDk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFybXY3bV9udmljX3NldF9w
ZW5kaW5nJwovbGhvbWUvcHJpeWFtdmFkL2RlYmlhbl9xZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90
YXJnZXQvYXJtL21faGVscGVyLmM6MTI1NDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYXJtdjdt
X252aWNfc2V0X3BlbmRpbmcnCi9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBk
YXRlZC9xZW11L3RhcmdldC9hcm0vbV9oZWxwZXIuYzoxMjcyOiB1bmRlZmluZWQgcmVmZXJlbmNl
IHRvIGBhcm12N21fbnZpY19zZXRfcGVuZGluZycKdGFyZ2V0L2FybS9tX2hlbHBlci5vOiBJbiBm
dW5jdGlvbiBgZG9fdjdtX2V4Y2VwdGlvbl9leGl0JzoKL2xob21lL3ByaXlhbXZhZC9kZWJpYW5f
cWVtdV9hcm0zMl91cGRhdGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjE0MDg6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYGFybXY3bV9udmljX3Jhd19leGVjdXRpb25fcHJpb3JpdHknCi9s
aG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9hcm0v
bV9oZWxwZXIuYzoxNDE2OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12N21fbnZpY19jb21w
bGV0ZV9pcnEnCi9saG9tZS9wcml5YW12YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11
L3RhcmdldC9hcm0vbV9oZWxwZXIuYzoxNDk3OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12
N21fbnZpY19zZXRfcGVuZGluZycKL2xob21lL3ByaXlhbXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91
cGRhdGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjE1MTU6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8gYGFybXY3bV9udmljX3NldF9wZW5kaW5nJwovbGhvbWUvcHJpeWFtdmFkL2RlYmlhbl9x
ZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90YXJnZXQvYXJtL21faGVscGVyLmM6MTUyODogdW5kZWZp
bmVkIHJlZmVyZW5jZSB0byBgYXJtdjdtX252aWNfc2V0X3BlbmRpbmcnCi9saG9tZS9wcml5YW12
YWQvZGViaWFuX3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9hcm0vbV9oZWxwZXIuYzox
NTQ1OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12N21fbnZpY19jYW5fdGFrZV9wZW5kaW5n
X2V4Y2VwdGlvbicKL2xob21lL3ByaXlhbXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91cGRhdGVkL3Fl
bXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjE1OTU6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFy
bXY3bV9udmljX3NldF9wZW5kaW5nJwovbGhvbWUvcHJpeWFtdmFkL2RlYmlhbl9xZW11X2FybTMy
X3VwZGF0ZWQvcWVtdS90YXJnZXQvYXJtL21faGVscGVyLmM6MTY2OTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgYXJtdjdtX252aWNfc2V0X3BlbmRpbmcnCi9saG9tZS9wcml5YW12YWQvZGViaWFu
X3FlbXVfYXJtMzJfdXBkYXRlZC9xZW11L3RhcmdldC9hcm0vbV9oZWxwZXIuYzoxNjg0OiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGBhcm12N21fbnZpY19zZXRfcGVuZGluZycKL2xob21lL3ByaXlh
bXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91cGRhdGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5j
OjE3MTE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFybXY3bV9udmljX3NldF9wZW5kaW5nJwov
bGhvbWUvcHJpeWFtdmFkL2RlYmlhbl9xZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90YXJnZXQvYXJt
L21faGVscGVyLmM6MTcyMTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYXJtdjdtX252aWNfc2V0
X3BlbmRpbmcnCnRhcmdldC9hcm0vbV9oZWxwZXIubzovbGhvbWUvcHJpeWFtdmFkL2RlYmlhbl9x
ZW11X2FybTMyX3VwZGF0ZWQvcWVtdS90YXJnZXQvYXJtL21faGVscGVyLmM6MTgyMDogbW9yZSB1
bmRlZmluZWQgcmVmZXJlbmNlcyB0byBgYXJtdjdtX252aWNfc2V0X3BlbmRpbmcnIGZvbGxvdwp0
YXJnZXQvYXJtL21faGVscGVyLm86IEluIGZ1bmN0aW9uIGBhcm1fdjdtX21tdV9pZHhfZm9yX3Nl
Y3N0YXRlX2FuZF9wcml2JzoKL2xob21lL3ByaXlhbXZhZC9kZWJpYW5fcWVtdV9hcm0zMl91cGRh
dGVkL3FlbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjI3MTA6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYGFybXY3bV9udmljX25lZ19wcmlvX3JlcXVlc3RlZCcKY29sbGVjdDI6IGVycm9yOiBsZCBy
ZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjA2OiBxZW11LXN5
c3RlbS1hcm1dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0OTQ6IGFybS1zb2Z0bW11L2Fs
bF0gRXJyb3IgMgo=
--00000000000024b235059ff2ad51--

