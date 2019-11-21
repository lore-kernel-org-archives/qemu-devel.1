Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35814C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0237B2068D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixUNnQcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0237B2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqNz-0002xp-6V
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXqME-0001rK-7v
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXqMC-0006VM-RJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:35:06 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXqMC-0006Uw-Fm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:35:04 -0500
Received: by mail-ot1-x343.google.com with SMTP id c19so3635664otr.11
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=W+Wy7vOe7sJm8qjWA3R3ZCakDWqMhF4OsRMwqmWTNJo=;
 b=ixUNnQcgkdGXzBfLmOgM37871AKkoTbDzGUBuMLSciybZQDWxC3DOt4ELXpRinlqyb
 0qpL0OOfmp++8RyO4vmUpNZx1ftM8umS3OQhBhTHWU56Kyr+VQHW/KRcK2O23zTpAcuS
 ViQ4TfRfZtm/XNskMv7lvxUeX0WmfvUzMMVQBL8q+UiB7Pt2+D0k/hhAM+l172bsy7qq
 z/+HLYJJbS9pYm4yqR4at059/A0E2jRtCCnStRfmxg188dVTno2jTyfdXDI3vicvU0JC
 cQKIEmU+ugfgkXkRTZM1fA61LY+Ab4usTg7Q4poSJ4sXALHjMpGReaD84J4A3qbV10qr
 R50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=W+Wy7vOe7sJm8qjWA3R3ZCakDWqMhF4OsRMwqmWTNJo=;
 b=hzG8xZCmgw0IULPMELv9sp2oDPV7r3IoEBwpclQZjINeows3QyjPltWV5/eFzSWKF4
 11xbDU9UoRhwsjKtPSfv2WQBAtpH6EWo4PM6fd69bhwPb6zX2RzxUaHOFWXHIwV/173I
 XVvePvnkhpZgzQTqCODkuYtmJawmijc4ZSd7B2bVQyAUKzc6lQGLhJY38tv/yQoFQ3gs
 7ar4TFD82PfquGiFB+WPLXZs/vCaH62tNH69a0+aY97RdNKkRSBsLA8GIGgE1t1Uuwdd
 1bsMvHbZ0s5g/NYFxSZhQROdwWVXN2xF0HCZ/AIAeOQgTBvpwLdjd2N62HTVLwDq0Z4D
 Txdg==
X-Gm-Message-State: APjAAAW7Y1YKMRYaj9mnTOBKM+9umhw2wAzZtaXb7XOE1yQwNXZfvIPU
 Wi9k21OqZT2y3qzIRmWZiJdzCyPGccRj2Kwf3NY=
X-Google-Smtp-Source: APXvYqxLKy12m6S4h5nJusl1oZdy6WOi+VYnh9SqQoGfRaNFg314nYWrjHvfjZJu/c02oDuIefMwqI86hDv+KoQg4Jo=
X-Received: by 2002:a05:6830:1383:: with SMTP id
 d3mr7466069otq.306.1574357703408; 
 Thu, 21 Nov 2019 09:35:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 21 Nov 2019 09:35:02
 -0800 (PST)
In-Reply-To: <32d6aa36-3240-7a80-89c1-5cba13bbc022@redhat.com>
References: <20191120145724.GA15677@ls3530.fritz.box>
 <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
 <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
 <015ab947-57ba-6d73-d99d-2e3263226c02@gmx.de>
 <f7f4ff93-fad0-3d72-a224-c19302dff9e0@redhat.com>
 <CAL1e-=hHFfkJ3bmOLhk5bBCExvnazA4NgmoCJtN+X3KQ8=9Pjw@mail.gmail.com>
 <32d6aa36-3240-7a80-89c1-5cba13bbc022@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 18:35:02 +0100
