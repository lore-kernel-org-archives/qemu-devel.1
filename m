Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45612C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3292072D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="hpjoMlaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3292072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRz1L-0007MT-O9
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kRyyH-0004AP-4j
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:38:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kRyyF-0007jw-0E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:38:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so19461908wrq.11
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uh722lOc2TCn76d8vhcWo55yMvXj9LJXaV9AngubfsQ=;
 b=hpjoMlaT/otgzcc7v6O2OmQvY95MFvbIysWbad+v3gUlgL3iSmG8yRBvWqYS3D2YYb
 w+7NrEhx7lrE/zKIn8ZLHiiDR6+esb/NZuk2YrroazzpfZpsMQGIqSNn85PsblqzsVbz
 E4aVk9n9Ny+cMycSUBbU67KLp671ijUnVseVtP69uBhsZ128UYlm+aL4WuQnak4FFBUM
 G1q6SJKVrz9Z2YLf0R51KOqiLJ8jY8rZbPDoRRFFhg5tRodgUOuXBkG3Tws0V7FSUHxD
 VCZ075x5jOeVrJxQN+smGv0jPxpMkwP6lnA3NDdpXfRJoCqGOBAdTH4Ndonp7d9kYcBg
 U0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uh722lOc2TCn76d8vhcWo55yMvXj9LJXaV9AngubfsQ=;
 b=LRqwA5FYMMBfDRcibBtQuVg0I/wrOm2Q6ojeWjFmzkMOE0fjm0r21zKy395/M9UTmZ
 /O1HlDZ9jMXYgstUQhQwwdO8nMXEqtb+Dg+GbsjGfbHJg8mwAsez0uFwTx3JX5/RKtYN
 IVAcaa2dyAnT+ACeStNvUJSZhMqzyWu2qdltPqIcuUTVS91DswPgCWe64C3T6kCN4Jl/
 S6MJp0feFWVoPMeAOeuw8gPITrX9cIUV3Rsir5+CVLVzqcp6y2h2dhxrmDdS7kHIbEiz
 4c8QTbEfnxsEA2ZRiXE7d6YskPX/5GBtFDzDUpAtYFP0krvYOL0b7gFlvqJAuKSm9ia6
 T56g==
X-Gm-Message-State: AOAM532jNnxg9NiPAbTXMWxIIQqKY+Xjw3+ZnhmEp6aocRitWMikkYVA
 JffLIS8yJ74bWrZRNfV/tp0vUq7/+6tsEiuXj1dqEni9xJUpAg==
X-Google-Smtp-Source: ABdhPJwqCz4awO4f5PnsXXcNSGIT0RAlzgQWLBVePJ4gnRuJprhGL18jN7uRLwZSV7quPoQeifi339CqQEwtIpLeEpM=
X-Received: by 2002:adf:de89:: with SMTP id w9mr7445226wrl.212.1602513516272; 
 Mon, 12 Oct 2020 07:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200921093325.25617-1-ani@anisinha.ca>
In-Reply-To: <20200921093325.25617-1-ani@anisinha.ca>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 12 Oct 2020 20:08:25 +0530
Message-ID: <CAARzgwz34NDJV40PpEcxCwptJdOfU0u=k5fpZ8JX60Q4_LS7Sg@mail.gmail.com>
Subject: Re: [PATCH v3] qom: code hardening - have bound checking while
 looping with integer value
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e2af8c05b17a4014"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e2af8c05b17a4014
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Request to queue this patch for the next pull.

On Mon, Sep 21, 2020 at 15:03 Ani Sinha <ani@anisinha.ca> wrote:

> Object property insertion code iterates over an integer to get an unused
> index that can be used as an unique name for an object property. This loo=
p
> increments the integer value indefinitely. Although very unlikely, this c=
an
> still cause an integer overflow.
> In this change, we fix the above code by checking against INT16_MAX and
> making
> sure that the interger index does not overflow beyond that value. If no
> available index is found, the code would cause an assertion failure. This
> assertion failure is necessary because the callers of the function do not
> check
> the return value for NULL.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qom/object.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> changelog:
> v1: initial version
> v2: change INT_MAX to INT16_MAX in code
> v3: make the same change in commit log. Sorry for missing it.
>
> diff --git a/qom/object.c b/qom/object.c
> index 387efb25eb..9962874598 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1166,11 +1166,11 @@ object_property_try_add(Object *obj, const char
> *name, const char *type,
>
>      if (name_len >=3D 3 && !memcmp(name + name_len - 3, "[*]", 4)) {
>          int i;
> -        ObjectProperty *ret;
> +        ObjectProperty *ret =3D NULL;
>          char *name_no_array =3D g_strdup(name);
>
>          name_no_array[name_len - 3] =3D '\0';
> -        for (i =3D 0; ; ++i) {
> +        for (i =3D 0; i < INT16_MAX; ++i) {
>              char *full_name =3D g_strdup_printf("%s[%d]", name_no_array,=
 i);
>
>              ret =3D object_property_try_add(obj, full_name, type, get, s=
et,
> @@ -1181,6 +1181,7 @@ object_property_try_add(Object *obj, const char
> *name, const char *type,
>              }
>          }
>          g_free(name_no_array);
> +        assert(ret);
>          return ret;
>      }
>
> --
> 2.17.1
>
>

--000000000000e2af8c05b17a4014
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Request to queue this patch for the next pull.</div><div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Sep 21, 2020 at 15:03 Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca">an=
i@anisinha.ca</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;padding-left:1ex;border-left-color:rgb(204,204,204)">Object property inse=
rtion code iterates over an integer to get an unused<br>
index that can be used as an unique name for an object property. This loop<=
br>
increments the integer value indefinitely. Although very unlikely, this can=
<br>
still cause an integer overflow.<br>
In this change, we fix the above code by checking against INT16_MAX and mak=
ing<br>
sure that the interger index does not overflow beyond that value. If no<br>
available index is found, the code would cause an assertion failure. This<b=
r>
assertion failure is necessary because the callers of the function do not c=
heck<br>
the return value for NULL.<br>
<br>
Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" target=3D"_=
blank">ani@anisinha.ca</a>&gt;<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qom/object.c | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
changelog:<br>
v1: initial version<br>
v2: change INT_MAX to INT16_MAX in code<br>
v3: make the same change in commit log. Sorry for missing it.<br>
<br>
diff --git a/qom/object.c b/qom/object.c<br>
index 387efb25eb..9962874598 100644<br>
--- a/qom/object.c<br>
+++ b/qom/object.c<br>
@@ -1166,11 +1166,11 @@ object_property_try_add(Object *obj, const char *na=
me, const char *type,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (name_len &gt;=3D 3 &amp;&amp; !memcmp(name + name_l=
en - 3, &quot;[*]&quot;, 4)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ObjectProperty *ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ObjectProperty *ret =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *name_no_array =3D g_strdup(name);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name_no_array[name_len - 3] =3D &#39;\0&#=
39;;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; ; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; INT16_MAX; ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *full_name =3D g_strdu=
p_printf(&quot;%s[%d]&quot;, name_no_array, i);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D object_property_try=
_add(obj, full_name, type, get, set,<br>
@@ -1181,6 +1181,7 @@ object_property_try_add(Object *obj, const char *name=
, const char *type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(name_no_array);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div></div>

--000000000000e2af8c05b17a4014--

