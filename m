Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF7C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 21:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9047E2074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 21:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEkeinwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9047E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRjVj-0003Kj-OZ
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 17:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRjUe-0002fB-Nq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRjUd-0000LV-OP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:34:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jRjUd-0000Kh-9o
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:34:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id v4so8468408wme.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JaqWyQSSn74uxBxXKvNfasHKRVhgS7C3/4w2m/7tWCc=;
 b=SEkeinwpSnTezASSVo05AyZaZpc8U8J3Rk+LWiZb0tv4fkyadiBwkJYFCLKVMrx/+O
 G23MGXRK0JPI5U6mstkRIZ4VQYLdKY6MMPvAkCyZvIsratgTslqLTjrHdRCv5kWdSHrR
 QPQeCTIUELn8W5MpBctyFYfqusj8u1Hl3kQw6w0tLVZA5rcEbOffKVSPeQZF+AMlFetM
 H3h11jDZm4zBkEk5525ncHQm8bV4Du6FJ12t8UBn0mWq9BANIMuVkt1kjP3VCljt917v
 X7+ehItz8iu2WQPRkQNYrQL8M5kf0lAznXHbaDWxnKMIHP5cdlu1QpnvDs1H4YwwSLXo
 8fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JaqWyQSSn74uxBxXKvNfasHKRVhgS7C3/4w2m/7tWCc=;
 b=VYV1P++SA8lCbvwT/RhP5mRWpt9+gPzp3OQTrdqM52K3n3pjUiuXQAmGv8aEgyKaTj
 ojbLmUFSrcUe0+0OoV0pJMpaOsbVjJ0+oGNmJcV06C84npPpVRFW4xFXIR3OMBIF/GDD
 uW/Bi+bjtP3r+dKjfkfmlRsHFlZqfiJgevxF5/o6twspV5qzJwwZBfs4PDq2kqmdEXV0
 I9cYbCgek9xlJvNF6uYV7N6Ayn43njTzFKvbBCnhihKoSzuPLrCDQjXdfI7dsOXtw6Ei
 BPN/ZH3y2ftc1oYOQo0V7IRBo2rpS4AIbe0Qmxpvz6F4CKBX3E7rS+GlDtTB/+Ht1bEs
 XqUw==
X-Gm-Message-State: AGi0Puasi7sDnQsgBEDd2koldVEWv8g8eRR0KmJoeU9F6LhLoWb3nuf6
 oliRkWIygxnQ5jSb/e/MP5wJE42cnrn2dV0OpAs=
X-Google-Smtp-Source: APiQypIfgOAHYZmW536j15xhEZveucamngD+nPNan88mVpQwYhCWKB5dG6b9FCM9k7SIsLechdAvM9MZMvQgq9/Vb2U=
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr5934951wmb.37.1587677684404;
 Thu, 23 Apr 2020 14:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200423202112.644-1-philmd@redhat.com>
 <20200423202112.644-6-philmd@redhat.com>
