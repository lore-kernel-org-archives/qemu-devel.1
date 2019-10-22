Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D39CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0142120640
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnCbv1gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0142120640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMq0s-0007jt-6x
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMq0B-0007Bv-Hg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMq09-0000lx-Iu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:58:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMq09-0000l8-Ei
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571734728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClnMIVCVSchrhUH/X8rae5F4lXRxmQWqJIcm8qZiUrg=;
 b=RnCbv1gryTrwFJCZ2mDoaDU9yk3qGXL6m/Z5HgMw/pIEWeR0kEqvdpcKVnGeGCOJryT3H8
 mEeLQfSR0CXuYKRLp27MrPzSWvz8sWyOGeLCYVrSCJtAWdJ6vi8HvcXemUgxJuXop0nvaC
 GS64kioRb7corjtsezl7SwaFea5ZKz4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-23TObJhPNIyQDnKyWgQ_bQ-1; Tue, 22 Oct 2019 04:58:46 -0400
Received: by mail-wr1-f69.google.com with SMTP id x9so2465331wrq.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 01:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ayd/SeWTSZAemrH7DapWEzpe3D7Ajn0oec+PTWibXxI=;
 b=ncqbOT5p1we21pWFtdcdUf1ndtytAiKdhM2b5lBYMik7q6mOqfkjFW5IiWbPSjAoDX
 osB0XBY/MjsRCsrh/C3b2qQJxIcXCyUC4wVBWU85CCuDlAXCLFaDWE9TfZlaOtQk5JXT
 0WKlQRbmjqu1aTwBHuufNJvol2bW7Qpchj+gtjxrhyxAaNikTO6169KW5HLltTMUpjfW
 dpMu6S+FYdoJloXj2myYWicujJ8nDPEfZU1zda7QTu3wynnypuOrIB9krGm22GfXuCzf
 GMmvVuTFWjM+3yu4nqwlcsOCMZQkzOwQDyzhkFE10xPS9kg4E4FMClA8U+HneoR1vKM3
 KnHw==
X-Gm-Message-State: APjAAAVHhqLBt0n3bvwinadmi1cZsy4awoCMh2I/YPVeiZSS8u8SkBrj
 AFMwCmlEuoEHjg0xs9K588mIWdqZyoyyeXJE4T59djwathVPWgdJvN7NayT8Q7S2Cn5jpMd/tJw
 sVU+emrKN6eqF8Zc=
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr2335990wrr.313.1571734724911; 
 Tue, 22 Oct 2019 01:58:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTXcOWmju4U9ee5t+FOXHv4KB5VV1t0sfWzoQ9v/XQMMNwTbL8+6Uyz8PGsUq5a1LMGJq1FQ==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr2335966wrr.313.1571734724627; 
 Tue, 22 Oct 2019 01:58:44 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id z9sm18223061wrl.35.2019.10.22.01.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 01:58:44 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] spapr_cpu_core: Implement DeviceClass::reset
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022072246.9200-1-clg@kaod.org>
 <20191022072246.9200-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <31941faa-88bd-b029-89e2-15374498af8a@redhat.com>
Date: Tue, 22 Oct 2019 10:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022072246.9200-3-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: 23TObJhPNIyQDnKyWgQ_bQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 9:22 AM, C=C3=A9dric Le Goater wrote:
> From: Greg Kurz <groug@kaod.org>
>=20
> Since vCPUs aren't plugged into a bus, we manually register a reset
> handler for each vCPU. We also call this handler at realize time
> to ensure hot plugged vCPUs are reset before being exposed to the
> guest. This results in vCPUs being reset twice at machine reset.
> It doesn't break anything but it is slightly suboptimal and above
> all confusing.
>=20
> The hotplug path in device_set_realized() already knows how to reset
> a hotplugged device if the device reset handler is present. Implement
> one for sPAPR CPU cores that resets all vCPUs under a core.
>=20
> While here rename spapr_cpu_reset() to spapr_reset_vcpu() for
> consistency with spapr_realize_vcpu() and spapr_unrealize_vcpu().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_cpu_core.c | 31 ++++++++++++++++++++++---------
>   1 file changed, 22 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 992f00da6540..5947e39b36ad 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -25,9 +25,8 @@
>   #include "sysemu/hw_accel.h"
>   #include "qemu/error-report.h"
>  =20
> -static void spapr_cpu_reset(void *opaque)
> +static void spapr_reset_vcpu(PowerPCCPU *cpu)
>   {
> -    PowerPCCPU *cpu =3D opaque;
>       CPUState *cs =3D CPU(cpu);
>       CPUPPCState *env =3D &cpu->env;
>       PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> @@ -193,7 +192,6 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, Spa=
prCpuCore *sc)
>       if (!sc->pre_3_0_migration) {
>           vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine=
_data);
>       }
> -    qemu_unregister_reset(spapr_cpu_reset, cpu);
>       if (spapr_cpu_state(cpu)->icp) {
>           object_unparent(OBJECT(spapr_cpu_state(cpu)->icp));
>       }
> @@ -204,12 +202,30 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, S=
paprCpuCore *sc)
>       object_unparent(OBJECT(cpu));
>   }
>  =20
> +static void spapr_cpu_core_reset(DeviceState *dev)
> +{
> +    CPUCore *cc =3D CPU_CORE(dev);
> +    SpaprCpuCore *sc =3D SPAPR_CPU_CORE(dev);
> +    int i;
> +
> +    for (i =3D 0; i < cc->nr_threads; i++) {
> +        spapr_reset_vcpu(sc->threads[i]);
> +    }
> +}
> +
> +static void spapr_cpu_core_reset_handler(void *opaque)
> +{
> +    spapr_cpu_core_reset(opaque);
> +}
> +
>   static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
>   {
>       SpaprCpuCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>       CPUCore *cc =3D CPU_CORE(dev);
>       int i;
>  =20
> +    qemu_unregister_reset(spapr_cpu_core_reset_handler, sc);
> +
>       for (i =3D 0; i < cc->nr_threads; i++) {
>           spapr_unrealize_vcpu(sc->threads[i], sc);
>       }
> @@ -238,12 +254,6 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>           goto error_intc_create;
>       }
>  =20
> -    /*
> -     * FIXME: Hot-plugged CPUs are not reseted. Do it at realize.
> -     */
> -    qemu_register_reset(spapr_cpu_reset, cpu);
> -    spapr_cpu_reset(cpu);
> -
>       if (!sc->pre_3_0_migration) {
>           vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
>                            cpu->machine_data);
> @@ -338,6 +348,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>               goto err_unrealize;
>           }
>       }
> +
> +    qemu_register_reset(spapr_cpu_core_reset_handler, sc);
>       return;
>  =20
>   err_unrealize:
> @@ -366,6 +378,7 @@ static void spapr_cpu_core_class_init(ObjectClass *oc=
, void *data)
>  =20
>       dc->realize =3D spapr_cpu_core_realize;
>       dc->unrealize =3D spapr_cpu_core_unrealize;
> +    dc->reset =3D spapr_cpu_core_reset;
>       dc->props =3D spapr_cpu_core_properties;
>       scc->cpu_type =3D data;
>   }
>=20

Good cleanup!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


