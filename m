Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F95C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8933B206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdDzsBxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8933B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI4FL-0005M1-Le
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 02:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kI4Eb-0004uy-62
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:14:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50387
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kI4EZ-0003mM-H6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600150470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XzH06oxUxO/xc1h4ZZpQYTzN39TDe8o6dWOtunp6qbY=;
 b=QdDzsBxWTFnBP9NQVmEJ8ZM507DK9hBGHYlcwmdTwcRGq4BHwzXwVAYIt7E1flgssK/yvD
 DJw/NIOntIk2nz96GQHHze3c4GupvyK+mnLtVENAHnZIsbRB+MjGs4UYK70sVWAqU7QmZf
 mkQeXzP185acVv7sA0wfBvufhjbCoPk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-squVBAffMrqrzVqeuJuO0w-1; Tue, 15 Sep 2020 02:14:28 -0400
X-MC-Unique: squVBAffMrqrzVqeuJuO0w-1
Received: by mail-wr1-f71.google.com with SMTP id a10so777877wrw.22
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 23:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XzH06oxUxO/xc1h4ZZpQYTzN39TDe8o6dWOtunp6qbY=;
 b=Kf2j+EaqLPSfOhKnbpUrqIAeJILAU4eWUQGobe1XnjGv4KJlB45WzGL6mvDqLjVrP2
 e8QdN1LwsTmdrqgWJ873cUthfXQlmlLwyLOMCUuHI3V2nUNPBYMH2ZxXNSYhnb6pHJvp
 Yfau06nWj2xsDb1pOfSPHv3dnc08NwwTYWOINXsdzi/yQw3wDPM8l4+oPYXq7hpbl6WU
 NcZ+zQUVOKd3S8OJH0Ry2smK3JZMm9KgBOdokaYx1l13nepZpZWI5TQWSe4ae7P2shvF
 8vGPTELDvBwsydIGE10mOA1ARAh2LjbdoQ2g4HsjddkUARH7N2uV1G/3g1gA+CL3CIn1
 yC+Q==
X-Gm-Message-State: AOAM5302Jgn1sW0c3ugnjhFyR2QH9PhqLHAp7vtm5Rds7gPqYLFUO7Pt
 29IPkW5f+CwOY1h2nahXEPt3aAgzDUqIzCEnvjY0vUYIDCUQ9RlYcQPzxaB9qjpocbUGMIerI+V
 DolyKTJopyDmaVQY=
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr2963749wme.102.1600150467437; 
 Mon, 14 Sep 2020 23:14:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3/wP284OMPNCEmfKXTLz1EpacbQU7XqkLqWCtApExhXa4Ot1P7TKenr5Zi887J0VKX4PK+A==
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr2963728wme.102.1600150467216; 
 Mon, 14 Sep 2020 23:14:27 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y2sm22134191wmg.23.2020.09.14.23.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 23:14:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] vfio: Find DMA available capability
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-2-git-send-email-mjrosato@linux.ibm.com>
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
Message-ID: <fbd1df4e-8d51-87c8-2b07-5b65666342d0@redhat.com>
Date: Tue, 15 Sep 2020 08:14:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600122570-12941-2-git-send-email-mjrosato@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:14:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, schnelle@linux.ibm.com,
 david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Matthew,

On 9/15/20 12:29 AM, Matthew Rosato wrote:
> The underlying host may be limiting the number of outstanding DMA
> requests for type 1 IOMMU.  Add helper functions to check for the
> DMA available capability and retrieve the current number of DMA
> mappings allowed.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/vfio/common.c              | 37 +++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |  2 ++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 3335714..7f4a338 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -844,6 +844,43 @@ vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
>      return NULL;
>  }
>  
> +static struct vfio_info_cap_header *
> +vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
> +{
> +    struct vfio_info_cap_header *hdr;
> +    void *ptr = info;
> +
> +    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
> +        return NULL;
> +    }
> +
> +    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
> +        if (hdr->id == id) {
> +            return hdr;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
> +                             unsigned int *avail)
> +{
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_iommu_type1_info_dma_avail *cap;
> +
> +    /* If the capability cannot be found, assume no DMA limiting */
> +    hdr = vfio_get_iommu_type1_info_cap(info,
> +                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
> +    if (hdr == NULL || avail == NULL) {

If you expect the caller to use avail=NULL, then why
return false when there is available information?

> +        return false;
> +    }
> +
> +    cap = (void *) hdr;
> +    *avail = cap->avail;
> +    return true;
> +}
> +
>  static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>                                            struct vfio_region_info *info)
>  {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c78f3ff..661a380 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -178,6 +178,8 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>  void vfio_put_group(VFIOGroup *group);
>  int vfio_get_device(VFIOGroup *group, const char *name,
>                      VFIODevice *vbasedev, Error **errp);
> +bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
> +                             unsigned int *avail);
>  
>  extern const MemoryRegionOps vfio_region_ops;
>  typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
> 


