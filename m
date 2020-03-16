Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5571EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2044420575
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVg5eNoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2044420575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqLb-0006Yh-NG
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoyu-0000hz-Ok
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoys-00064e-IK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:36:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoyr-0005tb-4t
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584362188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQ9Sh4N2YEJYb/hLXgC3HaPD6Usx8BcDx4hkOCzaw3U=;
 b=hVg5eNoX6eqdyUwNrldj2QGnDZj5dRyuVCteFqfwu3P6XrRBOXb751XuZLsO7gC489b1Aa
 /QV9dWMUxWm6HwzujZvqaoy8dm3P0IwBaqXyydQDoK65OLe8VdnUABNAJWurfbRg0VkbfX
 H+HnzeHypVU/LwcRxI2lcpbDcxJW8LQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-h-X87GOXNVSTlKLcRQJBqw-1; Mon, 16 Mar 2020 08:36:27 -0400
X-MC-Unique: h-X87GOXNVSTlKLcRQJBqw-1
Received: by mail-ed1-f72.google.com with SMTP id c2so2630648edx.16
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dAmnWd0zI62YSjEtFRQ6G7VQKY+XV02vfFULd99Xows=;
 b=gZdKZZZ0VrmT5fvg+uWWOz1sQJOm5AuQY4ukTKr2gaH0v1SHOB9nhs7gLdZ/IISqRS
 tQjzLD+XycsT7pTqguVu0udZeYnz2DXAxcbCA3yEabYRsSIp0C4Co/9Hoe1Ht4DOWCyN
 6VDu97TaIfZNLYAogfK7jDEu+XpcSfLvdSSelXRSdRJXahYyJfHa6a4EAs7XOvX8bTqv
 MMGTdTRrEQCUjpWHAfhPYqo595XKBEQwwpW/xnXsCmNwxYOUf4aB+YXdPvInoqUTS01g
 CQR1/mbw1mw3brawoXT2zkFsNiBoLHeFDftB42aQnUKL1b3/yOw6kwNfPVDzUjh1iOyJ
 CPCw==
X-Gm-Message-State: ANhLgQ1N9E2WEmczKWZmOgFoLaHv4Dngc16UJKVqCE6AGiYrLgsd8D5i
 fNgPesxOxusRLVZIBNVr9T3evXh+WMK3KdVdes+dGl6A8kMIWjU2l7ogLHdX9mjBhK58wTnydrj
 fvRncSGH5CDRgzI0=
X-Received: by 2002:a50:ed0f:: with SMTP id j15mr2046892eds.311.1584362185863; 
 Mon, 16 Mar 2020 05:36:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv3FPv1j7y6RtVx2WSJHuql278xYaD3pbcx/My4kFJxFlikmDSJFzbmspu4/S3wHxFXnWmneQ==
X-Received: by 2002:a50:ed0f:: with SMTP id j15mr2046861eds.311.1584362185673; 
 Mon, 16 Mar 2020 05:36:25 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id e20sm196924ejd.46.2020.03.16.05.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 05:36:25 -0700 (PDT)
Subject: Re: [PATCH 04/11] MAINTAINERS: Add an entry for the HVF accelerator
To: Roman Bolshakov <r.bolshakov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-5-philmd@redhat.com>
 <20200316121241.GA4312@SPB-NB-133.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71fafc19-359a-f5b8-d372-2bc3576cd012@redhat.com>
Date: Mon, 16 Mar 2020 13:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316121241.GA4312@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 "Reviewed-by : Nikita Leshenko" <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Roman,

On 3/16/20 1:12 PM, Roman Bolshakov wrote:
> Hi Philippe,
>=20
> I can take the ownership if nobody wants it. At the moment I'm working
> on APIC for HVF to get kvm-unit-tests fixed.
>=20
> Next items on the list (in no particular order):
> * MMX emulation
> * SSE emulation
> * qxl display
> * gdb stub
> * virtio-gpu/virgil running on metal
> * VFIO-PCI based on macOS user-space DriverKit framework

Glad to hear :)
I suppose Paolo will be happy to have someone caring about HVF.
Do you mind sending a patch to step in?

Thanks,

Phil.

>=20
> Best regards,
> Roman
>=20
> On Mon, Mar 16, 2020 at 01:00:42PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
>> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
>> Cc: Patrick Colp <patrick.colp@oracle.com>
>> Cc: Cameron Esfahani <dirty@apple.com>
>> Cc: Liran Alon <liran.alon@oracle.com>
>> Cc: Heiher <r@hev.cc>
>> ---
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7ec42a18f7..bcf40afb85 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -420,6 +420,12 @@ F: accel/stubs/hax-stub.c
>>   F: target/i386/hax-all.c
>>   F: include/sysemu/hax.h
>>  =20
>> +HVF Accelerator
>> +S: Orphan
>> +F: accel/stubs/hvf-stub.c
>> +F: target/i386/hvf/hvf.c
>> +F: include/sysemu/hvf.h
>> +
>>   WHPX CPUs
>>   M: Sunil Muthuswamy <sunilmut@microsoft.com>
>>   S: Supported
>> --=20
>> 2.21.1
>>
>=20


