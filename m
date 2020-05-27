Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D71C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2123F207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBLutZCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2123F207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqjO-0002Px-Bw
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdqio-00020E-2W
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:43:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdqik-0000lG-4z
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590565404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eia4uyeLtaWy/VIuerGuaiUPHsXir+O/2yO46CLXa+U=;
 b=cBLutZCHiKeDAT6nDpZZJkrg2JJtd2avzjxw0XwDlmHrj72GjToi9ZEHwJqfc20hXV07fJ
 N5IbTLq0uf+k+85LObZtwC1REfco4iFa7APFj+8EY6skqjM4RCbecS2JHrX/mtS74iPsim
 XVOyvamUnL2p6EXU+hNimst9TstHEUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-nLUTSzYYOnmwnubwGBUW4A-1; Wed, 27 May 2020 03:43:23 -0400
X-MC-Unique: nLUTSzYYOnmwnubwGBUW4A-1
Received: by mail-wm1-f72.google.com with SMTP id s15so562288wmc.8
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 00:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eia4uyeLtaWy/VIuerGuaiUPHsXir+O/2yO46CLXa+U=;
 b=cOjgZFvIUX6DD7PDE88tHqPLUB8QLfBTFBDdHIt3kZo4ioj1lqrWJ2Pt/QnDML43xE
 ctYDyIbV2AG1aK7Qnw/Nl/ycgxu7aE3rsxaxsB8RefexaauCgoBQLVjgEWhGuumP4juX
 c497PdfeX4sxw9xkHIPf7rZqqQb4bl6Xrkm3q5PD8q1w6wk/rkJXbF0yU92nufZiJkNI
 tzNimlm6kGuTRn0fESVbGvn4T4OHNVkvek+vX8DpTWQyXT1thlqzwyUGKc40vRepRkyy
 EYdCWQKP0VtwhlnVeoQAh2vX7Ig6bq71svoWbwD8HOdkwoF2b6XiTy+UG4KRvUjAWMWi
 O9Rw==
X-Gm-Message-State: AOAM531epDeRRgEeMBCpTpUq/siwy+LC/rZvRUZz+ExWbh3Ccq6hN7qS
 E4KaCZ3+i98/+SwPC+cpd2GwttOebhgvwFfM8yjSD6dYJ0vFbFubcMl9+Z0JQrLGwdwAMlZpOvw
 ift9fa8T1FHv3Rtk=
X-Received: by 2002:a1c:4189:: with SMTP id o131mr3139490wma.110.1590565402186; 
 Wed, 27 May 2020 00:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3kj4bt6Vi1jlIp2KeDXTVEXPMzxW8TvOnomEyoN1sjY/+vpUBGDtyNrwR0iMpxZCxN89u1g==
X-Received: by 2002:a1c:4189:: with SMTP id o131mr3139468wma.110.1590565401923; 
 Wed, 27 May 2020 00:43:21 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id p7sm2070056wro.26.2020.05.27.00.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 00:43:21 -0700 (PDT)
Subject: Re: [PATCH] hw/vfio/common: Trace in which mode a IOMMU is opened
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
References: <20200526173542.28710-1-philmd@redhat.com>
 <6c7c445d-0335-f67d-bb72-5b0c046bb247@redhat.com>
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
Message-ID: <24f88212-9b32-b6dc-fcd4-685cde8bf5d7@redhat.com>
Date: Wed, 27 May 2020 09:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6c7c445d-0335-f67d-bb72-5b0c046bb247@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 9:08 AM, Auger Eric wrote:
> Hi Philippe,
> 
> On 5/26/20 7:35 PM, Philippe Mathieu-Daudé wrote:
>> One might want to check which IOMMU version the host kernel
>> provide. Add a trace event to see in which mode we opened
>> our container.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/vfio/common.c     | 19 ++++++++++++++-----
>>  hw/vfio/trace-events |  1 +
>>  2 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 0b3593b3c0..6b69a259c1 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1157,15 +1157,24 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>>  static int vfio_get_iommu_type(VFIOContainer *container,
>>                                 Error **errp)
>>  {
>> -    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>> -                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
>> +    static const struct {
>> +        int type;
>> +        const char *name;
>> +    } iommu[] = {
>> +        {VFIO_TYPE1v2_IOMMU, "Type1 (v2)"},
>> +        {VFIO_TYPE1_IOMMU, "Type1 (v1)"},
>> +        {VFIO_SPAPR_TCE_v2_IOMMU, "sPAPR TCE (v2)"},
>> +        {VFIO_SPAPR_TCE_IOMMU, "sPAPR TCE (v1)"}
>> +    };
>>      int i;
>>  
>> -    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
>> -        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
>> -            return iommu_types[i];
>> +    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
>> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
>> +            trace_vfio_get_iommu_type(iommu[i].type, iommu[i].name);
> Just wondering why you want to trace the type as you now have the name
> string.

You are right :)

>> +            return iommu[i].type;
>>          }
>>      }
>> +    trace_vfio_get_iommu_type(-1, "Not available or not supported");
> nit: from a debugging pov, this may be not needed as
> vfio_get_group/vfio_connect_container() fails and this leads to an error
> output.

Indeed.

Thanks for the review!

> 
> Thanks
> 
> Eric
>>      error_setg(errp, "No available IOMMU models");
>>      return -EINVAL;
>>  }
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index b1ef55a33f..8166c4c50d 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -115,6 +115,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>>  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>>  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
>>  vfio_dma_unmap_overflow_workaround(void) ""
>> +vfio_get_iommu_type(int iommu_type, const char *iommu_name) "IOMMU type %d (%s)"
>>  
>>  # platform.c
>>  vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
>>
> 


