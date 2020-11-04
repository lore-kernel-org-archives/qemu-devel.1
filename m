Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C971C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59B122384
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1fHmAhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59B122384
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDtr-0006lf-KK
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaDsd-0006Le-BA
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:10:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaDsZ-0001VV-MR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604477450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPQPVGIP0JIcWMqHgoO4gLYROtf0uTxUtdxR9RFJ3V8=;
 b=H1fHmAhhQGZklTIuB7qMdNj9LCUI/M35202yqImz8ldUQ6chgVLaqOasQ4hYiOToTPL4em
 jxGba72Ioawx36hfvgSpONOwlgX1CLOiJEB/62VpnW4w46nW4tCJuAbmowwQnaxOSKZLCu
 VtGBDC92TEq2LDnqqaNB0vd0G0vYN0U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-UdyyeEg9P4-SlCYLOYvxHQ-1; Wed, 04 Nov 2020 03:10:48 -0500
X-MC-Unique: UdyyeEg9P4-SlCYLOYvxHQ-1
Received: by mail-pf1-f198.google.com with SMTP id m64so14268277pfm.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 00:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uPQPVGIP0JIcWMqHgoO4gLYROtf0uTxUtdxR9RFJ3V8=;
 b=mao4qDDnb1A4A2G2UWJ3uPK/gNnzV1Fk24cFoLiQQx4fM2i1dCz/wnYAo/HdumjXQ5
 f1w8+eAz41s1tYe/K5t+YfCxV7nWQWTr5U2aVOGxSdnT1MreGSZFoY5OuSLygjNCthpu
 0Nu0i9H4Q2UxK5G2favbxgb/+5dIGVzbXdNu6lh6Xhik1pjf5dtQrK37r0bhPHndVfbe
 mQnJceMS9whNf+8djRUEy6gvbr/Qbm59Rc12jBGcsb6JEdb1IfosqBXLMI3Fds6dyS1q
 9fDyOs6JEHqC5PFMIbeFY11bJt+vfyFYSNAxCxvcfh9/l5BZHWDIhnO4HHn754dm5/IO
 AiiA==
X-Gm-Message-State: AOAM530ME+yYeypChjOpKO0ukCozbpHGnokYFLMMWI22r3H8QETxCRnE
 4g8xbSbnRIJ89c68Pv9r2X2i+A98PKlkrvc83C/kGpoUL27g2jISr49WeXvmlluhXg9ko1Q+j7r
 QkR8tBDE3ztLY5562FIQYA31s5lezMtY=
X-Received: by 2002:a65:6086:: with SMTP id t6mr20230760pgu.146.1604477446969; 
 Wed, 04 Nov 2020 00:10:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjTRS0gGHbRaZJjCxWq1ZocvNQA78J9BbCzqut3BmuomMR+/8wJATvWswvOMYCObEVadMzH/zQEqjPrBoC0h4=
X-Received: by 2002:a65:6086:: with SMTP id t6mr20230747pgu.146.1604477446764; 
 Wed, 04 Nov 2020 00:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-4-pbonzini@redhat.com>
 <9fc66c84-56c4-ce09-524f-2cf8ffc210a4@redhat.com>
In-Reply-To: <9fc66c84-56c4-ce09-524f-2cf8ffc210a4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Nov 2020 09:10:34 +0100
Message-ID: <CABgObfZZku4YpfYs5r4rjpas7kjxyWL89D=ZgJnNGqLdT095cw@mail.gmail.com>
Subject: Re: [PATCH for-5.2 3/4] qtest: escape device name in
 device-introspect-test
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000043ce2805b3438481"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Armbruster,
 Markus" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000043ce2805b3438481
Content-Type: text/plain; charset="UTF-8"

I will just drop autofree usage completely, also because valgrind showed
that GRegex does not support it and apparently is leaked.

Paolo

Il mer 4 nov 2020, 08:44 Thomas Huth <thuth@redhat.com> ha scritto:

