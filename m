Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4D6C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 08:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C50E206EF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 08:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxNR0zVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C50E206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVAGd-0003Ru-9p
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 03:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVAFz-00030a-Cs
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVAFx-0005xi-S7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:13:35 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iVAFx-0005xG-JP
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:13:33 -0500
Received: by mail-wm1-x342.google.com with SMTP id z26so4631393wmi.4
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 00:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eaO8Scox9WRQ8A44IJJc/BIV+t9mH6asVTEC45zygNc=;
 b=dxNR0zVRQOphV3n0qYDDbu9guq/8QM5ySmou1TktMjZOAEGw49sh5nm2n+FgMvY6Ek
 o3F9H1kJD4BZAE4K21nJBzdU2IGAoTA6W7V2MSZJ1CL7R2SPsenM9VjfE4taOZXAdMwe
 n9qhQhjineiBQzbhmnYVAuHBYjZcA3ucPk20jGKaBLrVI/0+K4Vaw8V6yEKVpBIOhoMG
 iAKTcl3DHfstx8rvJnJOPkuIIvRjBolEZyPh90ymg3wpwtZ88QT3skRlpqW5Wj2i5jVb
 XM3DYerxil90T/R/Bbj/XXSg2zsIO6rAPUgF9PYpYvg5xM0480q0Qr6FgwcPJFZL/Ux4
 De9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eaO8Scox9WRQ8A44IJJc/BIV+t9mH6asVTEC45zygNc=;
 b=outPF/idypA3OU/AyqTLfRQZrLPTgaWIXiM17WxrP6N05x/IcHEBHWB8ofgAW9ax1Y
 jFNm5DZVLvYgYndmmcdFJhgwXZckWFJ1bz7VgNaiQYJh5M7Vg19NBfJ6yN8qXQLTV+BA
 H6Qv7zs6Up43b1vVlnzdaZAmQAbgPjyogsiR6lHxyjmbyfzTGqsOL03ssBytXtB14rPD
 X4yucXodDd6IT8HKQbeXm2bzMsss3o0ca7pKi3EM5MbQoFLrj3x7ycfAcuxOW74MSLan
 dkB7oQttkHRudcsidaCoNLrTKgUh1omMhhUULVYoZAYYPmEvruxnxYOgGPIhrLJ0iVgD
 t+sw==
X-Gm-Message-State: APjAAAX3OwghOfyWahC0pwEsk2BTcLaVJZhpbTTgvsrXaRx/FZ0djMpE
 4NoabFu82C10SyTOhEuMTSs3SmrkSRT0R0K1f+frq9UdJ1g=
X-Google-Smtp-Source: APXvYqwmLyfPJH4EubBDLALoppCJeQYl26x1BbbjYaq08lBrlEM8ei6gV5jIRG25TNopIcL9P7OM7z+3saH1lE0bANg=
X-Received: by 2002:a1c:9e10:: with SMTP id h16mr6465490wme.91.1573719211722; 
 Thu, 14 Nov 2019 00:13:31 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573655945-14912-4-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2019 12:13:18 +0400
