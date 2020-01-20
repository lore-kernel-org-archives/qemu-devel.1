Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F5EC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EA122525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjK2QpdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EA122525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itcS3-0007VM-W9
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itcRA-0006UI-EB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itcR6-0002D4-Nx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:10:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itcR6-0002Co-Kb
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579547407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=247hrgJBP7uWliOLwVd84TiPECnr36+QswrFxWYZpuQ=;
 b=EjK2QpdHeRnXj5zvfuFea39y6Jw9PPNrXtlU8H2GxW6UbS66CvknQPeB/YdDKtHdV1BoGN
 VcYL00yTUTYNCX2dbb9DCJUJFDGYdFdc+Xx6SMz76LoIsiGo85VJTCMZUzE6sa+H2VVvMP
 rWO3So5l3yOOrFyuTrw2tU/BaNek20s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-o-cClIkxOSizdJzHm3LpuQ-1; Mon, 20 Jan 2020 14:10:05 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so199966wrm.17
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 11:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LiEqYUpoJN7awPuju73mr0uSwGm3RoRSi4iqEulDso0=;
 b=FXWk3GXY2QERnSG/OfmJ7KxAR6FkG18L1tvX1tpxdfCz7UfBjJ1C+D5N22cpvspJJz
 p2Sw0vH/veIW0104pPpFT4in1Teo75gmq7ISvrXwrv+dYJnmC1hOEe+KDG5ZxmQIDnhU
 u3HguCpFHUxxBflJe5QlD2ajfM8zW2gVzzNMEqsxpaP5DsGhZYSEOLF2PSy0BCEejY/f
 cJYZjyjIBc62NJ9JYhk81LCt33X3Wefl4YOCzRRiNn90IDaFtNN8rYUPD98yF2NWXGH4
 VHSGnsp+x3ZKcIhJ1gFsMfPD048mfeDx5N3BdXXvNEhfkFBtl5vl7nQG02bfZ8RBrmZg
 /B4w==
X-Gm-Message-State: APjAAAUiCkgzdSlRggxu/k24tHevEPoFoaan77yPUBNZk1/ob0aTzCyD
 uish0DUmrSxbqYfXSyyBCC/HduLZq9/09H6NUt3iVBoZccNt/s7wak1SOcKrA+QhWQPaAftFQgy
 6KalZ6Zqhbdph4ZA=
X-Received: by 2002:a1c:8086:: with SMTP id b128mr329880wmd.80.1579547404149; 
 Mon, 20 Jan 2020 11:10:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHoJoVYSYbvwRT7PpcWSM1UNIQOw3rFYuZXo9TakaMfO1SSn/fTdxFjI9dYiq2zQv8ZDrF7g==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr329863wmd.80.1579547403883; 
 Mon, 20 Jan 2020 11:10:03 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id l17sm46726818wro.77.2020.01.20.11.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 11:10:03 -0800 (PST)
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Add missing m48t59 files to the PReP
 section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200117165809.31067-1-philmd@redhat.com>
 <20200117165809.31067-2-philmd@redhat.com>
 <f5181fa3-e830-7d04-1f4e-0673d2202eec@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d566490e-512c-527c-4b7e-b6e20cf790f0@redhat.com>
Date: Mon, 20 Jan 2020 20:10:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f5181fa3-e830-7d04-1f4e-0673d2202eec@redhat.com>
Content-Language: en-US
X-MC-Unique: o-cClIkxOSizdJzHm3LpuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 6:53 AM, Thomas Huth wrote:
> On 17/01/2020 17.58, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   MAINTAINERS | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4b425d030d..c162145bd0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1084,6 +1084,8 @@ F: hw/pci-host/prep.[hc]
>>   F: hw/isa/i82378.c
>>   F: hw/isa/pc87312.c
>>   F: hw/dma/i82374.c
>> +F: hw/rtc/m48t59.c
>> +F: hw/rtc/m48t59-internal.h
>>   F: hw/rtc/m48t59-isa.c
>>   F: include/hw/isa/pc87312.h
>>   F: include/hw/rtc/m48t59.h
>=20
> Why only PReP? The device seems also to be used by Sparc machines...?

Indeed, and also the PowerPC405 evaluation boards, so I'll simply drop=20
this patch.