> On 03/11/2020 16.14, Paolo Bonzini wrote:
> > device-introspect-test uses HMP, so it should escape the device name
> > properly.  Because of this, a few devices that had commas in their
> > names were escaping testing.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  tests/qtest/device-introspect-test.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/qtest/device-introspect-test.c
> b/tests/qtest/device-introspect-test.c
> > index 9f22340ee5..f471b0e0dd 100644
> > --- a/tests/qtest/device-introspect-test.c
> > +++ b/tests/qtest/device-introspect-test.c
> > @@ -104,7 +104,9 @@ static QList *device_type_list(QTestState *qts, bool
> abstract)
> >  static void test_one_device(QTestState *qts, const char *type)
> >  {
> >      QDict *resp;
> > -    char *help;
> > +    g_autofree char *help;
> > +    g_autofree GRegex *comma;
> > +    g_autofree char *escaped;
> >
> >      g_test_message("Testing device '%s'", type);
> >
> > @@ -113,8 +115,9 @@ static void test_one_device(QTestState *qts, const
> char *type)
> >                 type);
> >      qobject_unref(resp);
> >
> > -    help = qtest_hmp(qts, "device_add \"%s,help\"", type);
> > -    g_free(help);
> > +    comma = g_regex_new(",", 0, 0, NULL);
> > +    escaped = g_regex_replace_literal(comma, type, -1, 0, ",,", 0,
> NULL);
> > +    help = qtest_hmp(qts, "device_add \"%s,help\"", escaped);
> >  }
>
> Having "help =" as final statement now, this looks somewhat weird at a
> first
> glance (until you look at the g_autofree at the beginning of the function).
> Maybe it's better to drop the help variable completely and just do:
> g_free(gtest_hmp(...)) ?
>
>  Thomas
>
>

--00000000000043ce2805b3438481
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I will just drop autofree usage completely, also because =
valgrind showed that GRegex does not support it and apparently is leaked.<d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 4 nov 2020, 0=
8:44 Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 03/11/2020 16=
.14, Paolo Bonzini wrote:<br>
&gt; device-introspect-test uses HMP, so it should escape the device name<b=
r>
&gt; properly.=C2=A0 Because of this, a few devices that had commas in thei=
r<br>
&gt; names were escaping testing.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/qtest/device-introspect-test.c | 9 ++++++---<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device=
-introspect-test.c<br>
&gt; index 9f22340ee5..f471b0e0dd 100644<br>
&gt; --- a/tests/qtest/device-introspect-test.c<br>
&gt; +++ b/tests/qtest/device-introspect-test.c<br>
&gt; @@ -104,7 +104,9 @@ static QList *device_type_list(QTestState *qts, bo=
ol abstract)<br>
&gt;=C2=A0 static void test_one_device(QTestState *qts, const char *type)<b=
r>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QDict *resp;<br>
&gt; -=C2=A0 =C2=A0 char *help;<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *help;<br>
&gt; +=C2=A0 =C2=A0 g_autofree GRegex *comma;<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *escaped;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_message(&quot;Testing device &#39;%s&#39;&q=
uot;, type);<br>
&gt;=C2=A0 <br>
&gt; @@ -113,8 +115,9 @@ static void test_one_device(QTestState *qts, const=
 char *type)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 qobject_unref(resp);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 help =3D qtest_hmp(qts, &quot;device_add \&quot;%s,help=
\&quot;&quot;, type);<br>
&gt; -=C2=A0 =C2=A0 g_free(help);<br>
&gt; +=C2=A0 =C2=A0 comma =3D g_regex_new(&quot;,&quot;, 0, 0, NULL);<br>
&gt; +=C2=A0 =C2=A0 escaped =3D g_regex_replace_literal(comma, type, -1, 0,=
 &quot;,,&quot;, 0, NULL);<br>
&gt; +=C2=A0 =C2=A0 help =3D qtest_hmp(qts, &quot;device_add \&quot;%s,help=
\&quot;&quot;, escaped);<br>
&gt;=C2=A0 }<br>
<br>
Having &quot;help =3D&quot; as final statement now, this looks somewhat wei=
rd at a first<br>
glance (until you look at the g_autofree at the beginning of the function).=
<br>
Maybe it&#39;s better to drop the help variable completely and just do:<br>
g_free(gtest_hmp(...)) ?<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div>

--00000000000043ce2805b3438481--


