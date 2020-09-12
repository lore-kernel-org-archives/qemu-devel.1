Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCDFC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D03F20855
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="froCR7oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D03F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGyf4-0004ga-8U
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 02:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyeO-0004Ej-Fj
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyeM-0001mQ-6H
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599890676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixUpFMVZYn0dozVvBLk0ahZBqQvs5xK5vfGsdfRd3KU=;
 b=froCR7ooUS7InmPree1IDpyNC0XbCW4zeOGFCkUiR/Nf/oT1vfD5nzgHB4PQa8hTJKdMex
 OXFq04qgvN+GE/45D7AkbNloFkoAleNe+a37mHwVxZEWctX9WRihaT1r6pSEex3DE7R6jt
 nugMv/ieVYOLXgu9vXVyALz2U/wdrOY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-0FITFCeuNU254TF5Bq37Fg-1; Sat, 12 Sep 2020 02:03:54 -0400
X-MC-Unique: 0FITFCeuNU254TF5Bq37Fg-1
Received: by mail-wr1-f72.google.com with SMTP id o6so4060432wrp.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 23:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ixUpFMVZYn0dozVvBLk0ahZBqQvs5xK5vfGsdfRd3KU=;
 b=WqxZLQ0djrEOZla/A8l0sbIt2oVDjJwWpjxwe5l2DcwU/nXXOKbJiHXNnMt5hvW6+F
 DSZgtsYxe8uM/Qgbjd+lG5tqucIUIot1lqQEUNKlScbT21xWo4Wi8Ge7iEYH1vRUkIFz
 pz8Lz8tHTltVMA8d6VmeKyIh1eLjcGi8Dp6l53zqKy/f1Ye5HQdX+I0oZTHewAQ5nkdC
 vtlMdX2HA3rBIdYWTh/yyBeB5HpV9rlSJ9l7DX9oneXD0klnuUNJ8HI+fDRIz+WCSo3N
 oNBxBcvy2QRpLOFSa32qPGNRVzjgpDSRH+TGQf1HV28KaehyrAcwjJsr4dJ7rom7I8q+
 1QrQ==
X-Gm-Message-State: AOAM531nkJnRileWLQmQkQCLNDIkeBzZerHwE5wS63M927F6UZH3MApS
 zeHf9B/hJnwfCEMUtJaF2sx9sIE9f3uuUfkMxQwU2NzMA9JypB7+zkr8f6emw8zKJA60edqR14u
 vlMu9I1McR7NOcIM=
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr5295574wrm.174.1599890633462; 
 Fri, 11 Sep 2020 23:03:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmFabIJ55307wwrfVPk/dCtLaufyYczLRODkdW4fiLbBHxyh7iikHdKrTt6FyfB3OF8fzNqQ==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr5295554wrm.174.1599890633197; 
 Fri, 11 Sep 2020 23:03:53 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id g12sm8551106wro.89.2020.09.11.23.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 23:03:52 -0700 (PDT)
Subject: Re: [PATCH] memory: Convert IOMMUMemoryRegionClass doc comment to
 kernel-doc
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200908201129.3407568-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c4ceb41-81be-0775-ead0-971fd5398e4f@redhat.com>
Date: Sat, 12 Sep 2020 08:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908201129.3407568-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:04:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 22:11, Eduardo Habkost wrote:
> Convert the existing documentation comments of
> IOMMUMemoryRegionClass to kernel-doc format so their contents
> will appear in the API reference at docs/devel/memory.html.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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

Queued, thanks.

Paolo


