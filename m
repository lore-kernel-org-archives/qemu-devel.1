Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3BC2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B3922527
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JetfetHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B3922527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3nE-0003DT-Qs
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1if3mV-0002gU-6h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1if3mR-0006ml-SW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:20:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1if3mR-0006lP-Dq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576077598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqwLral0ePoKsgMP0FMvkTCbQxadumdMNu32wH3waJA=;
 b=JetfetHkhaP1G0Fek2bYnLGz1fuZorII37JHvYgEaJ2DxwpPG99xT5ijaXFHxv3N55aBZ8
 gBEFZY36kNoDSPKhHbe42lJBVgmUZ7BhH4EzDShnI0FTNINIZwwJ9shW/WUGWEUo7kSuqA
 zlxH6fZ8uYePjlcuzIKwPNor5ktkBrI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-iQkn7nzaMSmEQLsA2xCbYA-1; Wed, 11 Dec 2019 10:19:56 -0500
Received: by mail-wr1-f70.google.com with SMTP id f10so1083505wro.14
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 07:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FzNuMIkolt2BzGbBb95RpT2dmhPPNIOV3sl1gtgzVLQ=;
 b=TiA+/gH3NX1oIoA+APQBV9onFXQUf3L+gd+YXjKeAMJDacZSJRaJAyDBPEM0hYBzNH
 wxDFKrbTNJoNxtVSUN0Db+SQO1a8yoOe0oHWCdFNmfPZYbW61h90zyPVw7/AHXwcI3o9
 UvsC/HFu7q063dbtIo2yrOlJaZhD0TCiOVQX37Bv4FSjqCDDabS4l350gJIZiRQl3oQa
 /X3dSobgzOLVmyfgE4XhdusKQ9mc3TjjcvtmIhiT5T2MwK+KsXdkFmne4Xq/TQAe0FPU
 UC3lsNq59079veMpbGXeqsBQyWg11Bz0Ml8f9MTFSntW0GoJQjtHRUtL29jQGMMnQkNd
 1yzw==
X-Gm-Message-State: APjAAAXRBGYwnEpKa2n0XgoTJx8RuRzvHw6qCIol6KeYiI/Wq7phxJ99
 WO2TDCstiNlg+5nX6pTNMG20q1Wv25o/zCf59u34Cb149laic2OKuGTMTkyOguGZqTv5caI27u8
 7bXwpFk+uThNNNHw=
X-Received: by 2002:a1c:f303:: with SMTP id q3mr349182wmq.98.1576077595436;
 Wed, 11 Dec 2019 07:19:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyL41x51BHYpE68k01X6XWc4LTwO4jXE7YY5n+d2CN08ZwvE03Z/YzjXGno15EHVCDGbIHaBw==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr349164wmq.98.1576077595193;
 Wed, 11 Dec 2019 07:19:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id i16sm2777635wmb.36.2019.12.11.07.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 07:19:54 -0800 (PST)
Subject: Re: [PATCH] ff Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1576075593-50346-1-git-send-email-pbonzini@redhat.com>
 <20191211150228.GL955178@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f206baa1-9d25-6c41-cefb-06ce35782d34@redhat.com>
Date: Wed, 11 Dec 2019 16:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211150228.GL955178@redhat.com>
Content-Language: en-US
X-MC-Unique: iQkn7nzaMSmEQLsA2xCbYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 16:02, Daniel P. Berrang=C3=A9 wrote:
> Missing commit message subject line :-)

I'm not fast enough at Ctrl-C, it seems!

Paolo

> On Wed, Dec 11, 2019 at 03:46:33PM +0100, Paolo Bonzini wrote:
>> ---
>>  hw/ppc/e500.c      | 1 -
>>  hw/ppc/spapr_irq.c | 8 --------
>>  2 files changed, 9 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index 928efaa..12b6a5b 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -793,7 +793,6 @@ static DeviceState *ppce500_init_mpic(PPCE500Machine=
State *pms,
>>                                        MemoryRegion *ccsr,
>>                                        IrqLines *irqs)
>>  {
>> -    MachineState *machine =3D MACHINE(pms);
>>      const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms);
>>      DeviceState *dev =3D NULL;
>>      SysBusDevice *s;
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index c3f8870..15c3dd4 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -74,7 +74,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptControl=
ler *, Error **),
>>                         SpaprInterruptController *intc,
>>                         Error **errp)
>>  {
>> -    MachineState *machine =3D MACHINE(qdev_get_machine());
>>      Error *local_err =3D NULL;
>> =20
>>      if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
>> @@ -287,7 +286,6 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
>> =20
>>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>>  {
>> -    MachineState *machine =3D MACHINE(spapr);
>>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> =20
>>      if (kvm_enabled() && kvm_kernel_irqchip_split()) {
>> @@ -295,12 +293,6 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>>          return;
>>      }
>> =20
>> -    if (!kvm_enabled() && kvm_kernel_irqchip_required()) {
>> -        error_setg(errp,
>> -                   "kernel_irqchip requested but only available with KV=
M");
>> -        return;
>> -    }
>> -
>>      if (spapr_irq_check(spapr, errp) < 0) {
>>          return;
>>      }
>> --=20
>> 1.8.3.1
>>
>>
>=20
> Regards,
> Daniel
>=20


