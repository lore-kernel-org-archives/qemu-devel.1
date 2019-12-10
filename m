Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF919C00454
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D299207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBO+bkCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D299207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieeJN-00081N-Oz
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 07:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ieeGd-0005Ou-Sh
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ieeGY-0001nK-DU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:05:27 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ieeGY-0001l9-5O
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:05:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id c20so2872492wmb.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 04:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Do9M480OiF/mV/TsI463XjiLYTz9AZejk7h01p6crbI=;
 b=QBO+bkCWrT4cPXgBC7HeeLvZIIyUCkvQuGmELzIsdJjwyxkZKehm1WcEDl85JQgCcz
 w02coZu6tixVG0Nn3cR3Mbj687aYZiJPYNFt6QV0u2XwxjmzjVk6hDmYsCs1pqzdOZJY
 yAT/nqK9es2XBx0tmNbWnvCIgSp9jSr2fKrf4RXTI6yXGTdJm8kxakIWhCJcopX5clp4
 Y2TTijc6qWRSQP+UmQ/c9U2D4ksQJoNPGAHIO8d69LztyGB7BSFOqGWhvkBGYAkz2frJ
 Px2kR/6MwS2jWOJDYi9rDZRiQu1bouPcsyYbin45lf6vGmJkq7cgBHJDSamznsSWUEYL
 nctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Do9M480OiF/mV/TsI463XjiLYTz9AZejk7h01p6crbI=;
 b=H+wUjI6rNoyINDGyRUrdc4P0IlYWCaouq2Zo7MCBkw4cToO7vWtxlOwyl+WoyHWDqU
 mfZHa9JHvHNzRsAekR+HuewUiUO5BBc4TjOvln7jgnyyroHe/0jBMPZoRRbbPoxxkMYK
 OG/oBOMZ4pkUGRz3Xyg7fXsCIW/wfHbBdoNHabQmqxadmcTLBys8l8m6cQ68TSBTmHWm
 0yiNVSWsujLwvZBpuo9mwzUEZXzCvhnzFcWZI/0KvbxwqvV5hoF6ULMRqIXMkzhUPg5A
 3A3bpdXthSgU7XCDoBXeSmwW1aoMyRdl6bTyqqYokuDOocGYHuGQrpa5Tyj5wxFZxQtN
 outA==
X-Gm-Message-State: APjAAAWm9Ew+/aeEImt7BqXAfRHSt9h/642+37d4B9u1uBN/oiCEeCX/
 5bdkv+/aYwXAEH25ruXpymKVTPdzettP5969i1s=
X-Google-Smtp-Source: APXvYqxabEBpy8JUXDQZOSMgVGvxGAM9E6l1lDHjM6inLpw4n4NHjuw3fYkRWi1I7xFj6VRp2r0LU9wCccitPcn3pMI=
X-Received: by 2002:a1c:1dc4:: with SMTP id d187mr4939294wmd.46.1575979520796; 
 Tue, 10 Dec 2019 04:05:20 -0800 (PST)
MIME-Version: 1.0
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1575903705-12925-4-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Dec 2019 16:05:08 +0400
Message-ID: <CAJ+F1CJ45KA-=46CvHR6Xo1iGRVa1hpYcY6KvC-g2opo5KdLwA@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] tcg: move qemu_tcg_configure to
 accel/tcg/tcg-all.c
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

On Mon, Dec 9, 2019 at 7:07 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Move everything related to mttcg_enabled in accel/tcg/tcg-all.c,
> which will make even more sense when "thread" becomes a QOM property.
>
> For now, initializing mttcg_enabled in the instance_init function
> prepares for the next patch, which will only invoke qemu_tcg_configure
> when the command line includes a -accel option.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/tcg-all.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  cpus.c              | 72 ---------------------------------------------
>  2 files changed, 85 insertions(+), 72 deletions(-)
>
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index c59d5b0..78a0ab5 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -30,6 +30,11 @@
>  #include "cpu.h"
>  #include "sysemu/cpus.h"
>  #include "qemu/main-loop.h"
> +#include "tcg/tcg.h"
> +#include "include/qapi/error.h"
> +#include "include/qemu/error-report.h"
> +#include "include/hw/boards.h"
> +#include "qemu/option.h"
>
>  unsigned long tcg_tb_size;
>
> @@ -58,6 +63,55 @@ static void tcg_handle_interrupt(CPUState *cpu, int ma=
sk)
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

It breaks compilation:

accel/tcg/tcg-all.c:110:19: error: implicit declaration of function
=E2=80=98TCG_STATE=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  110 |     TCGState *s =3D TCG_STATE(obj);

> +
> +    mttcg_enabled =3D default_mttcg_enabled();
> +}
> +
>  static int tcg_init(MachineState *ms)
>  {
>      tcg_exec_init(tcg_tb_size * 1024 * 1024);
> @@ -65,6 +119,36 @@ static int tcg_init(MachineState *ms)
>      return 0;
>  }
>
> +void qemu_tcg_configure(QemuOpts *opts, Error **errp)
> +{
> +    const char *t =3D qemu_opt_get(opts, "thread");
> +    if (!t) {
> +        return;
> +    }
> +    if (strcmp(t, "multi") =3D=3D 0) {
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
> +            mttcg_enabled =3D true;
> +        }
> +    } else if (strcmp(t, "single") =3D=3D 0) {
> +        mttcg_enabled =3D false;
> +    } else {
> +        error_setg(errp, "Invalid 'thread' setting %s", t);
> +    }
> +}
> +
>  static void tcg_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac =3D ACCEL_CLASS(oc);
> @@ -78,6 +162,7 @@ static void tcg_accel_class_init(ObjectClass *oc, void=
 *data)
>  static const TypeInfo tcg_accel_type =3D {
>      .name =3D TYPE_TCG_ACCEL,
>      .parent =3D TYPE_ACCEL,
> +    .instance_init =3D tcg_accel_instance_init,
>      .class_init =3D tcg_accel_class_init,
>  };
>
> diff --git a/cpus.c b/cpus.c
> index 63bda15..b472378 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -166,78 +166,6 @@ typedef struct TimersState {
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
> --
> 1.8.3.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

