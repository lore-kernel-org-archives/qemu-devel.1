Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700DBC2D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359F520784
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGuii+tX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359F520784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJnS-0001Xt-89
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJJmf-000124-NA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJJme-00061b-41
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:30:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32376
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJJmd-00061I-W5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585672235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z18yHImWKK3lnoKTS4J8Z5NzJMN3odO8i1CnqiNLMZY=;
 b=AGuii+tXcFdZ/85f97zS6YtwKrrKpvC/xlQGXbwMufvDR8RbnM3kwfD+Q8ClnAXvFvnr1v
 qkHAhPTvDSHPyZgAQolZghz38s1iNqsHAXq60L4PPAz/6+lvc1Q1QBgwaRRA8tVtI1ap9j
 4X8VE0dXmGnHQVULqmNk9XoCqqmK644=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Q5QA5J0WMQSe_54GlM9cCA-1; Tue, 31 Mar 2020 12:30:31 -0400
X-MC-Unique: Q5QA5J0WMQSe_54GlM9cCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9413801A01;
 Tue, 31 Mar 2020 16:30:29 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3D1419C58;
 Tue, 31 Mar 2020 16:30:24 +0000 (UTC)
Date: Tue, 31 Mar 2020 18:30:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1] vl/s390: fixup ram sizes for compat machines
Message-ID: <20200331183022.72b662fd.cohuck@redhat.com>
In-Reply-To: <20200331153554.69341-1-borntraeger@de.ibm.com>
References: <20200331153554.69341-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?B?THVr?= =?UTF-8?B?w6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 11:35:54 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> compat machines did fixup the ram size to match what can be reported via

s/compat machines/Older QEMU versions/ ?

> sclp. We need to mimic those for machines 4.2 and older to not fail on

"We need to mimic this behavior for machine types 4.2 and older" ?

> inbound migration. For Machines >=3D 5.0 we can simply use an increment

s/Machines/machine types/

> size of 1M und use the full range of increment number which allows for
> all possible memory sizes. The old limitation of having a maximum of
> 1020 increments was added for standby memory, which we no longer
> support. With that we can now support even weird memory sizes like
> 10001234 MB.

FWIW, I think this approach is better than a hard fail of odd memory
sizes, even if we think now that the automatic rounding was not such a
good idea.

>=20
> Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> RFC->v1:
> - also fix mamram
> - provide full granularity for machine 5.0
>=20
>  hw/s390x/s390-skeys.c              |  2 +-
>  hw/s390x/s390-stattrib-kvm.c       |  4 ++--
>  hw/s390x/s390-virtio-ccw.c         | 20 ++++++++++++++++++++
>  hw/s390x/sclp.c                    | 19 ++++++-------------
>  include/hw/boards.h                |  1 +
>  include/hw/s390x/s390-virtio-ccw.h |  4 +++-
>  softmmu/vl.c                       |  3 +++
>  7 files changed, 36 insertions(+), 17 deletions(-)
>=20

(...)

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3cf19c99f3..bdfd10f77d 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -579,6 +579,16 @@ static void s390_nmi(NMIState *n, int cpu_index, Err=
or **errp)
>      s390_cpu_restart(S390_CPU(cs));
>  }
> =20
> +static ram_addr_t s390_align_ram(ram_addr_t sz)
> +{
> +    /* same logic as in sclp.c */
> +    int increment_size =3D 20;
> +    while ((sz >> increment_size) > 1020) {

<nitpick>Use MAX_STORAGE_INCREMENTS?</nitpick>

> +        increment_size++;
> +    }
> +    return sz >> increment_size << increment_size;
> +}
> +
>  static void ccw_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -590,6 +600,7 @@ static void ccw_machine_class_init(ObjectClass *oc, v=
oid *data)
>      s390mc->cpu_model_allowed =3D true;
>      s390mc->css_migration_enabled =3D true;
>      s390mc->hpage_1m_allowed =3D true;
> +    s390mc->mem_inc_1020 =3D false;
>      mc->init =3D ccw_init;
>      mc->reset =3D s390_machine_reset;
>      mc->hot_add_cpu =3D s390_hot_add_cpu;
> @@ -686,6 +697,11 @@ bool hpage_1m_allowed(void)
>      return get_machine_class()->hpage_1m_allowed;
>  }
> =20
> +bool mem_inc_1020(void)
> +{
> +    return get_machine_class()->mem_inc_1020;

Not sure I like that name; but cannot think of a better name, either :(

> +}
> +
>  static char *machine_get_loadparm(Object *obj, Error **errp)
>  {
>      S390CcwMachineState *ms =3D S390_CCW_MACHINE(obj);
> @@ -807,7 +823,11 @@ static void ccw_machine_4_2_instance_options(Machine=
State *machine)
> =20
>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>  {
> +    S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
> +
>      ccw_machine_5_0_class_options(mc);
> +    mc->machine_align_ram =3D s390_align_ram;
> +    s390mc->mem_inc_1020 =3D true;
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
>  }
>  DEFINE_CCW_MACHINE(4_2, "4.2", false);
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index d8ae207731..d1fff18443 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -21,6 +21,7 @@
>  #include "hw/s390x/sclp.h"
>  #include "hw/s390x/event-facility.h"
>  #include "hw/s390x/s390-pci-bus.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
>  #include "hw/s390x/ipl.h"
> =20
>  static inline SCLPDevice *get_sclp_device(void)
> @@ -346,7 +347,7 @@ static void sclp_realize(DeviceState *dev, Error **er=
rp)
>       */
>      qdev_set_parent_bus(DEVICE(sclp->event_facility), sysbus_get_default=
());
> =20
> -    ret =3D s390_set_memory_limit(machine->maxram_size, &hw_limit);
> +    ret =3D s390_set_memory_limit(machine->ram_size, &hw_limit);
>      if (ret =3D=3D -E2BIG) {
>          error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
>                     hw_limit / GiB);
> @@ -365,23 +366,15 @@ static void sclp_memory_init(SCLPDevice *sclp)
>      int increment_size =3D 20;
> =20
>      /* The storage increment size is a multiple of 1M and is a power of =
2.
> -     * The number of storage increments must be MAX_STORAGE_INCREMENTS o=
r fewer.
> +     * The number of storage increments must be MAX_STORAGE_INCREMENTS o=
r fewer
> +     * for some machine types.

I think

"For some machine types, the number of..."

would read a bit better.

>       * The variable 'increment_size' is an exponent of 2 that can be
>       * used to calculate the size (in bytes) of an increment. */
> -    while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
> +    while (mem_inc_1020() &&
> +           (initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
>          increment_size++;
>      }
>      sclp->increment_size =3D increment_size;
> -
> -    /* The core memory area needs to be aligned with the increment size.
> -     * In effect, this can cause the user-specified memory size to be ro=
unded
> -     * down to align with the nearest increment boundary. */
> -    initial_mem =3D initial_mem >> increment_size << increment_size;
> -
> -    machine->ram_size =3D initial_mem;
> -    machine->maxram_size =3D initial_mem;
> -    /* let's propagate the changed ram size into the global variable. */
> -    ram_size =3D initial_mem;
>  }
> =20
>  static void sclp_init(Object *obj)
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 236d239c19..e3574f4b5f 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -218,6 +218,7 @@ struct MachineClass {
>                                                           unsigned cpu_in=
dex);
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine)=
;
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
> +    ram_addr_t (*machine_align_ram)(ram_addr_t size);

/* Intended for compatibility handling. */ ?

>  };
> =20
>  /**

(...)

Apart from the nits, looks sane to me.


