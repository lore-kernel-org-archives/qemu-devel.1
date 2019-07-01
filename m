Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA4C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBE820881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBE820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtAD-0000oc-AZ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55456)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hht5A-0006Nd-M8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hht59-0007sg-Kp
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:58:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hht59-0007rh-CF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:58:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so13049938wrw.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YtzbtwJeSmY2r9CQ/aodjkBS7oniY9D5Gqhkb0tm5cE=;
 b=giDkt4r/gOU7aYZJpWyHOg0+IdBBvo06cSdhJREcBLUEm74LI3jIOa7TCsuwLqRLK6
 0x+3AbOrwwHT9/9Y2XWG1uEnqlfwJqGJdl11J3ypNVyRng2KTMs7jq0p3SyapPmyleES
 fTP841uD6bM9JLbPpFlQ9aXcOOngR/ltyBUR+5OGANXI9noYo+FGLa8abBPFTPyGZmAU
 eNJ53gR8foz42mHNnSxXWanWRCnFwzxhM2zHAXrHPEPAKzphzhQgUMzrbmY2THSziQOq
 9NlPFhSti84ExvES26jC3b5iyTfgmSi/roXLG/NL6XknI7SlXUsYINMMWUja9S/pRm+8
 8YHw==
X-Gm-Message-State: APjAAAVKM9D3vSFq+LHHvfK5AitkIiZ8U9BYKZu1vEM5DKzCQPfWoPmx
 v6Che63xuXNYoI5Jtx8dWPTWag==
X-Google-Smtp-Source: APXvYqwKPq4o6BdbfcPYV5Grns1CLYdlDMyGRTX17BjMbMCVWatU52xF/A9sDYxcxCgq4zKrofktEg==
X-Received: by 2002:adf:82a8:: with SMTP id 37mr8172535wrc.332.1561975122450; 
 Mon, 01 Jul 2019 02:58:42 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t15sm8826375wrx.84.2019.07.01.02.58.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 02:58:41 -0700 (PDT)
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 peterx@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com
References: <20190701093034.18873-1-eric.auger@redhat.com>
 <20190701093034.18873-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ca989a2a-05db-4222-7068-9d294f0434f7@redhat.com>
Date: Mon, 1 Jul 2019 11:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701093034.18873-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 1/6] memory: Remove unused
 memory_region_iommu_replay_all()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 11:30 AM, Eric Auger wrote:
> memory_region_iommu_replay_all is not used. Remove it.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/memory.h | 10 ----------
>  memory.c              |  9 ---------
>  2 files changed, 19 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e6140e8a04..bdd76653a8 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1076,16 +1076,6 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
>   */
>  void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n);
>  
> -/**
> - * memory_region_iommu_replay_all: replay existing IOMMU translations
> - * to all the notifiers registered.
> - *
> - * Note: this is not related to record-and-replay functionality.
> - *
> - * @iommu_mr: the memory region to observe
> - */
> -void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr);
> -
>  /**
>   * memory_region_unregister_iommu_notifier: unregister a notifier for
>   * changes to IOMMU translation entries.
> diff --git a/memory.c b/memory.c
> index 0a089a73ae..290a1493ef 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1910,15 +1910,6 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      }
>  }
>  
> -void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr)
> -{
> -    IOMMUNotifier *notifier;
> -
> -    IOMMU_NOTIFIER_FOREACH(notifier, iommu_mr) {
> -        memory_region_iommu_replay(iommu_mr, notifier);
> -    }
> -}
> -
>  void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>                                               IOMMUNotifier *n)
>  {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

