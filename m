Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411D1C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB20208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU1W17Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB20208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46PT-0002eq-7l
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46OY-0001Vb-Vc
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46OX-000578-QJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:10:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28783
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46OX-00056q-Ls
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582045849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMEZE4FBeorljvpFCff+eNlZDkJFmq9dUSlObMpMlSs=;
 b=bU1W17Rn8P3YJYs/OvZpfa3NeTDIOGfDcAY9n6a5H1OVRp1d2PXDH6rleSkGQD5pswUdfN
 drafo4B+n8Tr9XJTRJ591zlx5JZWMNeucj+Aul33vCJEzZdsJNUOmFWT5ROgeRu1mkiSOG
 VRVv5ow0j62543Rqu/5OO9xJxXc9fq8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-1iL9QudoPZ-A9i1k12TGXA-1; Tue, 18 Feb 2020 12:10:44 -0500
Received: by mail-wm1-f70.google.com with SMTP id d4so311966wmd.7
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zljyLSPb0rYUpA/BdrlSiMki21W1YRWEPjsnE6PX5GQ=;
 b=pKXb+yyDX8hfzbn+FtetocVmKIJvsLJTLkyxbd9wzgwGsHZFrtFbq7BmO37F2+23m9
 2eLRUhZOQPAJ2o8SsxED2+rJc/QovpWcPD2i5UgxuFDqY3SAX0ahLtorD4MJKCRZ27yC
 /0OMLzrXMA8JJlKUZZFv9Bx7d0cz5eiZrjv+nyF+01wf5v19PvyFx4g7i4sN8eom9H6V
 G66ffTRK2s10I0cGH7Mzni86P61RezSdSwOTARQD2DwTIeYTh+3aiS+Q+kpISt1MMYuR
 nb0L899uz+r4LErH7JvpHby9E0u7XkvAPNJV/CvwQs3WA64+mZXB6LT1PoEVuOAH+NqO
 AENg==
X-Gm-Message-State: APjAAAXahmNbOxPNzzpOmQdxFU93Dc3QsjnwmTKVzmuf5VAqy9F8plt2
 mw4MFjDd8mctswIadFWYIvuEyGa2RZrwaX9B22o8mO1L3UzRfxBqIFJbyEVp3TWYDeeNRJoELkU
 z012rztAv0F9W/Y4=
X-Received: by 2002:adf:a381:: with SMTP id l1mr30102800wrb.102.1582045843778; 
 Tue, 18 Feb 2020 09:10:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDehfRttzXqjjFn/ixdTXMjd+vt6kTGIGg0E4Up80hsM4rCJsH0qKGw81eMWZghSLAIVyksg==
X-Received: by 2002:adf:a381:: with SMTP id l1mr30102786wrb.102.1582045843621; 
 Tue, 18 Feb 2020 09:10:43 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s8sm4395703wmf.45.2020.02.18.09.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:10:43 -0800 (PST)
Subject: Re: [PATCH v5 02/79] machine: introduce memory-backend property
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-3-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4db18e3f-3448-8194-b781-32b579b16c8a@redhat.com>
Date: Tue, 18 Feb 2020 18:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-3-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 1iL9QudoPZ-A9i1k12TGXA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:33 PM, Igor Mammedov wrote:
> Property will contain link to memory backend that will be
> used for backing initial RAM.
> Follow up commit will alias -mem-path and -mem-prealloc
> CLI options into memory backend options to make memory
> handling consistent (using only hostmem backend family
> for guest RAM allocation).
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>   * make property a string, instead of a link.
>     Fixes -M memory-backend=3Dfoo: foo not found error
>     since foo creation is delayed well beyond point
>     where machine's properties are set
> v3:
>   * rename property name from ram-memdev to memory-backend
>     (Paolo Bonzini <pbonzini@redhat.com>)
>=20
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> CC: pasic@linux.ibm.com
> ---
>   include/hw/boards.h |  2 ++
>   hw/core/machine.c   | 24 ++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index fb1b43d5b9..7b4b6b79d7 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -4,6 +4,7 @@
>   #define HW_BOARDS_H
>  =20
>   #include "exec/memory.h"
> +#include "sysemu/hostmem.h"
>   #include "sysemu/blockdev.h"
>   #include "sysemu/accel.h"
>   #include "qapi/qapi-types-machine.h"
> @@ -285,6 +286,7 @@ struct MachineState {
>       bool enforce_config_section;
>       bool enable_graphics;
>       char *memory_encryption;
> +    char *ram_memdev_id;
>       DeviceMemoryState *device_memory;
>  =20
>       ram_addr_t ram_size;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 84812a1d1c..1a6e485c87 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -508,6 +508,22 @@ static void validate_sysbus_device(SysBusDevice *sbd=
ev, void *opaque)
>       }
>   }
>  =20
> +static char *machine_get_memdev(Object *obj, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    return g_strdup(ms->ram_memdev_id);
> +}
> +
> +static void machine_set_memdev(Object *obj, const char *value, Error **e=
rrp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    g_free(ms->ram_memdev_id);
> +    ms->ram_memdev_id =3D g_strdup(value);
> +}
> +
> +
>   static void machine_init_notify(Notifier *notifier, void *data)
>   {
>       MachineState *machine =3D MACHINE(qdev_get_machine());
> @@ -889,6 +905,14 @@ static void machine_initfn(Object *obj)
>                                           "Table (HMAT)", NULL);
>       }
>  =20
> +    object_property_add_str(obj, "memory-backend",
> +                            machine_get_memdev, machine_set_memdev,
> +                            &error_abort);
> +    object_property_set_description(obj, "memory-backend",
> +                                    "Set RAM backend"
> +                                    "Valid value is ID of hostmem based =
backend",
> +                                     &error_abort);
> +
>       /* Register notifier when init is done for sysbus sanity checks */
>       ms->sysbus_notifier.notify =3D machine_init_notify;
>       qemu_add_machine_init_done_notifier(&ms->sysbus_notifier);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


