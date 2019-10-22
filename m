Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6710DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A2020659
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcXgWYAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A2020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpe2-00038x-DL
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMpcQ-00021J-Kb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMpcP-0007DV-8Q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:34:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMpcO-0007C5-1K
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571733253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=EoYrb2qtL19XBGGIWYU+vJio620TxOIYm0uiqYTeKSc=;
 b=GcXgWYAVhftyPQ7fCKpSKP9ZJFk0ltaGnS5IVIZl+Wqa222ddPtGCWdqBjCULqQ34IFMTN
 b4YspnxnAzbgwSDcTTU6v9jU+cOSXiWEoajZtJv6sc9HjH5i2iSXVmuahiG2nbKDVwfUsH
 33PDJjozbRiIZ+QDeHDjOVT8Lb1qJZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-C5XLpxxlP06ckDoAfZIzNQ-1; Tue, 22 Oct 2019 04:34:12 -0400
Received: by mail-wm1-f70.google.com with SMTP id o188so7088539wmo.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 01:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6wbpy6sfnJTNjtUXNQcI+hAzgAqW8DDHA9ysT8boTQU=;
 b=JN8tVwZ7cABmJ5t/CXL4wJYrqfyxwTNASPKdO3W0j8BLo6+g8+LQBZPQAwalcs9+jv
 LEod1xujk4SaNKnx8n+tHDvuBXcyrwxa3mhvDo+DQhxQT/+cIFmRrl98xiPlLpc2WcNY
 CqEfp5HMQ5tDsCcA5ZL4VMIjnF3TQOAWsPe99C0nEnrYwMicu4Agde55w0y9kHeS/nXC
 eQ4/FjFkupi/P7EW4+IelW9q1MqocxiN3WQneVafmO0ewzjJ/UX2UCFzw7qAZ9pVk/EA
 9tC0XwKa72H5bqv5gGgjI4UpE/PAw21Zpndao3+1TP0AWsAirz0TtcF0EDnmkCT1zXRY
 pMFQ==
X-Gm-Message-State: APjAAAUH6JA7EbUU78WIf99+oXYwpSuBIBzWSGZj2Y3coXDFlplFUFAC
 jBUMuUQLSeSP1qLZ0IS9Vtu5fPdWMv0RZUo9q+gTsrSytoRxckbVmPhHQGcfKsEwnCOoNsp0LJR
 MfQOkgTvUN3eHb1Y=
X-Received: by 2002:adf:a157:: with SMTP id r23mr2244948wrr.51.1571733250726; 
 Tue, 22 Oct 2019 01:34:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyIic1u9i+Jsae1+KZcYsVK0fK2qhcDhGwWaMZYC6ZtH+pUhrYuQyNkbrI/OJoYjr7B8kKhcQ==
X-Received: by 2002:adf:a157:: with SMTP id r23mr2244914wrr.51.1571733250340; 
 Tue, 22 Oct 2019 01:34:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:566:fc24:94f2:2f13?
 ([2001:b07:6468:f312:566:fc24:94f2:2f13])
 by smtp.gmail.com with ESMTPSA id 37sm28128625wrc.96.2019.10.22.01.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 01:34:09 -0700 (PDT)
Subject: Re: [PATCH] Semihost SYS_READC implementation
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
References: <20191022031335.9880-1-keithp@keithp.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d7470bfa-ba4e-3287-326f-ee63c5d76407@redhat.com>
Date: Tue, 22 Oct 2019 10:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022031335.9880-1-keithp@keithp.com>
Content-Language: en-US
X-MC-Unique: C5XLpxxlP06ckDoAfZIzNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/19 05:13, Keith Packard wrote:
> Provides a blocking call to read a character from the console by hooking
> into the console input chain. This happens *after* any uart has hooked in=
,
> so specifying -semihost overrides input to any emulated uarts.
>=20
> Signed-off-by: Keith Packard <keithp@keithp.com>

I'm a bit confused, why is it not using semihosting_get_chardev?  That
would be

=09-chardev stdio,id=3Dsemihost
=09-semihosting-config on,chardev=3Dsemihost

Paolo

