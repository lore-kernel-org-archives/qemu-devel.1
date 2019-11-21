Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5CEC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E0F20714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHEC41CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E0F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkeP-00079X-Lg
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iXkcd-0005kz-O0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iXkcb-0002I5-FP
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:27:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iXkcb-0002Gr-8x
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574335655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIbt3YLdgoj52mhbKwXTX4I/2RPtWnyGw9qpDsm/aIw=;
 b=WHEC41CPu/QyBMbv70qWkHpXDdz2i6zfaCMlb62WZvAFILaRpqQ2P+mmGqKOwUOX/Crgxs
 CR1cmrRcpNEsA9bDFL3zcOi2Kxb3+xwYSLog7ysCrA+nbETiHY4+YWGR5xShZ+WhVLhNRk
 zVDqldv9hcISAk4oBV4SRD1w2cd6rwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-m7RCqmCyOViru8BzPWHoVw-1; Thu, 21 Nov 2019 06:27:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65EA71083E80;
 Thu, 21 Nov 2019 11:27:31 +0000 (UTC)
Received: from [10.36.116.214] (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8744C60C2C;
 Thu, 21 Nov 2019 11:27:29 +0000 (UTC)
Subject: Re: [PATCH 06/15] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-7-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8669fc89-c8a9-641d-d9aa-ee4aa011ac26@redhat.com>
Date: Thu, 21 Nov 2019 12:27:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-7-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: m7RCqmCyOViru8BzPWHoVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.11.19 12:43, Janosch Frank wrote:
> When a guest has saved a ipib of type 5 and call diagnose308 with
> subcode 10, we have to setup the protected processing environment via
> Ultravisor calls. The calls are done by KVM and are exposed via an API.
>=20
> The following steps are necessary:
> 1. Create a VM (register it with the Ultravisor)
> 2. Create secure CPUs for all of our current cpus
> 3. Forward the secure header to the Ultravisor (has all information on
> how to decrypt the image and VM information)
> 4. Protect image pages from the host and decrypt them
> 5. Verify the image integrity
>=20
> Only after step 5 a protected VM is allowed to run.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   hw/s390x/Makefile.objs              |   1 +
>   hw/s390x/ipl.c                      |  33 ++++++++
>   hw/s390x/ipl.h                      |   2 +
>   hw/s390x/pv.c                       | 118 ++++++++++++++++++++++++++++
>   hw/s390x/pv.h                       |  26 ++++++
>   hw/s390x/s390-virtio-ccw.c          |  45 ++++++++---
>   target/s390x/cpu_features_def.inc.h |   1 +
>   7 files changed, 216 insertions(+), 10 deletions(-)
>   create mode 100644 hw/s390x/pv.c
>   create mode 100644 hw/s390x/pv.h
>=20
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index 94e57113d8..568bab9711 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -31,6 +31,7 @@ obj-y +=3D tod-qemu.o
>   obj-$(CONFIG_KVM) +=3D tod-kvm.o
>   obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>   obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o s390-mchk.o
> +obj-$(CONFIG_KVM) +=3D pv.o
>   obj-y +=3D s390-ccw.o
>   obj-y +=3D ap-device.o
>   obj-y +=3D ap-bridge.o
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index a077926f36..50501fcd27 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -33,6 +33,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/option.h"
>   #include "exec/exec-all.h"
> +#include "pv.h"
>  =20
>   #define KERN_IMAGE_START                0x010000UL
>   #define LINUX_MAGIC_ADDR                0x010008UL
> @@ -668,6 +669,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>       cpu_physical_memory_unmap(addr, len, 1, len);
>   }
>  =20
> +int s390_ipl_prepare_pv_header(void)
> +{
> +    int rc;
> +    IplParameterBlock *iplb =3D s390_ipl_get_iplb_secure();
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
> +
> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
> +                             ipib_pv->pv_header_len);
> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
> +                               ipib_pv->pv_header_len);
> +    g_free(hdr);
> +    return rc;
> +}
> +
> +int s390_ipl_pv_unpack(void)
> +{
> +    int i, rc;
> +    IplParameterBlock *iplb =3D s390_ipl_get_iplb_secure();
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].siz=
e),
> +                            ipib_pv->components[i].tweak_pref);
> +        if (rc) {
> +            return rc;
> +        }
> +    }
> +    return rc;
> +}
> +
>   void s390_ipl_prepare_cpu(S390CPU *cpu)
>   {
>       S390IPLState *ipl =3D get_ipl_device();
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 7b8a493509..e848602c16 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -105,6 +105,8 @@ typedef union IplParameterBlock IplParameterBlock;
>   int s390_ipl_set_loadparm(uint8_t *loadparm);
>   int s390_ipl_pv_check_comp(IplParameterBlock *iplb);
>   void s390_ipl_update_diag308(IplParameterBlock *iplb);
> +int s390_ipl_prepare_pv_header(void);
> +int s390_ipl_pv_unpack(void);
>   void s390_ipl_prepare_cpu(S390CPU *cpu);
>   IplParameterBlock *s390_ipl_get_iplb(void);
>   IplParameterBlock *s390_ipl_get_iplb_secure(void);
> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000..0218070322
> --- /dev/null
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,118 @@
> +/*
> + * Secure execution functions
> + *
> + * Copyright IBM Corp. 2019
> + * Author(s):
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
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
> +    struct kvm_pv_cmd pv_cmd =3D {
> +        .cmd =3D cmd,
> +        .data =3D (uint64_t)data,
> +    };
> +
> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
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
> +    struct kvm_pv_cmd pv_cmd =3D {
> +        .cmd =3D cmd,
> +        .data =3D (uint64_t)data,
> +    };
> +
> +    rc =3D kvm_vcpu_ioctl(cs, KVM_S390_PV_COMMAND_VCPU, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV VCPU command failed cmd: %d rc: %d", cmd, r=
c);
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
> +    S390CPU *cpu =3D S390_CPU(cs);
> +    CPUS390XState *env =3D &cpu->env;
> +    int rc;
> +
> +    rc =3D s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_DESTROY, NULL);
> +    if (!rc) {
> +        env->pv =3D false;
> +    }
> +    return rc;
> +}
> +
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
> +{
> +    struct kvm_s390_pv_sec_parm args =3D {
> +        .origin =3D origin,
> +        .length =3D length,
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
> +    struct kvm_s390_pv_unp args =3D {
> +        .addr =3D addr,
> +        .size =3D size,
> +        .tweak =3D tweak,
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
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
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
> +
> +#endif /* HW_S390_PV_H */
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index c1d1440272..7262453616 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/s390x/tod.h"
>   #include "sysemu/sysemu.h"
> +#include "hw/s390x/pv.h"
>  =20
>   S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>   {
> @@ -322,6 +323,7 @@ static void s390_machine_reset(MachineState *machine)
>   {
>       enum s390_reset reset_type;
>       CPUState *cs, *t;
> +    S390CPU *cpu;
>  =20
>       /* get the reset parameters, reset them once done */
>       s390_ipl_get_reset_request(&cs, &reset_type);
> @@ -329,16 +331,10 @@ static void s390_machine_reset(MachineState *machin=
e)
>       /* all CPUs are paused and synchronized at this point */
>       s390_cmma_reset();
>  =20
> -    switch (reset_type) {
> -    case S390_RESET_EXTERNAL:
> -    case S390_RESET_REIPL:
> -        qemu_devices_reset();
> -        s390_crypto_reset();
> +    cpu =3D S390_CPU(cs);
>  =20
> -        /* configure and start the ipl CPU only */
> -        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
> -        break;
> -    case S390_RESET_MODIFIED_CLEAR:
> +    switch (reset_type) {
> +    case S390_RESET_MODIFIED_CLEAR:  /* Subcode 0 */
>           CPU_FOREACH(t) {
>               run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>           }
> @@ -346,7 +342,7 @@ static void s390_machine_reset(MachineState *machine)
>           s390_crypto_reset();
>           run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>           break;
> -    case S390_RESET_LOAD_NORMAL:
> +    case S390_RESET_LOAD_NORMAL: /* Subcode 1*/
>           CPU_FOREACH(t) {
>               if (t =3D=3D cs) {
>                   continue;
> @@ -357,6 +353,35 @@ static void s390_machine_reset(MachineState *machine=
)
>           run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>           run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>           break;
> +    case S390_RESET_EXTERNAL:
> +    case S390_RESET_REIPL: /* Subcode 4 */
> +        qemu_devices_reset();
> +        s390_crypto_reset();
> +        /* configure and start the ipl CPU only */
> +        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
> +        break;

Is there a way to modify this patch to not change unrelated code that=20
heavily? Makes it harder to review.

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
>       default:
>           g_assert_not_reached();
>       }
> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_featu=
res_def.inc.h
> index 31dff0d84e..60db28351d 100644
> --- a/target/s390x/cpu_features_def.inc.h
> +++ b/target/s390x/cpu_features_def.inc.h
> @@ -107,6 +107,7 @@ DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "De=
flate-conversion facility (
>   DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH, "vxpdeh", STFL, 152, "Vector-Packed=
-Decimal-Enhancement Facility")
>   DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-ex=
tension-9 facility (excluding subfunctions)")
>   DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
> +DEF_FEAT(UNPACK, "unpack", STFL, 161, "Unpack facility")
>  =20
>   /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative t=
o byte-80) */
>   DEF_FEAT(SIE_GSLS, "gsls", SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limi=
t-suppression facility")
>=20


--=20

Thanks,

David / dhildenb


