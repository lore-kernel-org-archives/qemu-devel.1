Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CDAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C1C2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JePpYl7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C1C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9qvm-0003ns-8y
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 08:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9quL-00023c-ND
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9quJ-0006PQ-Mu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:51:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53971
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9quJ-0006Oo-Hg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583416283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9Z9qgGw4KvSZOPWu/Lz5UVWolPRgHgzuO/reA3cdTgY=;
 b=JePpYl7VX0ruXJqU1pGCYG6LmpilQ57wHADzw5COXafOWGHY+pWY8cB1hGoYXKG49EunFl
 Gz6m98nUYIyqmNviaA/2GFwpMToEkOSYgm3rZKEWQbxSKvQVWDAb+9KCl7GELRmjxcjz2Y
 83OXAZXyoYMFvIhOei8OZq6HZlJs0BU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-vGfohmulOjuCa51Qiqp4pg-1; Thu, 05 Mar 2020 08:51:21 -0500
X-MC-Unique: vGfohmulOjuCa51Qiqp4pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 504888017DF;
 Thu,  5 Mar 2020 13:51:20 +0000 (UTC)
Received: from [10.10.120.166] (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8455C28C;
 Thu,  5 Mar 2020 13:51:16 +0000 (UTC)
Subject: Re: [PATCH v6 03/18] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-4-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <2a93ff2e-4955-67c4-e7af-766a49fc8b32@redhat.com>
Date: Thu, 5 Mar 2020 14:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304114231.23493-4-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04.03.20 12:42, Janosch Frank wrote:
> When a guest has saved a ipib of type 5 and calls diagnose308 with

s/a/an/

> subcode 10, we have to setup the protected processing environment via
> Ultravisor calls. The calls are done by KVM and are exposed via an
> API.
>=20
> The following steps are necessary:
> 1. Enable protected mode for the VM (register it and its cpus with the Ul=
travisor)
> 2. Forward the secure header to the Ultravisor (has all information on
> how to decrypt the image and VM information)
> 3. Protect image pages from the host and decrypt them
> 4. Verify the image integrity
>=20
> Only after step 4 a protected VM is allowed to run.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]
> ---
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  33 +++++++++
>  hw/s390x/ipl.h                      |   2 +
>  hw/s390x/pv.c                       | 106 ++++++++++++++++++++++++++++
>  hw/s390x/pv.h                       |  34 +++++++++
>  hw/s390x/s390-virtio-ccw.c          |  91 ++++++++++++++++++++++++
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  target/s390x/cpu.c                  |   4 ++
>  target/s390x/cpu.h                  |   1 +
>  target/s390x/cpu_features_def.inc.h |   1 +
>  10 files changed, 274 insertions(+)
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 hw/s390x/pv.h

[...]

> =20
>  #define KERN_IMAGE_START                0x010000UL
>  #define LINUX_MAGIC_ADDR                0x010008UL
> @@ -676,6 +677,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      cpu_physical_memory_unmap(addr, len, 1, len);
>  }
> =20
> +int s390_ipl_prepare_pv_header(void)
> +{
> +    S390IPLState *ipl =3D get_ipl_device();
> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
> +    int rc;
> +
> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
> +                             ipib_pv->pv_header_len);
> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
> +                          ipib_pv->pv_header_len);
> +    g_free(hdr);
> +    return rc;
> +}
> +
> +int s390_ipl_pv_unpack(void)
> +{
> +    int i, rc =3D 0;
> +    S390IPLState *ipl =3D get_ipl_device();
> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].siz=
e),
> +                            ipib_pv->components[i].tweak_pref);
> +        if (rc) {
> +            break;
> +        }

You can check for " && !rc" in the loop condition

