Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B5C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45362076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsJF9Y5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45362076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGij-000285-1G
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRGhm-00012E-1t
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRGhl-0007LP-Bd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:50:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35112
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRGhk-0007FU-Tf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587567023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6lGxlTES+FdcTITT4PYVV+xwQKdfGuXSFfyANuxqfc=;
 b=TsJF9Y5VoxvfR4YQ8l12x8ddqO7KQ5U6fqby53bi74GMA73luE2lldv/kHuYU7fKzib+1b
 mw4e8SBEBgg4P6oB4vLemWkV7iFytV2hjloX2kYSNIVqotKuFuJl/22kyxx4qOVtekzmQB
 rMd1rOvt5TPSIjTILVDKVCEOgzelx+g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-l6c8uJLCMW6Ub9NrlmPmNw-1; Wed, 22 Apr 2020 10:50:21 -0400
X-MC-Unique: l6c8uJLCMW6Ub9NrlmPmNw-1
Received: by mail-wr1-f71.google.com with SMTP id j22so1177229wrb.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 07:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZVu3g+hAAoWakKhMEs5FiYynaDk3K2/V1u77nfPud6A=;
 b=N9fL8MxpSAlqfxcMUV3C4I03KctLyet2PvnLeB8QBOZfib5bS7J4A15OIgtxPVuDiw
 GDbKSyRFAD7cyvO8roKyUJJ5o0MxlJHKgPm1ogOzIywtXzLLbcuP+aguwFmvs9w3B4AY
 D/7rz7T/1OpXfRj4jhvPjGqn4wxjSHXgp+A3isTG24VA2NPMIxgrUdWOYDEMRMjNaFPg
 TF9GHwN6NO1qLdJEzZqE0pt0gFP+WSJ9kkNm4qq3kUM/mrwnFz/L4uD/9+ZUbS2Ns4iR
 /cyFCEQz3x/0asy7XMn0Y2cUFBPFcKOHwXQjDvvQahU6iM2GY1Ck9WcT4cnGpCe+rOCT
 Hetw==
X-Gm-Message-State: AGi0PubIApvVczO6gPepWJp80uPa7Zqm1jeXcUVbIAhBrv0s3lynYaLT
 3uCa3nH5kL2YLYh/oAWkndRn2BzCcWvA5NE+qe3AZlGTzpmu5tUN52W+Hwh3pnYllCNUhVaIx6v
 v6Ze94TdAmsgvSQ8=
X-Received: by 2002:adf:a345:: with SMTP id d5mr28747656wrb.23.1587567020531; 
 Wed, 22 Apr 2020 07:50:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypIM/AJ+JhPrBbv0/NvBrk+SXM09NBJNfanOF/qC7ZvHX/NLIXQ7wjgWQmNSX0x1hLcna68OQA==
X-Received: by 2002:adf:a345:: with SMTP id d5mr28747631wrb.23.1587567020176; 
 Wed, 22 Apr 2020 07:50:20 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id c25sm2557900wmb.44.2020.04.22.07.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 07:50:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
To: BALATON Zoltan <balaton@eik.bme.hu>, Markus Armbruster <armbru@redhat.com>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
Date: Wed, 22 Apr 2020 16:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 4:27 PM, BALATON Zoltan wrote:
> On Wed, 22 Apr 2020, Markus Armbruster wrote:
>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>> pointer to a variable containing NULL.=A0 Passing an argument of the
>> latter kind twice without clearing it in between is wrong: if the
>> first call sets an error, it no longer points to NULL for the second
>> call.
>>
>> spd_data_generate() can pass @errp to error_setg() more than once when
>> it adjusts both memory size and type.=A0 Harmless, because no caller
>> passes anything that needs adjusting.=A0 Until the previous commit,
>> sam460ex passed types that needed adjusting, but not sizes.
>>
>> spd_data_generate()'s contract is rather awkward:
>>
>> =A0=A0 If everything's fine, return non-null and don't set an error.
>>
>> =A0=A0 Else, if memory size or type need adjusting, return non-null and
>> =A0=A0 set an error describing the adjustment.
>>
>> =A0=A0 Else, return null and set an error reporting why no data can be
>> =A0=A0 generated.
>>
>> Its callers treat the error as a warning even when null is returned.
>> They don't create the "smbus-eeprom" device then.=A0 Suspicious.
>>
>> Since the previous commit, only "everything's fine" can actually
>> happen.=A0 Drop the unused code and simplify the callers.=A0 This gets r=
id
>> of the error API violation.
>=20
> This leaves board code no chance to recover from values given by user=20
> that won't fit without duplicating checks that this function does. Also=
=20
> this will abort without giving meaningful errors if an invalid value=20
> does get through and result in a crash which is not used friendly. So I=
=20
> don't like this but if others think this is acceptable maybe at least=20
> unit test should be adjusted to make sure aborts cannot be triggered by=
=20
> user for values that are not usually tested during development.

