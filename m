Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6341C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A14F20578
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrXqW/s4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A14F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgqD-0004wx-OV
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jBglq-0006VG-FJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jBgln-0007IW-PN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:26:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jBgln-0007GM-FB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583853970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+58mnEHFmI8zv2AqmWz/d/Hiz4RvfdeOZPS+x6SlE9Q=;
 b=GrXqW/s4kkGWf1cmUfxMhP6LzX17UxY0wxhoUMTh8+Q9zVyfqy1yzG0GK6mvZfUMyCfXIQ
 ItJhLimzAJx88DLw3PoQxhc4xYi4iosfUkSRXIT6Wctr+h9Qox59qx6TRfm2InQ/GvJtrs
 0Qh17KnUsaiwwgsOls2Xpl/Vdl4cKUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-gRtUJ-S_NsOrSTLZixXjhw-1; Tue, 10 Mar 2020 11:26:07 -0400
X-MC-Unique: gRtUJ-S_NsOrSTLZixXjhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD99C18B644F;
 Tue, 10 Mar 2020 15:26:05 +0000 (UTC)
Received: from [10.36.116.71] (ovpn-116-71.ams2.redhat.com [10.36.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F0D88681F;
 Tue, 10 Mar 2020 15:26:04 +0000 (UTC)
Subject: Re: [PATCH v8 02/15] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200310134008.130038-1-frankja@linux.ibm.com>
 <20200310134008.130038-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <6e8508a7-4f8a-fca7-4ca7-4d598b0ccb84@redhat.com>
Date: Tue, 10 Mar 2020 16:26:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310134008.130038-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On 10.03.20 14:39, Janosch Frank wrote:
> The unpack facility provides the means to setup a protected guest. A
> protected guest can not be introspected by the hypervisor or any

"cannot"

> user/administrator of the machine it is running on.
>=20
> Protected guests are encrypted at rest and need a special boot
> mechanism via diag308 subcode 8 and 10.
>=20
> Code 8 sets the PV specific IPLB which is retained seperately from

"separately"

> those set via code 5.
>=20
> Code 10 is used to unpack the VM into protected memory, verify its
> integrity and start it.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]

[...]

> +static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
> +{
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +    int i;
> +
> +    if (ipib_pv->num_comp =3D=3D 0) {
> +        return false;
> +    }
> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +        /* Addr must be 4k aligned */
> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {

I usually find

QEMU_IS_ALIGNED(ipib_pv->components[i].addr, TARGET_PAGE_MASK)

nicer

[...]

> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000..1ba8bc7242
> --- /dev/null
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,104 @@
> +/*
> + * Protected Virtualization functions
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
> +};
> +
> +static int s390_pv_cmd(uint32_t cmd, void *data)
> +{
> +    int rc;

reverse x... :)

> +    struct kvm_pv_cmd pv_cmd =3D {
> +        .cmd =3D cmd,
> +        .data =3D (uint64_t)data,
> +    };
> +

and then maybe

int rc =3D  ...

> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV command %d (%s) failed: header rc %x rrc %x=
 "
> +                     "IOCTL rc: %d", cmd, cmd_names[cmd], pv_cmd.rc, pv_=
cmd.rrc,
> +                     rc);
> +    }
> +    return rc;
> +}
> +
> +static void s390_pv_cmd_exit(uint32_t cmd, void *data)
> +{
> +    int rc;
> +
> +    rc =3D s390_pv_cmd(cmd, data);

int rc =3D ...

> +    if (rc) {
> +        exit(1);
> +    }
> +}
> +

[...]

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 895498cca6..455ad31718 100644
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
> @@ -316,10 +318,80 @@ static inline void s390_do_cpu_ipl(CPUState *cs, ru=
n_on_cpu_data arg)
>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>  }
> =20
> +static void s390_machine_unprotect(S390CcwMachineState *ms)
> +{
> +

superfluous empty line

> +    s390_pv_vm_disable();
> +    ms->pv =3D false;
> +}
> +

[...]

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3dd396e870..bcb9e47767 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -37,6 +37,8 @@
>  #include "sysemu/hw_accel.h"
>  #include "hw/qdev-properties.h"
>  #ifndef CONFIG_USER_ONLY
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "hw/s390x/pv.h"

Do you need that include here? I don't think so.

>  #include "hw/boards.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
> @@ -174,6 +176,27 @@ static void s390_cpu_disas_set_info(CPUState *cpu, d=
isassemble_info *info)
>      info->print_insn =3D print_insn_s390;
>  }
> =20
> +#if !defined(CONFIG_USER_ONLY)
> +bool s390_is_pv(void)
> +{
> +    static S390CcwMachineState *ccw;
> +    Object *obj;
> +
> +    if (ccw) {
> +        return ccw->pv;
> +    }
> +
> +    /* we have to bail out for the "none" machine */
> +    obj =3D object_dynamic_cast(qdev_get_machine(),
> +                              TYPE_S390_CCW_MACHINE);
> +    if (!obj) {
> +        return false;
> +    }
> +    ccw =3D S390_CCW_MACHINE(obj);
> +    return ccw->pv;
> +}
> +#endif
> +

Nit: I *think* this would be better placed in hw/s390x/pv.h

>  static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs =3D CPU(dev);
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 1d17709d6e..8fa25d9ed5 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -762,6 +762,7 @@ static inline void s390_do_cpu_load_normal(CPUState *=
cs, run_on_cpu_data arg)
> =20
> =20
>  /* cpu.c */
> +bool s390_is_pv(void);

Wonder if this will compile with CONFIG_USER_ONLY (maybe we need a
"return false" dummy). I assume you test-compiled that with all variants
(CONFIG_TCG, CONFIG_USER_ONLY, ...)


.. we're almost there ... :)

--=20
Thanks,

David / dhildenb


