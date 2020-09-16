Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB71C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220692076B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JK7QUaOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220692076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIRgV-0003w7-7z
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIRfm-0003QN-8z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIRfj-0005EI-Vt
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600240567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YeskkhZrdYRC30aRDkN1HB5+YtMrgEAue+Oyyc6RWmM=;
 b=JK7QUaOjebzmelTLjOPdKJ28LUe+lXPXYymTvpydI6F/HPxyDT+0WCp/v4KUAkFBOdvC4C
 SNrLVFb6lVpmE54tebXVVNfcGVr/QbyhNucXHCJ/AAitW9vE0f3unMbinL/Z7PH7TnBYgC
 FInWG5UlBY68Ix258hDFgcZFkdromKM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-ldRULAslOJe8Nx_7yTS8TA-1; Wed, 16 Sep 2020 03:16:02 -0400
X-MC-Unique: ldRULAslOJe8Nx_7yTS8TA-1
Received: by mail-wr1-f72.google.com with SMTP id l15so2180083wro.10
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YeskkhZrdYRC30aRDkN1HB5+YtMrgEAue+Oyyc6RWmM=;
 b=TwzqgKBqf0ddKJ4W4NwbOuCyJBhQHJzZ55JS/QuMAcf3Qd24fzMB7xhc3Z0vZVG/YJ
 IG8A6NstTUt+xx87apr3bciYW6Rbq9p7oPGoMYHGeZVOT/EkNwc9RllozEDdiZ+eEXkS
 Jwfa+Jh5/1/K4/G2dIXWSp/ZEeDtZ7HV8QRDFietNaQwwnfhJr1TYil6X0j6G8TKLpQ4
 yTlq13sBe/CW3hv7OVVuvI6hBxJ2UMS9Uk6LHk0+0uv35i4/UKQ8qu1Q7LB7djzhVAXA
 nC7Fk/hj5av5Fb3NLaE5ctIzZCpMX7wWfgs6jbgnxYWl9LLRlQ8BV4yBYC9rStwjZFxA
 ES+w==
X-Gm-Message-State: AOAM532FiDO2xy73qZIiEwQtX0znBczWQvMBSgIvE9AIFrWshsY8pLGB
 SLw+gnbMFGApEJiHZnXCcX1+PpepsuUJRqEMWrgbMqyAg0Q86bKF8bkt6ZrNXkjqKrCtQLJnm/m
 n6jBBnyk+tyzLOnc=
X-Received: by 2002:a5d:568d:: with SMTP id f13mr24570482wrv.303.1600240561725; 
 Wed, 16 Sep 2020 00:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq0noszoQVJzm1DolWidvEViQOZeYjUogYdFgbN9z6nyZ6FKwQGNCkB9JVIICEVejxkoml4w==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr24570450wrv.303.1600240561426; 
 Wed, 16 Sep 2020 00:16:01 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t15sm24849685wrp.20.2020.09.16.00.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 00:16:00 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] vfio: Create shared routine for scanning info
 capabilities
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
References: <1600197283-25274-1-git-send-email-mjrosato@linux.ibm.com>
 <1600197283-25274-3-git-send-email-mjrosato@linux.ibm.com>
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
Message-ID: <3ee0b4c6-865e-82b3-b003-64a4ddaab4b5@redhat.com>
Date: Wed, 16 Sep 2020 09:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600197283-25274-3-git-send-email-mjrosato@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 schnelle@linux.ibm.com, david@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 9:14 PM, Matthew Rosato wrote:
> Rather than duplicating the same loop in multiple locations,
> create a static function to do the work.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/vfio/common.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 3335714..eba7b55 100644
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
> @@ -844,6 +839,16 @@ vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
>      return NULL;
>  }
>  
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
>  static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>                                            struct vfio_region_info *info)
>  {
> 


