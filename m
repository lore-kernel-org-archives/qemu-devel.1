Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A49AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 21:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2379220838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 21:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1IMKEBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2379220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJOmV-0001Jf-83
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 17:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jJOlf-0000m2-Tu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 17:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jJOld-000625-Up
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 17:49:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jJOld-00060W-PP
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 17:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585691393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxOYK8qu4OwLTLUal+NzlSu9ycwhL1MgwRaav+qqJe0=;
 b=J1IMKEBwLmkyM9AtHb7EnVtpt8NFBzfdDyYQJzgt5j9waNtgZFmXZzua9MiELoF4lfADwI
 95QxgC2p7lcpxoghj6pTdLlu/a11aqJZnKsGn84b3/V+7XeAxBZatkycMGpG0v7zw7KclE
 w+ulhlfGJocvC4ksdUYAFnTlbrAOTZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-q9Gd8rSZN1-cwUvTHk-TMw-1; Tue, 31 Mar 2020 17:49:49 -0400
X-MC-Unique: q9Gd8rSZN1-cwUvTHk-TMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9533C190A7A1;
 Tue, 31 Mar 2020 21:49:48 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AA055C1B0;
 Tue, 31 Mar 2020 21:49:42 +0000 (UTC)
Date: Tue, 31 Mar 2020 23:49:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1] vl/s390: fixup ram sizes for compat machines
Message-ID: <20200331234940.29d228a3@redhat.com>
In-Reply-To: <20200331153554.69341-1-borntraeger@de.ibm.com>
References: <20200331153554.69341-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 11:35:54 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> compat machines did fixup the ram size to match what can be reported via
> sclp. We need to mimic those for machines 4.2 and older to not fail on
> inbound migration.
not entirely correct, migration wouldn't fail if target was started
with correct ram size, so OLD machine with incorrect size can still
be migrated to new QEMU provided target QEMU CLI has corrected ram size.

this probably should be captured in commit message so it
would be clear that we are adding hack to keep rounding bug so users
won't have to care about correcting it on their side.

Probably also add here the table, David composed, about how much
RAM user would loose (but still pay for :/) in case of fixup kicks in.

PS:
Shall we add deprecation message along with this patch, so that
eventually we could remove fixup altogether, like we do with other
CLI breaking changes?
Something along the lines:
"
S390:
If user using -m explicitly specified ram size not aligned according
to the table below, 4.2 and older machine types will actually silently
round it down and VM will get less RAM than it was asked for on alignment
value.

Alignment table:
 VM size (<=3D) | Alignment
--------------------------
      1020M   |     1M
      2040M   |     2M
      4080M   |     4M
      8160M   |     8M
     16320M   |    16M
     32640M   |    32M
     65280M   |    64M
    130560M   |   128M
    261120M   |   256M
    522240M   |   512M
   1044480M   |     1G
   2088960M   |     2G
   4177920M   |     4G
   8355840M   |     8G

Suggested action is to replace unaligned -m value with a suitable aligned o=
ne,
future versions will add strict check for valid initial RAM sizes
so VM started on old QEMU with unaligned size won't be able to migrate
strait away since new QEMU won't start with incorrect size. However there i=
s
still possibility to migrate old running VM if migration target is started =
with
corrected RAM size according to above table.=20
"


> For Machines >=3D 5.0 we can simply use an increment
> size of 1M und use the full range of increment number which allows for
             ^^^ and=20
> all possible memory sizes. The old limitation of having a maximum of
> 1020 increments was added for standby memory, which we no longer
> support. With that we can now support even weird memory sizes like
> 10001234 MB.
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
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 5da6e5292f..a9a4ae7b39 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -176,7 +176,7 @@ static void qemu_s390_skeys_init(Object *obj)
>      QEMUS390SKeysState *skeys =3D QEMU_S390_SKEYS(obj);
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> =20
> -    skeys->key_count =3D machine->maxram_size / TARGET_PAGE_SIZE;
> +    skeys->key_count =3D machine->ram_size / TARGET_PAGE_SIZE;
>      skeys->keydata =3D g_malloc0(skeys->key_count);
>  }
> =20
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index c7e1f35524..f89d8d9d16 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -85,7 +85,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribSta=
te *sa,
>  {
>      KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> -    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
> +    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
> =20
>      if (start_gfn + count > max) {
>          error_report("Out of memory bounds when setting storage attribut=
es");
> @@ -104,7 +104,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttri=
bState *sa)
>  {
>      KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> -    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
> +    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
>      /* We do not need to reach the maximum buffer size allowed */
>      unsigned long cx, len =3D KVM_S390_SKEYS_MAX / 2;
>      int r;
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
> +        increment_size++;
> +    }

Print a warning here that asked for ram size is incorrect (if that's the ca=
se)?
and will be fixed up to (and maybe suggest user to fix config to valid size=
 we calculate here and how much size were lost due to alignment)

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
>       * The variable 'increment_size' is an exponent of 2 that can be
>       * used to calculate the size (in bytes) of an increment. */
> -    while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {

if s/machine_align_ram/fixup_ram_size/
then mem_inc_1020()&co could be replaced with

machine_class->fixup_ram_size !=3D NULL

> +    while ( mem_inc_1020() &&
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
I'd s/machine_//, looks redundant
also I'd call it fixup_ram_size() +=20
doc comment above saying something like:

"
 amends user provided ram size (with -m option) using machine
 specific algorithm. to be used by old machine types for compat
 purposes only.
 Applies only to default memory backend (i.e. explicit memory backend
 wasn't used.
"

>  };
> =20
>  /**
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-v=
irtio-ccw.h
> index cd1dccc6e3..022ee6685b 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
>      bool cpu_model_allowed;
>      bool css_migration_enabled;
>      bool hpage_1m_allowed;
> +    bool mem_inc_1020;
>  } S390CcwMachineClass;
> =20
>  /* runtime-instrumentation allowed by the machine */
> @@ -49,7 +50,8 @@ bool ri_allowed(void);
>  bool cpu_model_allowed(void);
>  /* 1M huge page mappings allowed by the machine */
>  bool hpage_1m_allowed(void);
> -
> +/* Machine has only 1020 memory increments */
> +bool mem_inc_1020(void);
>  /**
>   * Returns true if (vmstate based) migration of the channel subsystem
>   * is enabled, false if it is disabled.
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 1d33a28340..12b5758d12 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2601,6 +2601,9 @@ static bool set_memory_options(uint64_t *ram_slots,=
 ram_addr_t *maxram_size,
>      }
> =20
>      sz =3D QEMU_ALIGN_UP(sz, 8192);
> +    if (mc->machine_align_ram) {
> +        sz =3D mc->machine_align_ram(sz);
> +    }
>      ram_size =3D sz;
>      if (ram_size !=3D sz) {
>          error_report("ram size too large");


