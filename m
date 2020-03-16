Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90026C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5863220753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnXLqmF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5863220753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvM9-0002DP-Gi
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuye-000297-0J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuyc-0001Dr-7c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:00:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuyc-00019Q-2G
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584385237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTcwy5EcrKMKytC/WSeHnaZ/vMtgK6arLEK3I1pmChw=;
 b=WnXLqmF7AKzvN5M97FSK4YEDuEh3dK0zx23h+yHAN8hz7nrXDrg5fKHg9O24oiNF8J0TRd
 F3IpIjtKauW+sgAnmWQmV1oY+y6dXiBHnRWuSmbH39RJ8VTfZTrekUjl0afFxWtRSPUlGQ
 6FRfSGvgIMPU0dv43KPUm+20QkcoVSA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-uMdiNIahNCSf5GR7A5Ze7w-1; Mon, 16 Mar 2020 15:00:31 -0400
X-MC-Unique: uMdiNIahNCSf5GR7A5Ze7w-1
Received: by mail-ed1-f70.google.com with SMTP id dn10so2307368edb.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SBoLIS60m/R8vVlNjtCKtaSpPA1mtOn0IkBdkHi07aA=;
 b=eR6ggTwz3M0/ighoIVu/plUtkxrV60zLghH0XZULOzrSdUNDMU2x6YagtqNTjPedoV
 S3FUYepAWuJj4QM1Zp//FkGn1ciHtLIDTsISMMeSzbO1z3Aq6PBw3R3OvfqckyPjvrxi
 wrxYAaZEtxKFqeeoh2a7n851nepJ3SnVz1iQ/ihtMG5N+0cx/ZX+V3P0ft7I5wLW9z6p
 xvLw6UpaAMtgn1bTNuuhLbuxtBVck5o3mYrWTXImgcL8FPO39mV1uWlvopfi479RUPyM
 lA+KZ46B/IgYIkEUELz/mvS+5bX+dJxoBDHwNbDAm+0tMcz/8KYRj/1HuuUJXXxK2wZW
 gamg==
X-Gm-Message-State: ANhLgQ2+UmuwbxyFDD/mbPxx0Cm7hfo+vBRBG6oj+h9Xh55HTN4Vfd6H
 JBLOW+SuRAb3FH+6tdvQXlmC0ljBfp66Q4Ym5bJk2nhiz+ijKOssgG6AK9JFwuqDO9lS4woinS0
 01EPMjnyO1j5Lf00=
X-Received: by 2002:a05:6402:180a:: with SMTP id
 g10mr1396201edy.352.1584385228635; 
 Mon, 16 Mar 2020 12:00:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtBwTHbkTiIU9n1r6Qr6pyZg2hQ9rRIsQKNUEZ9lnKnt6gBUvvjzB3M5uPPCsZJF+W1RYG4Vw==
X-Received: by 2002:a05:6402:180a:: with SMTP id
 g10mr1396167edy.352.1584385228380; 
 Mon, 16 Mar 2020 12:00:28 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id d9sm50792ejc.79.2020.03.16.12.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:00:27 -0700 (PDT)
Subject: Re: [PATCH v3 18/19] hw/arm: Do not build to 'virt' machine on Xen
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-19-philmd@redhat.com>
 <CAFEAcA_bXb_RZFxMSYJ8FAoAahAxrq3c0PBzidu+Z0iXTzZqFw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a627400-c8bd-fcee-8cf8-9896c5b3760f@redhat.com>
Date: Mon, 16 Mar 2020 20:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bXb_RZFxMSYJ8FAoAahAxrq3c0PBzidu+Z0iXTzZqFw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, kvm-devel <kvm@vger.kernel.org>,
 Paul Durrant <paul@xen.org>, Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 6:11 PM, Peter Maydell wrote:
> On Mon, 16 Mar 2020 at 16:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Xen on ARM does not use QEMU machines [*]. Disable the 'virt'
>> machine there to avoid odd errors such:
>>
>>      CC      i386-softmmu/hw/cpu/a15mpcore.o
>>    hw/cpu/a15mpcore.c:28:10: fatal error: kvm_arm.h: No such file or dir=
ectory
>>
>> [*] https://wiki.xenproject.org/wiki/Xen_ARM_with_Virtualization_Extensi=
ons#Use_of_qemu-system-i386_on_ARM
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: Paul Durrant <paul@xen.org>
>> Cc: xen-devel@lists.xenproject.org
>> ---
>>   hw/arm/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 8e801cd15f..69a8e30125 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -1,5 +1,6 @@
>>   config ARM_VIRT
>>       bool
>> +    depends on !XEN
>>       default y if KVM
>>       imply PCI_DEVICES
>>       imply TEST_DEVICES
>> --
>=20
> This seems odd to me:
> (1) the error message you quote is for a15mpcore.c, not virt.c

This is the first device the virt board selects:

config ARM_VIRT
     bool
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VFIO_AMD_XGBE
     imply VFIO_PLATFORM
     imply VFIO_XGMAC
     imply TPM_TIS_SYSBUS
     select A15MPCORE
     ...

> (2) shouldn't this be prevented by something saying "don't build
> guest architecture X boards into Y-softmmu", rather than a specific
> flag for a specific arm board ?

Yes, agreed. This surgical change was quicker for my testing, but we=20
don't need this patch right now, so let's drop it.

>=20
> thanks
> -- PMM
>=20


