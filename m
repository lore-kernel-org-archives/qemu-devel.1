Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C406C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FCE206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr395fGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FCE206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVC15-0002Ix-8c
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVBs0-0002A7-Ej
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVBrz-0002y8-56
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:56:56 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iVBry-0002xX-V2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:56:55 -0500
Received: by mail-wm1-x343.google.com with SMTP id q70so4969041wme.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=W5W9c4wZh6+Bl+2TUc+NRe/Ljh59M/04katqaQTo5YY=;
 b=Dr395fGX4Ynvi/fj1HvvOh3sCQ491PEsFvThZbwQ+AzJj6uJwOdAvY95tRV7woSY5j
 1dhCaSZNwkceJDoGOoRmGVkuF4Yx51xzTqXFUbTaNsDhXA7tGWJ5UnEEAFZlEOwajfxQ
 Lnrc1dgphlVsm0/llHYZGw7qFAAXmpJTdMVfk4tyJOV5B6hN/aMdfflAarKFTC05cas9
 Yyad33BIYQVRoa2Pdl83bzlqITgn2Wq8uV3hv1lmQLJ0GjNggNnQPuQMXUm9Ebn/VovY
 zmnPAlHIpJKkixNhjKPQbum949C5WcGvXd6FVTVQOugq6hA0QtPNDP2D6BoatNrqQ+3J
 EK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=W5W9c4wZh6+Bl+2TUc+NRe/Ljh59M/04katqaQTo5YY=;
 b=CXiaidid35un6siv98iIJ7XwVP85hJEYZi+shVxPNWpiB2GXffW/yO13BXHH/uSjfe
 A51E8tBKAhXr1QTF7IcDHHF7w0XgWOsEh9OtoU3X9T53l7WWZMd6ObWYo+tAJGYSE19Q
 jP7ZosBmJ4cgYy9h1etJZj8Q0lw7at7O2nvIV/qiVb88p6/fb85uP3QPL+CPWIXhF48b
 C9kOPdyN6J30C5biF4unOEkBlpjVKqXwefbj1ufpE/IMhVTpWKB1TKjI5GeDZFgFeXFf
 GAi0Hj2MmKlFFOBtORg3rbjw3jUZi3ZXtH4PF0GJ//FB5MsXWHMMOhvkINyZ3eUWFIw2
 CJQQ==
X-Gm-Message-State: APjAAAVD2DtKK2dICYkZ1VMJX1dzgDi8NbIfaufKV2czrIcQmlAv+4ys
 p9N5W7qf32RsD3rmquyoF7N+4DeCdhedq+K2isI=
X-Google-Smtp-Source: APXvYqyuPiYtPAb1AQ+8RnEAms3l7aGkSEYwMMhpedIUO02CmEA64cn9l5diYFTPCyVnJhnJgeG2Pku1z0H0o1hsTVI=
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr6679021wmi.107.1573725412224; 
 Thu, 14 Nov 2019 01:56:52 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573655945-14912-10-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2019 13:56:40 +0400
Message-ID: <CAJ+F1CK0-cRFevUFHK4MM-ucfWkiNdpLfdm2jYuxDA066pd=+Q@mail.gmail.com>
Subject: Re: [PATCH 09/16] qom: add object_new_with_class
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

