Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A794C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C480120721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRfX0JoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C480120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipqhN-0002c0-Ty
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 04:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipqgQ-0001Sr-Fz
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipqgP-0000CX-83
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:34:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipqgP-00008M-4I
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578648860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9lo5GOumNC3bhWoq4aYS5JXPKfb57srj1k4SZXdFFkk=;
 b=gRfX0JoE/k8atlGSokr0MuacpQ/sTh81FA/vq/vQX7zTwKptpicSzb6LFqifjbrlv1abk0
 uF/n07Bxo0cmim2u5j8IVLCSKZa7ItxOl0O3IW7wjioidQuHT8z8+/2UnygX5boZFyPyXA
 FmzVD7xovonTeRHy5DkPdnLDvDZevkw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-k51Yc4dlNkGSP6e28jZXlw-1; Fri, 10 Jan 2020 04:34:16 -0500
Received: by mail-wr1-f70.google.com with SMTP id j4so644935wrs.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 01:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ukap/D6uM+tm5XLlP0CcTaHbFa/qulLkLeaGy/Fleuc=;
 b=DWnabvDO16QalwNOrXiHzgXzr+Uz7YeklYnA1kqV0sXbhVe41i9yTTDabmaFtU50zj
 NtthbZWZ45Lw96ZicBlBodfOADOtIry/0zzx+6kLmF7ayHGgclJGZ8k/BikZ8TAuPdig
 nAjUdgEUQpV2ebTn8b4ZUh7zj6r4Zr9vxZZDu2gS899xAmbY6CosFsiGKkkXfqw1M4Xd
 2a2/XdsDpUWOYZfS7bytoflZhKH1ee1LBwfm8lgqcjIoQFzE7rwCcANGC58VF2QhH838
 LAA9KTWRfi9eTG5ugH+NbqhK1lYff/P/yPVPJtWYgO5KH7yAvOwkz8HecNR0aLozCCOA
 NqdQ==
X-Gm-Message-State: APjAAAU2w/Yh2zE7IZyHNukDR9EPa37b7crV3nH0i6zKOB8dFyONlD4L
 qRGfNpnJGu1XmEIISZ5HfEh4tNfJXAhjFJ2SxT8LCovWwEJwtKW02I+4P/Q5TxCRAf0fy5ceLcr
 b1TWTTz2jEdAS5sQ=
X-Received: by 2002:adf:f789:: with SMTP id q9mr2461820wrp.103.1578648855163; 
 Fri, 10 Jan 2020 01:34:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqw60eNDeSeLZaK+zXZdsmOGqFEjjGKDrKCuXrKR/uyM92hpU/dvYO081Du7NvMHfdLGnlYFEA==
X-Received: by 2002:adf:f789:: with SMTP id q9mr2461773wrp.103.1578648854833; 
 Fri, 10 Jan 2020 01:34:14 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id v3sm1510233wru.32.2020.01.10.01.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 01:34:14 -0800 (PST)
Subject: Re: [PATCH 04/15] hw/ppc/spapr_rtas: Restrict variables scope to
 single switch case
To: Greg Kurz <groug@kaod.org>
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-5-philmd@redhat.com>
 <20200109184349.1aefa074@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9870f8ed-3fa0-1deb-860d-7481cb3db556@redhat.com>
Date: Fri, 10 Jan 2020 10:34:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109184349.1aefa074@bahia.lan>
Content-Language: en-US
X-MC-Unique: k51Yc4dlNkGSP6e28jZXlw-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 6:43 PM, Greg Kurz wrote:
> On Thu,  9 Jan 2020 16:21:22 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> We only access these variables in RTAS_SYSPARM_SPLPAR_CHARACTERISTICS
>> case, restrict their scope to avoid unnecessary initialization.
>>
>=20
> I guess a decent compiler can be smart enough detect that the initializat=
ion
> isn't needed outside of the RTAS_SYSPARM_SPLPAR_CHARACTERISTICS branch...
> Anyway, reducing scope isn't bad. The only hitch I could see is that some
> people do prefer to have all variables declared upfront, but there's a ne=
sted
> param_val variable already so I guess it's okay.

I don't want to outsmart compilers :)

The MACHINE() macro is not a simple cast, it does object introspection=20
with OBJECT_CHECK(), thus is not free. Since=20
object_dynamic_cast_assert() argument is not const, I'm not sure the=20
compiler can remove the call.

Richard, Eric, do you know?

>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/ppc/spapr_rtas.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 6f06e9d7fe..7237e5ebf2 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -267,8 +267,6 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU=
 *cpu,
>>                                             uint32_t nret, target_ulong =
rets)
>>   {
>>       PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>> -    MachineState *ms =3D MACHINE(spapr);
>> -    unsigned int max_cpus =3D ms->smp.max_cpus;
>>       target_ulong parameter =3D rtas_ld(args, 0);
>>       target_ulong buffer =3D rtas_ld(args, 1);
>>       target_ulong length =3D rtas_ld(args, 2);
>> @@ -276,6 +274,8 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU=
 *cpu,
>>  =20
>>       switch (parameter) {
>>       case RTAS_SYSPARM_SPLPAR_CHARACTERISTICS: {
>> +        MachineState *ms =3D MACHINE(spapr);
>> +        unsigned int max_cpus =3D ms->smp.max_cpus;
>=20
> The max_cpus variable used to be a global. Now that it got moved
> below ms->smp, I'm not sure it's worth keeping it IMHO. What about
> dropping it completely and do:
>=20
>          char *param_val =3D g_strdup_printf("MaxEntCap=3D%d,"
>                                            "DesMem=3D%" PRIu64 ","
>                                            "DesProcs=3D%d,"
>                                            "MaxPlatProcs=3D%d",
>                                            ms->smp.max_cpus,
>                                            current_machine->ram_size / Mi=
B,
>                                            ms->smp.cpus,
>                                            ms->smp.max_cpus);

OK, good idea.

> And maybe insert an empty line between the declaration of param_val
> and the code for a better readability ?
>=20
>>           char *param_val =3D g_strdup_printf("MaxEntCap=3D%d,"
>>                                             "DesMem=3D%" PRIu64 ","
>>                                             "DesProcs=3D%d,"
>=20


