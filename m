Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE75AC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 08:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD182071B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 08:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG+R3ipH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD182071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVAQW-0005lE-RV
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 03:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVAPn-0005KT-KP
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVAPm-00042D-Ji
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:23:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iVAPm-000422-By
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:23:42 -0500
Received: by mail-wr1-x443.google.com with SMTP id a15so5356080wrf.9
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 00:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GNyxYXtilU5UDYiGiqnRu9UepTLxlAsq7L9c8hYd89I=;
 b=dG+R3ipH2hWcO3rodakJu9JmHC6DGVhrBfOCSOXhlb9ZMAPKOLkkk/JI/+jzga6BjC
 G+LBFVjPcIQsQFvYEVcHsAWz0GOoyMfefdBY7WsnCEqNIJSjQH+47R2pXR6sHlQRfWH/
 2jmvuAjkeKx3TvItphceQeq8pBxWmHwonD9fcWHpRWe95GZoRQ17lTUBCXRMrZerXUbW
 IcOtvvf63Fey0KhXdMvGeGq2OZ8FKRLTIFpyxPDtsexWHonQFaaLL91EVKSXGLDsFMbs
 AhSoxXFLizcxwpU9Y09gg82mwmuFuq4qCH2aKYwaQsu9aQrg89AV5tWO5U9lKSudEE0M
 TwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GNyxYXtilU5UDYiGiqnRu9UepTLxlAsq7L9c8hYd89I=;
 b=Djh4Kaij6xd5WHI+DYY9HxBZCOdw+cnNZWNRxIhIBVYcpWavmOHnI667yLY6h9SLEN
 8frRXpquW08M+iiuwxOYTeAFo1vbUTrcSaagcmC7E1iekcmh9RiOcvF6Z78xwvbz39+m
 emqvtPqXF96VUXR6xAQByCVuHeUNbMUrqR02DPLOqgMep4cZT5YyL40V3XqOI7XGNvPz
 JyMDunwTKypWA/J34Axwf1+tsA6m9MXiH1zXr2Ncr9Ves0f2XufMpM2kFZRYcBrQ1cku
 qkcg81h86m43P7LNBYAAM947nGG+pCY0xq65RvdkPg3ewrdlbJTHYwREhxGnQQ9n5Fgm
 vbNQ==
X-Gm-Message-State: APjAAAVO17geNz1uW/25J9Zz03GBoyriWp34Egb/kV9IJRqqn5EEcvJy
 PTd3dPAGYIrru4o4lmijBzBVG9IYcI3xAuoeKkQ=
X-Google-Smtp-Source: APXvYqzCGGG9XWmkSJDyHfHpeS4rAdn1EPjamW3AfqDys65yql2UVnfqz8RyDM+o64FfDq7QbOiafwHzKQO6c7anIqI=
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr6893192wrc.202.1573719821140; 
 Thu, 14 Nov 2019 00:23:41 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573655945-14912-6-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2019 12:23:28 +0400
Message-ID: <CAJ+F1CL=m8WfLW2vJ73UTGNpbXBdww7zEtRGt+ri+TjoPd4auA@mail.gmail.com>
Subject: Re: [PATCH 05/16] vl: introduce object_parse_property_opt
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 6:42 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> We will reuse the parsing loop of machine_set_property soon for "-accel",
> but we do not want the "_" -> "-" conversion since "-accel" can just
> standardize on dashes.  We will also add a bunch of legacy option handlin=
g
> to keep the QOM machine object clean.  Extract the loop into a separate
> function, and keep the legacy handling in machine_set_property.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  vl.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index dbc99d7..b93217d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2617,27 +2617,17 @@ static MachineClass *select_machine(void)
>      return machine_class;
>  }
>
> -static int machine_set_property(void *opaque,
> -                                const char *name, const char *value,
> -                                Error **errp)
> +static int object_parse_property_opt(Object *obj,
> +                                     const char *name, const char *value=
,
> +                                     const char *skip, Error **errp)
>  {
> -    Object *obj =3D OBJECT(opaque);
>      Error *local_err =3D NULL;
> -    char *p, *qom_name;
>
> -    if (strcmp(name, "type") =3D=3D 0) {
> +    if (g_str_equal(name, skip)) {
>          return 0;
>      }
>
> -    qom_name =3D g_strdup(name);
> -    for (p =3D qom_name; *p; p++) {
> -        if (*p =3D=3D '_') {
> -            *p =3D '-';
> -        }
> -    }
> -
> -    object_property_parse(obj, value, qom_name, &local_err);
> -    g_free(qom_name);
> +    object_property_parse(obj, value, name, &local_err);
>
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -2647,6 +2637,24 @@ static int machine_set_property(void *opaque,
>      return 0;
>  }
>
> +static int machine_set_property(void *opaque,
> +                                const char *name, const char *value,
> +                                Error **errp)
> +{
> +    char *qom_name =3D g_strdup(name);

Could use g_autofree, and thus return directly without r.



> +    char *p;
> +    int r;
> +
> +    for (p =3D qom_name; *p; p++) {
> +        if (*p =3D=3D '_') {
> +            *p =3D '-';
> +        }
> +    }
> +
> +    r =3D object_parse_property_opt(opaque, name, value, "type", errp);

You want to pass qom_name, I guess

> +    g_free(qom_name);
> +    return r;
> +}
>
>  /*
>   * Initial object creation happens before all other
> --
> 1.8.3.1
>
>
>


--
Marc-Andr=C3=A9 Lureau