> ---
>  hw/semihosting/console.c          | 92 +++++++++++++++++++++++++++++++
>  include/hw/semihosting/console.h  | 12 ++++
>  include/hw/semihosting/semihost.h |  1 +
>  stubs/semihost.c                  |  4 ++
>  target/arm/arm-semi.c             |  3 +-
>  vl.c                              |  3 +
>  6 files changed, 113 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
> index b4b17c8afb..7345e2cce0 100644
> --- a/hw/semihosting/console.c
> +++ b/hw/semihosting/console.c
> @@ -98,3 +98,95 @@ void qemu_semihosting_console_outc(CPUArchState *env, =
target_ulong addr)
>                        __func__, addr);
>      }
>  }
> +
> +#include <pthread.h>
> +#include "chardev/char-fe.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/main-loop.h"
> +#include "qapi/error.h"
> +
> +#define FIFO_SIZE   1024
> +
> +typedef struct SemihostingFifo {
> +    unsigned int     insert, remove;
> +
> +    uint8_t fifo[FIFO_SIZE];
> +} SemihostingFifo;
> +
> +#define fifo_insert(f, c) do { \
> +    (f)->fifo[(f)->insert] =3D (c); \
> +    (f)->insert =3D ((f)->insert + 1) & (FIFO_SIZE - 1); \
> +} while (0)
> +
> +#define fifo_remove(f, c) do {\
> +    c =3D (f)->fifo[(f)->remove]; \
> +    (f)->remove =3D ((f)->remove + 1) & (FIFO_SIZE - 1); \
> +} while (0)
> +
> +#define fifo_full(f)        ((((f)->insert + 1) & (FIFO_SIZE - 1)) =3D=
=3D \
> +                             (f)->remove)
> +#define fifo_empty(f)       ((f)->insert =3D=3D (f)->remove)
> +#define fifo_space(f)       (((f)->remove - ((f)->insert + 1)) & \
> +                             (FIFO_SIZE - 1))
> +
> +typedef struct SemihostingConsole {
> +    CharBackend         backend;
> +    pthread_mutex_t     mutex;
> +    pthread_cond_t      cond;
> +    bool                got;
> +    SemihostingFifo     fifo;
> +} SemihostingConsole;
> +
> +static SemihostingConsole console =3D {
> +    .mutex =3D PTHREAD_MUTEX_INITIALIZER,
> +    .cond =3D PTHREAD_COND_INITIALIZER
> +};
> +
> +static int console_can_read(void *opaque)
> +{
> +    SemihostingConsole *c =3D opaque;
> +    int ret;
> +    pthread_mutex_lock(&c->mutex);
> +    ret =3D fifo_space(&c->fifo);
> +    pthread_mutex_unlock(&c->mutex);
> +    return ret;
> +}
> +
> +static void console_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    SemihostingConsole *c =3D opaque;
> +    pthread_mutex_lock(&c->mutex);
> +    while (size-- && !fifo_full(&c->fifo)) {
> +        fifo_insert(&c->fifo, *buf++);
> +    }
> +    pthread_cond_broadcast(&c->cond);
> +    pthread_mutex_unlock(&c->mutex);
> +}
> +
> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
> +{
> +    (void) env;
> +    SemihostingConsole *c =3D &console;
> +    qemu_mutex_unlock_iothread();
> +    pthread_mutex_lock(&c->mutex);
> +    while (fifo_empty(&c->fifo)) {
> +        pthread_cond_wait(&c->cond, &c->mutex);
> +    }
> +    uint8_t ch;
> +    fifo_remove(&c->fifo, ch);
> +    pthread_mutex_unlock(&c->mutex);
> +    qemu_mutex_lock_iothread();
> +    return (target_ulong) ch;
> +}
> +
> +void qemu_semihosting_console_init(void)
> +{
> +    if (semihosting_enabled()) {
> +        qemu_chr_fe_init(&console.backend, serial_hd(0), &error_abort);
> +        qemu_chr_fe_set_handlers(&console.backend,
> +                                 console_can_read,
> +                                 console_read,
> +                                 NULL, NULL, &console,
> +                                 NULL, true);
> +    }
> +}
> diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/co=
nsole.h
> index 9be9754bcd..56f3606a2a 100644
> --- a/include/hw/semihosting/console.h
> +++ b/include/hw/semihosting/console.h
> @@ -37,6 +37,18 @@ int qemu_semihosting_console_outs(CPUArchState *env, t=
arget_ulong s);
>   */
>  void qemu_semihosting_console_outc(CPUArchState *env, target_ulong c);
> =20
> +/**
> + * qemu_semihosting_console_outc:
> + * @env: CPUArchState
> + *
> + * Receive single character from debug console. This
> + * may be the remote gdb session if a softmmu guest is currently being
> + * debugged.
> + *
> + * Returns: character read or -1 on error
> + */
> +target_ulong qemu_semihosting_console_inc(CPUArchState *env);
> +
>  /**
>   * qemu_semihosting_log_out:
>   * @s: pointer to string
> diff --git a/include/hw/semihosting/semihost.h b/include/hw/semihosting/s=
emihost.h
> index 60fc42d851..a13d17c087 100644
> --- a/include/hw/semihosting/semihost.h
> +++ b/include/hw/semihosting/semihost.h
> @@ -68,6 +68,7 @@ Chardev *semihosting_get_chardev(void);
>  void qemu_semihosting_enable(void);
>  int qemu_semihosting_config_options(const char *opt);
>  void qemu_semihosting_connect_chardevs(void);
> +void qemu_semihosting_console_init(void);
>  #endif /* CONFIG_USER_ONLY */
> =20
>  #endif /* SEMIHOST_H */
> diff --git a/stubs/semihost.c b/stubs/semihost.c
> index f90589259c..1d8b37f7b2 100644
> --- a/stubs/semihost.c
> +++ b/stubs/semihost.c
> @@ -69,3 +69,7 @@ void semihosting_arg_fallback(const char *file, const c=
har *cmd)
>  void qemu_semihosting_connect_chardevs(void)
>  {
>  }
> +
> +void qemu_semihosting_console_init(void)
> +{
> +}
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 6f7b6d801b..47d61f6fe1 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -802,8 +802,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
> =20
>          return guestfd_fns[gf->type].readfn(cpu, gf, arg1, len);
>      case TARGET_SYS_READC:
> -        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func=
__);
> -        return 0;
> +        return qemu_semihosting_console_inc(env);
>      case TARGET_SYS_ISTTY:
>          GET_ARG(0);
> =20
> diff --git a/vl.c b/vl.c
> index 4489cfb2bb..ac584d97ea 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4381,6 +4381,9 @@ int main(int argc, char **argv, char **envp)
>      ds =3D init_displaystate();
>      qemu_display_init(ds, &dpy);
> =20
> +    /* connect semihosting console input if requested */
> +    qemu_semihosting_console_init();
> +
>      /* must be after terminal init, SDL library changes signal handlers =
*/
>      os_setup_signal_handling();
> =20
>=20


