Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6135C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5115207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IL2JHV30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5115207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnH6-00071D-RX
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnGC-0005Rk-5w
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:37:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnGB-00089i-6F
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lo/QiGpjGQh/rEUv/c2ZZ/JePZfgdN5OiHqyDyT3Ppc=;
 b=IL2JHV30c1zuHqum8M6wb6Xw+weThdTXNcjE9wi23ephE57NgMjsgR5Qh6Y4WOBsrBy+xn
 4uNyYOuA/boeB1tdVtRaEjT2iK5C7b1ALu9QFmPNUnsW7jhy7EtiYm3RIIkLdCv3QwTpLu
 y4+QnifwdbRYs/UMBtZIjpxFOci0Y4Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-a_2htYwJPliXLjLme_AmWQ-1; Thu, 21 May 2020 11:37:25 -0400
X-MC-Unique: a_2htYwJPliXLjLme_AmWQ-1
Received: by mail-wm1-f70.google.com with SMTP id f9so2816937wml.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lo/QiGpjGQh/rEUv/c2ZZ/JePZfgdN5OiHqyDyT3Ppc=;
 b=s81ebQfTBLQov7GKK+98xc3RmLVrvCYS9jnXTZYm+DUof1taSD32b1NHSk6C9vICnZ
 mi5S/9F+g+E98PN8g/SGHF/JuiUlyNqCr0S3z9qGviv9yLIYqCOaKG8r3i5plY/38p8p
 eCGslMjol2cBwn+yEYxnjFRcuY0mEyzDk8r91apTJeLKSZ1HE1k1WLtoMkDERlEPS+jP
 c8WQ4twBJTyvdCL61714iBEVHxbtD2quyynynihU/EJF+dKJxcMoBxvkVK/55cG6W2g7
 YZAJfyvj7ABVLdhva2Zz4oQ+faGVOhssVHJ+y3AoZLLHeio7FM7/12HmKfXlC3lkWYca
 iyJw==
X-Gm-Message-State: AOAM530a5QRcmtyzuo56/dUd1DjfK4NZI8qXcddIJPPh1Acf6u7koUOd
 F6gft8Yj+T6+UeXeh8WWiSSoJbBTF6ZU3AaKI8mWFP24Qdd510kVeBlL/Qq9NtBglEeWntqLaeb
 oJKquIZZgRBqelPs=
X-Received: by 2002:adf:b34e:: with SMTP id k14mr4410573wrd.109.1590075443534; 
 Thu, 21 May 2020 08:37:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/UPMDyY8i7aXcjYhJGoPrwqYPb6Rbb/0vMmzpjn2sS5GGQ6wd2yNeeoJBhzuZ5Kz9bpZiJw==
X-Received: by 2002:adf:b34e:: with SMTP id k14mr4410552wrd.109.1590075443260; 
 Thu, 21 May 2020 08:37:23 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id b145sm7416167wme.41.2020.05.21.08.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:37:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] exec/memory: Let address_space_read/write_cached()
 propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200517164817.5371-1-f4bug@amsat.org>
 <20200517164817.5371-2-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <485e95c2-1663-aa43-bf22-7bc3f6935fcf@redhat.com>
Date: Thu, 21 May 2020 17:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200517164817.5371-2-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/05/20 18:48, Philippe Mathieu-Daudé wrote:
> Both address_space_read_cached_slow() and
> address_space_write_cached_slow() return a MemTxResult type.
> Do not discard it, return it to the caller.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/exec/memory.h | 19 +++++++++++--------
>  exec.c                | 16 ++++++++--------
>  2 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e000bd2f97..5e8c009169 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2343,10 +2343,11 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
>  
>  /* Internal functions, part of the implementation of address_space_read_cached
>   * and address_space_write_cached.  */
> -void address_space_read_cached_slow(MemoryRegionCache *cache,
> -                                    hwaddr addr, void *buf, hwaddr len);
> -void address_space_write_cached_slow(MemoryRegionCache *cache,
> -                                     hwaddr addr, const void *buf, hwaddr len);
> +MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
> +                                           hwaddr addr, void *buf, hwaddr len);
> +MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
> +                                            hwaddr addr, const void *buf,
> +                                            hwaddr len);
>  
>  static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
>  {
> @@ -2411,15 +2412,16 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
>   * @buf: buffer with the data transferred
>   * @len: length of the data transferred
>   */
> -static inline void
> +static inline MemTxResult
>  address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
>                            void *buf, hwaddr len)
>  {
>      assert(addr < cache->len && len <= cache->len - addr);
>      if (likely(cache->ptr)) {
>          memcpy(buf, cache->ptr + addr, len);
> +        return MEMTX_OK;
>      } else {
> -        address_space_read_cached_slow(cache, addr, buf, len);
> +        return address_space_read_cached_slow(cache, addr, buf, len);
>      }
>  }
>  
> @@ -2431,15 +2433,16 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
>   * @buf: buffer with the data transferred
>   * @len: length of the data transferred
>   */
> -static inline void
> +static inline MemTxResult
>  address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
>                             const void *buf, hwaddr len)
>  {
>      assert(addr < cache->len && len <= cache->len - addr);
>      if (likely(cache->ptr)) {
>          memcpy(cache->ptr + addr, buf, len);
> +        return MEMTX_OK;
>      } else {
> -        address_space_write_cached_slow(cache, addr, buf, len);
> +        return address_space_write_cached_slow(cache, addr, buf, len);
>      }
>  }
>  
> diff --git a/exec.c b/exec.c
> index 5162f0d12f..877b51cc5c 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3716,7 +3716,7 @@ static inline MemoryRegion *address_space_translate_cached(
>  /* Called from RCU critical section. address_space_read_cached uses this
>   * out of line function when the target is an MMIO or IOMMU region.
>   */
> -void
> +MemTxResult
>  address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>                                     void *buf, hwaddr len)
>  {
> @@ -3726,15 +3726,15 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>      l = len;
>      mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
>                                          MEMTXATTRS_UNSPECIFIED);
> -    flatview_read_continue(cache->fv,
> -                           addr, MEMTXATTRS_UNSPECIFIED, buf, len,
> -                           addr1, l, mr);
> +    return flatview_read_continue(cache->fv,
> +                                  addr, MEMTXATTRS_UNSPECIFIED, buf, len,
> +                                  addr1, l, mr);
>  }
>  
>  /* Called from RCU critical section. address_space_write_cached uses this
>   * out of line function when the target is an MMIO or IOMMU region.
>   */
> -void
> +MemTxResult
>  address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>                                      const void *buf, hwaddr len)
>  {
> @@ -3744,9 +3744,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>      l = len;
>      mr = address_space_translate_cached(cache, addr, &addr1, &l, true,
>                                          MEMTXATTRS_UNSPECIFIED);
> -    flatview_write_continue(cache->fv,
> -                            addr, MEMTXATTRS_UNSPECIFIED, buf, len,
> -                            addr1, l, mr);
> +    return flatview_write_continue(cache->fv,
> +                                   addr, MEMTXATTRS_UNSPECIFIED, buf, len,
> +                                   addr1, l, mr);
>  }
>  
>  #define ARG1_DECL                MemoryRegionCache *cache
> 

Queued patch 1, thanks.

Paolo


