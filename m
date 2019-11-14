Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E54C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3417A206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUg43m+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3417A206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCzm-00074c-9q
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 06:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVCz9-0006dE-0h
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVCz7-0003Kf-4O
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:08:22 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iVCz6-0003KO-Sp
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:08:21 -0500
Received: by mail-wm1-x344.google.com with SMTP id l1so5217610wme.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 03:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dxaEENlWKmC+yNlnKkwSmCrOPC1hkDnxAuJ02G7epR0=;
 b=bUg43m+TTL/qLTriwrxajp5IkSrv7Wgcc2KciS4fKbHfoE0SxkrQKCqfv+L+5UJ0wp
 /Z8xtfDT4VHdeGAOYHjNkRaIiNa8s4beDFXUnkypKBNc9xZb7EuBoVFwc7C5m4H6XEvi
 wH38AGG8MvgaRILmsWhQndqMOlThOo4BhipRqhlWSFRqZvNm0D+vTczVwfeY0U2TTQWv
 ta/TTy5bBWEyXiBwZ+FcXq2fJ2Wio5E06Vy3/kgMf6L3j3j/jFpoPNnqMftPJ9eGUiyt
 qthWDlHfdk/Z+DLGWcliO2YkRT4zWrE+EssLZB4V2rAEmFa177vwts6jbimw0MYNOlRJ
 tOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dxaEENlWKmC+yNlnKkwSmCrOPC1hkDnxAuJ02G7epR0=;
 b=FHCDTwC9+xZD4ROL6OjW6m/eIG72TxHrNM7noxT1i708qtRlpuzDMwnVoFuang4IsF
 cEoLl3+zj+J1vZjn9JkyLlLK3JHcGiwlSQK+NMB8Un5YXZIklah7eT1PM7urqtgNtjfz
 fuECVxtLdUSfAJBobEmBjuD18NswzqtPMlgMlZoyByUmfjZj1L7ANXyKskfQXKNUta2K
 +3DGXnVntCLnM2hmd/rtSIcCcWlSOYJ4FZo4TWWl0a7gV3CbLLirltkgQ9lSFfFiJ5ON
 zUXpdvv6WJP+Dq0n9LbgpJDFQNIYw8NnSCI/NmN7crbKrYtEcbGd8A01Ig5bvV3chsFf
 NvXg==
X-Gm-Message-State: APjAAAVHBjllnNYoWkANhPPUjm9MVZpMRfwFRKGaEDwm99LIxSB6co9A
 2Hsx/FTXJ9nrtdatKz+S+OjA4nsQ9z/movOp/xc=
X-Google-Smtp-Source: APXvYqyGkKA9dLYUe1dt8pK8myu7MVj0pph0HsoR5wHljlP4FUhntj+O20kh16P73FNsOqXPiHo7WggFsmcfxtXdNuQ=
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr6975465wmi.107.1573729699424; 
 Thu, 14 Nov 2019 03:08:19 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573655945-14912-12-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2019 15:08:06 +0400
Message-ID: <CAJ+F1C+x1nmFx1q+DcqD=YvDk7cVRBSgBzu0JwM+soEkxKo-DQ@mail.gmail.com>
Subject: Re: [PATCH 11/16] tcg: convert "-accel threads" to a QOM property
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

