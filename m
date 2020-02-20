Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061FAC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91F62071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQbroIvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91F62071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jGP-0004zW-1V
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4jFU-0003dF-Nf
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4jFS-0002oC-Gf
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:40:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4jFS-0002nr-9G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582195201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRimwKLhXZgPHrHHU2A9cojRagc3JboVE1WPoUIv/oI=;
 b=bQbroIvQwQIJKC9a9AV0RRCT7q4QUTb9DRoJ80FAWaQNwpiZCtFcsg16oNAbNqOmSdce2n
 Yz1ZAoBvBcm9V0xoOV062iy+a/M96jow8HZCfPfgow8O7H6NZMRfraE3Rlb7FnbjMKh5kO
 uiNtinz6mBCkcj5EkREdg/j9xCrOk3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-GBKCCS_KOLSAnuTr-mtK-w-1; Thu, 20 Feb 2020 05:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA8E518FF672;
 Thu, 20 Feb 2020 10:39:58 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E7B35DA7B;
 Thu, 20 Feb 2020 10:39:54 +0000 (UTC)
Date: Thu, 20 Feb 2020 11:39:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 05/17] s390x: protvirt: Support unpack facility
Message-ID: <20200220113950.015984bf.cohuck@redhat.com>
In-Reply-To: <20200214151636.8764-6-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-6-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: GBKCCS_KOLSAnuTr-mtK-w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 10:16:24 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> When a guest has saved a ipib of type 5 and call diagnose308 with

s/call/calls/

> subcode 10, we have to setup the protected processing environment via
> Ultravisor calls. The calls are done by KVM and are exposed via an API.
> 
> The following steps are necessary:
> 1. Create a VM (register it with the Ultravisor)
> 2. Create secure CPUs for all of our current cpus
> 3. Forward the secure header to the Ultravisor (has all information on
> how to decrypt the image and VM information)
> 4. Protect image pages from the host and decrypt them
> 5. Verify the image integrity
> 
> Only after step 5 a protected VM is allowed to run.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]
> ---
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  32 ++++++
>  hw/s390x/ipl.h                      |   2 +
>  hw/s390x/pv.c                       | 154 ++++++++++++++++++++++++++++
>  hw/s390x/pv.h                       |  38 +++++++
>  hw/s390x/s390-virtio-ccw.c          |  79 ++++++++++++++
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  target/s390x/cpu.c                  |   4 +
>  target/s390x/cpu.h                  |   1 +
>  target/s390x/cpu_features_def.inc.h |   1 +
>  10 files changed, 313 insertions(+)
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 hw/s390x/pv.h

(...)

> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000..5b6a26cba9
> --- /dev/null
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,154 @@
> +/*
> + * Secure execution functions
> + *
> + * Copyright IBM Corp. 2019

Update the year?

> + * Author(s):
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */

(...)

> +void s390_pv_vm_destroy(void)
> +{
> +     s390_pv_cmd_exit(KVM_PV_VM_DESTROY, NULL);

Why does this exit()? Should Never Happen?

> +}
> +
> +int s390_pv_vcpu_create(CPUState *cs)
> +{
> +    int rc;
> +
> +    rc = s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_CREATE, NULL);
> +    if (!rc) {
> +        S390_CPU(cs)->env.pv = true;
> +    }
> +
> +    return rc;
> +}
> +
> +void s390_pv_vcpu_destroy(CPUState *cs)
> +{
> +    s390_pv_cmd_vcpu_exit(cs, KVM_PV_VCPU_DESTROY, NULL);

dito

> +    S390_CPU(cs)->env.pv = false;
> +}

(...)

