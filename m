Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97625C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0BB205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Senkgrtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0BB205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK2c-0006YA-6O
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK1F-0005SB-CD
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK1E-00038q-5e
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:05:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK1E-000350-0K
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jw4SmOUQ43hSod3BSp+VFMKN2Rhnvt47WNblOnGFLK8=;
 b=Senkgrtv2gK+M1he4hNDH6uq3m8pfNo0Ud/vfB0Cs8VMMp6IgN1q0qtlK1K8xQUu+G+J/C
 BpgqO/lhkkjhWZF057OQwcsCpsRTA4Nb04tsZbLbdX/pCmhmcwv6xb21YFMLwTWayp9F5S
 RntRUqScGR7Vi7y9FrHIByTXBl7+Mn8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-eMWZ02HuNY2S14PwQkKQew-1; Tue, 31 Dec 2019 11:05:13 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so12776812wrq.12
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0UiPk3jIlPGDrTglL/R3LzUszjnqHoxOAbnZdNA3D9w=;
 b=JO5Od8XfImUx92WksqlHvkj1a+/DwxJVCL2wHhg6iVdEimNW47u3l/jJQ4DUdip2mZ
 TXKVlViZCaNFTWJZSiEYqqOslgQdcRlS+qD1pohNZ5mdL4M6N8KjvxLNQhTivzj8NLA0
 4UEKwyQxAgG0t1nyEFb/7UCO789XtHIisKHKZ27eLlhpstuqj6g0FMhauUx6bQyc6Shw
 zQPekau7EHk22/ZHABoguI9nfKHY+eL2mxk1k5V58lp0UhxrnevqdltNanJC9VBzL022
 uEZCq4Tmkng3QCN5LLMldFOsV22sT7lbDk9T/+dS7jwp9c+1BFH6MjPghXZF7b5mvvhe
 zgHQ==
X-Gm-Message-State: APjAAAVf6fHIcjvXyLpJJBfRftBWP38QvIo+gEnW6pPH0QjT+c21mYzo
 fRj3tgtSxYm60s9SvDkanxjIRLKqx6NTD08hj2Ahf6j0Rs+S9m3LjTRz5R6ZT5Nzq5/Dt08WSnT
 N15yyyb8Z2QNuo1I=
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr4877974wmj.37.1577808312420;
 Tue, 31 Dec 2019 08:05:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgq7XM8rEzEsqgjXxOYRjRfoElhPPO6W7W19Cd6hGcURnSyDj8l+gHt7QSc0/P4SFgOSJnuQ==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr4877952wmj.37.1577808312247;
 Tue, 31 Dec 2019 08:05:12 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id m7sm2834524wma.39.2019.12.31.08.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:05:11 -0800 (PST)
Subject: Re: [PATCH 38/86] arm:xlnx-versal-virt: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-39-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <099ddef7-9283-a836-1498-c797db9442a6@redhat.com>
Date: Tue, 31 Dec 2019 17:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-39-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: eMWZ02HuNY2S14PwQkKQew-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 2:03 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/arm/xlnx-versal-virt.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 462493c..c137ff4 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -30,7 +30,6 @@ typedef struct VersalVirt {
>       MachineState parent_obj;
>  =20
>       Versal soc;
> -    MemoryRegion mr_ddr;
>  =20
>       void *fdt;
>       int fdt_size;
> @@ -414,12 +413,9 @@ static void versal_virt_init(MachineState *machine)
>           psci_conduit =3D QEMU_PSCI_CONDUIT_SMC;
>       }
>  =20
> -    memory_region_allocate_system_memory(&s->mr_ddr, NULL, "ddr",
> -                                         machine->ram_size);
> -
>       sysbus_init_child_obj(OBJECT(machine), "xlnx-ve", &s->soc,
>                             sizeof(s->soc), TYPE_XLNX_VERSAL);
> -    object_property_set_link(OBJECT(&s->soc), OBJECT(&s->mr_ddr),
> +    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
>                                "ddr", &error_abort);
>       object_property_set_int(OBJECT(&s->soc), psci_conduit,
>                               "psci-conduit", &error_abort);
> @@ -473,6 +469,7 @@ static void versal_virt_machine_class_init(ObjectClas=
s *oc, void *data)
>       mc->max_cpus =3D XLNX_VERSAL_NR_ACPUS;
>       mc->default_cpus =3D XLNX_VERSAL_NR_ACPUS;
>       mc->no_cdrom =3D true;
> +    mc->default_ram_id =3D "ddr";
>   }
>  =20
>   static const TypeInfo versal_virt_machine_init_typeinfo =3D {
>=20


