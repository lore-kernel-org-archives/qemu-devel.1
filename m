Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D89C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868BD2081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVAjhVMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868BD2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroSG-0004wE-Pg
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iroFY-000589-AK
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iroFV-0003gz-Sc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:22:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iroFV-0003gD-PR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579116159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igIoIzwY+OYMIqdQPvbpVbyIygpcqRcqs+h5kbyAz3k=;
 b=OVAjhVMsVjhWJx5C5tdTZAbOazSALnYldcWYMw1D10u9VdNHwF9bDPTB98pjmG5ZXbVOrU
 ++2Xz6cZbfv/FZy7AaBcvoY68AwvDiIXx3MfCqB//uhTGml1S4IIvByPeKcTQiRae0CM0R
 kadwVuVQdWTsltSlb4F00ibN6E76UHU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-CITW71njO02TtFcE7oe-EA-1; Wed, 15 Jan 2020 14:22:36 -0500
Received: by mail-wr1-f69.google.com with SMTP id y7so8386064wrm.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KfbO1Lb/YDZzj1X9Wey2X2fASOg3is9d+qgHfBm5QOY=;
 b=EIu4LVjITaEqkqrULZorn0mXOABXu7GDM0a884R2ej65S7OppsRZ3EUy7QjunaihR+
 GmPYk+GbTg4JNih+8EoUIhmfYFnJyHk2dgUpoBcAkLW7LFkNeIvddMcEFTbFSXIi6Bmv
 LgOZNBMz9WLpegmL5xEBE9QoZRa2m4Q0EwJXPNlc/Piifr59djxm8dwiL19ky8qdDL98
 NP4wf9GtbJwtxe6evlNIFhEJLDM2AYcY0+euytf7nmnjYsXBvKhx48uIuy/gv3XVvHED
 0IETvuc4SmfwS7G7AcVxiCmNAzXirM3+S7XPhDDQbpK5jtqTDD/M/1pV7g75JRK/cbHq
 H8pA==
X-Gm-Message-State: APjAAAWvgu6NT0ci07y+rbPxBZtJFsQYpDshFjXnKArfUeihVr3MUuNO
 8oqWR9UCiKwy5qLwMpI5y++TSmRJ1aLE0J8xV0e+z/aLRiMHBXIDS6ntsTUNWguYmMUHec2aknQ
 WxH9hNQhnwyobk/g=
X-Received: by 2002:a1c:a543:: with SMTP id o64mr1493986wme.73.1579116155569; 
 Wed, 15 Jan 2020 11:22:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxadGQLRBWh7qT3pa9dpnvoA3aEIhAB3+uObBzDZq9g6onQOC3x5FHZAsPkZl2FqX8dNf1ncg==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr1493970wme.73.1579116155398; 
 Wed, 15 Jan 2020 11:22:35 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id f1sm1107864wmc.45.2020.01.15.11.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:22:34 -0800 (PST)
Subject: Re: [PATCH v2 38/86] s390x:s390-virtio-ccw: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-39-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <142cf6c5-74f4-4e18-60f6-859aa43f4025@redhat.com>
Date: Wed, 15 Jan 2020 20:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-39-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: CITW71njO02TtFcE7oe-EA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:06 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: rth@twiddle.net
> CC: david@redhat.com
> CC: cohuck@redhat.com
> CC: pasic@linux.ibm.com
> CC: borntraeger@de.ibm.com
> CC: qemu-s390x@nongnu.org
> ---
>   hw/s390x/s390-virtio-ccw.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e0e2813..cbdd4ba 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -154,14 +154,12 @@ static void virtio_ccw_register_hcalls(void)
>                                      virtio_ccw_hcall_early_printk);
>   }
>  =20
> -static void s390_memory_init(ram_addr_t mem_size)
> +static void s390_memory_init(MemoryRegion *ram)
>   {
>       MemoryRegion *sysmem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       Error *local_err =3D NULL;
>  =20
>       /* allocate RAM for core */
> -    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size=
);
>       memory_region_add_subregion(sysmem, 0, ram);
>  =20
>       /*
> @@ -245,7 +243,7 @@ static void ccw_init(MachineState *machine)
>  =20
>       s390_sclp_init();
>       /* init memory + setup max page size. Required for the CPU model */
> -    s390_memory_init(machine->ram_size);
> +    s390_memory_init(machine->ram);
>  =20
>       /* init CPUs (incl. CPU model) early so s390_has_feature() works */
>       s390_init_cpus(machine);
> @@ -471,6 +469,7 @@ static void ccw_machine_class_init(ObjectClass *oc, v=
oid *data)
>       hc->plug =3D s390_machine_device_plug;
>       hc->unplug_request =3D s390_machine_device_unplug_request;
>       nc->nmi_monitor_handler =3D s390_nmi;
> +    mc->default_ram_id =3D "s390.ram";
>   }
>  =20
>   static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


