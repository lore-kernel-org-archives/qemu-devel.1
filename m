Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2830BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6ED62073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sslfVi+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6ED62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ief2G-0001Qk-2d
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 07:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ief1T-0000u0-Sf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ief1S-00023y-4H
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:53:51 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ief1R-000237-TU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:53:50 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so3038638wmi.5
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 04:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=E+EAOWnviqmyZP0NIV56eNheQeY3Orsb4a4/aR54/dI=;
 b=sslfVi+6HlunLrvgNCHvpZ1TvKnb1c24ppoUaZjEjWE73AydN5abx6L50c4I54KDlp
 5jP1TXEF3Pps5KWbOJvM1fgUoOq3xCqlr8GcAEX0uI3sivIZDS5O+BqvKumD0q8pWchn
 FuvcEEGPmHe+saeDEgxLRii9WAidaS6crhYx4VC+rVBPQLjt3DgsA8NyR0ugxhWhlX1E
 dl3+asQ3F731dmnOUWG6kBBkex9V0m0WJsvw4dicN0W7+bGOXUzGwCW70YcapVZsTssQ
 mCbYF3inMRFs5DWTmrkOJgoc/KmcUmTFWAtC6KcJPIZicJPGLkntaVWVoWgbif5ffwhJ
 J9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E+EAOWnviqmyZP0NIV56eNheQeY3Orsb4a4/aR54/dI=;
 b=S+KIIgM/4BMqRzNzIjdzQM0g+0fCgQ0NRnni4TwrDoskas0in9BywAFFX+JZTB3W5i
 nr7gUEr6qGn5JdxizrCKFrJe6hYyesZ++CBpCSLlCUDa3aoa06WWb0AXYtbzbMlgoVYh
 B7KYfDsjy2fzr1eO43OH15arNFZa44FZiw3cgRMv7Y5w0eNaVJbkcMkASWvGNqRd+0eR
 2koV/n2M0kNzM3ePBRMXa7yaFBWrd5I009QBNY4hsjk8/7tqy3nsBo/ehMqH/qZSKVEW
 xjCYPmUE9wk1RkV0ItXwR4qXC8DPjSCaQdBt8VZS3a/ew3zkLlRQBFNUOfXeA2TNYz0e
 +4BA==
X-Gm-Message-State: APjAAAWZ5DUE6xhDvBzJOeQf5VHOU+TFFml40F3WQWvACtI7dZcxQNQ5
 pAO/uzqLFL90+xpKQBEkNk9Lz29zzvYw5TAEByPa+xzc2B8=
X-Google-Smtp-Source: APXvYqxv5hwDCNHmpvsrnin4ovGdoRBojcHPqRGShZWKQEuDOxRzi/kc9OygKkjeqGzzAmOK3jjzQscK0p1mtyXBBgE=
X-Received: by 2002:a1c:750f:: with SMTP id o15mr5174029wmc.161.1575982428678; 
 Tue, 10 Dec 2019 04:53:48 -0800 (PST)
MIME-Version: 1.0
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1575903705-12925-15-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Dec 2019 16:53:36 +0400
Message-ID: <CAJ+F1CK2CPwjt39i9Jd+Uf9h9tRjU3dyf7B1dnwHAy0MFhVYnA@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] tcg: add "-accel tcg,
 tb-size" and deprecate "-tb-size"
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
 elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Dec 9, 2019 at 7:17 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> -tb-size fits nicely in the new framework for accelerator-specific option=
