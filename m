Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4DDC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8612206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOs6wmv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8612206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihBsX-000090-TW
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 07:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihBrw-00089c-4u
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihBrs-00023X-Vi
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:22:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihBrs-00022l-MK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576585343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+63qitR1Ktq7Uxr9O0lfUMq4e93GVUPKjxnxiqlnNg=;
 b=AOs6wmv1s92jKSWTvoKIzoebiYicoauJIL4ILkNbMT6jQ6KGbTo4FKFCVWv0urtlpTlRAp
 jW5Vg3SAAsVKtc0nLbq+fFl28dVERZnfRfQCXknWdNSup9h8lRonf9VqTkF/ACjRzlQqqw
 BMptosAQdMDRUxS53k2eH7aMOfJep70=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-v09Y8IehNQmlJJ513jbCxw-1; Tue, 17 Dec 2019 07:22:18 -0500
Received: by mail-wm1-f69.google.com with SMTP id t16so857625wmt.4
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 04:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pgvcN3SY7z1lI4WjFDrKe0V79LtaUkmIHJgLL4Ucaak=;
 b=VBO0dBZdzHHeVtKT5DNU0ZiCx8KyiFUMgddaoJCNzt3Gs16PEgYRUkJn+TMTzDgedi
 S7mRQvD8qSDkAvxe5NXyulmlefXJta+/9LF1bqdDLRxdgk/XtukLu3pwf9be4cXLgLPB
 eFMpL0DZiUPwiWgYxVoqQKgXZv9b4iiiqD74dKnRcoTGwXSQRcJITB3DE6R2T4gx7LhJ
 wbzzwDCiu68dn5NDVKu5I4gr0HTj4DggFU/qUNvY0kF3icXThYMx9Zna2ZvZEm/Snxic
 dmxg9/flho/rKbwJM5RMO9ra2iUBgGxzI+HbHEGVCMqdK87txG6/NZG2sqv4g/o0hh0y
 ZWOQ==
X-Gm-Message-State: APjAAAVGBf8vFDcLx4K2OnELxkzvwLRGyeExG18igDEVm1q9oNCjQASf
 S9TtQTeG0DuuyddzeTLyykXHqxg6EjYTao6uujFMlZbAi3tzwDg94HllBlOvHHFzdWu7MJnXZgC
 wDVSbq/kNFuPa5Ns=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr5142126wmh.35.1576585337454; 
 Tue, 17 Dec 2019 04:22:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWkxO7Igkqz1O4AdRxkJCjip5w8qAZGs867PLTnsmd2rMw+luuATS3R71/p6WNOYGsMRayxQ==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr5142098wmh.35.1576585337180; 
 Tue, 17 Dec 2019 04:22:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id m126sm2822901wmf.7.2019.12.17.04.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 04:22:16 -0800 (PST)
Subject: Re: [RFC PATCH] semihosting: suspend recieving CPU when blocked
 (HACK, WIP)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
 <20191217121443.14757-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com>
Date: Tue, 17 Dec 2019 13:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191217121443.14757-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: v09Y8IehNQmlJJ513jbCxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: keithp@keithp.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 13:14, Alex Benn=C3=A9e wrote:
> [AJB:
>=20
> So this at least solves the hang of not being able to quit system
> emulation while blocked. However there are two things we still need to
> ensure:
>=20
>  - the PC has not advanced until completion so we can redo the instructio=
n
>  - we actually wake up the CPU in console_read
>=20
> In my testcase console_read never seems to get called. I've tried with
> both an external pipe loopback and using the ringbuf:
>=20
> qemu-system-aarch64 -M virt --display none -cpu cortex-a57 -kernel systes=
t-a64-with-console.axf -semihosting-config
>  enable=3Don,chardev=3Dsh0 -serial mon:stdio -chardev ringbuf,logfile=3Df=
oo,id=3Dsh0
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/exec/cpu-all.h   |  1 +
>  hw/semihosting/console.c | 34 +++++++++++++++++-----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index e96781a4559..093d7a76edd 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -31,6 +31,7 @@
>  #define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external e=
vent) */
>  #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to anoth=
er */
>  #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
> +#define EXCP_BLOCKED    0x10006 /* cpu is blocked (semihosting) */
> =20
>  /* some important defines:
>   *
> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
> index 4db68d62270..bda457a0608 100644
> --- a/hw/semihosting/console.c
> +++ b/hw/semihosting/console.c
> @@ -20,6 +20,7 @@
>  #include "hw/semihosting/semihost.h"
>  #include "hw/semihosting/console.h"
>  #include "exec/gdbstub.h"
> +#include "exec/exec-all.h"
>  #include "qemu/log.h"
>  #include "chardev/char.h"
>  #include <pthread.h>
> @@ -109,50 +110,49 @@ void qemu_semihosting_console_outc(CPUArchState *en=
v, target_ulong addr)
> =20
>  typedef struct SemihostingConsole {
>      CharBackend         backend;
> -    pthread_mutex_t     mutex;
> -    pthread_cond_t      cond;
> +    CPUState            *sleeping_cpu;
>      bool                got;
>      Fifo8               fifo;
>  } SemihostingConsole;
> =20
> -static SemihostingConsole console =3D {
> -    .mutex =3D PTHREAD_MUTEX_INITIALIZER,
> -    .cond =3D PTHREAD_COND_INITIALIZER
> -};
> +static SemihostingConsole console;
> =20
>  static int console_can_read(void *opaque)
>  {
>      SemihostingConsole *c =3D opaque;
>      int ret;
> -    pthread_mutex_lock(&c->mutex);
> +    g_assert(qemu_mutex_iothread_locked());
>      ret =3D (int) fifo8_num_free(&c->fifo);
> -    pthread_mutex_unlock(&c->mutex);
>      return ret;
>  }
> =20
>  static void console_read(void *opaque, const uint8_t *buf, int size)
>  {
>      SemihostingConsole *c =3D opaque;
> -    pthread_mutex_lock(&c->mutex);
> +    g_assert(qemu_mutex_iothread_locked());
>      while (size-- && !fifo8_is_full(&c->fifo)) {
>          fifo8_push(&c->fifo, *buf++);
>      }
> -    pthread_cond_broadcast(&c->cond);
> -    pthread_mutex_unlock(&c->mutex);
> +    if (c->sleeping_cpu) {
> +        cpu_resume(c->sleeping_cpu);
> +    }
>  }
> =20
>  target_ulong qemu_semihosting_console_inc(CPUArchState *env)
>  {
>      uint8_t ch;
>      SemihostingConsole *c =3D &console;
> -    qemu_mutex_unlock_iothread();
> -    pthread_mutex_lock(&c->mutex);
> -    while (fifo8_is_empty(&c->fifo)) {
> -        pthread_cond_wait(&c->cond, &c->mutex);
> +    g_assert(qemu_mutex_iothread_locked());
> +    g_assert(current_cpu);
> +    if (fifo8_is_empty(&c->fifo)) {
> +        c->sleeping_cpu =3D current_cpu;
> +        c->sleeping_cpu->stop =3D true;
> +        c->sleeping_cpu->exception_index =3D EXCP_BLOCKED;

Why do you need to set exception_index to something other than -1 (using
cpu_loop_exit_noexc for example)?

Using ->stop here is a bit weird, since ->stop is usually related to
pause_all_vcpus.

Paolo


