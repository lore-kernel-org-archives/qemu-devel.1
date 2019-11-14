Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D8C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8497F2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzsCuUnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8497F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBrM-0000zr-Fy
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVBp6-0006de-7U
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVBp5-0000dD-0X
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:53:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iVBp3-0000b4-6t
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:53:53 -0500
Received: by mail-wr1-x442.google.com with SMTP id n1so5667157wra.10
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kbB2Y45L7oBiWC8ZUb/p54R4T/QBkMEEKASSdFhSGDw=;
 b=mzsCuUnXUIJSmBZ73EdiyGSk9op/LpgRtBjctY+05eM0rYKDNwz+L2RcbUfXOv40nQ
 1yKC8YizXq/bkE8O2setGpggEjpHyWILaQFcxq3QzZNMgvH3W2sVPEDoClFCR+PzRGja
 v6xtd1Uy32z5A0bwL7Q+N5kM8a3yCCat4C23onp9Mbij7upvH7g+JglCtBj4xd9D45Z5
 piAD1bbRDkeGtdnjPIFv9p6egeKgxM5s6sUFTLqCKnCa0FXEo/DBZl1Ewy4AXOimqkYv
 5z5ffEvKVxD6n23pO0hDR5sZAy/rw0M5Fk3rTsk6iDPVbAUvoyccSvKLcr54okh0bHsE
 etdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kbB2Y45L7oBiWC8ZUb/p54R4T/QBkMEEKASSdFhSGDw=;
 b=c4fVUixFXOvzgSlx0cFvHHjd6clFkFBghlMdmCIAgLwu7LZIEeVvKd9qTRfJdIIOws
 FufFtYNgkxLVX20qjeXkqxic+yqHFSnMAWNyK4hz/TVmuJBWQfMwlPjgvwE25iiXeNib
 Ky2Yyv0anKMpSCnnII+rvo84ElAWAV3r6w1n66p5ktuA/H17Zcndrn68fK/aQ21XqPeH
 hRE9y1qcvLVujMupmFsx2iQ1LO8pXya5KM58/gTVQXgwsiHe9rLgJl82pAYHvpcgkFcS
 s5QyUnH7SmeLO6YhbS+T6AZxbca/i4plccVHmHUnTrVLKSDd58z5Qwm3iFjiL/63/L9B
 NF1w==
X-Gm-Message-State: APjAAAUdXmN+bDGCAV+3Gy4nNR5zGIOCfZdBjVmsBZRT+svfIGQivY1U
 flMNtWtpDZ1L3HM+Nxppatum9N8Vk0A3do5tKwU=
X-Google-Smtp-Source: APXvYqwfhSQLmTp0w2ezzzrVD4hgwEuT4QngXbSekXg7vunog7cYZ6XP6MlpHEvuWPdv7DqQFdqeBhi+/f6CqJj2DXE=
X-Received: by 2002:a5d:670a:: with SMTP id o10mr7650456wru.312.1573725231402; 
 Thu, 14 Nov 2019 01:53:51 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573655945-14912-9-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2019 13:53:39 +0400
Message-ID: <CAJ+F1CLJhFZhu4RJOnwQ=RjJwP=U_xGU-15J0BO_3CEfys7aZg@mail.gmail.com>
Subject: Re: [PATCH 08/16] qom: introduce object_register_sugar_prop
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Hi

On Wed, Nov 13, 2019 at 6:46 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Similar to the existing "-rtc driftfix" option, we will convert some
> legacy "-machine" command line options to global properties on accelerato=
rs.
> Because accelerators are not devices, we cannot use qdev_prop_register_gl=
obal.
> Instead, provide a slot in the generic object_compat_props arrays for
> command line syntactic sugar.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

sounds reasonable

> ---
>  include/qom/object.h |  1 +
>  qom/object.c         | 23 +++++++++++++++++++++--
>  vl.c                 | 10 +++-------
>  3 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 128d00c..230b18f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -679,6 +679,7 @@ void object_apply_global_props(Object *obj, const GPt=
rArray *props,
>                                 Error **errp);
>  void object_set_machine_compat_props(GPtrArray *compat_props);
>  void object_set_accelerator_compat_props(GPtrArray *compat_props);
> +void object_register_sugar_prop(const char *driver, const char *prop, co=
nst char *value);

Or simply

void object_add_global_prop(const char *typename, ...) ?


>  void object_apply_compat_props(Object *obj);
>
>  /**
> diff --git a/qom/object.c b/qom/object.c
> index 6fa9c61..c7825dd 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -414,10 +414,29 @@ void object_apply_global_props(Object *obj, const G=
PtrArray *props, Error **errp
>   * Global property defaults
>   * Slot 0: accelerator's global property defaults
>   * Slot 1: machine's global property defaults
> + * Slot 2: global properties from legacy command line option
>   * Each is a GPtrArray of of GlobalProperty.
>   * Applied in order, later entries override earlier ones.
>   */
> -static GPtrArray *object_compat_props[2];
> +static GPtrArray *object_compat_props[3];
> +
> +/*
> + * Retrieve @GPtrArray for global property defined with options
> + * other than "-global".  These are generally used for syntactic
> + * sugar and legacy command line options.
> + */
> +void object_register_sugar_prop(const char *driver, const char *prop, co=
nst char *value)
> +{
> +    GlobalProperty *g;
> +    if (!object_compat_props[2]) {
> +        object_compat_props[2] =3D g_ptr_array_new();
> +    }
> +    g =3D g_new(GlobalProperty, 1);
> +    g->driver =3D g_strdup(driver);
> +    g->property =3D g_strdup(prop);
> +    g->value =3D g_strdup(value);
> +    g_ptr_array_add(object_compat_props[2], g);
> +}
>
>  /*
>   * Set machine's global property defaults to @compat_props.
> @@ -445,7 +464,7 @@ void object_apply_compat_props(Object *obj)
>
>      for (i =3D 0; i < ARRAY_SIZE(object_compat_props); i++) {
>          object_apply_global_props(obj, object_compat_props[i],
> -                                  &error_abort);
> +                                  i =3D=3D 2 ? &error_fatal : &error_abo=
rt);

Isn't error_abort() appropriate in all cases?


>      }
>  }
>
> diff --git a/vl.c b/vl.c
> index 843b263..cb993dd 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -896,13 +896,9 @@ static void configure_rtc(QemuOpts *opts)
>      value =3D qemu_opt_get(opts, "driftfix");
>      if (value) {
>          if (!strcmp(value, "slew")) {
> -            static GlobalProperty slew_lost_ticks =3D {
> -                .driver   =3D "mc146818rtc",
> -                .property =3D "lost_tick_policy",
> -                .value    =3D "slew",
> -            };
> -
> -            qdev_prop_register_global(&slew_lost_ticks);
> +            object_register_sugar_prop("mc146818rtc",
> +                                       "lost_tick_policy",
> +                                       "slew");

Why do you convert this since it's a device?

>          } else if (!strcmp(value, "none")) {
>              /* discard is default */
>          } else {
> --
> 1.8.3.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