> +    }
> +    return rc;
> +}
> +
>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 04be63cee1..ad8090a02c 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -105,6 +105,8 @@ typedef union IplParameterBlock IplParameterBlock;
>  int s390_ipl_set_loadparm(uint8_t *loadparm);
>  int s390_ipl_pv_check_components(IplParameterBlock *iplb);
>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
> +int s390_ipl_prepare_pv_header(void);
> +int s390_ipl_pv_unpack(void);
>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>  IplParameterBlock *s390_ipl_get_iplb(void);
>  IplParameterBlock *s390_ipl_get_iplb_secure(void);
> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000..50b68b6c34
> --- /dev/null
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,106 @@
> +/*
> + * Secure execution functions
> + *
> + * Copyright IBM Corp. 2020
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
> +const char *cmd_names[] =3D {
> +    "VM_ENABLE",
> +    "VM_DISABLE",
> +    "VM_SET_SEC_PARAMS",
> +    "VM_UNPACK",
> +    "VM_VERIFY",
> +    "VM_PREP_RESET",
> +    "VM_UNSHARE_ALL",
> +    NULL

Is the NULL really needed? This will be somewhat error prone when we add
new PV commands. Not sure if guarding this by an access function (chack
against ARRAY_SIZE() makes sense).

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index a89cf4c129..dd39890f89 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,8 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/s390x/pv.h"
> +#include <linux/kvm.h>
> =20
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -238,9 +240,11 @@ static void s390_create_sclpconsole(const char *type=
, Chardev *chardev)
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
>      VirtualCssBus *css_bus;
>      DeviceState *dev;
> =20
> +    ms->pv =3D false;

Should not be necessary, default is false.

>      s390_sclp_init();
>      /* init memory + setup max page size. Required for the CPU model */
>      s390_memory_init(machine->ram);
> @@ -316,10 +320,75 @@ static inline void s390_do_cpu_ipl(CPUState *cs, ru=
n_on_cpu_data arg)
>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>  }
> =20
> +static void s390_machine_unprotect(S390CcwMachineState *ms)
> +{
> +    CPUState *t;
> +
> +    if (!ms->pv)
> +        return;

How can this ever happen? g_assert(ms->pv) ?

Also, i don't see this function getting called from anywhere else except
when s390_machine_protect() fails. That looks wrong. This has to be
called when going out of PV mode.


> +    s390_pv_vm_disable();
> +    CPU_FOREACH(t) {
> +        S390_CPU(t)->env.pv =3D false;
> +    }
> +    ms->pv =3D false;
> +}
> +
> +static int s390_machine_protect(S390CcwMachineState *ms)
> +{
> +    CPUState *t;
> +    int rc;
> +

g_assert(!ms->pv) ?

> +    /* Create SE VM */
> +    rc =3D s390_pv_vm_enable();
> +    if (rc) {
> +        return rc;
> +    }
> +
> +    CPU_FOREACH(t) {
> +        S390_CPU(t)->env.pv =3D true;
> +    }
> +    ms->pv =3D true;
> +
> +    /* Set SE header and unpack */
> +    rc =3D s390_ipl_prepare_pv_header();
> +    if (rc) {
> +        goto out_err;
> +    }
> +
> +    /* Decrypt image */
> +    rc =3D s390_ipl_pv_unpack();
> +    if (rc) {
> +        goto out_err;
> +    }
> +
> +    /* Verify integrity */
> +    rc =3D s390_pv_verify();
> +    if (rc) {
> +        goto out_err;
> +    }
> +    return rc;
> +
> +out_err:
> +    s390_machine_unprotect(ms);
> +    return rc;
> +}
> +
> +#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
> +static void s390_machine_inject_pv_error(CPUState *cs)
> +{
> +    int r1 =3D (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
> +    CPUS390XState *env =3D &S390_CPU(cs)->env;
> +
> +    /* Report that we are unable to enter protected mode */
> +    env->regs[r1 + 1] =3D DIAG_308_RC_INVAL_FOR_PV;
> +}
> +

[...]
>      switch (reset_type) {
>      case S390_RESET_EXTERNAL:
>      case S390_RESET_REIPL:
> @@ -353,6 +424,26 @@ static void s390_machine_reset(MachineState *machine=
)
>          }
>          subsystem_reset();
>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
> +        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);

This does look unrelated and wrong?

> +        break;
> +    case S390_RESET_PV: /* Subcode 10 */
> +        subsystem_reset();
> +        s390_crypto_reset();
> +
> +        CPU_FOREACH(t) {
> +            if (t =3D=3D cs) {
> +                continue;
> +            }
> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
> +        }
> +        run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
> +
> +        if (s390_machine_protect(ms)) {
> +            s390_machine_inject_pv_error(cs);

Ah, so it's not an actual exception. BUT: All other guest cpus were
reset, can the guest deal with that?

(run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL) should go after the
s390_machine_protect() I assume - the change you had in the other patch)

> +            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> +            return;
> +        }
> +
>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>          break;
>      default:


--=20
Thanks,

David / dhildenb


