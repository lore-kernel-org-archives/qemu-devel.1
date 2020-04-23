Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B1FC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642342073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcDO49uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642342073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRipU-0004bw-IP
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRigz-0007St-KC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRigk-0003fC-Fk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:43:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jRigk-0003bY-11
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:43:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id e26so8093722wmk.5
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zp4Q+x86Gu3y75i2SV75beEga6P0Ez8SPwHhkxLlBv8=;
 b=GcDO49uXByJs9niokG90uSKRL0r+CZaFXXlXJDr5NNfgy3GfyUt33/77S6JNzPnk+e
 7A51oA0V6B1u+X46tnkd6KiC+gWIBhc35DuojWSo5GbeFv7Vzt0QEJpLpQiCAofQoAkO
 RZxE/06T+QpoDF5sWvoW90Uh36g6Px9aSit3Sk2+38LhVilf7HayAfXkZitSRFSrGqCh
 KFw6bfcmxxl0ZAHCgnjRXnHWPXzL9njFj98H9b6ei0Jv+SyyuzlBG9nKAcvPJLC57VJu
 U98UD/c6oWJEyIDUaxDUOpz1yPfkW8oP2FRlIvdhbuas9EEqs4JOxZSoBQraAQ+jVRD8
 jHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zp4Q+x86Gu3y75i2SV75beEga6P0Ez8SPwHhkxLlBv8=;
 b=lSX7SfR2XIMrmr+W28rYbYvJ/YTjMPyUPSzAi9zRAQC3h/WNDTCtI4Tw0fWtThbBAT
 Wllii9HHlC2ZKkmdySG+IZBKsdXkbp3V3aMP2exMSR9FXKNr9MnSV3CUGFrAw2ehHvT5
 XhWY0DB0NwC23x+HSWvRZ3FrN7os95nj98EnUESK0C/ouZaWWx1asDO3jGuQvoyPtRoc
 P+0PN26OS9CIppalSp0Latp6kfO/A6obfB+jsXWP+pOpEwSomPv67fkhGBowgEawOMz+
 iIdQmyPHV2gTD8kgVWTp66nK4GpYGtP6p9C6tpN6kP4idyvNVtby0FXvfQ7Zz+DOTxWz
 fkwg==
X-Gm-Message-State: AGi0PuYV4Zp3m0p34CcgvZ3Bv2r2iqRUhGSU3ZOW92Bbardmd6DAcaP1
 uZfeH+zFV76FyeUhEU8UjxEK0/tqZUwDuMRzO64=
X-Google-Smtp-Source: APiQypIC0KZjdJ/Ni9Aon4dvkIL1aEy0Bc/tBoOpfgb1vxpvNils7IJRaVnvPTBdKDMQJ6XVXzY/AgDGQpnoNjoGejw=
X-Received: by 2002:a1c:e284:: with SMTP id z126mr6370699wmg.32.1587674592455; 
 Thu, 23 Apr 2020 13:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200423202112.644-1-philmd@redhat.com>
 <20200423202112.644-7-philmd@redhat.com>
In-Reply-To: <20200423202112.644-7-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Apr 2020 22:43:00 +0200
Message-ID: <CAJ+F1C+TkuCeSwO8Mm5k-+2JJtuph_BiPVDQFYJ2q_+DL8X37g@mail.gmail.com>
Subject: Re: [PATCH 6/7] stubs: Split machine-init-done as machine-init and
 machine-notify
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 10:22 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As the machine notify handlers are only used in system emulation,
> split the current file in two, and only build the notifier when
> system emulation is used.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  stubs/machine-init.c                            | 4 ++++
>  stubs/{machine-init-done.c =3D> machine-notify.c} | 2 --
>  stubs/Makefile.objs                             | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>  create mode 100644 stubs/machine-init.c
>  rename stubs/{machine-init-done.c =3D> machine-notify.c} (78%)
>
> diff --git a/stubs/machine-init.c b/stubs/machine-init.c
> new file mode 100644
> index 0000000000..7622930ee0
> --- /dev/null
> +++ b/stubs/machine-init.c
> @@ -0,0 +1,4 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +
> +bool machine_init_done =3D true;
> diff --git a/stubs/machine-init-done.c b/stubs/machine-notify.c
> similarity index 78%
> rename from stubs/machine-init-done.c
> rename to stubs/machine-notify.c
> index cd8e81392d..d164ecccb9 100644
> --- a/stubs/machine-init-done.c
> +++ b/stubs/machine-notify.c
> @@ -1,8 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/sysemu.h"
>
> -bool machine_init_done =3D true;
> -
>  void qemu_add_machine_init_done_notifier(Notifier *notify)
>  {
>  }
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 45be5dc0ed..765659a3f9 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -15,7 +15,8 @@ stub-obj-y +=3D iothread-lock.o
>  stub-obj-y +=3D is-daemonized.o
>  stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
>  stub-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
> -stub-obj-y +=3D machine-init-done.o
> +stub-obj-y +=3D machine-init.o
> +stub-obj-$(CONFIG_SOFTMMU) +=3D machine-notify.o
>  stub-obj-y +=3D migr-blocker.o
>  stub-obj-y +=3D change-state-handler.o
>  stub-obj-y +=3D monitor.o
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

