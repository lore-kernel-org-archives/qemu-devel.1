Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EC2217F9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsMeUd0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EC2217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlKT-0005A0-57
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iWlJ1-0004Dy-O6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iWlJ0-00077S-5b
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:59:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iWlJ0-000779-0y
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574099957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgHRWXBcxuxaKCAEqUZcxNNJVWP9Joxm0Ojk5V3hxyE=;
 b=PsMeUd0zkzZSTJd3u/o9C93XJnh/iwMAfX0CHmdNISTvxPqd79fGHF6apzBPk3xCv9W3Y2
 fQ8K0O6yQTmcJXPIOJyClqgtQPIap/o+y1zVyEq1Uwc0Fj+TLDZLkdW1hENpc5y5WQlKJu
 TAwxjRstvZ24uhpbsyl+9L0IDPSSu78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-b67xWplDPwKte7uCUpYODA-1; Mon, 18 Nov 2019 12:59:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBB6A8018A2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-76.gru2.redhat.com
 [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16AEA60D0B;
 Mon, 18 Nov 2019 17:59:12 +0000 (UTC)
Subject: Re: [PATCH 06/16] vl: configure accelerators from -accel options
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-7-git-send-email-pbonzini@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <7ce1069a-7364-d04a-5ef2-a561f376cd5b@redhat.com>
Date: Mon, 18 Nov 2019 15:59:11 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1573655945-14912-7-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: b67xWplDPwKte7uCUpYODA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/13/19 12:38 PM, Paolo Bonzini wrote:
> Drop the "accel" property from MachineState, and instead desugar
> "-machine accel=3D" to a list of "-accel" options.
>
> This has a semantic change due to removing merge_lists from -accel.
> For example:
>
> - "-accel kvm -accel tcg" all but ignored "-accel kvm".  This is a bugfix=
.
>
> - "-accel kvm -accel thread=3Dsingle" ignored "thread=3Dsingle", since it
>    applied the option to KVM.  Now it fails due to not specifying the
>    accelerator on "-accel thread=3Dsingle".
>
> - "-accel tcg -accel thread=3Dsingle" chose single-threaded TCG, while no=
w
>    it will fail due to not specifying the accelerator on "-accel
>    thread=3Dsingle".
>
> Also, "-machine accel" and "-accel" become incompatible.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/machine.c   | 21 ------------
>   include/hw/boards.h |  1 -
>   vl.c                | 93 +++++++++++++++++++++++++++++++---------------=
-------
>   3 files changed, 54 insertions(+), 61 deletions(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1689ad3..45ddfb6 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -173,21 +173,6 @@ GlobalProperty hw_compat_2_1[] =3D {
>   };
>   const size_t hw_compat_2_1_len =3D G_N_ELEMENTS(hw_compat_2_1);
>  =20
> -static char *machine_get_accel(Object *obj, Error **errp)
> -{
> -    MachineState *ms =3D MACHINE(obj);
> -
> -    return g_strdup(ms->accel);
> -}
> -
> -static void machine_set_accel(Object *obj, const char *value, Error **er=
rp)
> -{
> -    MachineState *ms =3D MACHINE(obj);
> -
> -    g_free(ms->accel);
> -    ms->accel =3D g_strdup(value);
> -}
> -
>   static void machine_set_kernel_irqchip(Object *obj, Visitor *v,
>                                          const char *name, void *opaque,
>                                          Error **errp)
> @@ -808,11 +793,6 @@ static void machine_class_init(ObjectClass *oc, void=
 *data)
>       mc->numa_mem_align_shift =3D 23;
>       mc->numa_auto_assign_ram =3D numa_default_auto_assign_ram;
>  =20
> -    object_class_property_add_str(oc, "accel",
> -        machine_get_accel, machine_set_accel, &error_abort);
> -    object_class_property_set_description(oc, "accel",
> -        "Accelerator list", &error_abort);
> -
>       object_class_property_add(oc, "kernel-irqchip", "on|off|split",
>           NULL, machine_set_kernel_irqchip,
>           NULL, NULL, &error_abort);
> @@ -971,7 +951,6 @@ static void machine_finalize(Object *obj)
>   {
>       MachineState *ms =3D MACHINE(obj);
>  =20
> -    g_free(ms->accel);
>       g_free(ms->kernel_filename);
>       g_free(ms->initrd_filename);
>       g_free(ms->kernel_cmdline);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index de45087..36fcbda 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -275,7 +275,6 @@ struct MachineState {
>  =20
>       /*< public >*/
>  =20
> -    char *accel;
>       bool kernel_irqchip_allowed;
>       bool kernel_irqchip_required;
>       bool kernel_irqchip_split;
> diff --git a/vl.c b/vl.c
> index b93217d..dd895db 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -293,7 +293,6 @@ static QemuOptsList qemu_accel_opts =3D {
>       .name =3D "accel",
>       .implied_opt_name =3D "accel",
>       .head =3D QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
> -    .merge_lists =3D true,
>       .desc =3D {
>           {
>               .name =3D "accel",
> @@ -2651,6 +2650,11 @@ static int machine_set_property(void *opaque,
>           }
>       }
>  =20
> +    /* Legacy options do not correspond to MachineState properties.  */
> +    if (g_str_equal(qom_name, "accel")) {
> +        return 0;
> +    }
> +
>       r =3D object_parse_property_opt(opaque, name, value, "type", errp);
>       g_free(qom_name);
>       return r;
> @@ -2843,74 +2847,88 @@ static int do_configure_icount(void *opaque, Qemu=
Opts *opts, Error **errp)
>  =20
>   static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error=
 **errp)
>   {
> +    bool *p_init_failed =3D opaque;
> +    const char *acc =3D qemu_opt_get(opts, "accel");
> +    AccelClass *ac =3D accel_find(acc);
> +    int ret;
> +
> +    if (!ac) {
> +        return 0;
> +    }
> +    ret =3D accel_init_machine(ac, current_machine);
> +    if (ret < 0) {
> +        *p_init_failed =3D true;
> +        error_report("failed to initialize %s: %s",
> +                     acc, strerror(-ret));
> +        return 0;
> +    }
> +
>       if (tcg_enabled()) {
>           qemu_tcg_configure(opts, &error_fatal);
>       }
> -    return 0;
> +    return 1;
>   }
>  =20
>   static void configure_accelerators(const char *progname)
>   {
>       const char *accel;
>       char **accel_list, **tmp;
> -    int ret;
>       bool accel_initialised =3D false;
>       bool init_failed =3D false;
> -    AccelClass *acc =3D NULL;
>  =20
>       qemu_opts_foreach(qemu_find_opts("icount"),
>                         do_configure_icount, NULL, &error_fatal);
>  =20
>       accel =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
> -    if (accel =3D=3D NULL) {
> -        /* Select the default accelerator */
> -        if (!accel_find("tcg") && !accel_find("kvm")) {
> -            error_report("No accelerator selected and"
> -                         " no default accelerator available");

Perhaps on patch 07 you can also clarify this message, mentioning what's=20
the default accelerator.

> -            exit(1);
> -        } else {
> -            int pnlen =3D strlen(progname);
> -            if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3], "kvm")=
) {
> -                /* If the program name ends with "kvm", we prefer KVM */
> -                accel =3D "kvm:tcg";
> +    if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
> +        if (accel =3D=3D NULL) {
> +            /* Select the default accelerator */
> +            if (!accel_find("tcg") && !accel_find("kvm")) {
> +                error_report("No accelerator selected and"
> +                             " no default accelerator available");
> +                exit(1);
>               } else {
> -                accel =3D "tcg:kvm";
> +                int pnlen =3D strlen(progname);
> +                if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3], "k=
vm")) {
> +                    /* If the program name ends with "kvm", we prefer KV=
M */
> +                    accel =3D "kvm:tcg";
> +                } else {
> +                    accel =3D "tcg:kvm";
> +                }
>               }
>           }
> -    }
>  =20
> -    accel_list =3D g_strsplit(accel, ":", 0);
> +        accel_list =3D g_strsplit(accel, ":", 0);
>  =20
> -    for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp++) {
> -        acc =3D accel_find(*tmp);
> -        if (!acc) {
> -            continue;
> +        for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp+=
+) {
> +            /*
> +             * Filter invalid accelerators here, to prevent obscenities
> +             * such as "-machine accel=3Dtcg,,thread=3Dsingle".
> +             */
> +            if (accel_find(*tmp)) {
> +                qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, t=
rue);
> +            }
>           }
> -        ret =3D accel_init_machine(acc, current_machine);
> -        if (ret < 0) {
> -            init_failed =3D true;
> -            error_report("failed to initialize %s: %s",
> -                         acc->name, strerror(-ret));
> -        } else {
> -            accel_initialised =3D true;
> +    } else {
> +        if (accel !=3D NULL) {
> +            error_report("The -accel and \"-machine accel=3D\" options a=
re incompatible");
> +            exit(1);
>           }
>       }
> -    g_strfreev(accel_list);
>  =20
> -    if (!accel_initialised) {
> +    if (!qemu_opts_foreach(qemu_find_opts("accel"),
> +                           do_configure_accelerator, &init_failed, &erro=
r_fatal)) {
>           if (!init_failed) {
> -            error_report("-machine accel=3D%s: No accelerator found", ac=
cel);
> +            error_report("no accelerator found");

Likewise.

Thanks,

Wainer

>           }
>           exit(1);
>       }
>  =20
>       if (init_failed) {
> -        error_report("Back to %s accelerator", acc->name);
> +        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
> +        error_report("Back to %s accelerator", ac->name);
>       }
>  =20
> -    qemu_opts_foreach(qemu_find_opts("accel"),
> -                      do_configure_accelerator, NULL, &error_fatal);
> -
>       if (!tcg_enabled() && use_icount) {
>           error_report("-icount is not allowed with hardware virtualizati=
on");
>           exit(1);
> @@ -3618,9 +3636,6 @@ int main(int argc, char **argv, char **envp)
>                                    "use -M accel=3D... for now instead");
>                       exit(1);
>                   }
> -                opts =3D qemu_opts_create(qemu_find_opts("machine"), NUL=
L,
> -                                        false, &error_abort);
> -                qemu_opt_set(opts, "accel", optarg, &error_abort);
>                   break;
>               case QEMU_OPTION_usb:
>                   olist =3D qemu_find_opts("machine");