In-Reply-To: <20200423202112.644-6-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Apr 2020 23:34:30 +0200
Message-ID: <CAJ+F1C+LUnM8nvZwWZM_k1pL-dMpuuJ0QQB9qGALhhoWCG2eiQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] chardev: Extract system emulation specific code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 10:24 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Split out code only used during system emulation,
> to reduce code pulled in user emulation and tools.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/chardev-internal.h |  3 ++
>  chardev/char.c             | 35 +------------------
>  chardev/chardev-sysemu.c   | 69 ++++++++++++++++++++++++++++++++++++++
>  chardev/Makefile.objs      |  1 +
>  4 files changed, 74 insertions(+), 34 deletions(-)
>  create mode 100644 chardev/chardev-sysemu.c
>
> diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> index e0264ac349..f4d0429763 100644
> --- a/chardev/chardev-internal.h
> +++ b/chardev/chardev-internal.h
> @@ -26,6 +26,7 @@
>
>  #include "chardev/char.h"
>  #include "chardev/char-fe.h"
> +#include "qom/object.h"
>
>  #define MAX_MUX 4
>  #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
> @@ -59,4 +60,6 @@ typedef struct MuxChardev {
>  void mux_set_focus(Chardev *chr, int focus);
>  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
>
> +Object *get_chardevs_root(void);
> +
>  #endif /* CHAR_MUX_H */
> diff --git a/chardev/char.c b/chardev/char.c
> index b672a41150..555bb0448e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -44,7 +44,7 @@
>  /***********************************************************/
>  /* character device */
>
> -static Object *get_chardevs_root(void)
> +Object *get_chardevs_root(void)
>  {
>      return container_get(object_get_root(), "/chardevs");
>  }
> @@ -300,33 +300,6 @@ static const TypeInfo char_type_info =3D {
>      .class_init =3D char_class_init,
>  };
>
> -static int chardev_machine_done_notify_one(Object *child, void *opaque)
> -{
> -    Chardev *chr =3D (Chardev *)child;
> -    ChardevClass *class =3D CHARDEV_GET_CLASS(chr);
> -
> -    if (class->chr_machine_done) {
> -        return class->chr_machine_done(chr);
> -    }
> -
> -    return 0;
> -}
> -
> -static void chardev_machine_done_hook(Notifier *notifier, void *unused)
> -{
> -    int ret =3D object_child_foreach(get_chardevs_root(),
> -                                   chardev_machine_done_notify_one, NULL=
);
> -
> -    if (ret) {
> -        error_report("Failed to call chardev machine_done hooks");
> -        exit(1);
> -    }
> -}
> -
> -static Notifier chardev_machine_done_notify =3D {
> -    .notify =3D chardev_machine_done_hook,
> -};
> -
>  static bool qemu_chr_is_busy(Chardev *s)
>  {
>      if (CHARDEV_IS_MUX(s)) {
> @@ -1187,12 +1160,6 @@ void qemu_chr_cleanup(void)
>  static void register_types(void)
>  {
>      type_register_static(&char_type_info);
> -
> -    /* this must be done after machine init, since we register FEs with =
muxes
> -     * as part of realize functions like serial_isa_realizefn when -nogr=
aphic
> -     * is specified
> -     */
> -    qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
>  }
>
>  type_init(register_types);
> diff --git a/chardev/chardev-sysemu.c b/chardev/chardev-sysemu.c
> new file mode 100644
> index 0000000000..eecdc615ee
> --- /dev/null
> +++ b/chardev/chardev-sysemu.c
> @@ -0,0 +1,69 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "chardev/char.h"
> +#include "qemu/error-report.h"
> +#include "chardev-internal.h"
> +
> +static int chardev_machine_done_notify_one(Object *child, void *opaque)
> +{
> +    Chardev *chr =3D (Chardev *)child;
> +    ChardevClass *class =3D CHARDEV_GET_CLASS(chr);
> +
> +    if (class->chr_machine_done) {
> +        return class->chr_machine_done(chr);
> +    }
> +
> +    return 0;
> +}
> +
> +static void chardev_machine_done_hook(Notifier *notifier, void *unused)
> +{
> +    int ret =3D object_child_foreach(get_chardevs_root(),
> +                                   chardev_machine_done_notify_one, NULL=
);
> +
> +    if (ret) {
> +        error_report("Failed to call chardev machine_done hooks");
> +        exit(1);
> +    }
> +}
> +
> +
> +static Notifier chardev_machine_done_notify =3D {
> +    .notify =3D chardev_machine_done_hook,
> +};
> +
> +static void register_types(void)
> +{
> +    /*
> +     * This must be done after machine init, since we register FEs with =
muxes
> +     * as part of realize functions like serial_isa_realizefn when -nogr=
aphic
> +     * is specified.
> +     */
> +    qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
> +}
> +
> +type_init(register_types);
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index 15ee7f47da..a10acbc2b8 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -1,4 +1,5 @@
>  chardev-obj-y +=3D char.o
> +chardev-obj-$(CONFIG_SOFTMMU) +=3D chardev-sysemu.o
>  chardev-obj-$(CONFIG_WIN32) +=3D char-console.o
>  chardev-obj-$(CONFIG_POSIX) +=3D char-fd.o
>  chardev-obj-y +=3D char-fe.o
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