Agreed. Do you have an example (or more) to better show Markus this code=20
use? So we can add tests.

Personally I'd use a script to generate a dumb static array of all=20
possible sizes...

>=20
> Regards,
> BALATON Zoltan
>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> include/hw/i2c/smbus_eeprom.h |=A0 2 +-
>> hw/i2c/smbus_eeprom.c=A0=A0=A0=A0=A0=A0=A0=A0 | 30 ++++-----------------=
---------
>> hw/mips/mips_fulong2e.c=A0=A0=A0=A0=A0=A0 | 10 ++--------
>> hw/ppc/sam460ex.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 12 +++---------
>> 4 files changed, 10 insertions(+), 44 deletions(-)
>>
>> diff --git a/include/hw/i2c/smbus_eeprom.h=20
>> b/include/hw/i2c/smbus_eeprom.h
>> index 15e2151b50..68b0063ab6 100644
>> --- a/include/hw/i2c/smbus_eeprom.h
>> +++ b/include/hw/i2c/smbus_eeprom.h
>> @@ -31,6 +31,6 @@ void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const=
 uint8_t *eeprom_spd, int size);
>>
>> enum sdram_type { SDR =3D 0x4, DDR =3D 0x7, DDR2 =3D 0x8 };
>> -uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size,=20
>> Error **errp);
>> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size);
>>
>> #endif
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index 5adf3b15b5..07fbbf87f1 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -195,8 +195,7 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>> }
>>
>> /* Generate SDRAM SPD EEPROM data describing a module of type and size *=
/
>> -uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Error **errp)
>> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
>> {
>> =A0=A0=A0 uint8_t *spd;
>> =A0=A0=A0 uint8_t nbanks;
>> @@ -222,29 +221,10 @@ uint8_t *spd_data_generate(enum sdram_type type,=
=20
>> ram_addr_t ram_size,
>> =A0=A0=A0=A0=A0=A0=A0 g_assert_not_reached();
>> =A0=A0=A0 }
>> =A0=A0=A0 size =3D ram_size >> 20; /* work in terms of megabytes */
>> -=A0=A0=A0 if (size < 4) {
>> -=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "SDRAM size is too small");
>> -=A0=A0=A0=A0=A0=A0=A0 return NULL;
>> -=A0=A0=A0 }
>> =A0=A0=A0 sz_log2 =3D 31 - clz32(size);
>> =A0=A0=A0 size =3D 1U << sz_log2;
>> -=A0=A0=A0 if (ram_size > size * MiB) {
>> -=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "SDRAM size 0x"RAM_ADDR_FMT" is =
not a power=20
>> of 2, "
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "truncating to %=
u MB", ram_size, size);
>> -=A0=A0=A0 }
>> -=A0=A0=A0 if (sz_log2 < min_log2) {
>> -=A0=A0=A0=A0=A0=A0=A0 error_setg(errp,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Memory size is =
too small for SDRAM type,=20
>> adjusting type");
>> -=A0=A0=A0=A0=A0=A0=A0 if (size >=3D 32) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 type =3D DDR;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_log2 =3D 5;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_log2 =3D 12;
>> -=A0=A0=A0=A0=A0=A0=A0 } else {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 type =3D SDR;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_log2 =3D 2;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_log2 =3D 9;
>> -=A0=A0=A0=A0=A0=A0=A0 }
>> -=A0=A0=A0 }
>> +=A0=A0=A0 assert(ram_size =3D=3D size * MiB);
>> +=A0=A0=A0 assert(sz_log2 >=3D min_log2);
>>
>> =A0=A0=A0 nbanks =3D 1;
>> =A0=A0=A0 while (sz_log2 > max_log2 && nbanks < 8) {
>> @@ -252,9 +232,7 @@ uint8_t *spd_data_generate(enum sdram_type type,=20
>> ram_addr_t ram_size,
>> =A0=A0=A0=A0=A0=A0=A0 nbanks++;
>> =A0=A0=A0 }
>>
>> -=A0=A0=A0 if (size > (1ULL << sz_log2) * nbanks) {
>> -=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "Memory size is too big for SDRA=
M,=20
>> truncating");
>> -=A0=A0=A0 }
>> +=A0=A0=A0 assert(size =3D=3D (1ULL << sz_log2) * nbanks);
>>
>> =A0=A0=A0 /* split to 2 banks if possible to avoid a bug in MIPS Malta=
=20
>> firmware */
>> =A0=A0=A0 if (nbanks =3D=3D 1 && sz_log2 > min_log2) {
>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>> index 5040afd581..ef02d54b33 100644
>> --- a/hw/mips/mips_fulong2e.c
>> +++ b/hw/mips/mips_fulong2e.c
>> @@ -297,7 +297,6 @@ static void mips_fulong2e_init(MachineState *machine=
)
>> =A0=A0=A0 MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>> =A0=A0=A0 long bios_size;
>> =A0=A0=A0 uint8_t *spd_data;
>> -=A0=A0=A0 Error *err =3D NULL;
>> =A0=A0=A0 int64_t kernel_entry;
>> =A0=A0=A0 PCIBus *pci_bus;
>> =A0=A0=A0 ISABus *isa_bus;
>> @@ -377,13 +376,8 @@ static void mips_fulong2e_init(MachineState=20
>> *machine)
>> =A0=A0=A0 }
>>
>> =A0=A0=A0 /* Populate SPD eeprom data */
>> -=A0=A0=A0 spd_data =3D spd_data_generate(DDR, machine->ram_size, &err);
>> -=A0=A0=A0 if (err) {
>> -=A0=A0=A0=A0=A0=A0=A0 warn_report_err(err);
>> -=A0=A0=A0 }
>> -=A0=A0=A0 if (spd_data) {
>> -=A0=A0=A0=A0=A0=A0=A0 smbus_eeprom_init_one(smbus, 0x50, spd_data);
>> -=A0=A0=A0 }
>> +=A0=A0=A0 spd_data =3D spd_data_generate(DDR, machine->ram_size);
>> +=A0=A0=A0 smbus_eeprom_init_one(smbus, 0x50, spd_data);
>>
>> =A0=A0=A0 mc146818_rtc_init(isa_bus, 2000, NULL);
>>
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index 1e3eaac0db..42a8c9fb7f 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -292,7 +292,6 @@ static void sam460ex_init(MachineState *machine)
>> =A0=A0=A0 SysBusDevice *sbdev;
>> =A0=A0=A0 struct boot_info *boot_info;
>> =A0=A0=A0 uint8_t *spd_data;
>> -=A0=A0=A0 Error *err =3D NULL;
>> =A0=A0=A0 int success;
>>
>> =A0=A0=A0 cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>> @@ -336,14 +335,9 @@ static void sam460ex_init(MachineState *machine)
>> =A0=A0=A0 i2c =3D PPC4xx_I2C(dev)->bus;
>> =A0=A0=A0 /* SPD EEPROM on RAM module */
>> =A0=A0=A0 spd_data =3D spd_data_generate(ram_sizes[0] < 128 * MiB ? DDR =
: DDR2,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_sizes[0], &err);
>> -=A0=A0=A0 if (err) {
>> -=A0=A0=A0=A0=A0=A0=A0 warn_report_err(err);
>> -=A0=A0=A0 }
>> -=A0=A0=A0 if (spd_data) {
>> -=A0=A0=A0=A0=A0=A0=A0 spd_data[20] =3D 4; /* SO-DIMM module */
>> -=A0=A0=A0=A0=A0=A0=A0 smbus_eeprom_init_one(i2c, 0x50, spd_data);
>> -=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_sizes[0]);
>> +=A0=A0=A0 spd_data[20] =3D 4; /* SO-DIMM module */
>> +=A0=A0=A0 smbus_eeprom_init_one(i2c, 0x50, spd_data);
>> =A0=A0=A0 /* RTC */
>> =A0=A0=A0 i2c_create_slave(i2c, "m41t80", 0x68);
>>
>>
>=20


