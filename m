Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380F0C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 07:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CC220720
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 07:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+MSTE8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CC220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYliP-0005os-91
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 03:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYlhp-0005PQ-4w
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 03:53:45 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYlhn-0001aG-A2
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 03:53:44 -0400
Received: by mail-ej1-x641.google.com with SMTP id dk16so11114770ejb.12
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mxWcMmptaBm5kkdd1jeaWenpyWrK/Bce5pRfvPHwEhI=;
 b=P+MSTE8fUVnTt/NPMSnkMg/KZbBU9DSP+vJHbmTd2tGojnQ1cMl0Se44plOzXb1x8x
 pL3f5aJAakC/prCECGuwaq4Hm2xLNwTbPnbS2Xtpl8Xxlm+x22XjHte/b1BfhSoRrSeP
 6NJd7bmUHpv3FZ4aOJeZ/XDXcj+X24f3xyJzgZdqgM8LX5HjbmRDPL8qL9y21hTaEj6v
 Rf9tc2HuLarpbgcOFGBLtmv2ITiJygqvWOvp39H4kNOSDEdBRffDjvUsGiHtqXGJ2kcQ
 1yayNqOBgPvXhlztj6NpYPKVRUIbIz/xbAccH40ftyK3zu2c1BvsCkO5+crhKhNU6OYG
 vemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mxWcMmptaBm5kkdd1jeaWenpyWrK/Bce5pRfvPHwEhI=;
 b=Mh97ZR78isufo1ErW0bPPburYH9GEPTjl+WRr9paK/TEk1zJWgdFl16TOnr9qSmp9f
 AOEvpgN2F+04GVriSH/kXkZS7VGlrWgQcv8BxKsYR6tVL/VLNRcWs11KKZ+l6uWMwZpY
 uRLtrx78gzily62MixzlhFnDhttqmnbJCVANo3qDmGX3BrJMFYqxyq+jBrcVnFihmX1u
 veWzjkYLNzBHIuNioSVmeV+R9+c/U36qjlLvzG0YhMbmvEFoF7GUC8l7PhKAt+c4SS29
 ZsKWt61uoxNTRs+y/tQqXG6KZgVq6NPHqGfBlcTL/hTw50Nfpm+Mp+YxL/KhM+rEakbo
 Sujg==
X-Gm-Message-State: AOAM530CbP44Zy5k734vU6bT4+twPeylQnbiLDSHl3K494tO2eFGrheE
 i6FS8aRi0X6d2x1D/EZhRwAmad1y94IeUDxqvEM=
X-Google-Smtp-Source: ABdhPJwyPFA0TtP4cnZFqItAvThxBRtJeb0dCUTwf2jYvI/dk2CVypMHgvO0x32EVGKZ07p7c2i/Unvp/0ULreqLKpU=
X-Received: by 2002:a17:906:1a11:: with SMTP id
 i17mr6036856ejf.381.1604130821223; 
 Sat, 31 Oct 2020 00:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-34-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-34-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 31 Oct 2020 11:53:29 +0400
Message-ID: <CAJ+F1C+tiTOnb4sWiHN-777xP9kKD3ji1PeFyHxGpHKrGAZADw@mail.gmail.com>
Subject: Re: [PATCH 33/36] tests: Use static properties at check-qom-proplist
 test case
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c5bbfc05b2f2cfb5"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x641.google.com
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

--000000000000c5bbfc05b2f2cfb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:28 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Use static properties for the bool and string properties used at
> check-qom-proplist.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  tests/check-qom-proplist.c | 61 +++++---------------------------------
>  1 file changed, 8 insertions(+), 53 deletions(-)
>
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 1b76581980..94ad6631c0 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -26,6 +26,8 @@
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qom/object_interfaces.h"
> +#include "qom/static-property.h"
> +#include "qom/static-property-internal.h"
>

