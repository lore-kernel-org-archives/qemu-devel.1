Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58543C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC7222204
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyGiByRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC7222204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0tE-0004FU-0V
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG0o6-0005SL-64
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG0o4-00023u-6z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599660638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MWzaxhkIWjPPCR63AQJ7yOwCEw3bKbjsNfc8RYN4tkk=;
 b=TyGiByRKsMBlPAKXYk6iPIv5oRII9GPupbsUlqr/rK0lQ+PNItmPvEsraY09vWFQgF0zyP
 ruI+I7IMvvFTAFFNLvt1lHM71Vl5ChucI4MUxu+HZPWUGw0KrfFZhyDkSICThq80IghQVO
 mOMRI8qONCHoKcIdEbMtpggaygyn2pk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-fJ-xqmYJP2uSPLPiizUZVA-1; Wed, 09 Sep 2020 10:10:34 -0400
X-MC-Unique: fJ-xqmYJP2uSPLPiizUZVA-1
Received: by mail-wm1-f70.google.com with SMTP id u5so831351wme.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MWzaxhkIWjPPCR63AQJ7yOwCEw3bKbjsNfc8RYN4tkk=;
 b=k1IslVnnKpIMFBxQ+F4PwfMgAzHelEM73VGQzYYQMmd2H57iMVpE0QQyqLVsZsJwmK
 grwTqAuM7uwSF0hCWVJb3+zU4qW+3E9/bPQKiuxbmPleWGQ282nrszEsSXFgLXlsQ7FP
 +3iU9STG4GRG9yC52MdmKyWKXoPDA3lgptg6tZWAoNSil1S7E6iQAseZ9gMx1CNRBC30
 K3eb3hAEnwPq3/6U/EI3pir+AZP/0Fo867/PCHobtJTMZedunDgud98FQn3BOrviljxb
 smcSM3ncLxOifxgb8ONHlDIh0bIhKqrw+BcngQst0+7N6q9BYtdvKIc+hJJYVuY/pq13
 pzoA==
X-Gm-Message-State: AOAM531IywUFKQYon68AJqobpHHGVT7CYP49/TMQNX9FCreswKwyDHcm
 2gVKZVz7gpKQ7trnuuC7ZiuirggVjIaF13BnipvFaRFRZfC93u0v78BmFuv2Rg5WTR0CMTvUvdt
 /NQqtXt8aVRHseiI=
X-Received: by 2002:a5d:6301:: with SMTP id i1mr3878690wru.323.1599660633726; 
 Wed, 09 Sep 2020 07:10:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw27k258Wf74K31bmTyWZB6NotsOoDTWuGDSxSaDYGO/0v5VT9ud2EoCCPUYa1ZroENtoWfgw==
X-Received: by 2002:a5d:6301:: with SMTP id i1mr3878663wru.323.1599660633414; 
 Wed, 09 Sep 2020 07:10:33 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d6sm4436293wrq.67.2020.09.09.07.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 07:10:32 -0700 (PDT)
Subject: Re: [RFC PATCH v5 2/4] util/vfio-helpers: Report error when IOMMU
 page size is not supported
To: Fam Zheng <fam@euphon.net>
References: <20200908180342.280749-1-philmd@redhat.com>
 <20200908180342.280749-3-philmd@redhat.com>
 <20200909083815.wp2f3kmc2xxgjukm@dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <574d99fb-aaac-50e7-f2a3-37e31de2f341@redhat.com>
Date: Wed, 9 Sep 2020 16:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909083815.wp2f3kmc2xxgjukm@dev>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 10:38 AM, Fam Zheng wrote:
> On 2020-09-08 20:03, Philippe Mathieu-Daudé wrote:
>> This driver uses the host page size to align its memory regions,
>> but this size is not always compatible with the IOMMU. Add a
>> check if the size matches, and bails out with listing the sizes
>> the IOMMU supports.
>>
>> Example on Aarch64:
>>
>>  $ qemu-system-aarch64 -M virt -drive if=none,id=nvme0,file=nvme://0006:90:00.0/1,format=raw
>>  qemu-system-aarch64: -drive if=none,id=nvme0,file=nvme://0006:90:00.0/1,format=raw: Unsupported IOMMU page size: 4 KiB
>>  Available page size:
>>   64 KiB
>>   512 MiB
>>
>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  util/vfio-helpers.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index 55b4107ce69..6d9ec7d365c 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -11,6 +11,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include <sys/ioctl.h>
>>  #include <linux/vfio.h>
>>  #include "qapi/error.h"
>> @@ -316,6 +317,25 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>>          ret = -errno;
>>          goto fail;
>>      }
>> +    if (!(iommu_info.flags & VFIO_IOMMU_INFO_PGSIZES)) {
>> +        error_setg(errp, "Failed to get IOMMU page size info");
>> +        ret = -errno;
> 
> We don't have errno here, do we?

Oops thanks, I'll replace by "ret = -EINVAL;".

> 
>> +        goto fail;
>> +    }
>> +    if (!extract64(iommu_info.iova_pgsizes,
>> +                   ctz64(qemu_real_host_page_size), 1)) {
>> +        g_autofree char *host_page_size = size_to_str(qemu_real_host_page_size);
>> +        error_setg(errp, "Unsupported IOMMU page size: %s", host_page_size);
>> +        error_append_hint(errp, "Available page size:\n");
>> +        for (int i = 0; i < 64; i++) {
>> +            if (extract64(iommu_info.iova_pgsizes, i, 1)) {
>> +                g_autofree char *iova_pgsizes = size_to_str(1UL << i);
>> +                error_append_hint(errp, " %s\n", iova_pgsizes);
> 
> Interesting... Since it's printing page size which is fairly low level,
> why not just plain (hex) numbers?

Because this error is reported to the user (not the developer)
and depends of the host/iommu.

If you don't mind I'll keep it as it (as the code is written).

Thank you for reviewing the series!

Phil.

> 
> Fam
> 
>> +            }
>> +        }
>> +        ret = -EINVAL;
>> +        goto fail;
>> +    }
>>  
>>      s->device = ioctl(s->group, VFIO_GROUP_GET_DEVICE_FD, device);
>>  
>> -- 
>> 2.26.2
>>
>>
> 


