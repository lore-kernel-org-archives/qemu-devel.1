Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB527C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93ABC206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGozxefq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ABC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEriI-0007sG-Qv
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jErhd-0007TH-Ii
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jErhc-00006r-Hd
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:43:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jErhc-000057-Df
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584610979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7k0pb3qECeyaQ77BE3JoKB2RFvsHFmyIixW7ZPh0B4=;
 b=gGozxefqb7afgdBFOLGrub3LHb0vIumSAoZufHfAJJnxuydHfjmdoXmznAy0fdkT5KctXB
 LZQlpvIfPoKQvVwh+Iict2vT9cP04TF9giYJEmGA95qim5s4DicYxF8o7upkTznhtDJR4u
 qZn746W0/Kla3uH6eqXOoiquUUUbY2Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-BqMBBizVOGKvMUK7IUCwGA-1; Thu, 19 Mar 2020 05:42:57 -0400
X-MC-Unique: BqMBBizVOGKvMUK7IUCwGA-1
Received: by mail-ed1-f69.google.com with SMTP id b9so379645edj.10
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 02:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RTIRzWdSzbuUvlRO1n6Smjr+E0955ztEqTQgF5mis3U=;
 b=O6VzDGSUjSWPR/e/2h/9BDiRo7JoD7yCBXM2olYY4gpEekGh+zIY4ZMjU4XBKlmORH
 MaDk+eyoC73C6Dp++CpcDJnAvoAhvl7FSzC6YyWv1zFTOcWhRyiU1aGHGl0ldfyC1BRT
 MLtARYRRfZXA7qEWBEun+3wUckbxp9G1LhRSxhMyMf2n0oDj27ZwVEZL2pPK7oFNXT4F
 1D0+fdmSTGoShb8AzICo1M4ofVUm0zrC4B6pfiPL+5nI2AJM2jZs/XoEjhRE1fymz8IT
 VyhHH42O+nOiBe0alF4Sk5RPpC9XPhAFURBakRRwJ9FQYCQqaZMiZ9+cLO55n93TpOFB
 MJhg==
X-Gm-Message-State: ANhLgQ3ZjKh/GjkpcIlwGfR03Ao8fNxphPx9nGXrxenyuv2oGB+LR3Gr
 M0q5Ajbpgl0C7xQ3bP7ggAi7QtH45QRIK70AeF4b/Rlk854SiPI1hZYnmexyD4wewgq/Z9wOrSt
 TadNFAA9oXb9rWsg=
X-Received: by 2002:a05:6402:b77:: with SMTP id
 cb23mr1838920edb.246.1584610976640; 
 Thu, 19 Mar 2020 02:42:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvFqfyYGw9Iao0WE23kfIh3vWyGiWWiUdKLtVROct9xxiN02CPXqtgLndrrVDy7MUCrQdfTCA==
X-Received: by 2002:a05:6402:b77:: with SMTP id
 cb23mr1838891edb.246.1584610976367; 
 Thu, 19 Mar 2020 02:42:56 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id ov22sm75075ejb.70.2020.03.19.02.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 02:42:55 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <3ac0d8f1-15d8-51d3-b40e-8975ec1353ad@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1b61a51a-0419-1bd3-2728-e5c11606f99e@redhat.com>
Date: Thu, 19 Mar 2020 10:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3ac0d8f1-15d8-51d3-b40e-8975ec1353ad@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 10:36 AM, Paolo Bonzini wrote:
> On 18/03/20 23:15, Philippe Mathieu-Daud=C3=A9 wrote:
>> The I/O ranges registered by the piix4_acpi_system_hot_add_init()
>> function are not documented in the PIIX4 datasheet.
>> This appears to be a PC-only feature added in commit 5e3cb5347e
>> ("initialize hot add system / acpi gpe") which was then moved
>> to the PIIX4 device model in commit 9d5e77a22f ("make
>> qemu_system_device_hot_add piix independent")
>> Add a property (default enabled, to not modify the current
>> behavior) to allow machines wanting to model a simple PIIX4
>> to disable this feature.
>=20
> Yes, all hotplug stuff (PCI/memory/CPU) are custom additions by QEMU.
>=20
>> +    DEFINE_PROP_BOOL("system-hotplug-support", PIIX4PMState,
>> +                     use_acpi_system_hotplug, true),
>=20
> Why not cpu-hotplug-support?

Because I have no idea what this code is about, and it seems more than=20
cpu (pci, memory):

static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
                                            PCIBus *bus, PIIX4PMState *s)
{
     memory_region_init_io(&s->io_gpe, OBJECT(s), &piix4_gpe_ops, s,
                           "acpi-gpe0", GPE_LEN);
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);

     acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
                     s->use_acpi_pci_hotplug);

     s->cpu_hotplug_legacy =3D true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
                              piix4_get_cpu_hotplug_legacy,
                              piix4_set_cpu_hotplug_legacy,
                              NULL);
     legacy_acpi_cpu_hotplug_init(parent, OBJECT(s), &s->gpe_cpu,
                                  PIIX4_CPU_HOTPLUG_IO_BASE);

     if (s->acpi_memory_hotplug.is_enabled) {
         acpi_memory_hotplug_init(parent, OBJECT(s),=20
&s->acpi_memory_hotplug,
                                  ACPI_MEMORY_HOTPLUG_BASE);
     }
}


