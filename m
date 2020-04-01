Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A92C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D92720787
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htEYscrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D92720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZDG-0002o0-CR
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 04:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jJZCe-0002Me-KG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jJZCd-0006j2-4R
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:58:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jJZCd-0006iM-1K
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585731506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sKoJg+94H5Ra3ufAAQ+akWaH5zIKLec8RQqjLl3n0D8=;
 b=htEYscrj9H2Cp60sDvKH9ABwD5P5KwCtnXjVZW7f23rEz+C0kNzMfXRkGwszeg/uqymu6u
 4ItgTpAT9ilG5qoA8gp3/qvPddFcrfiQbR4oAM/nEMrJLHNSWAzmY65We7Ky6VhFFkT/97
 /R4UK0HJgUJpN8Ue6mXYTJUrb5wLJzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-0QBnagcqOE2QE9gGWEKrpw-1; Wed, 01 Apr 2020 04:58:20 -0400
X-MC-Unique: 0QBnagcqOE2QE9gGWEKrpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC1A8DB61;
 Wed,  1 Apr 2020 08:58:18 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 554F75C3FA;
 Wed,  1 Apr 2020 08:58:16 +0000 (UTC)
Subject: Re: [PATCH v2] vl/s390: fixup ram sizes for compat machines
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
References: <20200401085014.100125-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <da218b9e-1551-08c5-86e4-9f9837901974@redhat.com>
Date: Wed, 1 Apr 2020 10:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401085014.100125-1-borntraeger@de.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01.04.20 10:50, Christian Borntraeger wrote:
> Older QEMU versions did fixup the ram size to match what can be reported
> via sclp. We need to mimic this behaviour for machine types 4.2 and
> older to not fail on inbound migration for memory sizes that do not fit.
> Old machines with proper aligned memory sizes are not affected.
>=20
> Alignment table:
>  VM size (<=3D) | Alignment
> --------------------------
>       1020M   |     1M
>       2040M   |     2M
>       4080M   |     4M
>       8160M   |     8M
>      16320M   |    16M
>      32640M   |    32M
>      65280M   |    64M
>     130560M   |   128M
>     261120M   |   256M
>     522240M   |   512M
>    1044480M   |     1G
>    2088960M   |     2G
>    4177920M   |     4G
>    8355840M   |     8G
>=20
> Suggested action is to replace unaligned -m value with a suitable
> aligned one or to use a machine version >=3D 5.0 as future versions might
> remove the compatibility handling.
>=20
> For machine types >=3D 5.0 we can simply use an increment size of 1M and
> use the full range of increment number which allows for all possible
> memory sizes. The old limitation of having a maximum of 1020 increments
> was added for standby memory, which we no longer support. With that we
> can now support even weird memory sizes like 10001234 MB.
>=20

You should probably add while the maxram_size changes are done.

> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -27,6 +27,7 @@
>  #include "qemu/ctype.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
> +#include "qemu/qemu-print.h"
>  #include "s390-pci-bus.h"
>  #include "sysemu/reset.h"
>  #include "hw/s390x/storage-keys.h"
> @@ -579,6 +580,23 @@ static void s390_nmi(NMIState *n, int cpu_index, Err=
or **errp)
>      s390_cpu_restart(S390_CPU(cs));
>  }
> =20
> +static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
> +{
> +    /* same logic as in sclp.c */
> +    int increment_size =3D 20;

missing empty line

> +    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
> +        increment_size++;
> +    }
> +    if (sz !=3D sz >> increment_size << increment_size) {

I'd just cache the calculation so ...

> +        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
> +                    "MB to match machine restrictions. Consider updating=
 "
> +                    "the guest definition.\n",
> +                    sz / 1048576,
> +                    (sz >> increment_size << increment_size) / 1048576);

.. this looks less ugly.

Please use MiB instead of 1048576. (see my original patch)

> +    }
> +    return sz >> increment_size << increment_size;
> +}
> +
>  static void ccw_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -808,6 +826,7 @@ static void ccw_machine_4_2_instance_options(MachineS=
tate *machine)
>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>  {
>      ccw_machine_5_0_class_options(mc);
> +    mc->fixup_ram_size =3D s390_fixup_ram_size;
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
>  }
>  DEFINE_CCW_MACHINE(4_2, "4.2", false);
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index d8ae207731..d843c8fea2 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -346,7 +346,7 @@ static void sclp_realize(DeviceState *dev, Error **er=
rp)
>       */
>      qdev_set_parent_bus(DEVICE(sclp->event_facility), sysbus_get_default=
());
> =20
> -    ret =3D s390_set_memory_limit(machine->maxram_size, &hw_limit);
> +    ret =3D s390_set_memory_limit(machine->ram_size, &hw_limit);

I mentioned in my patch why I left this as is. But we can change that
with memory hotplug support.


>      if (ret =3D=3D -E2BIG) {
>          error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
>                     hw_limit / GiB);
> @@ -361,27 +361,20 @@ out:
>  static void sclp_memory_init(SCLPDevice *sclp)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> +    MachineClass *machine_class =3D MACHINE_GET_CLASS(qdev_get_machine()=
);
>      ram_addr_t initial_mem =3D machine->ram_size;
>      int increment_size =3D 20;
> =20
>      /* The storage increment size is a multiple of 1M and is a power of =
2.
> -     * The number of storage increments must be MAX_STORAGE_INCREMENTS o=
r fewer.
> +     * For some machine types, the number of storage increments must be
> +     * MAX_STORAGE_INCREMENTS or fewer.
>       * The variable 'increment_size' is an exponent of 2 that can be
>       * used to calculate the size (in bytes) of an increment. */
> -    while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
> +    while (machine_class->fixup_ram_size !=3D NULL &&
> +           (initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
>          increment_size++;
>      }
>      sclp->increment_size =3D increment_size;

IIRC one could define ram size in KB. Not sure if it is worth checking
against that.
[...]

>  static void sclp_init(Object *obj)
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 236d239c19..0532143327 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -152,6 +152,12 @@ typedef struct {
>   *    It also will be used as a way to optin into "-m" option support.
>   *    If it's not set by board, '-m' will be ignored and generic code wi=
ll
>   *    not create default RAM MemoryRegion.
> + * @fixup_ram_size:
> + *    amends user provided ram size (with -m option) using machine

s/amends/Amends/

> + *    specific algorithm. to be used by old machine types for compat

s/to/To/

> + *    purposes only.
> + *    Applies only to default memory backend, i.e. explicit memory backe=
nd

"i.e.,"


--=20
Thanks,

David / dhildenb


