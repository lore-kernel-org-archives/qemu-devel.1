Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B3BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A89206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxmZy2IR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A89206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2qG-00041h-2Z
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jz2pi-0003cu-7p
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:54:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28297
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jz2pg-0005MA-45
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595616849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GGTYruCWO4r/mn4LNquCFRe1gQmSZnVsA/dduqakRWA=;
 b=VxmZy2IRN1zoWPcds/V/eQqnhhWOJ7/QVn/XQrTy3dP2lHGCD0K9hRCFnSIYG4hZd4jUQu
 hvOajJ2DBekNCO7q1vJNwxB34mfaN/ZzXqE25ZXwoXRD141SnG9nTBYUAGSlRIyQ2orUhX
 8r+HkOvMMKl+/iHYz2kE6yFnOuIzRbo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-NL4ehR4JN9agLNtxyV580g-1; Fri, 24 Jul 2020 14:54:05 -0400
X-MC-Unique: NL4ehR4JN9agLNtxyV580g-1
Received: by mail-ej1-f71.google.com with SMTP id gv21so3995640ejb.8
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GGTYruCWO4r/mn4LNquCFRe1gQmSZnVsA/dduqakRWA=;
 b=X9Bd9ZVUJozOmLnjT+JW64/wt1ViifIDJs3jhhkOd4Y/Yk7hcfy+DuvGMA+A0tkPeH
 90rmLDyuxeVA1gNHhZHlaBFyazIHskn7AdCIOPoFQTST0TeHMkvYuuM+auwFQJdnmbb6
 qiN9LYW/HQQ0iuzeQcUHEBljuaxCJkTtoUFnZSyPdDihES4XGq+nH0VdQLoXooT/9Nqt
 kG0CLLR55wm/LTF+MD066EH08fcevevnvoMKrjYvI0MtG9s9srZ+tLIlrRMVg7Qp6TvG
 vfKYaUQorE4K9LoMkFYXtn3edvT5v8uVyG8maPTpxhlc6hN8uzSPMUKBXfpLwnaw4EZV
 eX/Q==
X-Gm-Message-State: AOAM530qfCaY4cwktmNovJNgld2AHxt6O7bwaswnIeywDDaD/a81YInZ
 wY2MlCs7hl2AWjcMgqMmc9T5QwYac+vfcs+pytjdQp/yZmq2W0VzqMW6If3QP0k8gxBg4dTDSnq
 zoWchUxBaPPq9ol/VeIC56/Gs574PBAs=
X-Received: by 2002:a17:906:f907:: with SMTP id
 lc7mr10955196ejb.143.1595616843769; 
 Fri, 24 Jul 2020 11:54:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDOfBgWVLXM1ykDIeMuin4pheUd0A3aJBMffcRv6DBfrMfsCW2v3zbk7r2ospgqQEaFNM9tMxOgmPCmtsA6Lo=
X-Received: by 2002:a17:906:f907:: with SMTP id
 lc7mr10955187ejb.143.1595616843534; 
 Fri, 24 Jul 2020 11:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200720154028.477457-1-richard.henderson@linaro.org>
 <cc3e60e3-e150-4b62-cb8e-abc71920f897@linaro.org>
In-Reply-To: <cc3e60e3-e150-4b62-cb8e-abc71920f897@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Jul 2020 20:53:51 +0200
Message-ID: <CABgObfZVXtspgcoG_b33j5NcCSJFiBCXntT+388GWFuJ0aTh2A@mail.gmail.com>
Subject: Re: [PATCH for-5.1?] target/i386: Save cc_op before loop insns
To: Richard Henderson <richard.henderson@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000028350d05ab347f16"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, "Habkost, Eduardo" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000028350d05ab347f16
Content-Type: text/plain; charset="UTF-8"

Looks good, will queue when I am back---or just send a pull request
yourself if you prefer.

Paolo

Il ven 24 lug 2020, 20:35 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> Ping?
>
> On 7/20/20 8:40 AM, Richard Henderson wrote:
> > We forgot to update cc_op before these branch insns,
> > which lead to losing track of the current eflags.
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1888165
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/i386/translate.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/target/i386/translate.c b/target/i386/translate.c
> > index a1d31f09c1..caea6f5fb1 100644
> > --- a/target/i386/translate.c
> > +++ b/target/i386/translate.c
> > @@ -7148,6 +7148,7 @@ static target_ulong disas_insn(DisasContext *s,
> CPUState *cpu)
> >              l1 = gen_new_label();
> >              l2 = gen_new_label();
> >              l3 = gen_new_label();
> > +            gen_update_cc_op(s);
> >              b &= 3;
> >              switch(b) {
> >              case 0: /* loopnz */
> >
>
>

--00000000000028350d05ab347f16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Looks good, will queue when I am back---or just send a pu=
ll request yourself if you prefer.<div dir=3D"auto"><br></div><div dir=3D"a=
uto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Il ven 24 lug 2020, 20:35 Richard Henderson &lt;<a href=3D"=
mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Ping?<br>
<br>
On 7/20/20 8:40 AM, Richard Henderson wrote:<br>
&gt; We forgot to update cc_op before these branch insns,<br>
&gt; which lead to losing track of the current eflags.<br>
&gt; <br>
&gt; Buglink: <a href=3D"https://bugs.launchpad.net/qemu/+bug/1888165" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://bugs.launchpad.net/qem=
u/+bug/1888165</a><br>
&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linar=
o.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/i386/translate.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/target/i386/translate.c b/target/i386/translate.c<br>
&gt; index a1d31f09c1..caea6f5fb1 100644<br>
&gt; --- a/target/i386/translate.c<br>
&gt; +++ b/target/i386/translate.c<br>
&gt; @@ -7148,6 +7148,7 @@ static target_ulong disas_insn(DisasContext *s, =
CPUState *cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l1 =3D gen_new_label()=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l2 =3D gen_new_label()=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l3 =3D gen_new_label()=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_update_cc_op(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b &amp;=3D 3;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch(b) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0: /* loopnz */<b=
r>
&gt; <br>
<br>
</blockquote></div>

--00000000000028350d05ab347f16--


