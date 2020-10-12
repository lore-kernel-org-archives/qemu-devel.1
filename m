Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FB1C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9613520709
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9z/fy+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9613520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyoF-00053T-OS
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRynO-00040K-MU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRyn8-00064Y-9J
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602512829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vo+2idY1iOLKCcCi+5C1utcyJaMx4cV6n4V4S3DSJYU=;
 b=D9z/fy+WqrDNWlxzzfefNn6zPD0BBBa+EtAUPnP0QIKljaCwIcPQnkYUFlOfB/RM1SHnYg
 9+5OSiDrOqjJgEJKP+KUM/x0/42tFv+cNW+1WmlThjPKziglTJUC7fvU8AhAUX5VnayQsJ
 xRt9rdPWU+rdGxPIxekx45/dFhy8fGc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-636idPakNyWMvEPGQqUmnQ-1; Mon, 12 Oct 2020 10:27:07 -0400
X-MC-Unique: 636idPakNyWMvEPGQqUmnQ-1
Received: by mail-wm1-f69.google.com with SMTP id s12so6577132wmj.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 07:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vo+2idY1iOLKCcCi+5C1utcyJaMx4cV6n4V4S3DSJYU=;
 b=CpLURDr+k2BJECCGfXRcVEcLHA3bNUIKmp7jHf5DjL9YInmqZgPrn9Un9P3fEsYTFP
 pi2MMomMehld0nCAoMUl0uvTb+Ye3d2o0BVagDG9jA++3e5B6MrFsKnLQOsF+KY2lXa5
 QkqdFI2sPC+tI7y1doHGKmqdo+iMBA4baXG5llxq3f3eamV28L0rLlIeUkGxphNxskjf
 t5K43quAvjYIcU0egu5z+jSaPm+JfrdH485uzi/pE1d6DxSVLmoEzdfEpuZKuGGkpGdB
 Ef/18lYTxyBJE2PdGD/lu+OmqYH85Mcz4iZP2FwnZ30Drf/0jNI4L0WdLBAoovIOJ88U
 qFPw==
X-Gm-Message-State: AOAM533t15JrZiA+hRliC8OYg5mzEP/5UzMvIbW7bSIS9d9vLHzhUPwo
 +3nu17iPhIdTF3LPoU5ZM4JMEN2Uc4lz+IDeEExyBoMI4R1qTMBUPb1RuoFFzzAPBwzYo5PUXdt
 1fmMYLm8glCrFGg8=
X-Received: by 2002:adf:8b92:: with SMTP id o18mr30897985wra.54.1602512826528; 
 Mon, 12 Oct 2020 07:27:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN/JUPdkMsHaZBYIgaydnOJmnNwLH0QYzEln08Ptid/yaqlyzjllxaKTcU7OhsAYIHHDu0Gg==
X-Received: by 2002:adf:8b92:: with SMTP id o18mr30897939wra.54.1602512826234; 
 Mon, 12 Oct 2020 07:27:06 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f6sm11354830wru.50.2020.10.12.07.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 07:27:05 -0700 (PDT)
Subject: Re: [PATCH 1/5] hw/pci-host/bonito: Make PCI_ADDR() macro more
 readable
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20201012124506.3406909-1-philmd@redhat.com>
 <20201012124506.3406909-2-philmd@redhat.com>
 <3894edd-a214-3edf-8cbe-3566842e8a4@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aadc1813-9289-85eb-18b9-70c4189fd879@redhat.com>
Date: Mon, 12 Oct 2020 16:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3894edd-a214-3edf-8cbe-3566842e8a4@eik.bme.hu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 3:55 PM, BALATON Zoltan wrote:
> On Mon, 12 Oct 2020, Philippe Mathieu-Daudé wrote:
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> The PCI_ADDR() macro use generic PCI fields shifted by 8-bit.
>> Rewrite it extracting the shift operation one layer.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> hw/pci-host/bonito.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
>> index a99eced0657..abb3ee86769 100644
>> --- a/hw/pci-host/bonito.c
>> +++ b/hw/pci-host/bonito.c
>> @@ -196,8 +196,8 @@ FIELD(BONGENCFG, PCIQUEUE,      12, 1)
>> #define PCI_IDSEL_VIA686B          (1 << PCI_IDSEL_VIA686B_BIT)
>>
>> #define PCI_ADDR(busno , devno , funno , regno)  \
>> -    ((((busno) << 16) & 0xff0000) + (((devno) << 11) & 0xf800) + \
>> -    (((funno) << 8) & 0x700) + (regno))
>> +    ((((busno) << 8) & 0xff00) + (((devno) << 3) & 0xf8) + \
>> +    (((funno) & 0x7) << 8) + (regno))
> 
> Are you missing a << 8 somewhere before + (regno) or both of these are 
> equally unreadable and I've missed something? This seems to be 
> completely replaced by next patch so what's the point of this change?

I might have missed a parenthesis somewhere indeed =)

I'm happy to merge it in the next patch, I thought it would
be easier to review but it isn't.

Thanks for reviewing!

> 
> Regards,
> BALATON Zoltan
> 
>>
>> typedef struct BonitoState BonitoState;
>>
>>


