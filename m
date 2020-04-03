Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A1DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91FB20721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoWU/FYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91FB20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHUe-0002CL-F2
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jKHMy-0006fa-Nl
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jKHMx-0003ZT-K0
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:08:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jKHMv-0003Y5-6e; Fri, 03 Apr 2020 04:08:01 -0400
Received: by mail-pg1-x544.google.com with SMTP id x7so3156552pgh.5;
 Fri, 03 Apr 2020 01:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=GK+2oWY3y/0ZFmMsAAjM/vekvDpb3NtIoHMqTf1fGD4=;
 b=KoWU/FYGEic89ZumiTVC1ccBP9Sp55XNoLJXJC4GB513ZLqyZmO3Mqvn4WYUwhIOdi
 n0wXIT9dVzfP12znFvC4Ul0usxN3PPiHnu2zZZHJ0KNQjREHeOeemFkg7zrGqZByOLD2
 V9/HhEDGfU+h4qZGvRlYSxq6VC6LGzHQqU9SCKiblqjy5iIXAMGJnNQuc4aMflwCtlnF
 WyEntxNSX8oCXWZ44ryQ+esueqn/HJYLgzpPgkg5QlgFqTh3lzp8INYq1/QdSVOk3QRI
 WMU5fOMzv9rVimC+kPsfVB/ZTYcJK+iBhbMY7Uf6LEPp7c5tbkBj1LbqF21Ptd+gWYDo
 zw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=GK+2oWY3y/0ZFmMsAAjM/vekvDpb3NtIoHMqTf1fGD4=;
 b=oZth/P1n/qQF4QojlHHr7VsH4p1iQzRY4YAkWwr01cN1ycZr1uk0uSKcjPjbP8oYqZ
 7y64G2ylf7HhsxAgct5ZRtPpK2j3Y5LMtXM11hJGhPWhu1xOa6+BauK0BAJrf0GqreyY
 3pKEDOnSZ59Hefzu38uTk0Gm6ADXZGN+AG48xBAcdAXscJMvmMXHcT5PHL+HGV5nDX4t
 j9e8NPqxFfyY6LAPAoQg18TnPJ24DoXGDZ+KMu/2ZKVCIealFRi1G2VRNi9Kx/Q0chCJ
 b6UFUlhnr388QOooaqgWrA+wan0tWX+AND/nPUmUBrk+uJjY4h4n/KFCZB0PkBaRCLud
 01pg==
X-Gm-Message-State: AGi0PuY4I5XLUByM75ijNYYsxKRCSqfZDvp7hf+E1ndhdus30YfpJ2Mo
 A4ZIGeYyh/EZuX50kb/cyhg=
X-Google-Smtp-Source: APiQypIjt15tT0xFkDmZFxBeSGcTp3nv1wvVTNPaJNzAlpE2vejrkdPiK9VcpCtba9slI91CsEUTPg==
X-Received: by 2002:a63:3302:: with SMTP id z2mr7133982pgz.24.1585901280148;
 Fri, 03 Apr 2020 01:08:00 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id y131sm5297174pfg.25.2020.04.03.01.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 01:07:59 -0700 (PDT)
Date: Fri, 03 Apr 2020 18:07:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [EXTERNAL] [PATCH 5/5] ppc/pnv: Implement mce injection
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-6-npiggin@gmail.com>
 <2724f082-dcfe-1d64-cd8c-43f45d2313db@kaod.org>
In-Reply-To: <2724f082-dcfe-1d64-cd8c-43f45d2313db@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585901116.pcj7mhik4t.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater's on March 26, 2020 2:39 am:
> On 3/25/20 3:41 PM, Nicholas Piggin wrote:
>> This implements mce injection for pnv.
>=20
> This would be the command to use ?=20
>=20
> (qemu) mce 0 0x100000 0x80 0xdeadbeef 1
>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ppc/pnv.c             | 55 ++++++++++++++++++++++++++++++++++++++++
>>  target/ppc/cpu.h         |  1 +
>>  target/ppc/excp_helper.c | 12 +++++++++
>>  3 files changed, 68 insertions(+)
>>=20
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 671535ebe6..9c515bfeed 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -38,6 +38,7 @@
>>  #include "hw/nmi.h"
>>  #include "exec/address-spaces.h"
>>  #include "qapi/visitor.h"
>> +#include "qapi/qmp/qdict.h"
>>  #include "monitor/monitor.h"
>>  #include "hw/intc/intc.h"
>>  #include "hw/ipmi/ipmi.h"
>> @@ -1981,11 +1982,63 @@ static void pnv_nmi(NMIState *n, int cpu_index, =
Error **errp)
>>      }
>>  }
>>=20
>> +typedef struct MCEInjectionParams {
>> +    uint64_t srr1_mask;
>> +    uint32_t dsisr;
>> +    uint64_t dar;
>> +    bool recovered;
>> +} MCEInjectionParams;
>> +
>> +static void pnv_do_mce_on_cpu(CPUState *cs, run_on_cpu_data data)
>> +{
>> +    MCEInjectionParams *params =3D data.host_ptr;
>> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> +    CPUPPCState *env =3D &cpu->env;
>> +    uint64_t srr1_mce_bits =3D PPC_BITMASK(42, 45) | PPC_BIT(36);
>> +
>> +    cpu_synchronize_state(cs);
>=20
> I think this call is superfluous as we don't support any accelerators=20
> on this machine (but we might one day).

Okay. I can remove it, or do you think it's fine to stay?

>> +    ppc_cpu_do_machine_check(cs);
>> +
>> +    env->spr[SPR_SRR1] |=3D (params->srr1_mask & srr1_mce_bits);
>=20
> Don't  we need to clear the previous settings like on spapr ?=20

Yes, good catch.

>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 7f2b5899d3..81dd8b6f8e 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -279,6 +279,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, in=
t excp_model, int excp)
>>              cs->halted =3D 1;
>>              cpu_interrupt_exittb(cs);
>>          }
>> +        if (msr_pow) {
>> +            /* indicate that we resumed from power save mode */
>> +            msr |=3D 0x10000;
>=20
> #define ?=20

It matches system reset, but yes it should be put in a define (or
PPC_BIT should be okay I guess because it's architecture). As
discussed in the nmi patch, we have to make some adjustments for
pnv so I'll tidy that up too.

Thanks,
Nick
=

