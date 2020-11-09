Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7BC56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626E620897
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626E620897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4x8-0006bm-Bh
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1kc4vv-0005dz-JH; Mon, 09 Nov 2020 06:01:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1kc4vs-0004dx-GF; Mon, 09 Nov 2020 06:01:59 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CV7NT3FwTzQpqk;
 Mon,  9 Nov 2020 19:01:45 +0800 (CST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 9 Nov 2020 19:01:50 +0800
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Mon, 9 Nov 2020 11:01:48 +0000
From: Salil Mehta <salil.mehta@huawei.com>
To: fangying <fangying1@huawei.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [RFC PATCH v3 03/13] hw/arm/virt: Replace smp_parse with one that
 prefers cores
Thread-Topic: [RFC PATCH v3 03/13] hw/arm/virt: Replace smp_parse with one
 that prefers cores
Thread-Index: AQHWtkUun+VWhAgXfUKxCOZCM20erKm/oYXw
Date: Mon, 9 Nov 2020 11:01:48 +0000
Message-ID: <f2b0f9ab3e7c4e4a82a1f003ca1d67e4@huawei.com>
References: <20201109030452.2197-1-fangying1@huawei.com>
 <20201109030452.2197-4-fangying1@huawei.com>
In-Reply-To: <20201109030452.2197-4-fangying1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.28.252]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=salil.mehta@huawei.com; helo=szxga02-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 05:45:32
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "drjones@redhat.com" <drjones@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: fangying
> Sent: Monday, November 9, 2020 3:05 AM
> To: peter.maydell@linaro.org
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; drjones@redhat.com;
> imammedo@redhat.com; shannon.zhaosl@gmail.com; alistair.francis@wdc.com;
> Zhanghailiang <zhang.zhanghailiang@huawei.com>; Salil Mehta
> <salil.mehta@huawei.com>
> Subject: [RFC PATCH v3 03/13] hw/arm/virt: Replace smp_parse with one tha=
t
> prefers cores
>=20
> From: Andrew Jones <drjones@redhat.com>
>=20
> The virt machine type has never used the CPU topology parameters, other
> than number of online CPUs and max CPUs. When choosing how to allocate
> those CPUs the default has been to assume cores. In preparation for
> using the other CPU topology parameters let's use an smp_parse that
> prefers cores over sockets. We can also enforce the topology matches
> max_cpus check because we have no legacy to preserve.


Hi Andrew,
I am wondering if we need to take care of other levels of processor
hierarchy as well in ARM64 like 'clusters'/'Dies'?

Thanks


>=20
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ea24b576c6..ba902b53ba 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -78,6 +78,8 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/char/pl011.h"
>  #include "qemu/guest-random.h"
> +#include "qapi/qmp/qerror.h"
> +#include "sysemu/replay.h"
>=20
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -2444,6 +2446,79 @@ static int virt_kvm_type(MachineState *ms, const c=
har
> *type_str)
>      return requested_pa_size > 40 ? requested_pa_size : 0;
>  }
>=20
> +/*
> + * Unlike smp_parse() in hw/core/machine.c, we prefer cores over sockets=
,
> + * e.g. '-smp 8' creates 1 socket with 8 cores.  Whereas '-smp 8' with
> + * hw/core/machine.c's smp_parse() creates 8 sockets, each with 1 core.
> + * Additionally, we can enforce the topology matches max_cpus check,
> + * because we have no legacy to preserve.
> + */
> +static void virt_smp_parse(MachineState *ms, QemuOpts *opts)
> +{
> +    if (opts) {
> +        unsigned cpus    =3D qemu_opt_get_number(opts, "cpus", 0);
> +        unsigned sockets =3D qemu_opt_get_number(opts, "sockets", 0);
> +        unsigned cores   =3D qemu_opt_get_number(opts, "cores", 0);
> +        unsigned threads =3D qemu_opt_get_number(opts, "threads", 0);
> +
> +        /*
> +         * Compute missing values; prefer cores over sockets and
> +         * sockets over threads.
> +         */
> +        if (cpus =3D=3D 0 || cores =3D=3D 0) {
> +            sockets =3D sockets > 0 ? sockets : 1;
> +            threads =3D threads > 0 ? threads : 1;
> +            if (cpus =3D=3D 0) {
> +                cores =3D cores > 0 ? cores : 1;
> +                cpus =3D cores * threads * sockets;
> +            } else {
> +                ms->smp.max_cpus =3D qemu_opt_get_number(opts, "maxcpus"=
, cpus);
> +                cores =3D ms->smp.max_cpus / (sockets * threads);
> +            }
> +        } else if (sockets =3D=3D 0) {
> +            threads =3D threads > 0 ? threads : 1;
> +            sockets =3D cpus / (cores * threads);
> +            sockets =3D sockets > 0 ? sockets : 1;
> +        } else if (threads =3D=3D 0) {
> +            threads =3D cpus / (cores * sockets);
> +            threads =3D threads > 0 ? threads : 1;
> +        } else if (sockets * cores * threads < cpus) {
> +            error_report("cpu topology: "
> +                         "sockets (%u) * cores (%u) * threads (%u) < "
> +                         "smp_cpus (%u)",
> +                         sockets, cores, threads, cpus);
> +            exit(1);
> +        }
> +
> +        ms->smp.max_cpus =3D qemu_opt_get_number(opts, "maxcpus", cpus);
> +
> +        if (ms->smp.max_cpus < cpus) {
> +            error_report("maxcpus must be equal to or greater than smp")=
;
> +            exit(1);
> +        }
> +
> +        if (sockets * cores * threads !=3D ms->smp.max_cpus) {
> +            error_report("cpu topology: "
> +                         "sockets (%u) * cores (%u) * threads (%u)"
> +                         "!=3D maxcpus (%u)",
> +                         sockets, cores, threads,
> +                         ms->smp.max_cpus);
> +            exit(1);
> +        }
> +
> +        ms->smp.cpus =3D cpus;
> +        ms->smp.cores =3D cores;
> +        ms->smp.threads =3D threads;
> +        ms->smp.sockets =3D sockets;
> +    }
> +
> +    if (ms->smp.cpus > 1) {
> +        Error *blocker =3D NULL;
> +        error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
> +        replay_add_blocker(blocker);
> +    }
> +}
> +
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -2469,6 +2544,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void
> *data)
>      mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
>      mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
>      mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
> +    mc->smp_parse =3D virt_smp_parse;
>      mc->kvm_type =3D virt_kvm_type;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler =3D virt_machine_get_hotplug_handler;
> --
> 2.23.0


