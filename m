Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B1BC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6589C2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCQBPnMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6589C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkBk-0001cS-Ip
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFkAq-0000YQ-HL
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:25:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFkAo-0007CF-KP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599596701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jt+EoWhGkGewVzY1REwvtTX22XtGx0i7DYvd5K+toJk=;
 b=cCQBPnMopBNLi9d9PPsdYw0DblTFwvIiBhGMah6AxvbEb2wHu7pAWolkHSUxAiJhSq5aP+
 0mlxXGQMey/sxhMBXDfMF5EuQo84n77Wz2sXXinOvX5Q54dxMaDxtmPsR1KtjqDJUiHYrw
 M182rpksRV4HC2xj2BmQ82eNti/LJKQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-gnKCd0BZNLiBIa0DYjKpCw-1; Tue, 08 Sep 2020 16:25:00 -0400
X-MC-Unique: gnKCd0BZNLiBIa0DYjKpCw-1
Received: by mail-wr1-f71.google.com with SMTP id i10so55691wrq.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jt+EoWhGkGewVzY1REwvtTX22XtGx0i7DYvd5K+toJk=;
 b=ouNNljenEbzRFF7pmlS49hiNYS10qLYKYoOZ1WfLsSUFr5zhyPgPgpW+LvDGb9bdYg
 ZbHIzxZpCIeHqCBHRpfZdis5WS/QMxuXCOrjdEPmyJgUyyRiehiARz/Wf0AGn/A26/Y0
 saimYPm+7aDsvlLCzbcC7COdXFPg3u4PsZQ4Rlt+kTUoi3wbhg6UREO/pY065ESTh0FY
 OlBaxcppKGZCczIrpFeEO0nfEifQHbxWKwSkh29vGbg3l3NZ9n2desCg8S1dflw5+6Jx
 It3Wlq8B+2q5UYIcZyXGfTSZ1OcNNXy8CseNChKS7gpl9t3lyO3vgBM4gTVeSugMm0nE
 IH8Q==
X-Gm-Message-State: AOAM5335p8PyrUHA1H7V4FHC7ShPxt4fYdeLaQjRtzLpm5W59Bwogkj0
 dJZrFcMPlenwlvRxHpG12xISDPecnwD7jfELIluyy/qb6mpRxIoupPATRqJDvdKs3SPEGMdfGfT
 ADH/GyYIsGOHVK3s=
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr173853wmc.100.1599596698911; 
 Tue, 08 Sep 2020 13:24:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP7EI3DjClAjfk7k4WjJJn72SxAs6mAhZxe+RQaqnNMjMQWiLT7oLd02H8pUK3MebKwYyRGQ==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr173832wmc.100.1599596698615; 
 Tue, 08 Sep 2020 13:24:58 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a83sm597475wmh.48.2020.09.08.13.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 13:24:58 -0700 (PDT)
