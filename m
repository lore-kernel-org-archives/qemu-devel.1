Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBBC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8698F2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCIlIbwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8698F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieela-0004SP-K3
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 07:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ieekw-000434-5F
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ieekt-0006Sj-Uz
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:36:46 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ieekt-0006PU-OP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:36:43 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so19789811wrl.13
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 04:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gAfZ0HqdKQx2gkWX6YIiiAzgEs6wRB7F/m+vAiGTvBo=;
 b=DCIlIbwp/Dbw+RhkOSzlYY7Bdi26r8AVLCfYdHqtyCC4+tfB44NLak4U/TF+6w23u8
 k0skol+W458Ys+lQKjJcbTc0b8UP3Prhpm+014v8+XOPd6mnzxRfND07vVZd1B149Ijm
 S0ZBwIZWxZLqQ0RT3Zdrc1Zw7Bg1FL76x5lmn7KBn0NGTZQ0XludC20LdUDVMoITD8i5
 MgK6fCVx1/53V0uQ/SrHqfwBiEAtlkBQFw0v79BbzG6Z2ipTzzyRjednqlk6WXKVihVl
 fWUP38XmeZtdFzpn5zjuhLFgz3u1dsli3T/zvfCFrWdQR0xwf9B2HDbJQTLerN6SdkxZ
 392g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gAfZ0HqdKQx2gkWX6YIiiAzgEs6wRB7F/m+vAiGTvBo=;
 b=Bn/xeVFEka0g/E3MVB/jRZs6+VA5tBFQA6xxvM7wxj40oXYnhIVMc0HeJebtTUyQ3p
 LfrKft/wCgslGU7letyfSFmT+HoMhgNUtk529AgGCjN/QkT6X9NbnCcghVv67gR7IX8o
 IdEabeMAzp2MfmiqbcJA9CVQLynp69x1W0XNL5GUEb4EzUH8RIPIu9sY/lNgYKVqAQWg
 l0kmvrmrYjoAoAD/OuBZifgIkJvSrXXI52E5oGchIrSFAiUXvtKFXzBT4V1y9F4BpWzk
 ajaZR3wJ1yP7lb58vn0b0/ezChIEwjKJ/Ps/gRuVh9lmvngwH7qixRLIoJDFSsRpB+nt
 B/8A==
X-Gm-Message-State: APjAAAV+eHNMLwAYVgNdZhadrC64Va3mHIGZvaogVrDOaIaLyaq5G6dD
 HIXUOVgTGlwps0lBc61FOEcFiRAcaHyHNRjEyaY=
X-Google-Smtp-Source: APXvYqyG5LJEJ6m7xFT5WEY6fPmt9sR524LNN/hrwXhOA0vI678cqPp0HOh2DTgGdO+1byUNDQ+Q00MHn6FVNTOIyzk=
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr3021719wrq.396.1575981402067; 
 Tue, 10 Dec 2019 04:36:42 -0800 (PST)
MIME-Version: 1.0
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1575903705-12925-11-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Dec 2019 16:36:29 +0400
Message-ID: <CAJ+F1C+Qx+B9h0fz=FvoZ438Z3S2N57idhN+y2TeXorAuXvQDA@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] qom: introduce object_register_sugar_prop
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
 elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Dec 9, 2019 at 7:10 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
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
>  void object_apply_compat_props(Object *obj);
>
>  /**
> diff --git a/qom/object.c b/qom/object.c
> index d51b57f..bfb4413 100644
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
>      }
>  }
>
> diff --git a/vl.c b/vl.c
> index 58aad4f..d6c77bc 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -897,13 +897,9 @@ static void configure_rtc(QemuOpts *opts)
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
>          } else if (!strcmp(value, "none")) {
>              /* discard is default */
>          } else {
> --
> 1.8.3.1
>
>
>


I am not too happy about the change, but the "global properties"
handling is an area that can be improved later.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