Message-ID: <CAL1e-=hDgLB-n2aOdB_ZOnVC0f3x3SGvQDUCcBWSobme7JSV4Q@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/strace: Improve output of various syscalls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a941480597deb787"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a941480597deb787
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 11/21/19 6:00 PM, Aleksandar Markovic wrote:
>
>> On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com
>> <mailto:philmd@redhat.com>> wrote:
>>
>>     On 11/21/19 9:19 AM, Helge Deller wrote:
>>
>>         On 20.11.19 23:20, Aleksandar Markovic wrote:
>>
>>             On Wed, Nov 20, 2019 at 10:13 PM Aleksandar Markovic
>>             <aleksandar.m.mail@gmail.com
>>             <mailto:aleksandar.m.mail@gmail.com>> wrote:
>>
>>
>>                 On Wed, Nov 20, 2019 at 3:58 PM Helge Deller
>>                 <deller@gmx.de <mailto:deller@gmx.de>> wrote:
>>
>>
>>                     Improve strace output of various syscalls which
>>                     either have none
>>                     or only int-type parameters.
>>
>>
>>                 It would be nice if you included a history of the patch
>>                 (after the line
>>                 "---", as it is customary for single patch submission).
>>                 You changed
>>                 only ioctl() in v2, right?
>>
>>
>>         Yes. Will add history in next round.
>>
>>                 I missed your v2, but responded with several hints to v1=
.
>>
>>
>>         Yes, I saw all your mails.
>>         Thanks for your feedback!
>>
>>             userfaultfd(), membarrier(), mlock2()... - all could be
>>             included into
>>             your patch.
>>
>>
>>         I think there are quite some more which I didn't included.
>>         That's why I wrote "*various*" and not "*all*" in my changelog.
>>         I'm debugging other code, and the ones I fixed are the ones I
>>         actually tested with my code.
>>
>>
>>     If you don't have handy way to test the other syscalls, I'll rather
>>     restrict your patch to the one you tested, at least you are certain
>>     you didn't introduced regressions. Unless their implementation is
>>     trivial, of course.
>>
>>
>> What can be handier than writing a program that contains a single system
>> call?
>>
>
> Ahah very easy indeed :) Not noticing it shows how busy I am with firmwar=
e
> world than I forgot linux-user can be a simpler/powerful way to easily te=
st
> stuff, as the Hexagon recent port also demonstrated.
>
>
Hexagon port doesn't have anything to do with this patch and didn't
demonstrate anything new wrt linux-user. I have no idea what you meant to
say.

But, OK, Helge is the submitter, and he decides on the scope of his patch.
I am fine if he wants to limit it only to handful of syscalls. I just
hinted he could increase the vslue of the patch significantly in an easy
way.

Thanks,
Aleksandar

--000000000000a941480597deb787
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 11/21/19 6:00 PM, Aleksandar Markovic wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"=
mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> &lt;mailt=
o:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com<=
/a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 On 11/21/19 9:19 AM, Helge Deller wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On 20.11.19 23:20, Aleksandar Markovic wrote:<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, Nov 20, 2019 at 10:13 PM =
Aleksandar Markovic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:aleksandar.=
m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:alek=
sandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@<wbr>gmail.com=
</a>&gt;&gt; wrote:<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, Nov 20, 201=
9 at 3:58 PM Helge Deller<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mail=
to:deller@gmx.de" target=3D"_blank">deller@gmx.de</a> &lt;mailto:<a href=3D=
"mailto:deller@gmx.de" target=3D"_blank">deller@gmx.de</a>&gt;&gt; wrote:<b=
r>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Impro=
ve strace output of various syscalls which<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eithe=
r have none<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or on=
ly int-type parameters.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 It would be nice if=
 you included a history of the patch<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (after the line<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;---&quot;, as=
 it is customary for single patch submission).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 You changed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 only ioctl() in v2,=
 right?<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Yes. Will add history in next round.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I missed your v2, b=
ut responded with several hints to v1.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Yes, I saw all your mails.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanks for your feedback!<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 userfaultfd(), membarrier(), mloc=
k2()... - all could be<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 included into<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 your patch.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I think there are quite some more which I didn&=
#39;t included.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 That&#39;s why I wrote &quot;*various*&quot; an=
d not &quot;*all*&quot; in my changelog.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I&#39;m debugging other code, and the ones I fi=
xed are the ones I<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 actually tested with my code.<br>
<br>
<br>
=C2=A0 =C2=A0 If you don&#39;t have handy way to test the other syscalls, I=
&#39;ll rather<br>
=C2=A0 =C2=A0 restrict your patch to the one you tested, at least you are c=
ertain<br>
=C2=A0 =C2=A0 you didn&#39;t introduced regressions. Unless their implement=
ation is<br>
=C2=A0 =C2=A0 trivial, of course.<br>
<br>
<br>
What can be handier than writing a program that contains a single system ca=
ll?<br>
</blockquote>
<br>
Ahah very easy indeed :) Not noticing it shows how busy I am with firmware =
world than I forgot linux-user can be a simpler/powerful way to easily test=
 stuff, as the Hexagon recent port also demonstrated.<br>
<br>
</blockquote><div><br></div><div>Hexagon port doesn&#39;t have anything to =
do with this patch and didn&#39;t demonstrate anything new wrt linux-user. =
I have no idea what you meant to say.</div><div><br></div><div>But, OK, Hel=
ge is the submitter, and he decides on the scope of his patch. I am fine if=
 he wants to limit it only to handful of syscalls. I just hinted he could i=
ncrease the vslue of the patch significantly in an easy way.</div><div><br>=
</div><div>Thanks,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</di=
v>

--000000000000a941480597deb787--