Subject: Re: [PATCH] memory: Convert IOMMUMemoryRegionClass doc comment to
 kernel-doc
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200908201129.3407568-1-ehabkost@redhat.com>
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
Message-ID: <638d74f2-3086-8ac0-7403-d8d9f8176dfc@redhat.com>
Date: Tue, 8 Sep 2020 22:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908201129.3407568-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 10:11 PM, Eduardo Habkost wrote:
> Convert the existing documentation comments of
> IOMMUMemoryRegionClass to kernel-doc format so their contents
> will appear in the API reference at docs/devel/memory.html.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/exec/memory.h | 52 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index f1bb2a7df5..c01475a4e9 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -211,7 +211,7 @@ enum IOMMUMemoryRegionAttr {
>      IOMMU_ATTR_SPAPR_TCE_FD
>  };
>  
> -/*
> +/**
>   * IOMMUMemoryRegionClass:
>   *
>   * All IOMMU implementations need to subclass TYPE_IOMMU_MEMORY_REGION
> @@ -228,8 +228,11 @@ enum IOMMUMemoryRegionAttr {
>   * attributes and the output TLB entry depends on the transaction
>   * attributes, we represent this using IOMMU indexes. Each index
>   * selects a particular translation table that the IOMMU has:
> + *
>   *   @attrs_to_index returns the IOMMU index for a set of transaction attributes
> + *
>   *   @translate takes an input address and an IOMMU index
> + *
>   * and the mapping returned can only depend on the input address and the
>   * IOMMU index.
>   *
> @@ -238,10 +241,13 @@ enum IOMMUMemoryRegionAttr {
>   * for secure transactions and one for non-secure transactions.
>   */
>  struct IOMMUMemoryRegionClass {
> -    /* private */
> +    /* private: */
>      MemoryRegionClass parent_class;
>  
> -    /*
> +    /* public: */
> +    /**
> +     * @translate:
> +     *
>       * Return a TLB entry that contains a given address.
>       *
>       * The IOMMUAccessFlags indicated via @flag are optional and may
> @@ -262,26 +268,38 @@ struct IOMMUMemoryRegionClass {
>       * information when the IOMMU mapping changes.
>       *
>       * @iommu: the IOMMUMemoryRegion
> +     *
>       * @hwaddr: address to be translated within the memory region
> -     * @flag: requested access permissions
> +     *
> +     * @flag: requested access permission
> +     *
>       * @iommu_idx: IOMMU index for the translation
>       */
>      IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
>                                 IOMMUAccessFlags flag, int iommu_idx);
> -    /* Returns minimum supported page size in bytes.
> +    /**
> +     * @get_min_page_size:
> +     *
> +     * Returns minimum supported page size in bytes.
> +     *
>       * If this method is not provided then the minimum is assumed to
>       * be TARGET_PAGE_SIZE.
>       *
>       * @iommu: the IOMMUMemoryRegion
>       */
>      uint64_t (*get_min_page_size)(IOMMUMemoryRegion *iommu);
> -    /* Called when IOMMU Notifier flag changes (ie when the set of
> +    /**
> +     * @notify_flag_changed:
> +     *
> +     * Called when IOMMU Notifier flag changes (ie when the set of
>       * events which IOMMU users are requesting notification for changes).
>       * Optional method -- need not be provided if the IOMMU does not
>       * need to know exactly which events must be notified.
>       *
>       * @iommu: the IOMMUMemoryRegion
> +     *
>       * @old_flags: events which previously needed to be notified
> +     *
>       * @new_flags: events which now need to be notified
>       *
>       * Returns 0 on success, or a negative errno; in particular
> @@ -293,7 +311,10 @@ struct IOMMUMemoryRegionClass {
>                                 IOMMUNotifierFlag old_flags,
>                                 IOMMUNotifierFlag new_flags,
>                                 Error **errp);
> -    /* Called to handle memory_region_iommu_replay().
> +    /**
> +     * @replay:
> +     *
> +     * Called to handle memory_region_iommu_replay().
>       *
>       * The default implementation of memory_region_iommu_replay() is to
>       * call the IOMMU translate method for every page in the address space
> @@ -310,7 +331,10 @@ struct IOMMUMemoryRegionClass {
>       */
>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
>  
> -    /* Get IOMMU misc attributes. This is an optional method that
> +    /**
> +     * @get_attr:
> +     *
> +     * Get IOMMU misc attributes. This is an optional method that
>       * can be used to allow users of the IOMMU to get implementation-specific
>       * information. The IOMMU implements this method to handle calls
>       * by IOMMU users to memory_region_iommu_get_attr() by filling in
> @@ -319,7 +343,9 @@ struct IOMMUMemoryRegionClass {
>       * memory_region_iommu_get_attr() will always return -EINVAL.
>       *
>       * @iommu: the IOMMUMemoryRegion
> +     *
>       * @attr: attribute being queried
> +     *
>       * @data: memory to fill in with the attribute data
>       *
>       * Returns 0 on success, or a negative errno; in particular
> @@ -328,7 +354,10 @@ struct IOMMUMemoryRegionClass {
>      int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr attr,
>                      void *data);
>  
> -    /* Return the IOMMU index to use for a given set of transaction attributes.
> +    /**
> +     * @attrs_to_index:
> +     *
> +     * Return the IOMMU index to use for a given set of transaction attributes.
>       *
>       * Optional method: if an IOMMU only supports a single IOMMU index then
>       * the default implementation of memory_region_iommu_attrs_to_index()
> @@ -341,7 +370,10 @@ struct IOMMUMemoryRegionClass {
>       */
>      int (*attrs_to_index)(IOMMUMemoryRegion *iommu, MemTxAttrs attrs);
>  
> -    /* Return the number of IOMMU indexes this IOMMU supports.
> +    /**
> +     * @num_indexes:
> +     *
> +     * Return the number of IOMMU indexes this IOMMU supports.
>       *
>       * Optional method: if this method is not provided, then
>       * memory_region_iommu_num_indexes() will return 1, indicating that
> 