s.  It
> is a very niche option, so insta-deprecate it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/tcg-all.c    | 40 +++++++++++++++++++++++++++++++++++++---
>  include/sysemu/accel.h |  2 --
>  qemu-deprecated.texi   |  6 ++++++
>  qemu-options.hx        |  8 ++++++--
>  vl.c                   |  8 ++++----
>  5 files changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 7829f02..1dc384c 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -34,11 +34,13 @@
>  #include "include/qapi/error.h"
>  #include "include/qemu/error-report.h"
>  #include "include/hw/boards.h"
> +#include "qapi/qapi-builtin-visit.h"
>
>  typedef struct TCGState {
>      AccelState parent_obj;
>
>      bool mttcg_enabled;
> +    unsigned long tb_size;
>  } TCGState;
>
>  #define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
> @@ -46,8 +48,6 @@ typedef struct TCGState {
>  #define TCG_STATE(obj) \
>          OBJECT_CHECK(TCGState, (obj), TYPE_TCG_ACCEL)
>
> -unsigned long tcg_tb_size;
> -
>  /* mask must never be zero, except for A20 change call */
>  static void tcg_handle_interrupt(CPUState *cpu, int mask)
>  {
> @@ -126,7 +126,7 @@ static int tcg_init(MachineState *ms)
>  {
>      TCGState *s =3D TCG_STATE(current_machine->accelerator);
>
> -    tcg_exec_init(tcg_tb_size * 1024 * 1024);
> +    tcg_exec_init(s->tb_size * 1024 * 1024);
>      cpu_interrupt_handler =3D tcg_handle_interrupt;
>      mttcg_enabled =3D s->mttcg_enabled;
>      return 0;
> @@ -167,6 +167,33 @@ static void tcg_set_thread(Object *obj, const char *=
value, Error **errp)
>      }
>  }
>
> +static void tcg_get_tb_size(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    TCGState *s =3D TCG_STATE(obj);
> +    uint32_t value =3D s->tb_size;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static void tcg_set_tb_size(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    TCGState *s =3D TCG_STATE(obj);
> +    Error *error =3D NULL;
> +    uint32_t value;
> +
> +    visit_type_uint32(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    s->tb_size =3D value;
> +}
> +
>  static void tcg_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac =3D ACCEL_CLASS(oc);
> @@ -178,6 +205,13 @@ static void tcg_accel_class_init(ObjectClass *oc, vo=
id *data)
>                                    tcg_get_thread,
>                                    tcg_set_thread,
>                                    NULL);
> +
> +    object_class_property_add(oc, "tb-size", "int",
> +        tcg_get_tb_size, tcg_set_tb_size,
> +        NULL, NULL, &error_abort);

After Felipe properties series, we should switch this to
object_class_property_add_uint32_ptr(). Would you mind adding a FIXME
if you agree?


> +    object_class_property_set_description(oc, "tb-size",
> +        "TCG translation block cache size", &error_abort);
> +
>  }
>
>  static const TypeInfo tcg_accel_type =3D {
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 22cac0f..d4c1429 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -64,8 +64,6 @@ typedef struct AccelClass {
>  #define ACCEL_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(AccelClass, (obj), TYPE_ACCEL)
>
> -extern unsigned long tcg_tb_size;
> -
>  AccelClass *accel_find(const char *opt_name);
>  int accel_init_machine(AccelState *accel, MachineState *ms);
>
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 4b4b742..487d2b4 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -147,6 +147,12 @@ QEMU 4.1 has three options, please migrate to one of=
 these three:
>        to do is specify the kernel they want to boot with the -kernel opt=
ion
>   3. ``-bios <file>`` - Tells QEMU to load the specified file as the firm=
wrae.
>
> +@subsection -tb-size option (since 5.0)
> +
> +QEMU 5.0 introduced an alternative syntax to specify the size of the tra=
nslation
> +block cache, @option{-accel tcg,tb-size=3D}.  The new syntax deprecates =
the
> +previously available @option{-tb-size} option.
> +
>  @section QEMU Machine Protocol (QMP) commands
>
>  @subsection change (since 2.5.0)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 65c9473..9775258 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -118,8 +118,9 @@ Select CPU model (@code{-cpu help} for list and addit=
ional feature selection)
>  ETEXI
>
>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> -    "-accel [accel=3D]accelerator[,thread=3Dsingle|multi]\n"
> +    "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
>      "                select accelerator (kvm, xen, hax, hvf, whpx or tcg=
; use 'help' for a list)\n"
> +    "                tb-size=3Dn (TCG translation block cache size)\n"
>      "                thread=3Dsingle|multi (enable multi-threaded TCG)\n=
", QEMU_ARCH_ALL)
>  STEXI
>  @item -accel @var{name}[,prop=3D@var{value}[,...]]
> @@ -129,6 +130,8 @@ kvm, xen, hax, hvf, whpx or tcg can be available. By =
default, tcg is used. If th
>  more than one accelerator specified, the next one is used if the previou=
s one
>  fails to initialize.
>  @table @option
> +@item tb-size=3D@var{n}
> +Controls the size (in MiB) of the TCG translation block cache.
>  @item thread=3Dsingle|multi
>  Controls number of TCG threads. When the TCG is multi-threaded there wil=
l be one
>  thread per vCPU therefor taking advantage of additional host cores. The =
default
> @@ -4012,7 +4015,8 @@ DEF("tb-size", HAS_ARG, QEMU_OPTION_tb_size, \
>  STEXI
>  @item -tb-size @var{n}
>  @findex -tb-size
> -Set TB size.
> +Set TCG translation block cache size.  Deprecated, use @samp{-accel tcg,=
tb-size=3D@var{n}}
> +instead.
>  ETEXI
>
>  DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
> diff --git a/vl.c b/vl.c
> index b6c23d1..e6ff56b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2852,6 +2852,7 @@ static int do_configure_accelerator(void *opaque, Q=
emuOpts *opts, Error **errp)
>          return 0;
>      }
>      accel =3D ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
> +    object_apply_compat_props(OBJECT(accel));
>      qemu_opt_foreach(opts, accelerator_set_property,
>                       accel,
>                       &error_fatal);
> @@ -2863,6 +2864,7 @@ static int do_configure_accelerator(void *opaque, Q=
emuOpts *opts, Error **errp)
>                       acc, strerror(-ret));
>          return 0;
>      }
> +
>      return 1;
>  }
>
> @@ -3745,10 +3747,8 @@ int main(int argc, char **argv, char **envp)
>                  error_report("TCG is disabled");
>                  exit(1);
>  #endif
> -                if (qemu_strtoul(optarg, NULL, 0, &tcg_tb_size) < 0) {
> -                    error_report("Invalid argument to -tb-size");
> -                    exit(1);
> -                }
> +                warn_report("The -tb-size option is deprecated, use -acc=
el tcg,tb-size instead");
> +                object_register_sugar_prop(ACCEL_CLASS_NAME("tcg"), "tb-=
size", optarg);
>                  break;
>              case QEMU_OPTION_icount:
>                  icount_opts =3D qemu_opts_parse_noisily(qemu_find_opts("=
icount"),
> --
> 1.8.3.1
>
>
>

otherwise,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau

