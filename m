Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8836CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9CF2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiGOHH2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9CF2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYSjt-0002wJ-9I
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 07:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYSih-0002Fj-Js
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:37:24 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYSie-0001TW-9J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:37:23 -0400
Received: by mail-ed1-x542.google.com with SMTP id dn5so6238818edb.10
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ijkJpYv+VMVBUEmhVNEE60rHkBkKWvsPAEVdDequaZ4=;
 b=BiGOHH2iVnbRLPGhdhKDaQVIS7DCa+JqNRsRVKcumCn7YzQIy8/x7D3fwjRhHXHU2H
 ui4bKuBxoHySFGlXO7+yMBH7tzYHgK9qLJcKMifIGenKflJvXxawgcVvwa688UeVasHD
 4kUPyk7D/dYWDFGhwYmkYhRoH+/nEmpFYcv6qx3u1OUy8J/7ImZKg1RFq0UP7akiBDwN
 A6npPsjMmny68PYCqPGgMAA8Yy/4PHAPWHzusb6N6DM10zzROPlX5aM2L+LTVOYa7tIu
 O47ia/qPWu5ERWB486d2zjbkUKG15doVE1124NSBHVINKlsgPBcyIPQ4+M/G5Hd4V/Dj
 tocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ijkJpYv+VMVBUEmhVNEE60rHkBkKWvsPAEVdDequaZ4=;
 b=YIkF7hIsrwOUF0BT7/kMh/nC7NL1GkFrDyYmeKTGjqRf0ZHkcojYJjBOyRx05Jumm9
 rP05rSL4XXlsYzT5bUo86UjWw6LneLljHAFEdJZDneE498m3+uF14CBIcAL+rD8X2nnd
 HoTNbYpl3wBMkdIjKiqrBEvTzW59/ItYj9Gfz8i2xoihbfAYqMG7DKAF+0CtpxOIVc0r
 qmA6YFedm9PXQDVSvtNRMJuXFbg0+idIjO9jIB7Lm+NvV+6YweA8MiqHeyAIZ119IVuR
 PyzUo6U5UYu2fwKDdlvCjzHStVPPRJRKK6TK1y+Qb9bZvyu29wktTYHc1wrR2bX/GAvX
 hFrQ==
X-Gm-Message-State: AOAM530Xb9cyyYacQNBe+/BKL9WbXl5tCrGbP5TtgHspbZdFxruPdR1u
 gK9Lt08YbaOeg863Ck8KF5NQcze6ihdQjhcDNrk=
X-Google-Smtp-Source: ABdhPJy6P4qtIXkz7jFqS0qXdrWr8IW634eXvm4Tmd+ZKaUgPRdW61n56OwrfWIh6Jt3iBWgJSBQaESDB+18GItvDMI=
X-Received: by 2002:aa7:cd98:: with SMTP id x24mr1732654edv.237.1604057838779; 
 Fri, 30 Oct 2020 04:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-21-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-21-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 15:37:07 +0400
Message-ID: <CAJ+F1CKJf54V+cOiFZXmXrmMSBPiN2f1B4ybwxV0-xcT8TWfLA@mail.gmail.com>
Subject: Re: [PATCH 20/36] qdev: Reuse object_property_add_static() when
 adding array elements
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ae029705b2e1d1f4"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ae029705b2e1d1f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:09 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Reuse function instead of calling object_property_add() directly.
> We need to hack ObjectProperty.release to make sure we will free
> the array property.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

