Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B53C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFAD2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUCphzVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFAD2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUf1-0003hc-1S
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAUPb-0005K1-Ak
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAUPU-0000is-5P
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehiedqTNRyLsLwOh+puLPuEtfUt5op6NnbGBalsnv/Q=;
 b=IUCphzVuV7kGqj+Bc+nO5EMRur9qcbSZIiQwYu0xLDrb2FksTdqEvqY3eynP7ZSBzLZAty
 0u5rwM8HdhsRumKEFV4kxI9creqw3fMJwgBK71iL+QkTtuDpKWfmwSO/sJECACEEzJB321
 dD3aMmzDkGMseZuYRSGZqAvjLw7/Qi0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-sKRCfx-gPUCa7k1kTVDzWw-1; Tue, 25 Aug 2020 04:34:25 -0400
X-MC-Unique: sKRCfx-gPUCa7k1kTVDzWw-1
Received: by mail-ed1-f72.google.com with SMTP id x68so4314565ede.21
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ehiedqTNRyLsLwOh+puLPuEtfUt5op6NnbGBalsnv/Q=;
 b=EdMuLRxOkI2LP7om6RsxzpRIGO2B4eIkeTBwfVD2LnYE8JujHjzffPajy2Hy9ChRcy
 ubJFu9RwIOkvrbXZ6VyZNP4GissuGmlX+C5aY3i4P8KJ8XDZ66xwuoFgOgsJHa99CJz9
 1SQesYLmmsgcWi2V+Qk0WgSNm4TIAITbvBjWpj49fG/OfqZ4G5vcosdLaGbXRrbTJpLJ
 KRH7mWudhpS5nzdPxZ6ksEcu6h6nzW4zShFxrCptuFlhAkPGToLAl06GK85DNhSpnAaD
 oX5ngKSQ+UhVy1MwPNE6DHUk6w2dZeY/lv36zxmHJiBa9qBKOsVtwFynN0ef8v97WHJy
 o4hQ==
X-Gm-Message-State: AOAM53166JLAfo71wnaQhhpwk0d4O4PpoQThQ0VDdfe2N9aaXFWtaTUE
 AgX6mafZp2G8hgpfPm5v/6vWulT7v08T/qCbiVk4BdP4q7daXnEtbCQZT96nwyAYPRZSQ+FShvw
 yqO9kOkTWywP1paWkeaDLZjECAQ4qAI4=
X-Received: by 2002:a50:fb94:: with SMTP id e20mr9208643edq.103.1598344463847; 
 Tue, 25 Aug 2020 01:34:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvcujtPyIK6noq+02JXW3Lz3XncNhbbyA96/URhVTeuof1qMwd/jHYDGAh+B5npGxMTWr9WkKCQgmOr1jj4o4=
X-Received: by 2002:a50:fb94:: with SMTP id e20mr9208634edq.103.1598344463669; 
 Tue, 25 Aug 2020 01:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
 <20200824113729.a3yfnllxep4kjfwc@sirius.home.kraxel.org>
 <09b683be-0a13-00cc-9398-285385ea290d@ilande.co.uk>
 <CABgObfZBW6Zvd4CXAjghAqo4yfyH2RukkW0yDuFE09P+46MwmA@mail.gmail.com>
 <CAE2XoE_265qKQ=BMOaSF6uC=Yo=Y2V=u=eGfbbckX08eL5VAfw@mail.gmail.com>
In-Reply-To: <CAE2XoE_265qKQ=BMOaSF6uC=Yo=Y2V=u=eGfbbckX08eL5VAfw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 10:34:12 +0200
Message-ID: <CABgObfZ6j1PGBq7X44H7a3pnS=7h9G1xFQ9P==DE+39xRbmPew@mail.gmail.com>
Subject: Re: meson: problems building under msys2/mingw-w64 native
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fc74de05adaf9104"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fc74de05adaf9104
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I saw it, thanks. I would like to have someone else (like Mark) test it and
then I will include it.

Paolo

Il mar 25 ago 2020, 10:24 =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyon=
ggang@gmail.com> ha
scritto:

> Hi Paolo Bonzini,
> I've already sent a series of fixes for msys, do you have a look at that?
>
>
> On Tue, Aug 25, 2020 at 3:55 PM Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>
>> Great, thanks! Can you send it as a patch? I am collecting Meson fixes
>> and I should be able to send a pull request this week.
>>
>> Also if you can please test the msys fixes that were sent on the list
>> that would be great.
>>
>> Paolo
>>
>> Il mar 25 ago 2020, 09:52 Mark Cave-Ayland <mark.cave-ayland@ilande.co.u=
k>
>> ha scritto:
>>
>>> On 24/08/2020 12:37, Gerd Hoffmann wrote:
>>>
>>> >> 2) GTK UI now depends on CONFIG_VTE
>>> >>
>>> >> This one I spotted on my local Linux setup as I didn't have the
>>> libvte-dev package
>>> >> installed and couldn't understand why I couldn't run QEMU with the
>>> GTK UI as I always
>>> >> do, even though configure reported that it found the GTK library and
>>> headers.
>>> >>
>>> >> A quick search showed that the GTK UI was being guarded by "if
>>> >> config_host.has_key('CONFIG_GTK') and
>>> config_host.has_key('CONFIG_VTE')" in
>>> >> ui/meson.build.
>>> >
>>> > That is not correct.  vte is intentionally not a hard dependency ...
>>> >
>>> >> For me the easy solution was to install libvte-dev, but since there
>>> are no VTE
>>> >> packages for Windows my guess is this will now make the GTK UI
>>> unavailable for
>>> >> Windows users.
>>> >
>>> > .. because we don't have that on windows.
>>> >
>>> > I think simply dropping the "and config_host.has_key('CONFIG_VTE')"
>>> > should work, can you try that?
>>>
>>> Hi Gerd,
>>>
>>> I can't get the native Windows build to complete yet, however I've
>>> removed the
>>> libvte-dev headers again on my Linux setup and confirmed that GTK works
>>> once again
>>> with the below diff:
>>>
>>> diff --git a/ui/meson.build b/ui/meson.build
>>> index 81fd393432..cc71f51f37 100644
>>> --- a/ui/meson.build
>>> +++ b/ui/meson.build
>>> @@ -42,7 +42,7 @@ if config_host.has_key('CONFIG_CURSES')
>>>    ui_modules +=3D {'curses' : curses_ss}
>>>  endif
>>>
>>> -if config_host.has_key('CONFIG_GTK') and
>>> config_host.has_key('CONFIG_VTE')
>>> +if config_host.has_key('CONFIG_GTK')
>>>    softmmu_ss.add(when: 'CONFIG_WIN32', if_true:
>>> files('win32-kbd-hook.c'))
>>>
>>>    gtk_ss =3D ss.source_set()
>>>
>>>
>>> ATB,
>>>
>>> Mark.
>>>
>>>
>
> --
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo
>

--000000000000fc74de05adaf9104
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I saw it, thanks. I would like to have someone else (like=
 Mark) test it and then I will include it.<div dir=3D"auto"><br></div><div =
dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">Il mar 25 ago 2020, 10:24 =E7=BD=97=E5=8B=87=E5=88=
=9A(Yonggang Luo) &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@=
gmail.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
dir=3D"ltr"><div>Hi Paolo Bonzini,</div>I&#39;ve already sent a series of f=
ixes for msys, do you have a look at that?<div><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 20=
20 at 3:55 PM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto">Great=
, thanks! Can you send it as a patch? I am collecting Meson fixes and I sho=
uld be able to send a pull request this week.<div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Also if you can please test the msys fixes that were sent o=
n the list that would be great.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 25 ago 2020, 09:52 Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"_blank" rel=3D"noreferr=
er">mark.cave-ayland@ilande.co.uk</a>&gt; ha scritto:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On 24/08/2020 12:37, Gerd Hoffmann wr=
ote:<br>
<br>
&gt;&gt; 2) GTK UI now depends on CONFIG_VTE<br>
&gt;&gt;<br>
&gt;&gt; This one I spotted on my local Linux setup as I didn&#39;t have th=
e libvte-dev package<br>
&gt;&gt; installed and couldn&#39;t understand why I couldn&#39;t run QEMU =
with the GTK UI as I always<br>
&gt;&gt; do, even though configure reported that it found the GTK library a=
nd headers.<br>
&gt;&gt;<br>
&gt;&gt; A quick search showed that the GTK UI was being guarded by &quot;i=
f<br>
&gt;&gt; config_host.has_key(&#39;CONFIG_GTK&#39;) and config_host.has_key(=
&#39;CONFIG_VTE&#39;)&quot; in<br>
&gt;&gt; ui/meson.build.<br>
&gt; <br>
&gt; That is not correct.=C2=A0 vte is intentionally not a hard dependency =
...<br>
&gt; <br>
&gt;&gt; For me the easy solution was to install libvte-dev, but since ther=
e are no VTE<br>
&gt;&gt; packages for Windows my guess is this will now make the GTK UI una=
vailable for<br>
&gt;&gt; Windows users.<br>
&gt; <br>
&gt; .. because we don&#39;t have that on windows.<br>
&gt; <br>
&gt; I think simply dropping the &quot;and config_host.has_key(&#39;CONFIG_=
VTE&#39;)&quot;<br>
&gt; should work, can you try that?<br>
<br>
Hi Gerd,<br>
<br>
I can&#39;t get the native Windows build to complete yet, however I&#39;ve =
removed the<br>
libvte-dev headers again on my Linux setup and confirmed that GTK works onc=
e again<br>
with the below diff:<br>
<br>
diff --git a/ui/meson.build b/ui/meson.build<br>
index 81fd393432..cc71f51f37 100644<br>
--- a/ui/meson.build<br>
+++ b/ui/meson.build<br>
@@ -42,7 +42,7 @@ if config_host.has_key(&#39;CONFIG_CURSES&#39;)<br>
=C2=A0 =C2=A0ui_modules +=3D {&#39;curses&#39; : curses_ss}<br>
=C2=A0endif<br>
<br>
-if config_host.has_key(&#39;CONFIG_GTK&#39;) and config_host.has_key(&#39;=
CONFIG_VTE&#39;)<br>
+if config_host.has_key(&#39;CONFIG_GTK&#39;)<br>
=C2=A0 =C2=A0softmmu_ss.add(when: &#39;CONFIG_WIN32&#39;, if_true: files(&#=
39;win32-kbd-hook.c&#39;))<br>
<br>
=C2=A0 =C2=A0gtk_ss =3D ss.source_set()<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo<br></div>
</blockquote></div>

--000000000000fc74de05adaf9104--


