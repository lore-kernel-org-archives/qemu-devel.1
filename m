Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B34C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 22:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AE520C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 22:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvK2j327"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AE520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG8jL-0004RS-FW
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 18:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG8ie-0003vT-Vn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 18:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG8id-0004N6-1I
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 18:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599691053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOvR5EuTytKxZA74/khLQXA8VHNsbiuYZo8acy4qD4g=;
 b=RvK2j3278bSSHkJcXeNveGqmPJrfaSCIa/0piXTSCyKNiffGbUlTU0FNngBOYIxoIs+8bL
 9A8oLuhCWXAvGDYMNyRDQVYWfMa4UF5OF8KSDXDskvzLnhVIKVtkOm8+knd/oWrYsC0bGl
 4b9A2iFFtiA/B9NwWwS28xnW/ZvLwNo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-9_BJ3CPoNgW5PfOHiFKbaQ-1; Wed, 09 Sep 2020 18:37:29 -0400
X-MC-Unique: 9_BJ3CPoNgW5PfOHiFKbaQ-1
Received: by mail-ed1-f71.google.com with SMTP id y15so1647263edq.4
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 15:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DOvR5EuTytKxZA74/khLQXA8VHNsbiuYZo8acy4qD4g=;
 b=P1tg1xB8w+2cukXRRZx8pslQ4ClqK414vulYNUijQGnI9RZdjemjGj8JxoUM3yHCzQ
 iiUTeoblx1TRpidRnRvouh7qVebYEXMBcwWavQmdxKVO9hDM/HxV8hOVFce4VB/8hHZT
 xQ1nUc/rhl35/A2QVV6MUI0ZWdHUh3/MK8i7VF5d/ToDhc04U9m0ZkO5yyOh1FivtvtC
 46UmJWVL5mOrA08xfXqNX5owODBfOavJ27qmQyK7ZhWMeRTf/1E52jg0vhF1nfkAMn6J
 53XYVaf9mJpah7DyfAdev3Hxdhr3c0tZ8d4//GQEua+zRNGJnSCJVI9geX9CXxIzURZw
 ElVQ==
X-Gm-Message-State: AOAM533YAYODhDRd35RTdi1j352guPIdoz4SDFEAkGQ5LQRAfX2C/M2e
 HciSGjCfKNGE03BJa6L5Qcd1h/L5Pj/32EFjq154nnJ00FGTfbJ3UhlqODtEqYqZ2yEpCy5Xng1
 HjSRbO5ITzPWuu3FfkWjJ/orDrer2vgw=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr6181181ejk.449.1599691048073; 
 Wed, 09 Sep 2020 15:37:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1p6tB/P/r2NdTPL5eQ8+2lx2UmhIQtfQrhhzLHkPRAw2VI/O0KhsBH8KjztT28DXBC6sr11C3PXDIQf2SsQc=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr6181149ejk.449.1599691047836; 
 Wed, 09 Sep 2020 15:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200909184237.765-1-luoyonggang@gmail.com>
 <20200909184237.765-3-luoyonggang@gmail.com>
 <CABgObfaGzMDC_n5ukJc4y2k9NVvDkYT=Zp6DGycCXRtmXQzJ5g@mail.gmail.com>
 <CAE2XoE9kA6PTqg-eTHe2jyhrh=RcLAQMmu4WSSBGhbyUJ6Sv1Q@mail.gmail.com>
In-Reply-To: <CAE2XoE9kA6PTqg-eTHe2jyhrh=RcLAQMmu4WSSBGhbyUJ6Sv1Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Sep 2020 00:37:16 +0200
Message-ID: <CABgObfb=qYyyLze3as1Omo5k_CDS-s_C=661g+RgS2V+WrsOzA@mail.gmail.com>
Subject: Re: [PATCH v6 25/25] meson: guard the minimal meson version to 0.55.1
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a82d8e05aee918e6"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 17:05:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a82d8e05aee918e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 9 set 2020, 22:11 =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyong=
gang@gmail.com> ha
scritto:

>
>
> On Thu, Sep 10, 2020 at 4:08 AM Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>
>>
>>
>> Il mer 9 set 2020, 20:43 Yonggang Luo <luoyonggang@gmail.com> ha scritto=
:
>>
>>> So we can removal usage of unstable-keyval
>>>
>>
>> Isn't it stable only on 0.56.0?
>>
>> Paolo
>>
> On Windows, there is following warning:   WARNING: Module unstable-keyval
> is now stable, please use the keyval module instead.
>

That's because Meson advertises itself as version 0.55.90 until 0.56 is
released. It will fix itself when the next release is out.

Paolo

