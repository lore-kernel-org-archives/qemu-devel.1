Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0BEC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D1C20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk+ETcAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D1C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBalo-0004Yy-GS
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jBakV-0003Mo-QS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jBakT-0005dy-Sh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:00:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jBakT-0005cO-NX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583830825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aglfHNYcjl1+oLBV0NW7glqkTl9fCrlRglPZCj9XjGc=;
 b=Mk+ETcAHWS8LcPqHefGetu18uoLQpFn59D2PSmEWFALVaIcgYsy8KwqtMjbHAwxsE79ThE
 PUrhLG3yRWnX8qhXywWlfjrMkuE4ESB8htIbxNTYeXxwHGGoUEX9U4ZwayPJrx8xDuKw4A
 BMDyZMuhxYvnSO+sKC6Fp8UjX2fZ0RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-OB_PgceTO_uwvbg6YNFEDg-1; Tue, 10 Mar 2020 05:00:23 -0400
X-MC-Unique: OB_PgceTO_uwvbg6YNFEDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB7B0800D50;
 Tue, 10 Mar 2020 09:00:21 +0000 (UTC)
Received: from [10.36.118.8] (unknown [10.36.118.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B56375D9C5;
 Tue, 10 Mar 2020 09:00:20 +0000 (UTC)
Subject: Re: [PATCH v8 2/2] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <b608f7d8-81ac-1e5b-011d-bd576f77aade@redhat.com>
 <20200310083232.29805-1-frankja@linux.ibm.com>
 <20200310083232.29805-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <100bd846-61f1-973b-b97f-753463646e68@redhat.com>
Date: Tue, 10 Mar 2020 10:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310083232.29805-2-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.03.20 09:32, Janosch Frank wrote:
> The unpack facility provides the means to setup a protected guest. A
> protected guest can not be introspected by the hypervisor or any
> user/administrator of the machine it is running on.
>=20
> Protected guests are encrypted at rest and need a special boot
> mechanism via diag308 subcode 8 and 10.
>=20
> Code 8 sets the PV specific IPLB which is retained seperately from
> those set via code 5.
>=20
> Code 10 is used to unpack the VM into protected memory, verify its
> integrity and start it.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]

[...]


> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000..ba6409246e
> --- /dev/null
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,104 @@
> +/*
> + * Secure execution functions

Protected virtualization ;)

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

[...]

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

As discussed, not needed.

>      s390_sclp_init();
>      /* init memory + setup max page size. Required for the CPU model */
>      s390_memory_init(machine->ram);
> @@ -316,10 +320,88 @@ static inline void s390_do_cpu_ipl(CPUState *cs, ru=
n_on_cpu_data arg)
>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>  }
> =20
> +static void s390_machine_unprotect(S390CcwMachineState *ms)
> +{
> +    CPUState *t;
> +
> +    s390_pv_vm_disable();
> +    CPU_FOREACH(t) {
> +        S390_CPU(t)->env.pv =3D false;
> +    }

See below, would be great if we can get rid of env.pv IMHO.

[...]

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
> +            /*
> +             * Continue after the diag308 so the guest knows something
> +             * went wrong.
> +             */
> +            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> +            return;

Didn't you want to squash in that hunk from the other patch? (I remember
seeing a goto)

> +        }
> +
>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>          break;
>      default:

[...]

> =20
> +#if !defined(CONFIG_USER_ONLY)
> +static bool machine_is_pv(MachineState *ms)
> +{
> +    static S390CcwMachineState *ccw;
> +    Object *obj;
> +
> +    if (ccw)
> +=09    return ccw->pv;

missing {}

> +
> +    /* we have to bail out for the "none" machine */
> +    obj =3D object_dynamic_cast(OBJECT(ms), TYPE_S390_CCW_MACHINE);
> +     if (!obj) {
> +        return false;
> +    }
> +    ccw =3D S390_CCW_MACHINE(obj);
> +    return ccw->pv;
> +}
> +#endif

Now that we talked about cached values, what about

#if !defined(CONFIG_USER_ONLY)
static bool s390_is_pv(void)
{
    static S390CcwMachineState *ccw;
    Object *obj;

    if (ccw) {
        return ccw->pv;
    }

    /* we have to bail out for the "none" machine */
    obj =3D object_dynamic_cast(qdev_get_machine(),
                              TYPE_S390_CCW_MACHINE);
    if (!obj) {
        return false;
    }
    ccw =3D S390_CCW_MACHINE(obj);
    return ccw->pv;
}
#endif

and drop all env->pv checks, replacing them by s390_is_pv(). (sorry,
should have recommended that earlier)

> +
>  static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs =3D CPU(dev);
> @@ -205,6 +226,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
>          goto out;
>      }
> =20
> +    cpu->env.pv =3D machine_is_pv(ms);
>      /* sync cs->cpu_index and env->core_id. The latter is needed for TCG=
. */
>      cs->cpu_index =3D cpu->env.core_id;
>  #endif
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 1d17709d6e..7e4d9d267c 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -114,6 +114,7 @@ struct CPUS390XState {
> =20
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
> +    bool pv; /* protected virtualization */
> =20
>  #if !defined(CONFIG_USER_ONLY)
>      uint32_t core_id; /* PoP "CPU address", same as cpu_index */
> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_featu=
res_def.inc.h
> index 31dff0d84e..60db28351d 100644
> --- a/target/s390x/cpu_features_def.inc.h
> +++ b/target/s390x/cpu_features_def.inc.h
> @@ -107,6 +107,7 @@ DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "De=
flate-conversion facility (
>  DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH, "vxpdeh", STFL, 152, "Vector-Packed-=
Decimal-Enhancement Facility")
>  DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-ext=
ension-9 facility (excluding subfunctions)")
>  DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
> +DEF_FEAT(UNPACK, "unpack", STFL, 161, "Unpack facility")

Random thought: The naming of that facility could have been improved to
something that gives users/readers an idea what it's actually doing.


[...]

> @@ -128,17 +142,31 @@ out:
>          g_free(iplb);
>          return;
>      case DIAG308_STORE:
> +    case DIAG308_PV_STORE:
>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>              return;
>          }
> -        iplb =3D s390_ipl_get_iplb();
> +        if (subcode =3D=3D DIAG308_PV_STORE) {
> +            iplb =3D s390_ipl_get_iplb_pv();
> +        } else {
> +            iplb =3D s390_ipl_get_iplb();
> +        }
>          if (iplb) {
>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len)=
);
>              env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>          } else {
>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>          }
> -        return;
> +        break;

return->break is unrelated, but we do have a wild mixture already.

> +    case DIAG308_PV_START:
> +        iplb =3D s390_ipl_get_iplb_pv();
> +        if (!iplb) {
> +            env->regs[r1 + 1] =3D DIAG_308_RC_NO_PV_CONF;
> +            return;
> +        }
> +
> +        s390_ipl_reset_request(cs, S390_RESET_PV);
> +        break;
>      default:
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          break;
>=20


--=20
Thanks,

David / dhildenb


