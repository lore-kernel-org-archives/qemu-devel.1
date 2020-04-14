Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18737C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE88D20767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKLGo7zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE88D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOHzJ-0006XI-2V
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOHyd-0005mv-2s
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOHyZ-0005iX-In
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:35:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOHyZ-0005iI-FA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586856927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVcFMZZBtPQE3+kS5ZueLyR/9d3HwNBV2CXwHLqUy3E=;
 b=TKLGo7zOQ6Re2C04Iy8Tqor+mHod9HfrUNlBMi7DZ27ruB6lYD4zKCrQMx8SG5zIkSAl2c
 WqFUA1NCX8f+FEXUqxKvbXPPq7AHVwylKvfBEUg25stqDHDCnqONCcy4mYQiITWtrgy5BE
 hosj95RTjkWP3GG1w9Y9jqheTllNzpc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-N65obfjdOSC8yzNA1F32kA-1; Tue, 14 Apr 2020 05:35:25 -0400
X-MC-Unique: N65obfjdOSC8yzNA1F32kA-1
Received: by mail-wr1-f69.google.com with SMTP id t8so8308076wrq.22
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 02:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SVcFMZZBtPQE3+kS5ZueLyR/9d3HwNBV2CXwHLqUy3E=;
 b=NQGk8kV+vzGoF9rYtc19rdc7gL38GcHEWYIESKvJLr+nfXf69mZ7LL8d1zl1J1AfH/
 HqPmgsF3tBPf5MaaEhsjSsepboIOWB3zvP/UogYkCcSTkx1d3PJJ+ThPl57peuwvTaUG
 c7yHGxymy2e350Tlb+3qL7eP392Xwsr9Q9RucImozF7KXWz929DFxXFIe5gWS1N1kwt9
 CeiJjFg7NstYxI60xK39Tlm7/Om46xpU5EZT8HEooiA8fm1bjYxx6XqEBaWrKDLAOcOp
 ygJyVuG6C9hp2uzP1S/4snTCllrnB2iuehcYWwZKg1Gt3QXNWDe4eWERuKJgSw1Oejxv
 vCRQ==
X-Gm-Message-State: AGi0PuYClruGT2Il/62dogICzOskTByYVJGf/ck6ZEF7/m9fq5lC68qW
 rC6cxP3bQ1RDgcwjBaW+OwJRBfGfxwkgBdZ11/Jkx0FOUrgUHjcJZ1i8iUNee/q6PDFq4MobujY
 akX8tJhWsQoGTP5Q=
X-Received: by 2002:a5d:4012:: with SMTP id n18mr20396048wrp.387.1586856924073; 
 Tue, 14 Apr 2020 02:35:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJtPwl8WcsFLkro3HJD2E6QSyA+vLB59Sl2ngJWw7Bb1Are8E1Lvxa2MIefz6TxtuETxUm7JQ==
X-Received: by 2002:a5d:4012:: with SMTP id n18mr20396030wrp.387.1586856923899; 
 Tue, 14 Apr 2020 02:35:23 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n6sm17375870wmc.28.2020.04.14.02.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 02:35:23 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>, qemu-devel@nongnu.org
References: <20200413063627.84608-1-yan.y.zhao@intel.com>
 <20200413063713.84659-1-yan.y.zhao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <36cbf8f3-65e6-936f-6278-ab45dc470b02@redhat.com>
Date: Tue, 14 Apr 2020 11:35:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413063713.84659-1-yan.y.zhao@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, alex.williamson@redhat.com,
 Xin Zeng <xin.zeng@intel.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 8:37 AM, Yan Zhao wrote:
> for ram device regions, drop guest writes if the regions is read-only.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>   memory.c     | 6 +++++-
>   trace-events | 2 +-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 601b749906..a380b59980 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1312,7 +1312,11 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>   {
>       MemoryRegion *mr = opaque;
>   
> -    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
> +    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data,
> +                                         size, mr->readonly);
> +    if (mr->readonly) {

            qemu_log_mask(LOG_GUEST_ERROR, ...)?

> +        return;
> +    }
>   
>       switch (size) {
>       case 1:
> diff --git a/trace-events b/trace-events
> index 42107ebc69..e1de662973 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -61,7 +61,7 @@ memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value,
>   memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
>   memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
>   memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> +memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, bool readonly) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u" " is_readonly_region=%d"
>   flatview_new(void *view, void *root) "%p (root %p)"
>   flatview_destroy(void *view, void *root) "%p (root %p)"
>   flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
> 


