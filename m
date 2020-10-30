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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020FCC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539E520731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gczs0sKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539E520731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXt2-0003UW-5v
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXrX-0002Ms-3W
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:06:51 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXrV-00065U-2a
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:06:50 -0400
Received: by mail-ej1-x641.google.com with SMTP id o9so7503214ejg.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ageQKVMyXpw9lAwTpkp/Z7CU4TKfDOZ4BpnSRCl+0wA=;
 b=Gczs0sKU/+6F1DsaSN5/o13SPrFx8a7k60gcHcUn7nUp53m8dTJpFW9FeOaDdwFgUN
 xKubYwHANZaWbL0w2MoCx9c3SyiIZKHCl0OjbPeO+9OifhvXIOor7FMS/5T6zAGyn22/
 T/AEWzV7sJfRG29TAR1IIoL0xbp57+Mmr0pRR50LalJo6ruJphJ0B1qMcSPqltBVZmy0
 5WZy0T4+S23Z5d1gJbD44z25AAwhbnWvKJzyk6g783fStF6b+8cuVGjbARGFbu2J5Y60
 GnUB3nWWfp9cJrd6yhqnmm63K6I3/9BHAMS7/vYN4YNolda/bP9pEt9CEGZWrwtW8Z0F
 9H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ageQKVMyXpw9lAwTpkp/Z7CU4TKfDOZ4BpnSRCl+0wA=;
 b=R5U/b65vpGciKcosan2A8sVqF7yWdEVJIVnb0Zf0wUa7wRGpROb23tUbiiUkfXpzXr
 luOYWbp6SQ1UnwAtxDBm5yM9fgcToKx3wM8eZVcJn7S8wyqIeZdvFJunIzPNNoxPWnkj
 /a/YQzyoqaZcQmFysDKGn2+MaOPfCivAcoiMvUpj1KDzVIk3JC6mDsfcW4pt/4fU1loe
 EGFN+nwGq9J7Os0lWyNeizu/wvk2GlRQrP1vZ+dsmdo55wroRzN+SY+qYLMEv4TCOrMo
 bMEi/mxz/b9mCu4WDxTIyBmwBzx7t/7SoFknEiTACmu3n0+NHDYjSCg5pkPny7fElo4v
 3xdA==
X-Gm-Message-State: AOAM531P7iE8cJB1E7JqbXq+rWkBomQX3hOL1Ev6HIvfUWzHJ4dPpVGl
 2r+rB7V6ErIl8Td611nwBk+k44NdOYWQ7QOPD3k=
X-Google-Smtp-Source: ABdhPJy4zUlvxWVQ0Ax2b8p6ySbth0T9tlKbRKblQQDuAfl4aPCSBvxxJpqNdZbASI4azlbcks+V/T/Dh7g5W2JtEiw=
X-Received: by 2002:a17:906:2798:: with SMTP id
 j24mr3375976ejc.109.1604077607203; 
 Fri, 30 Oct 2020 10:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-32-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-32-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 21:06:34 +0400
Message-ID: <CAJ+F1C+-=hW0b0-kYKMftxOcz7BCr3bxEokj0LRWPqM5MCjj2w@mail.gmail.com>
Subject: Re: [PATCH 31/36] qdev: Stop using error_set_from_qdev_prop_error()
 for UUID property
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f83bca05b2e66b02"
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

--000000000000f83bca05b2e66b02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:22 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Just setting a reasonable error string using error_setg() is
> simpler and makes error messages clearer.
>
> Before:
>
>   $ qemu-system-x86_64 -device vmgenid,guid=3Dx
>   qemu-system-x86_64: -device vmgenid,guid=3Dx: Property 'vmgenid.guid'
> doesn't take value 'x'
>
> After:
>
>   $ qemu-system-x86_64 -device vmgenid,guid=3Dx
>   qemu-system-x86_64: -device vmgenid,guid=3Dx: invalid UUID: 'x'
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

It looks like we agree that error_set_from_qdev_prop_error() should
eventually be replaced :)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/core/qdev-properties.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 59d65a7362..5b9907e8ba 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -509,7 +509,7 @@ static void set_uuid(Object *obj, Visitor *v, const
> char *name, void *opaque,
>      if (!strcmp(str, UUID_VALUE_AUTO)) {
>          qemu_uuid_generate(uuid);
>      } else if (qemu_uuid_parse(str, uuid) < 0) {
> -        error_set_from_qdev_prop_error(errp, EINVAL, obj, prop, str);
> +        error_setg(errp, "invalid UUID: '%s'", str);
>      }
>      g_free(str);
>  }
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000f83bca05b2e66b02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:22 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ju=
st setting a reasonable error string using error_setg() is<br>
simpler and makes error messages clearer.<br>
<br>
Before:<br>
<br>
=C2=A0 $ qemu-system-x86_64 -device vmgenid,guid=3Dx<br>
=C2=A0 qemu-system-x86_64: -device vmgenid,guid=3Dx: Property &#39;vmgenid.=
guid&#39; doesn&#39;t take value &#39;x&#39;<br>
<br>
After:<br>
<br>
=C2=A0 $ qemu-system-x86_64 -device vmgenid,guid=3Dx<br>
=C2=A0 qemu-system-x86_64: -device vmgenid,guid=3Dx: invalid UUID: &#39;x&#=
39;<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>It looks like we agree that error_set_from_qdev_prop_error() should e=
ventually be replaced :)</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lur=
eau@redhat.com</a>&gt;</div><div> <br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
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
=C2=A0hw/core/qdev-properties.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 59d65a7362..5b9907e8ba 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -509,7 +509,7 @@ static void set_uuid(Object *obj, Visitor *v, const cha=
r *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0if (!strcmp(str, UUID_VALUE_AUTO)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(uuid);<br>
=C2=A0 =C2=A0 =C2=A0} else if (qemu_uuid_parse(str, uuid) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_set_from_qdev_prop_error(errp, EINVAL, o=
bj, prop, str);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;invalid UUID: &#39;%s&#=
39;&quot;, str);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_free(str);<br>
=C2=A0}<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000f83bca05b2e66b02--