>
>  #define TYPE_DUMMY "qemu-dummy"
> @@ -68,24 +70,6 @@ struct DummyObjectClass {
>  };
>
>
> -static void dummy_set_bv(Object *obj,
> -                         bool value,
> -                         Error **errp)
> -{
> -    DummyObject *dobj =3D DUMMY_OBJECT(obj);
> -
> -    dobj->bv =3D value;
> -}
> -
> -static bool dummy_get_bv(Object *obj,
> -                         Error **errp)
> -{
> -    DummyObject *dobj =3D DUMMY_OBJECT(obj);
> -
> -    return dobj->bv;
> -}
> -
> -
>  static void dummy_set_av(Object *obj,
>                           int value,
>                           Error **errp)
> @@ -103,39 +87,20 @@ static int dummy_get_av(Object *obj,
>      return dobj->av;
>  }
>
> +static Property bv_prop =3D
> +    DEFINE_PROP_BOOL("bv", DummyObject, bv, false);
>
> -static void dummy_set_sv(Object *obj,
> -                         const char *value,
> -                         Error **errp)
> -{
> -    DummyObject *dobj =3D DUMMY_OBJECT(obj);
> -
> -    g_free(dobj->sv);
> -    dobj->sv =3D g_strdup(value);
> -}
> -
> -static char *dummy_get_sv(Object *obj,
> -                          Error **errp)
> -{
> -    DummyObject *dobj =3D DUMMY_OBJECT(obj);
> -
> -    return g_strdup(dobj->sv);
> -}
> -
> +static Property sv_prop =3D
> +    DEFINE_PROP_STRING("sv", DummyObject, sv);
>
>  static void dummy_init(Object *obj)
>  {
> -    object_property_add_bool(obj, "bv",
> -                             dummy_get_bv,
> -                             dummy_set_bv);
> +    object_property_add_static(obj, &bv_prop, NULL);
>

Ok for testing internal functions.. hopefully it won't serve as an example!

 }