> +void s390_pv_perf_clear_reset(void)
> +{
> +    s390_pv_cmd_exit(KVM_PV_VM_PREP_RESET, NULL);

And here. Or is that because the machine should not be left around in
an undefined state?

> +}
> +
> +int s390_pv_verify(void)
> +{
> +    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
> +}
> +
> +void s390_pv_unshare(void)
> +{
> +    s390_pv_cmd_exit(KVM_PV_VM_UNSHARE_ALL, NULL);
> +}
> diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
> new file mode 100644
> index 0000000000..7d20bdd12e
> --- /dev/null
> +++ b/hw/s390x/pv.h
> @@ -0,0 +1,38 @@
> +/*
> + * Protected Virtualization header
> + *
> + * Copyright IBM Corp. 2019

Year++

> + * Author(s):
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef HW_S390_PV_H
> +#define HW_S390_PV_H
> +
> +#ifdef CONFIG_KVM
> +int s390_pv_vm_create(void);
> +void s390_pv_vm_destroy(void);
> +void s390_pv_vcpu_destroy(CPUState *cs);
> +int s390_pv_vcpu_create(CPUState *cs);
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
> +void s390_pv_perf_clear_reset(void);
> +int s390_pv_verify(void);
> +void s390_pv_unshare(void);
> +#else
> +int s390_pv_vm_create(void) { return 0; }

I'm wondering why you return 0 here (and below). These function should
not be called for !KVM, but just to help catch logic error, use -EINVAL
or so?

> +void s390_pv_vm_destroy(void) {}
> +void s390_pv_vcpu_destroy(CPUState *cs) {}
> +int s390_pv_vcpu_create(CPUState *cs) { return 0; }
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length) { return 0; }
> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0: }
> +void s390_pv_perf_clear_reset(void) {}
> +int s390_pv_verify(void) { return 0; }
> +void s390_pv_unshare(void) {}
> +#endif
> +
> +#endif /* HW_S390_PV_H */
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e759eb5f83..5fa4372083 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/s390x/pv.h"
>  
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -240,9 +241,11 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
>      VirtualCssBus *css_bus;
>      DeviceState *dev;
>  
> +    ms->pv = false;

I'm wondering why you need to init this to false - isn't it already
zeroed out?

>      s390_sclp_init();
>      /* init memory + setup max page size. Required for the CPU model */
>      s390_memory_init(machine->ram_size);
> @@ -318,10 +321,58 @@ static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>  }
>  
> +static int s390_machine_pv_secure(S390CcwMachineState *ms)
> +{
> +    CPUState *t;
> +    int rc;
> +
> +    /* Create SE VM */
> +    rc = s390_pv_vm_create();
> +    if (rc) {
> +        return rc;
> +    }
> +
> +    CPU_FOREACH(t) {
> +        rc = s390_pv_vcpu_create(t);
> +        if (rc) {
> +            return rc;

No need to undo something on error?

> +        }
> +    }
> +
> +    ms->pv = true;
> +
> +    /* Set SE header and unpack */
> +    rc = s390_ipl_prepare_pv_header();
> +    if (rc) {
> +        return rc;

Also here.

> +    }
> +
> +    /* Decrypt image */
> +    rc = s390_ipl_pv_unpack();
> +    if (rc) {
> +        return rc;

And here.

> +    }
> +
> +    /* Verify integrity */
> +    rc = s390_pv_verify();
> +    return rc;

And here.

> +}

(...)

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 8da1905485..1dbd84b9d7 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -37,6 +37,8 @@
>  #include "sysemu/hw_accel.h"
>  #include "hw/qdev-properties.h"
>  #ifndef CONFIG_USER_ONLY
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "hw/s390x/pv.h"
>  #include "hw/boards.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
> @@ -191,6 +193,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>  
>  #if !defined(CONFIG_USER_ONLY)
>      MachineState *ms = MACHINE(qdev_get_machine());
> +    S390CcwMachineState *ccw = S390_CCW_MACHINE(ms);

I find the variable name a bit confusing... maybe ccw_ms?

>      unsigned int max_cpus = ms->smp.max_cpus;
>      if (cpu->env.core_id >= max_cpus) {
>          error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
> @@ -205,6 +208,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>          goto out;
>      }
>  
> +    cpu->env.pv = ccw->pv;

So, if you add a cpu, it will inherit the pv state of the machine...
doesn't it need any setup?

>      /* sync cs->cpu_index and env->core_id. The latter is needed for TCG. */
>      cs->cpu_index = cpu->env.core_id;
>  #endif

(...)


