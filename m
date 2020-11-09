Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0775C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B7520789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5PYePnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B7520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5pT-00010P-At
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kc5op-0000TX-5b
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:58:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kc5oj-0007sZ-A9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604923115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jOQRqBr01VKWNhQUIqSvEAhMD9eAbdN4XBBsDSxB6go=;
 b=d5PYePnLqY7myjpWLzti5bjeseDJOlKtP+/SeH4fxB1McPFZkXCCQaBpTX+aZiP5tBXqF7
 YLPsM6louq6cgTaCVPN/id7Yl3Yf1JEEeBenv0zumuUaHsxHCwA9B/PM9tUjp0zgpBvd6x
 2PlRnZWObh+2E+TXvCwRzSxMW5fFGZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-3_BqG14dPo-PlfAupupHmg-1; Mon, 09 Nov 2020 06:58:31 -0500
X-MC-Unique: 3_BqG14dPo-PlfAupupHmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0024F809DCD;
 Mon,  9 Nov 2020 11:58:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D64606EF67;
 Mon,  9 Nov 2020 11:58:25 +0000 (UTC)
Date: Mon, 9 Nov 2020 12:58:22 +0100
From: Andrew Jones <drjones@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [RFC PATCH v3 03/13] hw/arm/virt: Replace smp_parse with one
 that prefers cores
Message-ID: <20201109115822.aqdmrljdlqcj2mhg@kamzik.brq.redhat.com>
References: <20201109030452.2197-1-fangying1@huawei.com>
 <20201109030452.2197-4-fangying1@huawei.com>
 <f2b0f9ab3e7c4e4a82a1f003ca1d67e4@huawei.com>
MIME-Version: 1.0
In-Reply-To: <f2b0f9ab3e7c4e4a82a1f003ca1d67e4@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 fangying <fangying1@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 09, 2020 at 11:01:48AM +0000, Salil Mehta wrote:
> > From: fangying
> > Sent: Monday, November 9, 2020 3:05 AM
> > To: peter.maydell@linaro.org
> > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; drjones@redhat.com;
> > imammedo@redhat.com; shannon.zhaosl@gmail.com; alistair.francis@wdc.com;
> > Zhanghailiang <zhang.zhanghailiang@huawei.com>; Salil Mehta
> > <salil.mehta@huawei.com>
> > Subject: [RFC PATCH v3 03/13] hw/arm/virt: Replace smp_parse with one that
> > prefers cores
> > 
> > From: Andrew Jones <drjones@redhat.com>
> > 
> > The virt machine type has never used the CPU topology parameters, other
> > than number of online CPUs and max CPUs. When choosing how to allocate
> > those CPUs the default has been to assume cores. In preparation for
> > using the other CPU topology parameters let's use an smp_parse that
> > prefers cores over sockets. We can also enforce the topology matches
> > max_cpus check because we have no legacy to preserve.
> 
> 
> Hi Andrew,
> I am wondering if we need to take care of other levels of processor
> hierarchy as well in ARM64 like 'clusters'/'Dies'?

I don't know, but so far in Linux only x86 considers dies. Also, Linux
doesn't define the concept of a cluster in its arch-neutral cpu topology
API. With that in mind, I think we should just focus on sockets, cores,
and threads until we have a guest OS that can be used to test other
levels.

Thanks,
drew

> 
> Thanks
> 
> 
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  hw/arm/virt.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index ea24b576c6..ba902b53ba 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -78,6 +78,8 @@
> >  #include "hw/virtio/virtio-iommu.h"
> >  #include "hw/char/pl011.h"
> >  #include "qemu/guest-random.h"
> > +#include "qapi/qmp/qerror.h"
> > +#include "sysemu/replay.h"
> > 
> >  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> >      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> > @@ -2444,6 +2446,79 @@ static int virt_kvm_type(MachineState *ms, const char
> > *type_str)
> >      return requested_pa_size > 40 ? requested_pa_size : 0;
> >  }
> > 
> > +/*
> > + * Unlike smp_parse() in hw/core/machine.c, we prefer cores over sockets,
> > + * e.g. '-smp 8' creates 1 socket with 8 cores.  Whereas '-smp 8' with
> > + * hw/core/machine.c's smp_parse() creates 8 sockets, each with 1 core.
> > + * Additionally, we can enforce the topology matches max_cpus check,
> > + * because we have no legacy to preserve.
> > + */
> > +static void virt_smp_parse(MachineState *ms, QemuOpts *opts)
> > +{
> > +    if (opts) {
> > +        unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
> > +        unsigned sockets = qemu_opt_get_number(opts, "sockets", 0);
> > +        unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
> > +        unsigned threads = qemu_opt_get_number(opts, "threads", 0);
> > +
> > +        /*
> > +         * Compute missing values; prefer cores over sockets and
> > +         * sockets over threads.
> > +         */
> > +        if (cpus == 0 || cores == 0) {
> > +            sockets = sockets > 0 ? sockets : 1;
> > +            threads = threads > 0 ? threads : 1;
> > +            if (cpus == 0) {
> > +                cores = cores > 0 ? cores : 1;
> > +                cpus = cores * threads * sockets;
> > +            } else {
> > +                ms->smp.max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> > +                cores = ms->smp.max_cpus / (sockets * threads);
> > +            }
> > +        } else if (sockets == 0) {
> > +            threads = threads > 0 ? threads : 1;
> > +            sockets = cpus / (cores * threads);
> > +            sockets = sockets > 0 ? sockets : 1;
> > +        } else if (threads == 0) {
> > +            threads = cpus / (cores * sockets);
> > +            threads = threads > 0 ? threads : 1;
> > +        } else if (sockets * cores * threads < cpus) {
> > +            error_report("cpu topology: "
> > +                         "sockets (%u) * cores (%u) * threads (%u) < "
> > +                         "smp_cpus (%u)",
> > +                         sockets, cores, threads, cpus);
> > +            exit(1);
> > +        }
> > +
> > +        ms->smp.max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> > +
> > +        if (ms->smp.max_cpus < cpus) {
> > +            error_report("maxcpus must be equal to or greater than smp");
> > +            exit(1);
> > +        }
> > +
> > +        if (sockets * cores * threads != ms->smp.max_cpus) {
> > +            error_report("cpu topology: "
> > +                         "sockets (%u) * cores (%u) * threads (%u)"
> > +                         "!= maxcpus (%u)",
> > +                         sockets, cores, threads,
> > +                         ms->smp.max_cpus);
> > +            exit(1);
> > +        }
> > +
> > +        ms->smp.cpus = cpus;
> > +        ms->smp.cores = cores;
> > +        ms->smp.threads = threads;
> > +        ms->smp.sockets = sockets;
> > +    }
> > +
> > +    if (ms->smp.cpus > 1) {
> > +        Error *blocker = NULL;
> > +        error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
> > +        replay_add_blocker(blocker);
> > +    }
> > +}
> > +
> >  static void virt_machine_class_init(ObjectClass *oc, void *data)
> >  {
> >      MachineClass *mc = MACHINE_CLASS(oc);
> > @@ -2469,6 +2544,7 @@ static void virt_machine_class_init(ObjectClass *oc, void
> > *data)
> >      mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
> >      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
> >      mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
> > +    mc->smp_parse = virt_smp_parse;
> >      mc->kvm_type = virt_kvm_type;
> >      assert(!mc->get_hotplug_handler);
> >      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
> > --
> > 2.23.0
> 
> 


