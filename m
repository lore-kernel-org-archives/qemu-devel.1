Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FE3207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGydzd5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FE3207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiRK-0007bG-I1
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jii9K-00010r-No
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:34:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23023
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jii9J-0004Nk-JO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591724096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VQrdRpqLldViq3Wqb15KISCbf7wNxRDk8mCujYohA1I=;
 b=OGydzd5Gz6+9w2lonsoDoNfOFlETnVZYCeHQVs6wGdNj8w9XqcjUg9eUztLcPMY9pXW/yE
 dubSgj3B0OXR65XhebrKmhBvhmFFLhQNMptKzp2z4Ucl/wn8b7ME99duEHaXaQa4TVrK3W
 Wh21nq5BlDfhuLbKpLm0Dd1K5NifTPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-sp4rsLYQPuah4Wi4ulzBJg-1; Tue, 09 Jun 2020 13:34:54 -0400
X-MC-Unique: sp4rsLYQPuah4Wi4ulzBJg-1
Received: by mail-wr1-f71.google.com with SMTP id w16so8864025wru.18
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VQrdRpqLldViq3Wqb15KISCbf7wNxRDk8mCujYohA1I=;
 b=lVCBxWaexArYjyHk7D9NYCgj14VStIGpgPE6H0kPDUoqSoDbO235SRYYcQ4dj/7tno
 MZLDTG4x5A5o/pjE9h6XXgQXk/o3ckw+kut+toXb3rzljqc6SJuiwfQGIeItCL4juX0s
 KlG1MxWnIL9iXEQKIJtgXf+hhBvyfwym885lSQFC1AGj4QX8YoQ2YUAmDTgNtulUL7yz
 YCHYXvxI/H1EzKDRICqn0WHDBVDs6xDqOO47n8JOZHOGrZXngF+bxUbneNs251vStbwa
 /vVPZ0PRl4jb4PBsdUxF5PmW6VTpw4/JIntaQ6fvHJcpuBTSBVvsrw5YwgMPafjgh2x8
 QGyQ==
X-Gm-Message-State: AOAM530rFoU9vd2Lyu2WCZUCDlquY+9k7ltDfvc+ZSzGLYvJNRKlNM52
 uFifP4NO6Xlsh1jciuJ+eKAXuebEQHtebxz/yayhP8A9XJIVKPROwFH47ad16B7z/8m9M+nEvt7
 GJGYDxANqtL/0cPM=
X-Received: by 2002:adf:ef47:: with SMTP id c7mr6117784wrp.57.1591724093480;
 Tue, 09 Jun 2020 10:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq67DRkTegDF8ibezZuDgmxJOnSaFWmR/dw/lk3h9uKYhnGg7PugG640eWAuHAeP9nR0M29Q==
X-Received: by 2002:adf:ef47:: with SMTP id c7mr6117758wrp.57.1591724093202;
 Tue, 09 Jun 2020 10:34:53 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u9sm3778427wme.16.2020.06.09.10.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 10:34:52 -0700 (PDT)
Subject: Re: [PATCH v2] hw/vfio/common: Trace in which mode an IOMMU is opened
To: Alex Williamson <alex.williamson@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20200527155555.6833-1-philmd@redhat.com>
 <b687dd06-490d-dde9-53cc-aa05f38f769e@vivier.eu>
 <20200609113326.100e74fe@w520.home>
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
Message-ID: <0f7cda31-1ca6-621f-10dc-9237fa952ec5@redhat.com>
Date: Tue, 9 Jun 2020 19:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609113326.100e74fe@w520.home>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 7:33 PM, Alex Williamson wrote:
> On Tue, 9 Jun 2020 19:23:32 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> Le 27/05/2020 à 17:55, Philippe Mathieu-Daudé a écrit :
>>> One might want to check which IOMMU version the host kernel
>>> provide. Add a trace event to see in which mode we opened
>>> our container.
>>>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> v2: Only display string description (Eric)
>>>
>>> Supersedes: <20200526173542.28710-1-philmd@redhat.com>
>>> ---
>>>  hw/vfio/common.c     | 19 ++++++++++++++-----
>>>  hw/vfio/trace-events |  1 +
>>>  2 files changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 0b3593b3c0..f24450472e 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1157,15 +1157,24 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>>>  static int vfio_get_iommu_type(VFIOContainer *container,
>>>                                 Error **errp)
>>>  {
>>> -    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>>> -                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
>>> +    static const struct {
>>> +        int type;
>>> +        const char *name;
>>> +    } iommu[] = {
>>> +        {VFIO_TYPE1v2_IOMMU, "Type1 (v2)"},
>>> +        {VFIO_TYPE1_IOMMU, "Type1 (v1)"},
>>> +        {VFIO_SPAPR_TCE_v2_IOMMU, "sPAPR TCE (v2)"},
>>> +        {VFIO_SPAPR_TCE_IOMMU, "sPAPR TCE (v1)"}
>>> +    };
>>>      int i;
>>>  
>>> -    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
>>> -        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
>>> -            return iommu_types[i];
>>> +    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
>>> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
>>> +            trace_vfio_get_iommu_type(iommu[i].name);
>>> +            return iommu[i].type;
>>>          }
>>>      }
>>> +    trace_vfio_get_iommu_type("Not available or not supported");
>>>      error_setg(errp, "No available IOMMU models");
>>>      return -EINVAL;
>>>  }
>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>> index b1ef55a33f..d3f1e48618 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -115,6 +115,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>>>  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>>>  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
>>>  vfio_dma_unmap_overflow_workaround(void) ""
>>> +vfio_get_iommu_type(const char *type) "IOMMU type: %s"
>>>  
>>>  # platform.c
>>>  vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
>>>   
>>
>> Applied to my trivial-patches branch.
> 
> I was not actually a fan of this patch:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08144.html
> 
> I don't think the convenience to the trace user to avoid looking up the
> type string in the header is worth the bloat to the non-trace user to
> declare these strings in the code.  Thanks,

Yep, planned to send simpler v3 but re-prioritize stuffs...


