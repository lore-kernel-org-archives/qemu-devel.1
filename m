Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA26C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E15F20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQCpdaA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E15F20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVywe-0000VE-W9
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyho-0006Mc-99
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyhj-0007K8-BD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603465804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCFiKM9r31iSz+0w3GgYriDALNKarg3PwnkOFLl/y2k=;
 b=IQCpdaA0++vUMTx5C9C9SFGI9m0Jc8cgieIov8mt8rDO4O6h7SUCtT0I2RzvlgzEUuH2nv
 lM11SlYX+moFoMpey1G5DODHQCjA6R30FIt2vQp7mG3uPMWbRtiKBhwKa8/cIqPU/eElZ5
 y9THOfYxzskvG+4lysexbpvrC+7e02s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-pnZWj_IEP0W114TmdP8fpg-1; Fri, 23 Oct 2020 11:09:59 -0400
X-MC-Unique: pnZWj_IEP0W114TmdP8fpg-1
Received: by mail-wm1-f72.google.com with SMTP id o15so565971wmh.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VCFiKM9r31iSz+0w3GgYriDALNKarg3PwnkOFLl/y2k=;
 b=lYW+Ebs4Yzn+r+qwOj3uD5c+F/iyB1lALJzfT/6pnpHFmDXsGozgOPcl6NWrKrW69h
 rFcoxhbQIGVfnaplCOIGtRJdkpJTa/WyJ/mrML5jd2XavPW294CvdK67jAJTZzeERp1A
 u6+r4yFCNcF5r0WAn9jBFGkqbHy93vBIrgutcN5OwdLEE9akxlKyAr/79IujaDibqtOg
 ailNxy4u5U0EgoB1tnsMnjadKHGTKqxHZVHaEVq0mXndCrNbM9oJsSEEpzI4U680gvyL
 f1YfXwxY7MGYUxUQ3LL2sCuXnwtwZSJCyBd86giQx2T263BohHDReuOCHZZt4mvjmCTZ
 xPcQ==
X-Gm-Message-State: AOAM533FxXvsnPM4OMJyMNQSSm9+qmb3Hv95q/Wdm1YiYW2AShBB4E9y
 /w9P+wAPoR3JcSJOVAF3o3IZl0fNkvXciZPE56pV3sGnMo43hLjRTOcf2AsfviP/Y6VlfDAbGpP
 2LVYTHDdvPgtO1k0=
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr2913159wmg.151.1603465794079; 
 Fri, 23 Oct 2020 08:09:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPeqxPAWtDkAru7cfTUlF5BCbxZonr89vbJYqoOcBWev98qoXCBuiw5/4RQZ50XxPdWYZkVg==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr2913142wmg.151.1603465793832; 
 Fri, 23 Oct 2020 08:09:53 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id l3sm5343572wmg.32.2020.10.23.08.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 08:09:53 -0700 (PDT)
Subject: Re: [PATCH RESEND v2 00/16] hw: Let DMA/PCI API take MemTxAttrs
 argument and propagate MemTxResult
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201001172519.1620782-1-philmd@redhat.com>
 <e25101fd-5a14-13ff-6e5b-d46b780a8ca5@redhat.com>
Message-ID: <7b6f9053-206d-f301-808d-d2c990320207@redhat.com>
Date: Fri, 23 Oct 2020 17:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e25101fd-5a14-13ff-6e5b-d46b780a8ca5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 10/22/20 4:44 PM, Philippe Mathieu-Daudé wrote:
> ping?

In case the rationale is not clear, the motivation
for this series is to make the API more robust to
enforce correct use by the consumers.

Currently the MemTxResult return value is not
propagated, so lost.

If adding the MemTxAttrs argument could introduce
security issues and you need more time to consider
this change, I can repost only the MemTxResult
propagation patches, and we'll discuss the MemTxAttrs
after the 5.2 release.

Laszlo Ersek pointed me to commit f794aa4a2fd
("target-i386: introduce cpu_get_mem_attrs") to
understand how MemTxAttrs is used by SMM on X86.

 From the review comment from Edgar in v1, I understand
there should not be security issues with the current
codebase.
https://www.mail-archive.com/qemu-block@nongnu.org/msg74077.html

Regards,

Phil.

> 
> On 10/1/20 7:25 PM, Philippe Mathieu-Daudé wrote:
>> This is a respin of:
>>
>> "dma: Let the DMA API take MemTxAttrs argument and propagate MemTxResult"
>> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html
>>
>> and:
>> "pci: Let PCI DMA API functions propagate a MemTxResult"
>> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html
>>
>> (resent using correct git-profile).
>>
>> The DMA API propagates MemTxResult:
>> - MEMTX_OK,
>> - MEMTX_device_ERROR,
>> - MEMTX_DECODE_ERROR.
>>
>> Let the PCI DMA API propagate them, as they are
>> clearer than an undocumented 'int'.
>>
>> Klaus Jensen (1):
>>    pci: pass along the return value of dma_memory_rw
>>
>> Philippe Mathieu-Daudé (15):
>>    docs/devel/loads-stores: Add regexp for DMA functions
>>    dma: Document address_space_map/address_space_unmap() prototypes
>>    dma: Let dma_memory_set() propagate MemTxResult
>>    dma: Let dma_memory_rw() propagate MemTxResult
>>    dma: Let dma_memory_read() propagate MemTxResult
>>    dma: Let dma_memory_write() propagate MemTxResult
>>    dma: Let dma_memory_valid() take MemTxAttrs argument
>>    dma: Let dma_memory_set() take MemTxAttrs argument
>>    dma: Let dma_memory_rw_relaxed() take MemTxAttrs argument
>>    dma: Let dma_memory_rw() take MemTxAttrs argument
>>    dma: Let dma_memory_read/write() take MemTxAttrs argument
>>    dma: Let dma_memory_map() take MemTxAttrs argument
>>    pci: Let pci_dma_rw() propagate MemTxResult
>>    pci: Let pci_dma_read() propagate MemTxResult
>>    pci: Let pci_dma_write() propagate MemTxResult


