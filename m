Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A743C2D0F3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B682073B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJK1TbMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B682073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJdDC-0003uX-4v
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 09:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jJdCH-0003Tu-MR
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jJdCF-0004le-Ny
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jJdCF-0004l0-Es
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585746858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kzni+a+pjMuuVixoz0QjYPTvNR/en/IwUGQP0qomcFw=;
 b=GJK1TbMk+WzqUTPg1agvkwJttz4SJSazOQvo6TcP95bNisJqPodJMp3HfuRMqh9CqKgS9n
 /Yjhkb4O+glIl3soU+UfbQA8qa0kg+bDqnd0ELfQ9MM8+jfs72uqwizkY1GGeda4510sz1
 N22aRyolDbPeURThXrqKC5JIfgNT1F8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-GF_1ge3oNEWBVaEutNJqkw-1; Wed, 01 Apr 2020 09:14:17 -0400
X-MC-Unique: GF_1ge3oNEWBVaEutNJqkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A86D58017F4;
 Wed,  1 Apr 2020 13:14:15 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 406A660C05;
 Wed,  1 Apr 2020 13:14:13 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] vl/s390x: fixup ram sizes for compat machines
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
References: <20200401123754.109602-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <285819e0-e23e-32ac-b061-a0b683baeb5a@redhat.com>
Date: Wed, 1 Apr 2020 15:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401123754.109602-1-borntraeger@de.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01.04.20 14:37, Christian Borntraeger wrote:
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
> aligned one or if a change to a newer machine type is possible, use a
> machine version >=3D 5.0.
>=20
> A future versions might remove the compatibility handling.
>=20
> For machine types >=3D 5.0 we can simply use an increment size of 1M and
> use the full range of increment number which allows for all possible
> memory sizes. The old limitation of having a maximum of 1020 increments
> was added for standby memory, which we no longer support. With that we
> can now support even weird memory sizes like 10001234 MB.
>=20
> As we no longer fixup maxram_size as well, make other users use ram_size
> instead. Keep using maxram_size when setting the maximum ram size in KVM,
> as that will come in handy in the future when supporting memory hotplug
> (in contrast, storage keys and storage attributes for hotplugged memory
> will have to be migrated per RAM block in the future).
>=20
> Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-skeys.c        |  2 +-
>  hw/s390x/s390-stattrib-kvm.c |  4 ++--
>  hw/s390x/s390-virtio-ccw.c   | 21 +++++++++++++++++++++
>  hw/s390x/sclp.c              | 17 +++++------------
>  include/hw/boards.h          |  7 +++++++
>  softmmu/vl.c                 |  3 +++
>  6 files changed, 39 insertions(+), 15 deletions(-)
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
> index 3cf19c99f3..61a8a0e693 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -27,6 +27,7 @@
>  #include "qemu/ctype.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
> +#include "qemu/qemu-print.h"
>  #include "s390-pci-bus.h"
>  #include "sysemu/reset.h"
>  #include "hw/s390x/storage-keys.h"
> @@ -579,6 +580,25 @@ static void s390_nmi(NMIState *n, int cpu_index, Err=
or **errp)
>      s390_cpu_restart(S390_CPU(cs));
>  }
> =20
> +static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
> +{
> +    /* same logic as in sclp.c */
> +    int increment_size =3D 20;
> +    ram_addr_t newsz;
> +
> +    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
> +        increment_size++;
> +    }
> +    newsz =3D sz >> increment_size << increment_size;
> +
> +    if (sz !=3D newsz) {
> +        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
> +                    "MB to match machine restrictions. Consider updating=
 "
> +                    "the guest definition.i\n", sz / MiB, newsz / MiB);

Not sure if news/zs will be printed correctly in case ram_addr_t !=3D
uint64_t.

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb


