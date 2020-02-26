Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA8AC4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E4B24684
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E4B24684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vsJ-0005pp-6n
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j6vnK-0007na-RW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j6vnE-0007Th-Uc
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:28:06 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j6vnC-00075r-0e; Wed, 26 Feb 2020 07:27:58 -0500
Received: by mail-yw1-f65.google.com with SMTP id h6so167628ywc.8;
 Wed, 26 Feb 2020 04:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zXiBwlFgIMdrvUdeU+34KHi9Vw3Mcx+YL09TYworXoE=;
 b=ow2G4LRfwt+hd6wAJPTdxi751UPCEzmbmdmMNGin1d4r8rzdc2Zyyl9AUMwBSDjcFR
 9YcPrCcEi+wEMMFgPT2IfLjnnEfH7ERqeOIUlMH93PkJVhbNA67ZbqNvdrtKvuH1Y6Sk
 qDWq05iKkKOOHSWREzEh6+/4a1HB4h2RPR4nM/txCoZUEIFg867V+ornGTVLBICdOmU8
 coss8Qd01Yvw5rSOxTIde+aaPBvYL041h/DxdtH8WOLkZ9b40UrxgxEjYUUp5EXVO5rx
 OhHpwETsPSSgg4F0SzqVdlIzqH25NvXQ/+sHQqk8NcQ6cp/s2A+HU7ZKxkp13ZCmaP9C
 +V9g==
X-Gm-Message-State: APjAAAW+lUlmieuBk12e/SEj2y1XfVex+l1hscQS1sviDlWsMzgYR8cs
 bzX9FhR9RR6h+cKSVwnoQ17ifKo2LernnQiAPGI=
X-Google-Smtp-Source: APXvYqz3W1RispGXdoXDFeIO25cige6S8PSd9tmPRFO4FmAqcnFqpanaAwFYQ87+wgoYcqksP4zaF8lM3dO1t/5u+KQ=
X-Received: by 2002:a81:8443:: with SMTP id u64mr3323124ywf.443.1582720076891; 
 Wed, 26 Feb 2020 04:27:56 -0800 (PST)
MIME-Version: 1.0
References: <158271897341.44994.2741557659975232894.stgit@lep8c.aus.stglabs.ibm.com>
In-Reply-To: <158271897341.44994.2741557659975232894.stgit@lep8c.aus.stglabs.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Feb 2020 13:27:45 +0100
Message-ID: <CAAdtpL5gYr9ZRhSdqfhKMVQ41BUUZqYbbFGyMLTPaROfazW8cA@mail.gmail.com>
Subject: Re: [PATCH] spapr: Fix Coverity warning while validating nvdimm
 options
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000f6497d059f79bb9b"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.65
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
 "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f6497d059f79bb9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 26 f=C3=A9vr. 2020 13:11, Shivaprasad G Bhat <sbhat@linux.ibm.com> =
a
=C3=A9crit :

> Fixes Coverity issue,
>       CID 1419883:  Error handling issues  (CHECKED_RETURN)
>            Calling "qemu_uuid_parse" without checking return value
>
> nvdimm_set_uuid() already verifies if the user provided uuid is valid or
> not. So, need to check for the validity during pre-plug validation again.
>
> As this a false positive in this case, assert if not valid to be safe.
>
> Reported-by: Coverity (CID 1419883)
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/ppc/spapr_nvdimm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 74eeb8bb74..051727536e 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -44,7 +44,7 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm,
> uint64_t size,
>      }
>
>      uuidstr =3D object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP=
,
> NULL);
> -    qemu_uuid_parse(uuidstr, &uuid);
> +    g_assert(qemu_uuid_parse(uuidstr, &uuid) =3D=3D 0);
>

From https://developer.gnome.org/glib/stable/glib-Testing.html#g-assert

The macro can be turned off in final releases of code by defining
G_DISABLE_ASSERT when compiling the application, so code must not depend on
any side effects from expr.

This looks like bad pattern example.

     g_free(uuidstr);
>
>      if (qemu_uuid_is_null(&uuid)) {
>
>
>

--000000000000f6497d059f79bb9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le mer. 26 f=C3=A9vr. 2020 13:11, Shivaprasad G Bhat &lt;<a hr=
ef=3D"mailto:sbhat@linux.ibm.com" target=3D"_blank" rel=3D"noreferrer">sbha=
t@linux.ibm.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Fixes Coverity issue,<br>
=C2=A0 =C2=A0 =C2=A0 CID 1419883:=C2=A0 Error handling issues=C2=A0 (CHECKE=
D_RETURN)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Calling &quot;qemu_uuid_parse&quot=
; without checking return value<br>
<br>
nvdimm_set_uuid() already verifies if the user provided uuid is valid or<br=
>
not. So, need to check for the validity during pre-plug validation again.<b=
r>
<br>
As this a false positive in this case, assert if not valid to be safe.<br>
<br>
Reported-by: Coverity (CID 1419883)<br>
Signed-off-by: Shivaprasad G Bhat &lt;<a href=3D"mailto:sbhat@linux.ibm.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">sbhat@linux.ibm.com</a>&g=
t;<br>
---<br>
=C2=A0hw/ppc/spapr_nvdimm.c |=C2=A0 =C2=A0 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c<br>
index 74eeb8bb74..051727536e 100644<br>
--- a/hw/ppc/spapr_nvdimm.c<br>
+++ b/hw/ppc/spapr_nvdimm.c<br>
@@ -44,7 +44,7 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uin=
t64_t size,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0uuidstr =3D object_property_get_str(OBJECT(nvdimm), NVD=
IMM_UUID_PROP, NULL);<br>
-=C2=A0 =C2=A0 qemu_uuid_parse(uuidstr, &amp;uuid);<br>
+=C2=A0 =C2=A0 g_assert(qemu_uuid_parse(uuidstr, &amp;uuid) =3D=3D 0);<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">From =
<a href=3D"https://developer.gnome.org/glib/stable/glib-Testing.html#g-asse=
rt" target=3D"_blank" rel=3D"noreferrer">https://developer.gnome.org/glib/s=
table/glib-Testing.html#g-assert</a><br></div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><span style=3D"color:rgb(85,85,85);font-family:cantarell,&=
#39;droid sans&#39;,ubuntu,&#39;dejavu sans&#39;,arial,sans-serif;font-size=
:14px;background-color:rgb(255,255,255)">The macro can be turned off in fin=
al releases of code by defining=C2=A0</span><code style=3D"margin:0px;paddi=
ng:1px;border:0px;font-size:14px;vertical-align:baseline;color:rgb(85,85,85=
);background:rgba(0,0,0,0.0980392)">G_DISABLE_ASSERT</code><span style=3D"c=
olor:rgb(85,85,85);font-family:cantarell,&#39;droid sans&#39;,ubuntu,&#39;d=
ejavu sans&#39;,arial,sans-serif;font-size:14px;background-color:rgb(255,25=
5,255)">=C2=A0when compiling the application, so code must not depend on an=
y side effects from expr.</span><br></div><div dir=3D"auto"><span style=3D"=
color:rgb(85,85,85);font-family:cantarell,&#39;droid sans&#39;,ubuntu,&#39;=
dejavu sans&#39;,arial,sans-serif;font-size:14px;background-color:rgb(255,2=
55,255)"><br></span></div><div dir=3D"auto">This looks like bad pattern exa=
mple.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0g_free(uuidstr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (qemu_uuid_is_null(&amp;uuid)) {<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000f6497d059f79bb9b--