NOTE: guest cross-compilers enabled: cc
> Using 'PKG_CONFIG_PATH' from environment with value:
> 'C:\\CI-Tools\\msys64\\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\ming=
w64\\share\\pkgconfig'
> Using 'PKG_CONFIG_PATH' from environment with value:
> 'C:\\CI-Tools\\msys64\\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\ming=
w64\\share\\pkgconfig'
> The Meson build system
> Version: 0.55.999
> Source dir: C:/work/xemu/qemu
> Build dir: C:/work/xemu/qemu/build
> Build type: native build
> Project name: qemu
> Project version: 5.1.50
> C compiler for the host machine: cc (gcc 10.2.0 "cc (Rev1, Built by MSYS2
> project) 10.2.0")
> C linker for the host machine: cc ld.bfd 2.35
> Host machine cpu family: x86_64
> Host machine cpu: x86_64
> WARNING: Module unstable-keyval is now stable, please use the keyval
> module instead.
> Program sh found: YES
>
> But when I commit this patch to running CI, osx are failing, so there is
> problem with this patch, sorry for that. this patch need to be discard
>
>>
>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>>  meson.build | 9 +++------
>>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 0b1741557d..af34a85bec 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -1,14 +1,11 @@
>>> -project('qemu', ['c'], meson_version: '>=3D0.55.0',
>>> +project('qemu', ['c'], meson_version: '>=3D0.55.1',
>>>          default_options: ['warning_level=3D1', 'c_std=3Dgnu99',
>>> 'cpp_std=3Dgnu++11',
>>>                            'b_colorout=3Dauto'],
>>>          version: run_command('head', meson.source_root() /
>>> 'VERSION').stdout().strip())
>>>
>>>  not_found =3D dependency('', required: false)
>>> -if meson.version().version_compare('>=3D0.56.0')
>>> -  keyval =3D import('keyval')
>>> -else
>>> -  keyval =3D import('unstable-keyval')
>>> -endif
>>> +keyval =3D import('keyval')
>>> +
>>>  ss =3D import('sourceset')
>>>
>>>  sh =3D find_program('sh')
>>> --
>>> 2.28.0.windows.1
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

--000000000000a82d8e05aee918e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 9 set 2020, 22:11 =E7=BD=97=E5=8B=87=E5=88=9A(Y=
onggang Luo) &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail=
.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 4:08 AM Paolo Bonzini=
 &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"auto"><div><br><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 9 set 2020, 20:43 Yong=
gang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">luoyonggang@gmail.com</a>&gt; ha scritto:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">So we can removal usage of unstab=
le-keyval<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Isn&#39;t it stable only on 0.56.0?</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Paolo</div></div></blockquote><div>On Windows, there =
is following warning:=C2=A0=C2=A0

WARNING: Module unstable-keyval is now stable, please use the keyval module=
 instead.</div></div></div></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">That&#39;s because Meson advertises itself as versio=
n 0.55.90 until 0.56 is released. It will fix itself when the next release =
is out.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>

</div>NOTE: guest cross-compilers enabled: cc<br>Using &#39;PKG_CONFIG_PATH=
&#39; from environment with value: &#39;C:\\CI-Tools\\msys64\\mingw64\\lib\=
\pkgconfig;C:\\CI-Tools\\msys64\\mingw64\\share\\pkgconfig&#39;<br>Using &#=
39;PKG_CONFIG_PATH&#39; from environment with value: &#39;C:\\CI-Tools\\msy=
s64\\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\mingw64\\share\\pkgconfi=
g&#39;<br>The Meson build system<br>Version: 0.55.999<br>Source dir: C:/wor=
k/xemu/qemu<br>Build dir: C:/work/xemu/qemu/build<br>Build type: native bui=
ld<br>Project name: qemu<br>Project version: 5.1.50<br>C compiler for the h=
ost machine: cc (gcc 10.2.0 &quot;cc (Rev1, Built by MSYS2 project) 10.2.0&=
quot;)<br>C linker for the host machine: cc ld.bfd 2.35<br>Host machine cpu=
 family: x86_64<br>Host machine cpu: x86_64<br>WARNING: Module unstable-key=
val is now stable, please use the keyval module instead.<br><div>Program sh=
 found: YES=C2=A0</div><div><br></div><div>But when I commit this patch to =
running CI, osx are failing, so there is problem with this patch, sorry for=
 that. this patch need to be discard</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" re=
l=3D"noreferrer noreferrer" target=3D"_blank">luoyonggang@gmail.com</a>&gt;=
<br>
---<br>
=C2=A0meson.build | 9 +++------<br>
=C2=A01 file changed, 3 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 0b1741557d..af34a85bec 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1,14 +1,11 @@<br>
-project(&#39;qemu&#39;, [&#39;c&#39;], meson_version: &#39;&gt;=3D0.55.0&#=
39;,<br>
+project(&#39;qemu&#39;, [&#39;c&#39;], meson_version: &#39;&gt;=3D0.55.1&#=
39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default_options: [&#39;warning_level=3D1&=
#39;, &#39;c_std=3Dgnu99&#39;, &#39;cpp_std=3Dgnu++11&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;b_colorout=3Dauto&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version: run_command(&#39;head&#39;, meso=
n.source_root() / &#39;VERSION&#39;).stdout().strip())<br>
<br>
=C2=A0not_found =3D dependency(&#39;&#39;, required: false)<br>
-if meson.version().version_compare(&#39;&gt;=3D0.56.0&#39;)<br>
-=C2=A0 keyval =3D import(&#39;keyval&#39;)<br>
-else<br>
-=C2=A0 keyval =3D import(&#39;unstable-keyval&#39;)<br>
-endif<br>
+keyval =3D import(&#39;keyval&#39;)<br>
+<br>
=C2=A0ss =3D import(&#39;sourceset&#39;)<br>
<br>
=C2=A0sh =3D find_program(&#39;sh&#39;)<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo<br></div></div>
</blockquote></div></div></div>

--000000000000a82d8e05aee918e6--


