Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A7EC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4D7206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GifCoddx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4D7206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHsAd-00088U-F1
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHs9u-0007bV-HV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHs9s-0003TU-US
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:48:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46045)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHs9s-0003RG-QA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585327716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5qmy82R2pnXOpntrrKDBeipHWn+mC+swlvydz10xCI=;
 b=GifCoddxzn2x2sk9ZZnqC+krqT/6sD4l8oMEvMiabumDolYDPJ+rTRhgBC4cWQjLe2cbyN
 2vKkp+NhHMUfgJFztMNqxgORHi5yK5tKRl8LKbrZkMAhl+vDHZIVJJDdrXjvEMkQCxyWkC
 ls9O+/K78RmymMzEMBcd2SZ2AEqHXfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-5C8SStlDNhmqbMIHk0a6-g-1; Fri, 27 Mar 2020 12:48:32 -0400
X-MC-Unique: 5C8SStlDNhmqbMIHk0a6-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE0DA0CC0;
 Fri, 27 Mar 2020 16:48:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 393B160304;
 Fri, 27 Mar 2020 16:48:24 +0000 (UTC)
Date: Fri, 27 Mar 2020 17:48:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] s390x: Reject unaligned RAM sizes
Message-ID: <20200327174823.48c523dc@redhat.com>
In-Reply-To: <20200327152930.66636-1-david@redhat.com>
References: <20200327152930.66636-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 16:29:30 +0100
David Hildenbrand <david@redhat.com> wrote:

> Historically, we fixed up the RAM size (rounded it down), to fit into
> storage increments. Since commit 3a12fc61af5c ("390x/s390-virtio-ccw: use
> memdev for RAM"), we no longer consider the fixed-up size when
> allcoating the RAM block - which will break migration.
>=20
> Let's simply drop that manual fixup code and let the user supply sane
> RAM sizes. This will bail out early when trying to migrate (and make
> an existing guest with e.g., 12345 MB non-migratable), but maybe we
> should have rejected such RAM sizes right from the beginning.
>=20
> As we no longer fixup maxram_size as well, make other users use ram_size
> instead. Keep using maxram_size when setting the maximum ram size in KVM,
> as that will come in handy in the future when supporting memory hotplug
> (in contrast, storage keys and storage attributes for hotplugged memory
>  will have to be migrated per RAM block in the future).
>=20
> This fixes (or rather rejects early):
>=20
> 1. Migrating older QEMU to upstream QEMU (e.g., with "-m 1235M"), as the
>    RAM block size changed.
>=20
> 2. Migrating upstream QEMU to upstream QEMU (e.g., with "-m 1235M"), as
>    we receive storage attributes for memory we don't expect (as we fixed =
up
>    ram_size and maxram_size).
>=20
> Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-skeys.c        |  4 +---
>  hw/s390x/s390-stattrib-kvm.c |  7 ++-----
>  hw/s390x/sclp.c              | 21 +++++++++++----------
>  3 files changed, 14 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 5da6e5292f..2545b1576b 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -11,7 +11,6 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> -#include "hw/boards.h"
>  #include "hw/s390x/storage-keys.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc-target.h"
> @@ -174,9 +173,8 @@ out:
>  static void qemu_s390_skeys_init(Object *obj)
>  {
>      QEMUS390SKeysState *skeys =3D QEMU_S390_SKEYS(obj);
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> =20
> -    skeys->key_count =3D machine->maxram_size / TARGET_PAGE_SIZE;
> +    skeys->key_count =3D ram_size / TARGET_PAGE_SIZE;

why are you dropping machine->foo all around and switching to global ram_si=
ze?
(I'd rather do other way around)

>      skeys->keydata =3D g_malloc0(skeys->key_count);
>  }
> =20
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index c7e1f35524..ae88fbc32e 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -10,7 +10,6 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -#include "hw/boards.h"
>  #include "migration/qemu-file.h"
>  #include "hw/s390x/storage-attributes.h"
>  #include "qemu/error-report.h"
> @@ -84,8 +83,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribSta=
te *sa,
>                                          uint8_t *values)
>  {
>      KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> -    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
> +    unsigned long max =3D ram_size / TARGET_PAGE_SIZE;
> =20
>      if (start_gfn + count > max) {
>          error_report("Out of memory bounds when setting storage attribut=
es");
> @@ -103,8 +101,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribS=
tate *sa,
>  static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>  {
>      KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> -    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
> +    unsigned long max =3D ram_size / TARGET_PAGE_SIZE;
>      /* We do not need to reach the maximum buffer size allowed */
>      unsigned long cx, len =3D KVM_S390_SKEYS_MAX / 2;
>      int r;
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index af0bfbc2ec..6af471fb3f 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -326,8 +326,7 @@ out:
> =20
>  static void sclp_memory_init(SCLPDevice *sclp)
>  {
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> -    ram_addr_t initial_mem =3D machine->ram_size;
> +    uint64_t initial_mem =3D ram_size;
>      int increment_size =3D 20;
> =20
>      /* The storage increment size is a multiple of 1M and is a power of =
2.
> @@ -339,15 +338,17 @@ static void sclp_memory_init(SCLPDevice *sclp)
>      }
>      sclp->increment_size =3D increment_size;
> =20
> -    /* The core memory area needs to be aligned with the increment size.
> -     * In effect, this can cause the user-specified memory size to be ro=
unded
> -     * down to align with the nearest increment boundary. */
> +    /*
> +     * The core memory area needs to be aligned to the increment size. I=
n
> +     * case it's not aligned, bail out.
> +     */
>      initial_mem =3D initial_mem >> increment_size << increment_size;
> -
> -    machine->ram_size =3D initial_mem;
> -    machine->maxram_size =3D initial_mem;
> -    /* let's propagate the changed ram size into the global variable. */
> -    ram_size =3D initial_mem;
> +    if (initial_mem !=3D ram_size) {
> +        error_report("RAM size not aligned to storage increments."
> +                     " Possible aligned RAM size: %" PRIu64 " MB",
> +                     initial_mem / MiB);
> +        exit(1);
> +    }
>  }
> =20
>  static void sclp_init(Object *obj)


