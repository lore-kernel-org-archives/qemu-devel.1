Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2218C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8C220704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRJ/cx59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8C220704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudc8-0000hv-F7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iucM9-0008Nr-NK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iucM8-0001Ty-Fd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:17:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iucM8-0001TZ-C6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579785428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIe36dpDykNzGzkerVyZLI/wog/PwFLVBaR/9cyGChA=;
 b=JRJ/cx59YUACgC5zgNRcB6sJ2an4fuSy6lHiCSaC7rDe0oueNnPfb+DmjS4VQyztAvX7FH
 aNsT3LAvRLPcOHocNM2WpWiL4eL4bOzRLQhih3BlRCi/kFNQwcwRdpbjQooQps+1rTqbKf
 3FR0M/4VcN3oSMGBgGz2dzQCBqXZfrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-GCejRvX4N5iEFdqrCpfgpw-1; Thu, 23 Jan 2020 08:17:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35726800D4C;
 Thu, 23 Jan 2020 13:17:05 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BA5960C85;
 Thu, 23 Jan 2020 13:17:04 +0000 (UTC)
Date: Thu, 23 Jan 2020 14:17:01 +0100
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 31/80] arm/virt: use memdev for RAM
Message-ID: <20200123131701.46h2lofbsujkkhj6@kamzik.brq.redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-32-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1579779525-20065-32-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GCejRvX4N5iEFdqrCpfgpw-1
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

On Thu, Jan 23, 2020 at 12:37:56PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away,
> so replace it with memdev allocated MemoryRegion.
> The later is initialized by generic code, so board only
> needs to opt in to memdev scheme by providing
>   MachineClass::default_ram_id
> and then map memory region provided by
>   MachineState::ram_memdev
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> CC: drjones@redhat.com
> ---
>  hw/arm/virt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 39ab5f4..e2fbca3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1512,7 +1512,6 @@ static void machvirt_init(MachineState *machine)
>      MemoryRegion *sysmem =3D get_system_memory();
>      MemoryRegion *secure_sysmem =3D NULL;
>      int n, virt_max_cpus;
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      bool firmware_loaded;
>      bool aarch64 =3D true;
>      bool has_ged =3D !vmc->no_ged;
> @@ -1701,9 +1700,8 @@ static void machvirt_init(MachineState *machine)
>          }
>      }
> =20
> -    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram)=
;
> +    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
> +                                machine->ram);
>      if (machine->device_memory) {
>          memory_region_add_subregion(sysmem, machine->device_memory->base=
,
>                                      &machine->device_memory->mr);
> @@ -2053,6 +2051,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>      hc->unplug_request =3D virt_machine_device_unplug_request_cb;
>      mc->numa_mem_supported =3D true;
>      mc->auto_enable_numa_with_memhp =3D true;
> +    mc->default_ram_id =3D "mach-virt.ram";
>  }
> =20
>  static void virt_instance_init(Object *obj)
> --=20
> 2.7.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com>


