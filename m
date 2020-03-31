Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16440C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D9320848
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErReSaoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D9320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKJ5-0002II-VS
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJKHl-0001eQ-Al
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJKHj-00080l-OZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:02:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJKHj-00080B-LS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585674163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSTIpBUhuW1l8WUYuT333335bgK+YqNtERpWuDFuBwM=;
 b=ErReSaoOheP/BzMNPmA59oVB8XA/i8PeSZjzSlY2mGZYL3wOLu9KkNYdFtlYOsM7XhWMUG
 V8EjHOA46TBOQc7LHs0iAZIRutV6jSj7Xdpfe71RNG1abKmKDxeoruyeCzjxRnBn5pBO8T
 +EDwWenTuQxenaeDqN+gX6vrehmyuJc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-V-mlv-eoNs-0_SffHNMgbQ-1; Tue, 31 Mar 2020 13:02:41 -0400
X-MC-Unique: V-mlv-eoNs-0_SffHNMgbQ-1
Received: by mail-ed1-f70.google.com with SMTP id i61so19106657edc.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 10:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VxPUOgxhW5CqurI1DXhkKMNh+pzCFBxZDrmIuW5r3m8=;
 b=lFG8vwlxqYPTbiWBjKD2VfX6ns6m/247yYFUjOUWOj/xBTDkXO6uVRZN67qV3sjHAN
 i6daD6cfhTwLcWcjcokT8hqOH6SaYwMxbGtYPFQd1IClBPZ40SW/OUwE0mv7WE9V001N
 i+1bB5OG8sGjIBjkGgtTJgEKqtXzYpi/T6aY/SGaq+oFHoqC2Scm3jbYC87mWwvvrJ/V
 /a200RrG9QL5wdssLReFOCJpECvKyiX8Bzu7B70FFg/J6KCsMJf0jdKwuhiHWthHGigh
 OIT4cRfz+RtmADYhxTxNPdkz6zxfGVxmxMGAb/d1tHjfvzgM7Dk/4mHEylEo7ax3FCYR
 BVbQ==
X-Gm-Message-State: ANhLgQ3ezFwvwc/8F5JZQBzkoT4fAayJOsix/+WgsRDdpdm9BeskpHZf
 LDkjRslXjng9DHO7BRXt+SxAWI8KonhgxLK0sLLhkD/WvsUEIp+9xKxGSDXUiKu2KiCsnBOw7iz
 EvuzA3IdKKjQoO9c=
X-Received: by 2002:a05:6402:206e:: with SMTP id
 bd14mr17555587edb.308.1585674159913; 
 Tue, 31 Mar 2020 10:02:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvdHL6KZbUMvwUDu00Vj1kMBX6eZskEG00dPf+VXEPKj8SoXLJjW0o/x3V3HLZjj5qOd12c5A==
X-Received: by 2002:a05:6402:206e:: with SMTP id
 bd14mr17555541edb.308.1585674159661; 
 Tue, 31 Mar 2020 10:02:39 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j19sm2247453ejx.75.2020.03.31.10.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 10:02:38 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 12/12] hw/riscv/sifive_u: Add missing
 error-propagation code
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-13-f4bug@amsat.org>
 <CAFEAcA-26fHbOp5saM+XBCz72fzfz+=+xtiXGRtWnc6CMoiakA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e293f19c-7005-16f0-57df-55ce953fe0a4@redhat.com>
Date: Tue, 31 Mar 2020 19:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-26fHbOp5saM+XBCz72fzfz+=+xtiXGRtWnc6CMoiakA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 10:55 PM, Peter Maydell wrote:
> On Wed, 25 Mar 2020 at 19:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>>
>> Running the coccinelle script produced:
>>
>>    $ spatch \
>>      --macro-file scripts/cocci-macro-file.h --include-headers \
>>      --sp-file scripts/coccinelle/object_property_missing_error_propagat=
e.cocci \
>>      --keep-comments --smpl-spacing --dir hw
>>
>>    [[manual check required: error_propagate() might be missing in object=
_property_set_bool() hw/riscv/sifive_u.c:558:4]]
>>    [[manual check required: error_propagate() might be missing in object=
_property_set_bool() hw/riscv/sifive_u.c:561:4]]
>>
>> Add the missing error_propagate() after manual review.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   hw/riscv/sifive_u.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> index 56351c4faa..01e44018cd 100644
>> --- a/hw/riscv/sifive_u.c
>> +++ b/hw/riscv/sifive_u.c
>> @@ -473,113 +473,121 @@ static void riscv_sifive_u_machine_instance_init=
(Object *obj)
>>   static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>>   {
>>       MachineState *ms =3D MACHINE(qdev_get_machine());
>>       SiFiveUSoCState *s =3D RISCV_U_SOC(dev);
>>       const struct MemmapEntry *memmap =3D sifive_u_memmap;
>>       MemoryRegion *system_memory =3D get_system_memory();
>>       MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
>>       MemoryRegion *l2lim_mem =3D g_new(MemoryRegion, 1);
>>       qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
>>       char *plic_hart_config;
>>       size_t plic_hart_config_len;
>>       int i;
>>       Error *err =3D NULL;
>>       NICInfo *nd =3D &nd_table[0];
>>
>>       object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
>>                                &error_abort);
>>       object_property_set_bool(OBJECT(&s->u_cpus), true, "realized",
>>                                &error_abort);
>>       /*
>>        * The cluster must be realized after the RISC-V hart array contai=
ner,
>>        * as the container's CPU object is only created on realize, and t=
he
>>        * CPU must exist and have been parented into the cluster before t=
he
>>        * cluster is realized.
>>        */
>>       object_property_set_bool(OBJECT(&s->e_cluster), true, "realized",
>>                                &error_abort);
>>       object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
>>                                &error_abort);
>=20
> Different bug noticed in passing: these really ought not to be
> using error_abort to realize things, as realize is a fairly
> likely-to-fail operation on most objects (either now or in
> the future if the object implementation changes).

OK.

>=20
>>
>>       /* boot rom */
>>       memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom=
",
>>                              memmap[SIFIVE_U_MROM].size, &error_fatal);

What about this memory_region_init_rom() call (and later=20
memory_region_init_ram) using error_fatal, same reasoning right?

>>       memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].b=
ase,
>>                                   mask_rom);
>=20
>>       object_property_set_bool(OBJECT(&s->prci), true, "realized", &err)=
;
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI]=
.base);
>>
>>       object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>=20
> The changes made in this patch are fine though:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> thanks
> -- PMM
>=20


