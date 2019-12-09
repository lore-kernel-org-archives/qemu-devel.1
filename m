Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF48C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A602068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUGbqmGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A602068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKy7-0006Dn-7E
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieKxF-0005iF-Bs
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieKxD-0000HY-Sz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:28:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieKxD-0000HS-PE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575905287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMf2SzgGOkups3ZfibpY7cB3/DLZv13/bx3GcAtb7LY=;
 b=ZUGbqmGqXmoG7SMQXHFw3AyTRrv2vWjUDVEVa4m30ZpT+QUHPb05UsoWncVRgmhFdI6e7y
 +s+QJIPQGjkE75scngTaRb3DiS09LcxIk926PVySP23k5Y38KFv3YmwYP7Zly8sLFnZ1tA
 7rkYxc6lDFppLHxd3vTPB8UrDquP/qc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-VnM1k_gSNE6ti3m9Gv5HtA-1; Mon, 09 Dec 2019 10:28:03 -0500
Received: by mail-wm1-f69.google.com with SMTP id g26so3095042wmk.6
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aNL6FR7ESIi6R8yIVsztOzrw3vLhiqsqy60KJj6oNAc=;
 b=pgy8kLIhY190Bl+g6bxzLKKTU4gWi7kiqhawyIINGOrs2soeAGu9JmxBOR/x0fO/z4
 eLAkI7Y4iIRJGzou57qpMs1Fyx6NNlgNPvzMXY8ckDkl7MhsK/BTrxu+1hC58IfxB4Is
 pPBbcTPPwdqYnX6kMhXsjPw6G7SQ+QpHCI7iZWXxpudLu4f0Pcq237UeqaoiWVwoV41H
 vA+GbJV3I9cf5uatfSlUXvlWpNxXAI5S3vyGkVr2v1k9BVOcjMRP7ottWUina6lxR3QV
 cRbUy/0nzeev56so+nfkTsnbj6A1tK0WjZJrIBc1y1VeXIIIGqj6MmXBROX8+UIbMqdz
 40OQ==
X-Gm-Message-State: APjAAAV3/c/DCplKk82uKLx4YW2TcPEl+0SRZgUrtWyuCOhVCEDdQ4c+
 vPi/pFXMhrctdzUgGL/6P2C90yapg0Vj2vaRZLmq5zro6Yiy0EoB3yWD/sBD6Rwsrew+HMMYTtk
 flq7KWhGTxdoZB/Q=
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr26639767wmi.1.1575905282682; 
 Mon, 09 Dec 2019 07:28:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxc0FJ9Ju3/PVXoqwu7yE5yNl0Y+VmGZQLUyec6uDfFhcdyyPb7fcDyLM6os39Iv38rNFpeA==
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr26639735wmi.1.1575905282423; 
 Mon, 09 Dec 2019 07:28:02 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id n30sm128359wmd.3.2019.12.09.07.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:28:01 -0800 (PST)
