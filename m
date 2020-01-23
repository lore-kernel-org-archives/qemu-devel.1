Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DF4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438CF2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo4g760O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438CF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudRf-0003Qs-QP
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iuc4u-00022m-G0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iuc4s-0003S1-DZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:59:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iuc4s-0003Ok-9N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579784357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIHo9nSGeSNM1Jx0RaQGNR+am3PYYKn0cacxfBZ/Pr4=;
 b=Mo4g760O8QA/wZQAkhDvkOPwGtNMmqgXlTOygwjj8XClGCgKfAOMRIwi3YCjbmx7LJbmUQ
 TOc9YNUl6CbCvfWFXuAyY8FBvGkOdrndZC79IrMrqGGd6bl26m2RT6yPxQrWfqkVB1Qiyb
 2UozzOyB45cMRvxJ7PnlJvnmTT0hlBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-MUcgccStOrC0hQlsGnVWHA-1; Thu, 23 Jan 2020 07:59:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B88FB108597E;
 Thu, 23 Jan 2020 12:59:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C24711001920;
 Thu, 23 Jan 2020 12:59:11 +0000 (UTC)
Date: Thu, 23 Jan 2020 13:59:09 +0100
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 20/80] arm/mps2-tz: use memdev for RAM
Message-ID: <20200123125909.p2aq3ad2x5l24zq5@kamzik.brq.redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-21-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1579779525-20065-21-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MUcgccStOrC0hQlsGnVWHA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 12:37:45PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>  while at it add check for user supplied RAM size and error
>  out if it mismatches board expected value.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * fix format string causing build failure on 32-bit host
>     (Philippe Mathieu-Daud=E9 <philmd@redhat.com>)
>=20
> CC: drjones@redhat.com
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>  hw/arm/mps2-tz.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index f8b620b..06dacf6 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -39,6 +39,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/arm/boot.h"
> @@ -79,7 +80,6 @@ typedef struct {
>      MachineState parent;
> =20
>      ARMSSE iotkit;
> -    MemoryRegion psram;
>      MemoryRegion ssram[3];
>      MemoryRegion ssram1_m;
>      MPS2SCC scc;
> @@ -388,6 +388,13 @@ static void mps2tz_common_init(MachineState *machine=
)
>          exit(1);
>      }
> =20
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
>      sysbus_init_child_obj(OBJECT(machine), "iotkit", &mms->iotkit,
>                            sizeof(mms->iotkit), mmc->armsse_type);
>      iotkitdev =3D DEVICE(&mms->iotkit);
> @@ -458,9 +465,7 @@ static void mps2tz_common_init(MachineState *machine)
>       * tradeoffs. For QEMU they're all just RAM, though. We arbitrarily
>       * call the 16MB our "system memory", as it's the largest lump.
>       */
> -    memory_region_allocate_system_memory(&mms->psram,
> -                                         NULL, "mps.ram", 16 * MiB);
> -    memory_region_add_subregion(system_memory, 0x80000000, &mms->psram);
> +    memory_region_add_subregion(system_memory, 0x80000000, machine->ram)=
;
> =20
>      /* The overflow IRQs for all UARTs are ORed together.
>       * Tx, Rx and "combined" IRQs are sent to the NVIC separately.
> @@ -642,6 +647,7 @@ static void mps2tz_class_init(ObjectClass *oc, void *=
data)
> =20
>      mc->init =3D mps2tz_common_init;
>      iic->check =3D mps2_tz_idau_check;
> +    mc->default_ram_id =3D "mps.ram";
>  }
> =20
>  static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
> @@ -657,6 +663,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, =
void *data)
>      mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-m33");
>      mmc->scc_id =3D 0x41045050;
>      mmc->armsse_type =3D TYPE_IOTKIT;
> +    mc->default_ram_size =3D 16 * MiB;

Shouldn't this line be added to mps2tz_class_init ?

Thanks,
drew

>  }
> =20
>  static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
> --=20
> 2.7.4
>=20


