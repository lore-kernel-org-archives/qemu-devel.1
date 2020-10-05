Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5247C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596AB20853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6bLA+o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596AB20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPUyx-0000en-HG
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPUxs-0008UW-5o
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPUxp-00030J-Li
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601921516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gASi9rYA8+AinxFz/3HZ5MKzz8wAZmyb7cZE9xMn8c0=;
 b=N6bLA+o9vs31HsYqpfDPlWtSoGYtkWxH9g76sTTBeI0Pcm2pkzeJZlzoSH8mxJCh8QXFDq
 QHdBjPOU0Tz2JTCBdHWF79Y4Ai1LeXYz3cOQNBC0MhmJ5Kbi3dJpCzDewt1VuPeuRJb23A
 uZejP19+VkuYPtcYv0PO/faNmI5P5oo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-cSeoPbpFMS6mFHbM0hSPcg-1; Mon, 05 Oct 2020 14:11:54 -0400
X-MC-Unique: cSeoPbpFMS6mFHbM0hSPcg-1
Received: by mail-wr1-f69.google.com with SMTP id 33so4310454wrk.12
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 11:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gASi9rYA8+AinxFz/3HZ5MKzz8wAZmyb7cZE9xMn8c0=;
 b=peF2NBoLvd3XZ9+fQ+LLY0z2vfgh8cgXWx1hsJZc8dbfG7m/qJ0eB2wC3iYjHO9bNf
 H5uV/2SEIPxCV1Pr3bthGcglll4D1IdzVbO82OMia44NuyYtyLpuJYF14a2+eNMR6pvZ
 wBf7ozXp5A9LiBs2iKQ60YC5yEeMH7IMNdz0+TZQpZSxrNyuHidhD1sZh5OBnCwcwlIL
 ukJrOdm9VWqurfd/+BhwYEyyzsuL2Cokv/sagv7lxjK+yGm6S/TY8yZlAWp1FW5SXqaz
 O6m5kMvh9cOC0q7MOEFm3pGLuWfcMNfejXDZhRLKgZdfETDUQXDUW4Fe9osXHySD7PjJ
 s5nw==
X-Gm-Message-State: AOAM5312R8R9YHNohu9rEZCoI2wrsPDHk3i0xO///PM6CD4dfH2WL6rS
 7edO0KN8x3/7Q8SAVsTw4NAtOoAgDLF+xIetf65kOgr0Y+SpM3x4rVXghKqEhcP/dgYOnybabd0
 W9tUaj7bRbTk2cdA=
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr649546wra.187.1601921513548; 
 Mon, 05 Oct 2020 11:11:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqBCcdEtC5tC3NJWK+DQE3fv93oDPz6Fjxnk1b13650kauop1I4B1NJGQTaBIpEmZG05BLhg==
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr649528wra.187.1601921513292; 
 Mon, 05 Oct 2020 11:11:53 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m13sm921052wrr.74.2020.10.05.11.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 11:11:52 -0700 (PDT)
Subject: Re: [PATCH] softmmu/memory: Log invalid memory accesses
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201005152725.2143444-1-philmd@redhat.com>
 <20201005135652-mutt-send-email-mst@kernel.org>
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
Message-ID: <f4efb3e6-d11b-6136-33db-57cd12fe45a9@redhat.com>
Date: Mon, 5 Oct 2020 20:11:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005135652-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 7:57 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 05, 2020 at 05:27:25PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> Log invalid memory accesses with as GUEST_ERROR.
>>
>> This is particularly useful since commit 5d971f9e67 which reverted
>> ("memory: accept mismatching sizes in memory_region_access_valid").
>>
>> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Paolo's tree I assume?

Or qemu-trivial, whichever is less busy :)

> 
>> ---
>>  softmmu/memory.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index fa280a19f7..403ff3abc9 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -14,6 +14,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/log.h"
>>  #include "qapi/error.h"
>>  #include "cpu.h"
>>  #include "exec/memory.h"
>> @@ -1353,10 +1354,18 @@ bool memory_region_access_valid(MemoryRegion *mr,
>>  {
>>      if (mr->ops->valid.accepts
>>          && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
>> +                                       "0x%" HWADDR_PRIX ", size %u, "
>> +                                       "region '%s', reason: rejected\n",
>> +                      addr, size, memory_region_name(mr));
>>          return false;
>>      }
>>  
>>      if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
>> +                                       "0x%" HWADDR_PRIX ", size %u, "
>> +                                       "region '%s', reason: unaligned\n",
>> +                      addr, size, memory_region_name(mr));
>>          return false;
>>      }
>>  
>> @@ -1367,6 +1376,13 @@ bool memory_region_access_valid(MemoryRegion *mr,
>>  
>>      if (size > mr->ops->valid.max_access_size
>>          || size < mr->ops->valid.min_access_size) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
>> +                                       "0x%" HWADDR_PRIX ", size %u, "
>> +                                       "region '%s', reason: invalid size "
>> +                                       "(min:%u max:%u)\n",
>> +                      addr, size, memory_region_name(mr),
>> +                      mr->ops->valid.min_access_size,
>> +                      mr->ops->valid.max_access_size);
>>          return false;
>>      }
>>      return true;
>> -- 
>> 2.26.2
> 