On Wed, Nov 13, 2019 at 6:49 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Replace the ad-hoc qemu_tcg_configure with generic code invoking
> QOM property getters and setters.  This will be extended in the
> next patches, which will turn accelerator-related "-machine"
> options into QOM properties as well.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  accel/tcg/tcg-all.c   | 111 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  cpus.c                |  72 --------------------------------
>  include/sysemu/cpus.h |   2 -
>  vl.c                  |  32 ++++++++-------
>  4 files changed, 126 insertions(+), 91 deletions(-)
>
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index c59d5b0..7829f02 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -30,6 +30,21 @@
>  #include "cpu.h"
>  #include "sysemu/cpus.h"
>  #include "qemu/main-loop.h"
> +#include "tcg/tcg.h"
> +#include "include/qapi/error.h"
> +#include "include/qemu/error-report.h"
> +#include "include/hw/boards.h"
> +
> +typedef struct TCGState {
> +    AccelState parent_obj;
> +
> +    bool mttcg_enabled;
> +} TCGState;
> +
> +#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
> +
> +#define TCG_STATE(obj) \
> +        OBJECT_CHECK(TCGState, (obj), TYPE_TCG_ACCEL)
>
>  unsigned long tcg_tb_size;
>
> @@ -58,27 +73,119 @@ static void tcg_handle_interrupt(CPUState *cpu, int =
mask)
>      }
>  }
>
> +/*
> + * We default to false if we know other options have been enabled
> + * which are currently incompatible with MTTCG. Otherwise when each
> + * guest (target) has been updated to support:
> + *   - atomic instructions
> + *   - memory ordering primitives (barriers)
> + * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
> + *
> + * Once a guest architecture has been converted to the new primitives
> + * there are two remaining limitations to check.
> + *
> + * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
> + * - The host must have a stronger memory order than the guest
> + *
> + * It may be possible in future to support strong guests on weak hosts
> + * but that will require tagging all load/stores in a guest with their
> + * implicit memory order requirements which would likely slow things
> + * down a lot.
> + */
> +
> +static bool check_tcg_memory_orders_compatible(void)
> +{
> +#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
> +    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) =3D=3D 0;
> +#else
> +    return false;
> +#endif
> +}
> +
> +static bool default_mttcg_enabled(void)
> +{
> +    if (use_icount || TCG_OVERSIZED_GUEST) {
> +        return false;
> +    } else {
> +#ifdef TARGET_SUPPORTS_MTTCG
> +        return check_tcg_memory_orders_compatible();
> +#else
> +        return false;
> +#endif
> +    }
> +}
> +
> +static void tcg_accel_instance_init(Object *obj)
> +{
> +    TCGState *s =3D TCG_STATE(obj);
> +
> +    s->mttcg_enabled =3D default_mttcg_enabled();
> +}
> +
>  static int tcg_init(MachineState *ms)
>  {
> +    TCGState *s =3D TCG_STATE(current_machine->accelerator);
> +
>      tcg_exec_init(tcg_tb_size * 1024 * 1024);
>      cpu_interrupt_handler =3D tcg_handle_interrupt;
> +    mttcg_enabled =3D s->mttcg_enabled;
>      return 0;
>  }
>
> +static char *tcg_get_thread(Object *obj, Error **errp)
> +{
> +    TCGState *s =3D TCG_STATE(obj);
> +
> +    return g_strdup(s->mttcg_enabled ? "multi" : "single");
> +}
> +
> +static void tcg_set_thread(Object *obj, const char *value, Error **errp)
> +{
> +    TCGState *s =3D TCG_STATE(obj);
> +
> +    if (strcmp(value, "multi") =3D=3D 0) {
> +        if (TCG_OVERSIZED_GUEST) {
> +            error_setg(errp, "No MTTCG when guest word size > hosts");
> +        } else if (use_icount) {
> +            error_setg(errp, "No MTTCG when icount is enabled");
> +        } else {
> +#ifndef TARGET_SUPPORTS_MTTCG
> +            warn_report("Guest not yet converted to MTTCG - "
> +                        "you may get unexpected results");
> +#endif
> +            if (!check_tcg_memory_orders_compatible()) {
> +                warn_report("Guest expects a stronger memory ordering "
> +                            "than the host provides");
> +                error_printf("This may cause strange/hard to debug error=
s\n");
> +            }
> +            s->mttcg_enabled =3D true;
> +        }
> +    } else if (strcmp(value, "single") =3D=3D 0) {
> +        s->mttcg_enabled =3D false;
> +    } else {
> +        error_setg(errp, "Invalid 'thread' setting %s", value);
> +    }
> +}
> +
>  static void tcg_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac =3D ACCEL_CLASS(oc);
>      ac->name =3D "tcg";
>      ac->init_machine =3D tcg_init;
>      ac->allowed =3D &tcg_allowed;
> -}
>
> -#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
> +    object_class_property_add_str(oc, "thread",
> +                                  tcg_get_thread,
> +                                  tcg_set_thread,
> +                                  NULL);
> +}
>
>  static const TypeInfo tcg_accel_type =3D {
>      .name =3D TYPE_TCG_ACCEL,
>      .parent =3D TYPE_ACCEL,
> +    .instance_init =3D tcg_accel_instance_init,
>      .class_init =3D tcg_accel_class_init,
> +    .instance_size =3D sizeof(TCGState),
>  };
>
>  static void register_accel_types(void)
> diff --git a/cpus.c b/cpus.c
> index fabbeca..69d4f6a 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -165,78 +165,6 @@ typedef struct TimersState {
>  static TimersState timers_state;
>  bool mttcg_enabled;
>
> -/*
> - * We default to false if we know other options have been enabled
> - * which are currently incompatible with MTTCG. Otherwise when each
> - * guest (target) has been updated to support:
> - *   - atomic instructions
> - *   - memory ordering primitives (barriers)
> - * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
> - *
> - * Once a guest architecture has been converted to the new primitives
> - * there are two remaining limitations to check.
> - *
> - * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
> - * - The host must have a stronger memory order than the guest
> - *
> - * It may be possible in future to support strong guests on weak hosts
> - * but that will require tagging all load/stores in a guest with their
> - * implicit memory order requirements which would likely slow things
> - * down a lot.
> - */
> -
> -static bool check_tcg_memory_orders_compatible(void)
> -{
> -#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
> -    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) =3D=3D 0;
> -#else
> -    return false;
> -#endif
> -}
> -
> -static bool default_mttcg_enabled(void)
> -{
> -    if (use_icount || TCG_OVERSIZED_GUEST) {
> -        return false;
> -    } else {
> -#ifdef TARGET_SUPPORTS_MTTCG
> -        return check_tcg_memory_orders_compatible();
> -#else
> -        return false;
> -#endif
> -    }
> -}
> -
> -void qemu_tcg_configure(QemuOpts *opts, Error **errp)
> -{
> -    const char *t =3D qemu_opt_get(opts, "thread");
> -    if (t) {
> -        if (strcmp(t, "multi") =3D=3D 0) {
> -            if (TCG_OVERSIZED_GUEST) {
> -                error_setg(errp, "No MTTCG when guest word size > hosts"=
);
> -            } else if (use_icount) {
> -                error_setg(errp, "No MTTCG when icount is enabled");
> -            } else {
> -#ifndef TARGET_SUPPORTS_MTTCG
> -                warn_report("Guest not yet converted to MTTCG - "
> -                            "you may get unexpected results");
> -#endif
> -                if (!check_tcg_memory_orders_compatible()) {
> -                    warn_report("Guest expects a stronger memory orderin=
g "
> -                                "than the host provides");
> -                    error_printf("This may cause strange/hard to debug e=
rrors\n");
> -                }
> -                mttcg_enabled =3D true;
> -            }
> -        } else if (strcmp(t, "single") =3D=3D 0) {
> -            mttcg_enabled =3D false;
> -        } else {
> -            error_setg(errp, "Invalid 'thread' setting %s", t);
> -        }
> -    } else {
> -        mttcg_enabled =3D default_mttcg_enabled();
> -    }
> -}
>
>  /* The current number of executed instructions is based on what we
>   * originally budgeted minus the current state of the decrementing
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 32c05f2..3c1da6a 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -40,6 +40,4 @@ extern int smp_threads;
>
>  void list_cpus(const char *optarg);
>
> -void qemu_tcg_configure(QemuOpts *opts, Error **errp);
> -
>  #endif
> diff --git a/vl.c b/vl.c
> index c8ec906..2ea94c7 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -294,17 +294,12 @@ static QemuOptsList qemu_accel_opts =3D {
>      .implied_opt_name =3D "accel",
>      .head =3D QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
>      .desc =3D {
> -        {
> -            .name =3D "accel",
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "Select the type of accelerator",
> -        },
> -        {
> -            .name =3D "thread",
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "Enable/disable multi-threaded TCG",
> -        },
> -        { /* end of list */ }
> +        /*
> +         * no elements =3D> accept any
> +         * sanity checking will happen later
> +         * when setting accelerator properties
> +         */
> +        { }
>      },
>  };
>
> @@ -2841,6 +2836,13 @@ static int do_configure_icount(void *opaque, QemuO=
pts *opts, Error **errp)
>      return 0;
>  }
>
> +static int accelerator_set_property(void *opaque,
> +                                const char *name, const char *value,
> +                                Error **errp)
> +{
> +    return object_parse_property_opt(opaque, name, value, "accel", errp)=
;
> +}
> +
>  static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error =
**errp)
>  {
>      bool *p_init_failed =3D opaque;
> @@ -2855,6 +2857,10 @@ static int do_configure_accelerator(void *opaque, =
QemuOpts *opts, Error **errp)
>          return 0;
>      }
>      accel =3D ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
> +    qemu_opt_foreach(opts, accelerator_set_property,
> +                     accel,
> +                     &error_fatal);
> +
>      ret =3D accel_init_machine(accel, current_machine);
>      if (ret < 0) {
>          *p_init_failed =3D true;
> @@ -2862,10 +2868,6 @@ static int do_configure_accelerator(void *opaque, =
QemuOpts *opts, Error **errp)
>                       acc, strerror(-ret));
>          return 0;
>      }
> -
> -    if (tcg_enabled()) {
> -        qemu_tcg_configure(opts, &error_fatal);
> -    }
>      return 1;
>  }
>
> --
> 1.8.3.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