On Wed, Nov 13, 2019 at 6:48 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Similar to CPU and machine classes, "-accel" class names are mangled,
> so we have to first get a class via accel_find and then instantiate it.
> Provide a new function to instantiate a class without going through
> object_class_get_name, and use it for CPUs and machines already.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/qom/object.h      | 12 ++++++++++++
>  qom/object.c              |  5 +++++
>  target/i386/cpu.c         |  8 ++++----
>  target/s390x/cpu_models.c |  4 ++--
>  vl.c                      |  3 +--
>  5 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 230b18f..f9ad692 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -593,6 +593,18 @@ struct InterfaceClass
>                                               __FILE__, __LINE__, __func_=
_))
>
>  /**
> + * object_new_with_class:
> + * @klass: The class to instantiate.
> + *
> + * This function will initialize a new object using heap allocated memor=
y.
> + * The returned object has a reference count of 1, and will be freed whe=
n
> + * the last reference is dropped.
> + *
> + * Returns: The newly allocated and instantiated object.
> + */
> +Object *object_new_with_class(ObjectClass *klass);
> +
> +/**
>   * object_new:
>   * @typename: The name of the type of the object to instantiate.
>   *
> diff --git a/qom/object.c b/qom/object.c
> index c7825dd..ee7708e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -658,6 +658,11 @@ static Object *object_new_with_type(Type type)
>      return obj;
>  }
>
> +Object *object_new_with_class(ObjectClass *klass)
> +{
> +    return object_new_with_type(klass->type);
> +}
> +
>  Object *object_new(const char *typename)
>  {
>      TypeImpl *ti =3D type_get_by_name(typename);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a624163..4742a0e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3881,7 +3881,7 @@ static void x86_cpu_class_check_missing_features(X8=
6CPUClass *xcc,
>          return;
>      }
>
> -    xc =3D X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))))=
;
> +    xc =3D X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
>
>      x86_cpu_expand_features(xc, &err);
>      if (err) {
> @@ -3952,7 +3952,7 @@ static GSList *get_sorted_cpu_model_list(void)
>
>  static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
>  {
> -    Object *obj =3D object_new(object_class_get_name(OBJECT_CLASS(xc)));
> +    Object *obj =3D object_new_with_class(OBJECT_CLASS(xc));
>      char *r =3D object_property_get_str(obj, "model-id", &error_abort);
>      object_unref(obj);
>      return r;
> @@ -4333,7 +4333,7 @@ static X86CPU *x86_cpu_from_model(const char *model=
, QDict *props, Error **errp)
>          goto out;
>      }
>
> -    xc =3D X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))))=
;
> +    xc =3D X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
>      if (props) {
>          object_apply_props(OBJECT(xc), props, &err);
>          if (err) {
> @@ -5177,7 +5177,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error =
**errp)
>      APICCommonState *apic;
>      ObjectClass *apic_class =3D OBJECT_CLASS(apic_get_class());
>
> -    cpu->apic_state =3D DEVICE(object_new(object_class_get_name(apic_cla=
ss)));
> +    cpu->apic_state =3D DEVICE(object_new_with_class(apic_class));
>
>      object_property_add_child(OBJECT(cpu), "lapic",
>                                OBJECT(cpu->apic_state), &error_abort);
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7e92fb2..72cf48b 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -440,7 +440,7 @@ static void create_cpu_model_list(ObjectClass *klass,=
 void *opaque)
>      if (cpu_list_data->model) {
>          Object *obj;
>          S390CPU *sc;
> -        obj =3D object_new(object_class_get_name(klass));
> +        obj =3D object_new_with_class(klass);
>          sc =3D S390_CPU(obj);
>          if (sc->model) {
>              info->has_unavailable_features =3D true;
> @@ -501,7 +501,7 @@ static void cpu_model_from_info(S390CPUModel *model, =
const CpuModelInfo *info,
>          error_setg(errp, "The CPU definition '%s' requires KVM", info->n=
ame);
>          return;
>      }
> -    obj =3D object_new(object_class_get_name(oc));
> +    obj =3D object_new_with_class(oc);
>      cpu =3D S390_CPU(obj);
>
>      if (!cpu->model) {
> diff --git a/vl.c b/vl.c
> index cb993dd..6e406d4 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3988,8 +3988,7 @@ int main(int argc, char **argv, char **envp)
>                        cleanup_add_fd, NULL, &error_fatal);
>  #endif
>
> -    current_machine =3D MACHINE(object_new(object_class_get_name(
> -                          OBJECT_CLASS(machine_class))));
> +    current_machine =3D MACHINE(object_new_with_class(OBJECT_CLASS(machi=
ne_class)));
>      if (machine_help_func(qemu_get_machine_opts(), current_machine)) {
>          exit(0);
>      }
> --
> 1.8.3.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