Subject: Re: [PATCH v2 13/18] tcg: convert "-accel threads" to a QOM property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-14-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <006616d3-1e38-c1fa-3d28-d574cc3e50b3@redhat.com>
Date: Mon, 9 Dec 2019 16:28:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-14-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: VnM1k_gSNE6ti3m9Gv5HtA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 4:01 PM, Paolo Bonzini wrote:
> Replace the ad-hoc qemu_tcg_configure with generic code invoking QOM
> property getters and setters.  More properties (and thus more valid
> -accel suboptions) will be added in the next patches, which will move
> accelerator-related "-machine" options to accelerators.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   accel/tcg/tcg-all.c   | 50 ++++++++++++++++++++++++++++++++++++--------=
------
>   include/sysemu/cpus.h |  2 --
>   vl.c                  | 32 +++++++++++++++++---------------
>   3 files changed, 53 insertions(+), 31 deletions(-)
>=20
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 78a0ab5..7829f02 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -34,7 +34,17 @@
>   #include "include/qapi/error.h"
>   #include "include/qemu/error-report.h"
>   #include "include/hw/boards.h"
> -#include "qemu/option.h"
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
>  =20
>   unsigned long tcg_tb_size;
>  =20
> @@ -109,23 +119,31 @@ static void tcg_accel_instance_init(Object *obj)
>   {
>       TCGState *s =3D TCG_STATE(obj);
>  =20
> -    mttcg_enabled =3D default_mttcg_enabled();
> +    s->mttcg_enabled =3D default_mttcg_enabled();
>   }
>  =20
>   static int tcg_init(MachineState *ms)
>   {
> +    TCGState *s =3D TCG_STATE(current_machine->accelerator);
> +
>       tcg_exec_init(tcg_tb_size * 1024 * 1024);
>       cpu_interrupt_handler =3D tcg_handle_interrupt;
> +    mttcg_enabled =3D s->mttcg_enabled;
>       return 0;
>   }
>  =20
> -void qemu_tcg_configure(QemuOpts *opts, Error **errp)
> +static char *tcg_get_thread(Object *obj, Error **errp)
>   {
> -    const char *t =3D qemu_opt_get(opts, "thread");
> -    if (!t) {
> -        return;
> -    }
> -    if (strcmp(t, "multi") =3D=3D 0) {
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
>           if (TCG_OVERSIZED_GUEST) {
>               error_setg(errp, "No MTTCG when guest word size > hosts");
>           } else if (use_icount) {
> @@ -140,12 +158,12 @@ void qemu_tcg_configure(QemuOpts *opts, Error **err=
p)
>                               "than the host provides");
>                   error_printf("This may cause strange/hard to debug erro=
rs\n");
>               }
> -            mttcg_enabled =3D true;
> +            s->mttcg_enabled =3D true;
>           }
> -    } else if (strcmp(t, "single") =3D=3D 0) {
> -        mttcg_enabled =3D false;
> +    } else if (strcmp(value, "single") =3D=3D 0) {
> +        s->mttcg_enabled =3D false;
>       } else {
> -        error_setg(errp, "Invalid 'thread' setting %s", t);
> +        error_setg(errp, "Invalid 'thread' setting %s", value);
>       }
>   }
>  =20
> @@ -155,15 +173,19 @@ static void tcg_accel_class_init(ObjectClass *oc, v=
oid *data)
>       ac->name =3D "tcg";
>       ac->init_machine =3D tcg_init;
>       ac->allowed =3D &tcg_allowed;
> -}
>  =20
> -#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
> +    object_class_property_add_str(oc, "thread",
> +                                  tcg_get_thread,
> +                                  tcg_set_thread,
> +                                  NULL);
> +}
>  =20
>   static const TypeInfo tcg_accel_type =3D {
>       .name =3D TYPE_TCG_ACCEL,
>       .parent =3D TYPE_ACCEL,
>       .instance_init =3D tcg_accel_instance_init,
>       .class_init =3D tcg_accel_class_init,
> +    .instance_size =3D sizeof(TCGState),
>   };
>  =20
>   static void register_accel_types(void)
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 32c05f2..3c1da6a 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -40,6 +40,4 @@ extern int smp_threads;
>  =20
>   void list_cpus(const char *optarg);
>  =20
> -void qemu_tcg_configure(QemuOpts *opts, Error **errp);
> -
>   #endif
> diff --git a/vl.c b/vl.c
> index 078ab7a..b6c23d1 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -295,17 +295,12 @@ static QemuOptsList qemu_accel_opts =3D {
>       .implied_opt_name =3D "accel",
>       .head =3D QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
>       .desc =3D {
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
>       },
>   };
>  =20
> @@ -2836,6 +2831,13 @@ static int do_configure_icount(void *opaque, QemuO=
pts *opts, Error **errp)
>       return 0;
>   }
>  =20
> +static int accelerator_set_property(void *opaque,
> +                                const char *name, const char *value,
> +                                Error **errp)
> +{
> +    return object_parse_property_opt(opaque, name, value, "accel", errp)=
;
> +}
> +
>   static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error=
 **errp)
>   {
>       bool *p_init_failed =3D opaque;
> @@ -2850,6 +2852,10 @@ static int do_configure_accelerator(void *opaque, =
QemuOpts *opts, Error **errp)
>           return 0;
>       }
>       accel =3D ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
> +    qemu_opt_foreach(opts, accelerator_set_property,
> +                     accel,
> +                     &error_fatal);
> +
>       ret =3D accel_init_machine(accel, current_machine);
>       if (ret < 0) {
>           *p_init_failed =3D true;
> @@ -2857,10 +2863,6 @@ static int do_configure_accelerator(void *opaque, =
QemuOpts *opts, Error **errp)
>                        acc, strerror(-ret));
>           return 0;
>       }
> -
> -    if (tcg_enabled()) {
> -        qemu_tcg_configure(opts, &error_fatal);
> -    }
>       return 1;
>   }
>  =20
>=20


