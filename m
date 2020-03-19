Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE1AC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757572072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="QLCj2dFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757572072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEyjT-0004kc-M3
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEyij-000422-Nh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEyii-0007Ru-Fd
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:12:37 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:44392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jEyii-0007RB-57
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:12:36 -0400
Received: by mail-yb1-xb43.google.com with SMTP id g206so689297ybg.11
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hxQZT16SA1rVirRQkwRp9XSAQaPXuYtZifuj/YzV9og=;
 b=QLCj2dFBPiPgu/9tgiLXA1RQtArkRTmGvdwo3/TaC3dVdA5BtCJwknknqCAauD9o9S
 Annio0KL6pJalyOoLCeAU654K2fJn6vzoV4v85Cuj9jrT4lSoPlof0tIDKOM9C0g+MPc
 uoPYKG2eqngLFDKVP9h2X7mMyifOj5Fae1KzdJmAp6l2tLmSUBEOG5VMALAWzMHxa5Gn
 RQd9++lmbZ6buWQzBhOExGFVrhANfIRYMxKu7GcUqPEJFoNyim28Of9pAja92sZb91Gl
 5Y3mi84cmy30RyOsu1AjVupjHAinYHEQWYuIXgfLJBN+v8o/zyE+LydJy130y+wUFQHq
 /gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hxQZT16SA1rVirRQkwRp9XSAQaPXuYtZifuj/YzV9og=;
 b=Hucvd8A19ffq62zHuYEojb3sMsNjvO2eJ6w0cmuHXhItWJ02ZFnI8UOmZFNn50p3pA
 aJOl7/LgLG9LjPC/5IXzpmJm+8Fjgu0rzKZ++LDFCHev5D/aey9O2MxTULMAMjPqnLwY
 3IgR21JmWQeD33AHTb9tJqiY8dstlmubADphSZGjh1ya+ocFPmgF5WsmMp56YnKXEk0+
 vkOIc8BPf0b63mtv9zUT1I4243YcXORKgUmkuKFVi6X/rWozeYl6ueNieAnDoCw6NHbH
 x4dcUZdBVLTP1GtHkGulA5hP7WoPTx2+PJPVoxnHgOlIcG3/C7hH8ohfdJSt0i/zQlcw
 GMoA==
X-Gm-Message-State: ANhLgQ0cYFBCEXTop5F8dzV/w8D7D/e8+QFbr92+OgdwXB3V3m8Hmlt0
 zRbT/xhq//wibOiOwy9zt0U+FubDpcH8mkHbHAJ3oA==
X-Google-Smtp-Source: ADFU+vs0rUPbaTOIOE4pUbHW4cwHa52aeGbM5VgonHzNxbJd0SujoIfrDKheqkLtXyzzYzoZFre6UhmADpN5HJ0a0fc=
X-Received: by 2002:a25:950:: with SMTP id u16mr6285047ybm.447.1584637955069; 
 Thu, 19 Mar 2020 10:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-7-yuri.benditovich@daynix.com>
 <20200318054039-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200318054039-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 19 Mar 2020 19:12:20 +0200
Message-ID: <CAOEp5Od6TNqbR0tTomGJoJudoA1Qx4-RAA1MniSFEw+FUbjAGA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC
 macro
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000068f49f05a1384620"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000068f49f05a1384620
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 18, 2020 at 11:42 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 18, 2020 at 11:15:24AM +0200, Yuri Benditovich wrote:
> > Similar to VMSTATE_VARRAY_UINT32_ALLOC, but the size is
> > 16-bit field.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>
> Hmm this is exactly my patch isn't it? If yes pls fix up attribution
> (if this is not reposted, then when applying):
>

Of course, it is similar to the one you wrote inline.
Unlike one you wrote inline this patch does not fail on checkpatch.
But the idea is the same, hard to invent something.
Please just let me know what exactly should I do: resubmit or not and
whether it is possible to fix it without resubmission.


>
> From: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> > ---
> >  include/migration/vmstate.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 30667631bc..baaefb6b9b 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;
> >      .offset     = vmstate_offset_pointer(_state, _field, _type),     \
> >  }
> >
> > +#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num,
> _version, _info, _type) {\
> > +    .name       = (stringify(_field)),                               \
> > +    .version_id = (_version),                                        \
> > +    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
> > +    .info       = &(_info),                                          \
> > +    .size       = sizeof(_type),                                     \
> > +    .flags      = VMS_VARRAY_UINT16 | VMS_POINTER | VMS_ALLOC,       \
> > +    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
> > +}
> > +
> >  #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num,
> _version, _info, _type) {\
> >      .name       = (stringify(_field)),                               \
> >      .version_id = (_version),                                        \
> > --
> > 2.17.1
>
>

--00000000000068f49f05a1384620
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 18, 2020 at 11:42 AM Mich=
ael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, =
Mar 18, 2020 at 11:15:24AM +0200, Yuri Benditovich wrote:<br>
&gt; Similar to VMSTATE_VARRAY_UINT32_ALLOC, but the size is<br>
&gt; 16-bit field.<br>
&gt; <br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
<br>
Hmm this is exactly my patch isn&#39;t it? If yes pls fix up attribution<br=
>
(if this is not reposted, then when applying):<br></blockquote><div><br></d=
iv><div>Of course, it is similar to the one you wrote inline.</div><div>Unl=
ike one you wrote inline this patch does not fail on checkpatch.</div><div>=
But the idea is the same, hard to invent something.</div><div>Please just l=
et me know what exactly should I do: resubmit or not and whether it is poss=
ible to fix it without resubmission.</div><div>=C2=A0<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
From: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_b=
lank">mst@redhat.com</a>&gt;<br>
Signed-off-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" tar=
get=3D"_blank">mst@redhat.com</a>&gt;<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 include/migration/vmstate.h | 10 ++++++++++<br>
&gt;=C2=A0 1 file changed, 10 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h=
<br>
&gt; index 30667631bc..baaefb6b9b 100644<br>
&gt; --- a/include/migration/vmstate.h<br>
&gt; +++ b/include/migration/vmstate.h<br>
&gt; @@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .offset=C2=A0 =C2=A0 =C2=A0=3D vmstate_offset_poin=
ter(_state, _field, _type),=C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _vers=
ion, _info, _type) {\<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (stringify(_field))=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D (_version),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 .num_offset =3D vmstate_offset_value(_state, _field_num=
, uint16_t),\<br>
&gt; +=C2=A0 =C2=A0 .info=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &amp;(_info),=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 .size=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D sizeof(_type),=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =3D VMS_VARRAY_UINT16 | VMS_=
POINTER | VMS_ALLOC,=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 .offset=C2=A0 =C2=A0 =C2=A0=3D vmstate_offset_pointer(_=
state, _field, _type),=C2=A0 =C2=A0 =C2=A0\<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num,=
 _version, _info, _type) {\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (stringify(_fi=
eld)),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .version_id =3D (_version),=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; -- <br>
&gt; 2.17.1<br>
<br>
</blockquote></div></div>

--00000000000068f49f05a1384620--

