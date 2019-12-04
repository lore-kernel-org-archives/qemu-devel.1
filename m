Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99001C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629E520674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFfd1Vqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629E520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTYd-00065k-WF
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icSCk-0004ij-PF
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icSCf-0003T9-KD
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:48:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icSCf-0003LF-9X
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575456495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=0zvA/GpHO8RuFn0TtmBqGCCyH1fWXZWNucJ0tk8jr7w=;
 b=GFfd1Vqgru6zI37PiidMJXvNL3CBtBj0Ki3aiUL8THjXODd0IzouD42wVIJbMGJn77Cl8T
 lldljHUhFyk6LzYF+SEzeAH8G8cnoj+U3O5hNuH+M0ti5oSpkSGyTQCFkOjS3mrl28auMz
 FJmq1Y+wTjEwF84igDPy1v1KrhGtnM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-z2KEPGLpNUal2dvu80mXOg-1; Wed, 04 Dec 2019 05:48:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09372890E6A;
 Wed,  4 Dec 2019 10:48:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0672519C69;
 Wed,  4 Dec 2019 10:48:02 +0000 (UTC)
Subject: Re: [PATCH v2 03/13] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3f891828-f7d1-91a4-08de-71ac2ed00ad1@redhat.com>
Date: Wed, 4 Dec 2019 11:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129094809.26684-4-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: z2KEPGLpNUal2dvu80mXOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 10.47, Janosch Frank wrote:
> When a guest has saved a ipib of type 5 and call diagnose308 with
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
> ---
[...]
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,118 @@
> +/*
> + * Secure execution functions
> + *
> + * Copyright IBM Corp. 2019
> + * Author(s):
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +
> +#include <linux/kvm.h>
> +
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "pv.h"
> +
> +static int s390_pv_cmd(uint32_t cmd, void *data)
> +{
> +    int rc;
> +    struct kvm_pv_cmd pv_cmd = {
> +        .cmd = cmd,
> +        .data = (uint64_t)data,
> +    };
> +
> +    rc = kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV command failed cmd: %d rc: %d", cmd, rc);
> +        exit(1);
> +    }
> +    return rc;
> +}
> +
> +static int s390_pv_cmd_vcpu(CPUState *cs, uint32_t cmd, void *data)
> +{
> +    int rc;
> +    struct kvm_pv_cmd pv_cmd = {
> +        .cmd = cmd,
> +        .data = (uint64_t)data,
> +    };
> +
> +    rc = kvm_vcpu_ioctl(cs, KVM_S390_PV_COMMAND_VCPU, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV VCPU command failed cmd: %d rc: %d", cmd, rc);
> +        exit(1);
> +    }
> +    return rc;
> +}
> +
> +int s390_pv_vm_create(void)
> +{
> +    return s390_pv_cmd(KVM_PV_VM_CREATE, NULL);
> +}
> +
> +int s390_pv_vm_destroy(void)
> +{
> +    return s390_pv_cmd(KVM_PV_VM_DESTROY, NULL);
> +}
> +
> +int s390_pv_vcpu_create(CPUState *cs)
> +{
> +    return s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_CREATE, NULL);
> +}
> +
> +int s390_pv_vcpu_destroy(CPUState *cs)
> +{
> +    S390CPU *cpu = S390_CPU(cs);
> +    CPUS390XState *env = &cpu->env;
> +    int rc;
> +
> +    rc = s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_DESTROY, NULL);
> +    if (!rc) {
> +        env->pv = false;
> +    }
> +    return rc;
> +}
> +
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
> +{
> +    struct kvm_s390_pv_sec_parm args = {
> +        .origin = origin,
> +        .length = length,
> +    };
> +
> +    return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
> +}
> +
> +/*
> + * Called for each component in the SE type IPL parameter block 0.
> + */
> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
> +{
> +    struct kvm_s390_pv_unp args = {
> +        .addr = addr,
> +        .size = size,
> +        .tweak = tweak,
> +    };
> +
> +    return s390_pv_cmd(KVM_PV_VM_UNPACK, &args);
> +}
> +
> +int s390_pv_perf_clear_reset(void)
> +{
> +    return s390_pv_cmd(KVM_PV_VM_PERF_CLEAR_RESET, NULL);
> +}
> +
> +int s390_pv_verify(void)
> +{
> +    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
> +}
> +
> +int s390_pv_unshare(void)
> +{
> +    return s390_pv_cmd(KVM_PV_VM_UNSHARE, NULL);
> +}
> diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
> new file mode 100644
> index 0000000000..eb074e4bc9
> --- /dev/null
> +++ b/hw/s390x/pv.h
> @@ -0,0 +1,26 @@
> +/*
> + * Protected Virtualization header
> + *
> + * Copyright IBM Corp. 2019
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
> +int s390_pv_vm_create(void);
> +int s390_pv_vm_destroy(void);
> +int s390_pv_vcpu_destroy(CPUState *cs);
> +int s390_pv_vcpu_create(CPUState *cs);
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
> +int s390_pv_perf_clear_reset(void);
> +int s390_pv_verify(void);
> +int s390_pv_unshare(void);

I still think you should make all those functions returning "void"
instead of "int" - since errors results in an exit() in s390_pv_cmd()
and s390_pv_cmd_vcpu() anyway...

> +
> +#endif /* HW_S390_PV_H */
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index c1d1440272..f9481ccace 100644
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
> @@ -322,6 +323,7 @@ static void s390_machine_reset(MachineState *machine)
>  {
>      enum s390_reset reset_type;
>      CPUState *cs, *t;
> +    S390CPU *cpu;
>  
>      /* get the reset parameters, reset them once done */
>      s390_ipl_get_reset_request(&cs, &reset_type);
> @@ -329,6 +331,8 @@ static void s390_machine_reset(MachineState *machine)
>      /* all CPUs are paused and synchronized at this point */
>      s390_cmma_reset();
>  
> +    cpu = S390_CPU(cs);
> +
>      switch (reset_type) {
>      case S390_RESET_EXTERNAL:
>      case S390_RESET_REIPL:
> @@ -357,6 +361,28 @@ static void s390_machine_reset(MachineState *machine)
>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>          break;
> +    case S390_RESET_PV: /* Subcode 10 */
> +        subsystem_reset();
> +        s390_crypto_reset();
> +
> +        CPU_FOREACH(t) {
> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
> +        }
> +
> +        /* Create SE VM */
> +        s390_pv_vm_create();
> +        CPU_FOREACH(t) {
> +            s390_pv_vcpu_create(t);
> +        }
> +
> +        /* Set SE header and unpack */
> +        s390_ipl_prepare_pv_header();
> +        /* Decrypt image */
> +        s390_ipl_pv_unpack();
> +        /* Verify integrity */
> +        s390_pv_verify();
> +        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> +        break;

... and here you completely ignore the return codes of all the new
functions.

 Thomas


