Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1AEC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE6B207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1mn68QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE6B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wrI-00008v-0B
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wpq-0007Ly-8Q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3wpp-0007Hd-3w
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:58:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20770
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3wpp-0007HW-0h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582009100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Kic1KEWfotHPmGHFRbraT4hB69X/U9MbatUAY1Kkpk=;
 b=P1mn68QPxyNtzAAuo93bC88fGkQbP1n+4eAZM4L6n7tfvUJLuuDbH4V6NQaYwN+/5LYMSc
 nDfzGk1ZTKrWI4K9qUeU9Vw/LBcyXTBA9S/YHMDpbVKebDIq7YeKqzhbzpCrgJkHapWGLE
 hBhvdb1GaT49oHs7mU+KUdURBX1bjpM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-TgH-GAJTOluc5AiBDrLfEw-1; Tue, 18 Feb 2020 01:58:16 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so10243898wrq.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qE4EeTlwpEWsmMvWYFY8sgS+JqN68xrfEP8dfkqNA0s=;
 b=nBvYeAX0oVU6jgdbuuyks174rneELoCNG9moQ7qzMUV+QRBsd8VZNOIKCLjo8PzaCR
 /qLzWQQ0Kg4wdIIopDg2jh3mulHyp07LcAB3K0O8kkdkO7LxCh42J3qORkO0Y1vAON/6
 2D9ljC+9PLsiBW5yy8oZ+kJSUDDaKWBBOf2ansBJFDz1eLA7Wa8qhGFP83ZsnuVuO9Oy
 7YMnCyTCsCleUhv4JEAAgG2bZLA6PJbSoutfoPK1EsNNFTf1iTfqG2JEWrMuvKTrfBaD
 Qma5wSsePLK/v2/OrOSPlyUnyfCUikimVw9DkI4nOUfcn/yXPeaURPFwUhnaLGn++i3G
 HEsA==
X-Gm-Message-State: APjAAAWmwl4XItyZ0FNe0HtWq9POOToYyua7IqJFJDIvkkTqEDBlvlD+
 IwPkj9H1xaspMdzM0aSbHuFW5FugnRJuhtTnlIus8UHnHac3pSMGFvEQ0pIkRvbPAKlQkZu4j4r
 Amw5dN8Gn0UBkY5E=
X-Received: by 2002:a5d:5044:: with SMTP id h4mr25604562wrt.4.1582009095414;
 Mon, 17 Feb 2020 22:58:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHpYza3oTRH7PHNzrUlBjI40aJKpzFzDJFMuMswBzm235peTqd7JJ1JI/qgjRssLFM+rKspw==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr25604526wrt.4.1582009095165;
 Mon, 17 Feb 2020 22:58:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y131sm2404501wmc.13.2020.02.17.22.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:58:14 -0800 (PST)
Subject: Re: [PATCH v5 24/79] arm/musicpal: use memdev for RAM
To: Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-25-imammedo@redhat.com>
 <a0a461ef-b4b3-fe1a-dba3-c1672a33670a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <18847546-4e2d-dfcd-1a42-79a21b5e84b3@redhat.com>
Date: Tue, 18 Feb 2020 07:58:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a0a461ef-b4b3-fe1a-dba3-c1672a33670a@linaro.org>
Content-Language: en-US
X-MC-Unique: TgH-GAJTOluc5AiBDrLfEw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jan.kiszka@web.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 8:11 PM, Richard Henderson wrote:
> On 2/17/20 9:33 AM, Igor Mammedov wrote:
>> memory_region_allocate_system_memory() API is going away, so
>> replace it with memdev allocated MemoryRegion. The later is
>> initialized by generic code, so board only needs to opt in
>> to memdev scheme by providing
>>    MachineClass::default_ram_id
>> and using MachineState::ram instead of manually initializing
>> RAM memory region.
>>
>> PS:
>>   while at it add check for user supplied RAM size and error
>>   out if it mismatches board expected value.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>> ---
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>> @@ -1589,16 +1590,21 @@ static void musicpal_init(MachineState *machine)
>>       int i;
>>       unsigned long flash_size;
>>       DriveInfo *dinfo;
>> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>>       MemoryRegion *address_space_mem =3D get_system_memory();
>> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>>       MemoryRegion *sram =3D g_new(MemoryRegion, 1);
>>  =20
>> +    /* For now we use a fixed - the original - RAM size */
>> +    if (machine->ram_size !=3D mc->default_ram_size) {
>> +        char *sz =3D size_to_str(mc->default_ram_size);
>> +        error_report("Invalid RAM size, should be %s", sz);
>> +        g_free(sz);
>> +        exit(EXIT_FAILURE);
>> +    }
>=20
> If for some reason you need to re-spin this series again, and considering=
 my
> comment re arm/imx25_pdk, I think it would be worthwhile to create a comm=
on
> helper for this:
>=20
> void machine_memory_check_fixed_size(MachineState *machine)
> {
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>=20
>      if (machine->ram_size !=3D mc->default_ram_size) {
>          char *sz =3D size_to_str(mc->default_ram_size);
>          error_report("Invalid RAM size, should be %s", sz);
>          g_free(sz);
>          exit(EXIT_FAILURE);
>      }
> }
>=20
> That would keep the language consistent across the boards.

Excellent idea.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