>
> -
>  static void dummy_class_init(ObjectClass *cls, void *data)
>  {
> -    object_class_property_add_str(cls, "sv",
> -                                  dummy_get_sv,
> -                                  dummy_set_sv);
> +    object_class_property_add_static(cls, &sv_prop, NULL);
>      object_class_property_add_enum(cls, "av",
>                                     "DummyAnimal",
>                                     &dummy_animal_map,
> @@ -143,21 +108,11 @@ static void dummy_class_init(ObjectClass *cls, void
> *data)
>                                     dummy_set_av);
>  }
>
> -
> -static void dummy_finalize(Object *obj)
> -{
> -    DummyObject *dobj =3D DUMMY_OBJECT(obj);
> -
> -    g_free(dobj->sv);
> -}
> -
> -
>  static const TypeInfo dummy_info =3D {
>      .name          =3D TYPE_DUMMY,
>      .parent        =3D TYPE_OBJECT,
>      .instance_size =3D sizeof(DummyObject),
>      .instance_init =3D dummy_init,
> -    .instance_finalize =3D dummy_finalize,
>      .class_size =3D sizeof(DummyObjectClass),
>      .class_init =3D dummy_class_init,
>      .interfaces =3D (InterfaceInfo[]) {
> --
> 2.28.0
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c5bbfc05b2f2cfb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:28 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Us=
e static properties for the bool and string properties used at<br>
check-qom-proplist.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br>
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
=C2=A0tests/check-qom-proplist.c | 61 +++++--------------------------------=
-<br>
=C2=A01 file changed, 8 insertions(+), 53 deletions(-)<br>
<br>
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c<br>
index 1b76581980..94ad6631c0 100644<br>
--- a/tests/check-qom-proplist.c<br>
+++ b/tests/check-qom-proplist.c<br>
@@ -26,6 +26,8 @@<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
=C2=A0#include &quot;qemu/config-file.h&quot;<br>
=C2=A0#include &quot;qom/object_interfaces.h&quot;<br>
+#include &quot;qom/static-property.h&quot;<br>
+#include &quot;qom/static-property-internal.h&quot; <br></blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
=C2=A0#define TYPE_DUMMY &quot;qemu-dummy&quot;<br>
@@ -68,24 +70,6 @@ struct DummyObjectClass {<br>
=C2=A0};<br>
<br>
<br>
-static void dummy_set_bv(Object *obj,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool value,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 DummyObject *dobj =3D DUMMY_OBJECT(obj);<br>
-<br>
-=C2=A0 =C2=A0 dobj-&gt;bv =3D value;<br>
-}<br>
-<br>
-static bool dummy_get_bv(Object *obj,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 DummyObject *dobj =3D DUMMY_OBJECT(obj);<br>
-<br>
-=C2=A0 =C2=A0 return dobj-&gt;bv;<br>
-}<br>
-<br>
-<br>
=C2=A0static void dummy_set_av(Object *obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
@@ -103,39 +87,20 @@ static int dummy_get_av(Object *obj,<br>
=C2=A0 =C2=A0 =C2=A0return dobj-&gt;av;<br>
=C2=A0}<br>
<br>
+static Property bv_prop =3D<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;bv&quot;, DummyObject, bv, false);<br=
>
<br>
-static void dummy_set_sv(Object *obj,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *value,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 DummyObject *dobj =3D DUMMY_OBJECT(obj);<br>
-<br>
-=C2=A0 =C2=A0 g_free(dobj-&gt;sv);<br>
-=C2=A0 =C2=A0 dobj-&gt;sv =3D g_strdup(value);<br>
-}<br>
-<br>
-static char *dummy_get_sv(Object *obj,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 DummyObject *dobj =3D DUMMY_OBJECT(obj);<br>
-<br>
-=C2=A0 =C2=A0 return g_strdup(dobj-&gt;sv);<br>
-}<br>
-<br>
+static Property sv_prop =3D<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;sv&quot;, DummyObject, sv);<br>
<br>
=C2=A0static void dummy_init(Object *obj)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 object_property_add_bool(obj, &quot;bv&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dummy_get_bv,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dummy_set_bv);<br>
+=C2=A0 =C2=A0 object_property_add_static(obj, &amp;bv_prop, NULL);<br></bl=
ockquote></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quo=
te">Ok for testing internal functions.. hopefully it won&#39;t serve as an =
example!<br></div><div class=3D"gmail_quote"><div> <br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
=C2=A0}<br>
<br>
-<br>
=C2=A0static void dummy_class_init(ObjectClass *cls, void *data)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 object_class_property_add_str(cls, &quot;sv&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dummy_get_sv,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dummy_set_sv);<br>
+=C2=A0 =C2=A0 object_class_property_add_static(cls, &amp;sv_prop, NULL);<b=
r>
=C2=A0 =C2=A0 =C2=A0object_class_property_add_enum(cls, &quot;av&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;DummyAnimal&quot=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;dummy_animal_map,=
<br>
@@ -143,21 +108,11 @@ static void dummy_class_init(ObjectClass *cls, void *=
data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dummy_set_av);<br>
=C2=A0}<br>
<br>
-<br>
-static void dummy_finalize(Object *obj)<br>
-{<br>
-=C2=A0 =C2=A0 DummyObject *dobj =3D DUMMY_OBJECT(obj);<br>
-<br>
-=C2=A0 =C2=A0 g_free(dobj-&gt;sv);<br>
-}<br>
-<br>
-<br>
=C2=A0static const TypeInfo dummy_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_DUMMY,=
<br>
=C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_OBJECT,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(DummyObject),<br>
=C2=A0 =C2=A0 =C2=A0.instance_init =3D dummy_init,<br>
-=C2=A0 =C2=A0 .instance_finalize =3D dummy_finalize,<br>
=C2=A0 =C2=A0 =C2=A0.class_size =3D sizeof(DummyObjectClass),<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D dummy_class_init,<br>
=C2=A0 =C2=A0 =C2=A0.interfaces =3D (InterfaceInfo[]) {<br>
-- <br>
2.28.0<br></blockquote><div>=C2=A0</div></div>Reviewed-by: Marc-Andr=C3=A9 =
Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@=
redhat.com</a>&gt;<br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gm=
ail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000c5bbfc05b2f2cfb5--

