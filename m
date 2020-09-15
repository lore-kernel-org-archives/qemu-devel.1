Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A150CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C3720732
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtZghfhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C3720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI4I0-0006SM-Lx
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 02:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kI4H7-000607-Ud
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:17:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52526
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kI4H3-0004MP-5c
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600150624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C0UQmO+27YOKqBXPt++CUZUgQwVTyyou4t1I2CBH484=;
 b=HtZghfhMFCKPxBRYEx+3lCU5QolZIZlkgku8nSCgqkCun6NXJ3iqN4Cr4nnNUIGAkZClJK
 BJNHrcMqmKNMPhB4Rr9eiOK6ikwMiiqI/vj9p0JFGwMyy8ZgwhhsJkFgcr4Zey6u6RBh0s
 eOHcmRrDUqvKQeYl2uEvLfXh9jKwsts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-TJvbqh4CNB2YGcnZHzwhDQ-1; Tue, 15 Sep 2020 02:17:02 -0400
X-MC-Unique: TJvbqh4CNB2YGcnZHzwhDQ-1
Received: by mail-wm1-f70.google.com with SMTP id b20so1732784wmj.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 23:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=C0UQmO+27YOKqBXPt++CUZUgQwVTyyou4t1I2CBH484=;
 b=beHyG5UssBnE0v6r1Ennk3z88uXcSpclbsM8+CzW86ZLyaKBSyv5fZ1aq00g0G1xOl
 um7aNz97viUEnYkofuw53oFs+2GuOFBCpYweQLVV03FcD03dBo9eFylczjmFCgyeChtk
 LRUngurLZLrTsC5htu3q1ir2UUxDHnjREoy/8N39IOV95rXsnkdfjxVb5KtA8Uq6FAd7
 fvLjBd3+x5sLtVyWqFuPC8dOyIYJA4NWUPAFB/BxYOm/3+urfpnp65w43Ko2Ed5BsN4Y
 ozqlioFcF3CAojQY4a4ENqo987NkkLof1WwRQieKZgLBM2mN0NWylRYpszUEkgxxuW7M
 A09w==
X-Gm-Message-State: AOAM532PjbT9WH2Ra4ppg5rJ9/PjmBlECYDSAHcl1cLZSNAu7olxa+p9
 OUhQLNEsPX6RDbZOlCLuEgm8fcGr+EwpdA3LcwdKrxEVErcllO/XlmJShJWNM4dUZH2bofO/pwW
 qkJc7k5WSQWyfV08=
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr2717923wmf.47.1600150621547;
 Mon, 14 Sep 2020 23:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeV9nYUb37iRYHMcbVKeb4xceCKX9ufBLQihnWlvokIVsAvjlgb0V9Qv7eG5B4wnWiCzdh2Q==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr2717896wmf.47.1600150621376;
 Mon, 14 Sep 2020 23:17:01 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id s12sm15680272wmd.20.2020.09.14.23.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 23:17:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] vfio: Create shared routine for scanning info
 capabilities
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-4-git-send-email-mjrosato@linux.ibm.com>
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
Message-ID: <942e216a-f431-9eb2-c20b-e3733615601e@redhat.com>
Date: Tue, 15 Sep 2020 08:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600122570-12941-4-git-send-email-mjrosato@linux.ibm.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/20 12:29 AM, Matthew Rosato wrote:
> Rather than duplicating the same loop in multiple locations,
> create a static function to do the work.

Why not do that first in your series?

> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/vfio/common.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7f4a338..bfbbfe4 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -825,17 +825,12 @@ static void vfio_listener_release(VFIOContainer *container)
>      }
>  }
>  
> -struct vfio_info_cap_header *
> -vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
> +static struct vfio_info_cap_header *
> +vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id)
>  {
>      struct vfio_info_cap_header *hdr;
> -    void *ptr = info;
> -
> -    if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS)) {
> -        return NULL;
> -    }
>  
> -    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
> +    for (hdr = ptr + cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
>          if (hdr->id == id) {
>              return hdr;
>          }
> @@ -844,23 +839,25 @@ vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
>      return NULL;
>  }
>  
> +
> +struct vfio_info_cap_header *
> +vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
> +{
> +    if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS)) {
> +        return NULL;
> +    }
> +
> +    return vfio_get_cap((void *)info, info->cap_offset, id);
> +}
> +
>  static struct vfio_info_cap_header *
>  vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
>  {
> -    struct vfio_info_cap_header *hdr;
> -    void *ptr = info;
> -
>      if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
>          return NULL;
>      }
>  
> -    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
> -        if (hdr->id == id) {
> -            return hdr;
> -        }
> -    }
> -
> -    return NULL;
> +    return vfio_get_cap((void *)info, info->cap_offset, id);
>  }
>  
>  bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
> 