Message-ID: <CAJ+F1CL4aqmH=_u768BO223PutusCNxa+FSA78g6Mj9FTe2YqA@mail.gmail.com>
Subject: Re: [PATCH 03/16] vl: merge -accel processing into
 configure_accelerators
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 13, 2019 at 6:42 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The next step is to move the parsing of "-machine accel=3D..." into vl.c,
> unifying it with the configure_accelerators() function that has just
> been introduced.  This way, we will be able to desugar it into multiple
> "-accel" options, without polluting accel/accel.c.
>
> The CONFIG_TCG and CONFIG_KVM symbols are not available in vl.c, but
> we can use accel_find instead to find their value at runtime.  Once we
> know that the binary has one of TCG or KVM, the default accelerator
> can be expressed simply as "tcg:kvm", because TCG never fails to initiali=
ze.
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/accel.c          | 63 ++------------------------------------------=
------
>  include/sysemu/accel.h |  4 +++-
>  vl.c                   | 62 ++++++++++++++++++++++++++++++++++++++++++++=
+----
>  3 files changed, 62 insertions(+), 67 deletions(-)
>
> diff --git a/accel/accel.c b/accel/accel.c
> index 5fa3171..74eda68 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -44,7 +44,7 @@ static const TypeInfo accel_type =3D {
>  };
>
>  /* Lookup AccelClass from opt_name. Returns NULL if not found */
> -static AccelClass *accel_find(const char *opt_name)
> +AccelClass *accel_find(const char *opt_name)
>  {
>      char *class_name =3D g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_nam=
e);
>      AccelClass *ac =3D ACCEL_CLASS(object_class_by_name(class_name));
> @@ -52,7 +52,7 @@ static AccelClass *accel_find(const char *opt_name)
>      return ac;
>  }
>
> -static int accel_init_machine(AccelClass *acc, MachineState *ms)
> +int accel_init_machine(AccelClass *acc, MachineState *ms)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(acc);
>      const char *cname =3D object_class_get_name(oc);
> @@ -71,65 +71,6 @@ static int accel_init_machine(AccelClass *acc, Machine=
State *ms)
>      return ret;
>  }
>
> -void configure_accelerator(MachineState *ms, const char *progname)
> -{
> -    const char *accel;
> -    char **accel_list, **tmp;
> -    int ret;
> -    bool accel_initialised =3D false;
> -    bool init_failed =3D false;
> -    AccelClass *acc =3D NULL;
> -
> -    accel =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
> -    if (accel =3D=3D NULL) {
> -        /* Select the default accelerator */
> -        int pnlen =3D strlen(progname);
> -        if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
> -            /* If the program name ends with "kvm", we prefer KVM */
> -            accel =3D "kvm:tcg";
> -        } else {
> -#if defined(CONFIG_TCG)
> -            accel =3D "tcg";
> -#elif defined(CONFIG_KVM)
> -            accel =3D "kvm";
> -#else
> -            error_report("No accelerator selected and"
> -                         " no default accelerator available");
> -            exit(1);
> -#endif
> -        }
> -    }
> -
> -    accel_list =3D g_strsplit(accel, ":", 0);
> -
> -    for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp++) {
> -        acc =3D accel_find(*tmp);
> -        if (!acc) {
> -            continue;
> -        }
> -        ret =3D accel_init_machine(acc, ms);
> -        if (ret < 0) {
> -            init_failed =3D true;
> -            error_report("failed to initialize %s: %s",
> -                         acc->name, strerror(-ret));
> -        } else {
> -            accel_initialised =3D true;
> -        }
> -    }
> -    g_strfreev(accel_list);
> -
> -    if (!accel_initialised) {
> -        if (!init_failed) {
> -            error_report("-machine accel=3D%s: No accelerator found", ac=
cel);
> -        }
> -        exit(1);
> -    }
> -
> -    if (init_failed) {
> -        error_report("Back to %s accelerator", acc->name);
> -    }
> -}
> -
>  void accel_setup_post(MachineState *ms)
>  {
>      AccelState *accel =3D ms->accelerator;
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 8eb60b8..90b6213 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -66,7 +66,9 @@ typedef struct AccelClass {
>
>  extern unsigned long tcg_tb_size;
>
> -void configure_accelerator(MachineState *ms, const char *progname);
> +AccelClass *accel_find(const char *opt_name);
> +int accel_init_machine(AccelClass *acc, MachineState *ms);
> +
>  /* Called just before os_setup_post (ie just before drop OS privs) */
>  void accel_setup_post(MachineState *ms);
>
> diff --git a/vl.c b/vl.c
> index 5367f23..fc9e70f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2845,8 +2845,62 @@ static int do_configure_accelerator(void *opaque, =
QemuOpts *opts, Error **errp)
>      return 0;
>  }
>
> -static void configure_accelerators(void)
> +static void configure_accelerators(const char *progname)
>  {
> +    const char *accel;
> +    char **accel_list, **tmp;
> +    int ret;
> +    bool accel_initialised =3D false;
> +    bool init_failed =3D false;
> +    AccelClass *acc =3D NULL;
> +
> +    accel =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
> +    if (accel =3D=3D NULL) {
> +        /* Select the default accelerator */
> +        if (!accel_find("tcg") && !accel_find("kvm")) {
> +            error_report("No accelerator selected and"
> +                         " no default accelerator available");
> +            exit(1);
> +        } else {
> +            int pnlen =3D strlen(progname);
> +            if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3], "kvm")=
) {
> +                /* If the program name ends with "kvm", we prefer KVM */
> +                accel =3D "kvm:tcg";
> +            } else {
> +                accel =3D "tcg:kvm";
> +            }
> +        }
> +    }
> +
> +    accel_list =3D g_strsplit(accel, ":", 0);
> +
> +    for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp++) {
> +        acc =3D accel_find(*tmp);
> +        if (!acc) {
> +            continue;
> +        }
> +        ret =3D accel_init_machine(acc, current_machine);
> +        if (ret < 0) {
> +            init_failed =3D true;
> +            error_report("failed to initialize %s: %s",
> +                         acc->name, strerror(-ret));
> +        } else {
> +            accel_initialised =3D true;
> +        }
> +    }
> +    g_strfreev(accel_list);
> +
> +    if (!accel_initialised) {
> +        if (!init_failed) {
> +            error_report("-machine accel=3D%s: No accelerator found", ac=
cel);
> +        }
> +        exit(1);
> +    }
> +
> +    if (init_failed) {
> +        error_report("Back to %s accelerator", acc->name);
> +    }
> +
>      qemu_opts_foreach(qemu_find_opts("icount"),
>                        do_configure_icount, NULL, &error_fatal);
>
> @@ -4183,7 +4237,8 @@ int main(int argc, char **argv, char **envp)
>       * Note: uses machine properties such as kernel-irqchip, must run
>       * after machine_set_property().
>       */
> -    configure_accelerator(current_machine, argv[0]);
> +    cpu_ticks_init();
> +    configure_accelerators(argv[0]);
>
>      /*
>       * Beware, QOM objects created before this point miss global and
> @@ -4267,9 +4322,6 @@ int main(int argc, char **argv, char **envp)
>      /* spice needs the timers to be initialized by this point */
>      qemu_spice_init();
>
> -    cpu_ticks_init();
> -    configure_accelerators();
> -
>      if (default_net) {
>          QemuOptsList *net =3D qemu_find_opts("net");
>          qemu_opts_set(net, NULL, "type", "nic", &error_abort);
> --
> 1.8.3.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

