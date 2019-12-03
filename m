Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EC7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E15206DC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="AsfrtPnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E15206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibywl-000214-TN
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 22:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ibyw0-0001Ti-Tz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ibyvz-0003ae-3R
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:33:08 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ibyvy-0003Wc-Dn
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:33:07 -0500
Received: by mail-pg1-x544.google.com with SMTP id x7so970728pgl.11
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 19:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RHQ3bfkztbI1GsqkKPNKTs5d8XzxE6NAsYnqSou7r30=;
 b=AsfrtPnKN9zCtX8cyxk8+fOI7s2mNX+UKzbWbgDShHBB7d4M8VAberva2Ci24+dbTb
 T8h67izyfzVhKOpKlksXopPBsaVMDuHymQKVn8RnteNFMzbLl2IoNvD2rZQC8xgu8Mlj
 eFZn+gQy/syNuhG5/thS1NSpG5sXb0eMnC2nzNf84IVBk7tKIMMQFUtz+gJPXquBJDhZ
 1SiqCJu+qLAyEDzeHMkEE/gH+c53UQA4uA9rzJo5UBHnmvrctEdnCTfcx9VjEg4j+nJz
 /bIprwbHfTxAyWofjXHTiv3MIZGXaMfUeM4pMNuy+451y+8DG8dEQMqpF04tUVrDtunw
 CfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RHQ3bfkztbI1GsqkKPNKTs5d8XzxE6NAsYnqSou7r30=;
 b=ARnS99GNujOd6bGe4Goq1pjq4I3v5uv6zTSilclepZSYV2Q+5gW+7efrlt6g/ChNnZ
 WFmnxeVQVWScR0xg7B2KuEZmAefDZVGXaVnTpfQTJ8OcYQhGgS/0h+J9l8Ez1+xOJkLg
 MGxZldtQhuBLEH6kSO93iNAfkCAVSC8yoF4iKoC/X9jBWYT4QwIY3W2y2j4J4cqzPt57
 /lYAwJb7SNNMLesNpMgaOPDt9zTgRoS8ykC8G7tZ1Ib0u03gJ6uSYPRyr7AzhYJhCDCp
 g19RELZG3CvCebc3cGXcTRnfVp1ZpC6r4bFiuHYlCBznOwuxdwZK2+nb1HiZM8yLnK3M
 ZKQg==
X-Gm-Message-State: APjAAAUmgo0xkL3HQVG+6sfdKNUwl/N0LGPtSVEajH8aRyFZYwDq00Jo
 tIZ8/mMW7TXP8EdiCbxhNQ/3cUwGJKQ=
X-Google-Smtp-Source: APXvYqweZALG4S8IwqZdeePs0raxWKgY/MJQWuFA+BgfYBuE7l6ySAHLJRpIi8f8cK59SfdaO4g5mw==
X-Received: by 2002:a65:654e:: with SMTP id a14mr3028647pgw.170.1575343984218; 
 Mon, 02 Dec 2019 19:33:04 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f18sm1030208pfk.124.2019.12.02.19.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 19:33:03 -0800 (PST)
Subject: Re: [for-5.0 1/4] spapr,ppc: Simplify signature of kvmppc_rma_size()
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
 <20191129013504.145455-2-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <f70c476b-4329-c62f-38ed-0c57137fc93b@ozlabs.ru>
Date: Tue, 3 Dec 2019 14:32:59 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129013504.145455-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 29/11/2019 12:35, David Gibson wrote:
> This function calculates the maximum size of the RMA as implied by the
> host's page size of structure of the VRMA (there are a number of other
> constraints on the RMA size which will supersede this one in many
> circumstances).
> 
> The current interface takes the current RMA size estimate, and clamps it
> to the VRMA derived size.  The only current caller passes in an arguably
> wrong value (it will match the current RMA estimate in some but not all
> cases).
> 
> We want to fix that, but for now just keep concerns separated by having the
> KVM helper function just return the VRMA derived limit, and let the caller
> combine it with other constraints.  We call the new function
> kvmppc_vrma_limit() to more clearly indicate its limited responsibility.
> 
> The helper should only ever be called in the KVM enabled case, so replace
> its !CONFIG_KVM stub with an assert() rather than a dummy value.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Besides not compiling, otherwise looks good.


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




> ---
>  hw/ppc/spapr.c       | 5 +++--
>  target/ppc/kvm.c     | 5 ++---
>  target/ppc/kvm_ppc.h | 7 +++----
>  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d9c9a2bcee..069bd04a8d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1635,8 +1635,9 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
>      spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
>  
>      if (spapr->vrma_adjust) {
> -        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(MACHINE(spapr)),
> -                                          spapr->htab_shift);
> +        hwaddr vrma_limit = kvmppc_vrma_limit(spapr->htab_shift);
> +
> +        spapr->rma_size = MIN(spapr_node0_size(MACHINE(spapr)), vrma_limit);
>      }
>  }
>  
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c77f9848ec..09b3bd6443 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2101,7 +2101,7 @@ void kvmppc_hint_smt_possible(Error **errp)
>  
>  
>  #ifdef TARGET_PPC64
> -uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
> +uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
>  {
>      struct kvm_ppc_smmu_info info;
>      long rampagesize, best_page_shift;
> @@ -2128,8 +2128,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
>          }
>      }
>  
> -    return MIN(current_size,
> -               1ULL << (best_page_shift + hash_shift - 7));
> +    return 1ULL << (best_page_shift + hash_shift - 7));
>  }
>  #endif
>  
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5da6..4f0eec4c1b 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -45,7 +45,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
>                                int *pfd, bool need_vfio);
>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
>  int kvmppc_reset_htab(int shift_hint);
> -uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
> +uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
>  bool kvmppc_has_cap_spapr_vfio(void);
>  #endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
> @@ -241,10 +241,9 @@ static inline int kvmppc_reset_htab(int shift_hint)
>      return 0;
>  }
>  
> -static inline uint64_t kvmppc_rma_size(uint64_t current_size,
> -                                       unsigned int hash_shift)
> +static inline uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
>  {
> -    return ram_size;
> +    g_assert_not_reached();
>  }
>  
>  static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
> 

-- 
Alexey