that seems to be right, but could use more eyes... somebody may have an
idea of simplification.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/core/qdev-properties.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 1f06dfb5d5..4fec9cb73b 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -600,7 +600,6 @@ static ArrayElementProperty *array_element_new(Object
> *obj,
>  {
>      char *propname =3D g_strdup_printf("%s[%d]", arrayname, index);
>      ArrayElementProperty *arrayprop =3D g_new0(ArrayElementProperty, 1);
> -    arrayprop->release =3D array_len_prop->arrayinfo->release;
>      arrayprop->propname =3D propname;
>      arrayprop->prop.info =3D array_len_prop->arrayinfo;
>      arrayprop->prop.name =3D propname;
> @@ -632,12 +631,12 @@ static void object_property_add_array_element(Objec=
t
> *obj,
>                                                Property *array_len_prop,
>                                                ArrayElementProperty *prop=
)
>  {
> -    object_property_add(obj, prop->prop.name,
> -                        prop->prop.info->name,
> -                        static_prop_getter(prop->prop.info),
> -                        static_prop_setter(prop->prop.info),
> -                        array_element_release,
> -                        prop);
> +    ObjectProperty *op =3D object_property_add_static(obj, &prop->prop);
> +
> +    assert((void *)prop =3D=3D (void *)&prop->prop);
> +    prop->release =3D op->release;
> +    /* array_element_release() will call the original release function *=
/
> +    op->release =3D array_element_release;
>  }
>
>  static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ae029705b2e1d1f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:09 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Re=
use function instead of calling object_property_add() directly.<br>
We need to hack ObjectProperty.release to make sure we will free<br>
the array property.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>that seems to be right, but could use more eyes... somebody may have =
an idea of simplification.</div><div><br></div><div>Reviewed-by: Marc-Andr=
=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.=
lureau@redhat.com</a>&gt;</div><div><br> </div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
---<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mailto:berrange@redh=
at.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Cc: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_b=
lank">ehabkost@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0hw/core/qdev-properties.c | 13 ++++++-------<br>
=C2=A01 file changed, 6 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 1f06dfb5d5..4fec9cb73b 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -600,7 +600,6 @@ static ArrayElementProperty *array_element_new(Object *=
obj,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0char *propname =3D g_strdup_printf(&quot;%s[%d]&quot;, =
arrayname, index);<br>
=C2=A0 =C2=A0 =C2=A0ArrayElementProperty *arrayprop =3D g_new0(ArrayElement=
Property, 1);<br>
-=C2=A0 =C2=A0 arrayprop-&gt;release =3D array_len_prop-&gt;arrayinfo-&gt;r=
elease;<br>
=C2=A0 =C2=A0 =C2=A0arrayprop-&gt;propname =3D propname;<br>
=C2=A0 =C2=A0 =C2=A0arrayprop-&gt;<a href=3D"http://prop.info" rel=3D"noref=
errer" target=3D"_blank">prop.info</a> =3D array_len_prop-&gt;arrayinfo;<br=
>
=C2=A0 =C2=A0 =C2=A0arrayprop-&gt;<a href=3D"http://prop.name" rel=3D"noref=
errer" target=3D"_blank">prop.name</a> =3D propname;<br>
@@ -632,12 +631,12 @@ static void object_property_add_array_element(Object =
*obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Property *array_len_prop,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ArrayElementProperty *prop)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 object_property_add(obj, prop-&gt;<a href=3D"http://prop.nam=
e" rel=3D"noreferrer" target=3D"_blank">prop.name</a>,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 prop-&gt;prop.info-&gt;name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 static_prop_getter(prop-&gt;<a href=3D"http://prop.info" rel=3D"=
noreferrer" target=3D"_blank">prop.info</a>),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 static_prop_setter(prop-&gt;<a href=3D"http://prop.info" rel=3D"=
noreferrer" target=3D"_blank">prop.info</a>),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 array_element_release,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 prop);<br>
+=C2=A0 =C2=A0 ObjectProperty *op =3D object_property_add_static(obj, &amp;=
prop-&gt;prop);<br>
+<br>
+=C2=A0 =C2=A0 assert((void *)prop =3D=3D (void *)&amp;prop-&gt;prop);<br>
+=C2=A0 =C2=A0 prop-&gt;release =3D op-&gt;release;<br>
+=C2=A0 =C2=A0 /* array_element_release() will call the original release fu=
nction */<br>
+=C2=A0 =C2=A0 op-&gt;release =3D array_element_release;<br>
=C2=A0}<br>
<br>
=C2=A0static void set_prop_arraylen(Object *obj, Visitor *v, const char *na=
me,<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ae029705b2e1d1f4--

