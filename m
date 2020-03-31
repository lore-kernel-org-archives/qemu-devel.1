Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E439AC2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF68720787
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOi8tl6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF68720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCDL-0008Tt-PK
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhangfei.gao@linaro.org>) id 1jJCCM-0007Dv-9H
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhangfei.gao@linaro.org>) id 1jJCCK-0002Qn-Hh
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:24:38 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33234)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhangfei.gao@linaro.org>)
 id 1jJCCK-0002Ov-AH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:24:36 -0400
Received: by mail-pf1-x444.google.com with SMTP id c138so354761pfc.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RBjB4RwxEoa9gh4/QXpSAf7OmChI2hQjPdb5UTa+Xa0=;
 b=AOi8tl6BbSN3D1/izOtH6vxk1PdXCoWZcIUUg0RLWqMsDArt/y8llkXPrOqBQz7XbF
 n1DgtS8/sHp7EZckh46znX0VCZG87XREVusjJ2NvdDbosve9GowL75BEapHEzTE58Hp2
 QYJQI3ZeTtmuhauyeusr1OX5iqrrjE0gllWUqSnL6PxeL2uXdKFT1dWyQngTvNto5IiQ
 5UaeTG37j7AE4rwts9PDtsEIu1v+uHQKbkoRF2lU4yZiYw3DEfNUL6yrOJ7g3TMkCo0y
 rYoAp7FzV4XAdDV8zI97Ut8R5dTWPTym4uGvleNgtwYbZ9Q70MPF7ToX8OPuC2XCUQpg
 4PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RBjB4RwxEoa9gh4/QXpSAf7OmChI2hQjPdb5UTa+Xa0=;
 b=Gj2VcMiXXJAnqwUW2G1CAaFXV2CoSB3R+wsFcCYMkBbcbHxGkeSbx3GvEaV8YcyMwb
 DKbjZPWS02EC9Dw7oz/f2N+j+OEwVfuJKHBTtTHUrzr2fnj0P32wf+mukqd6b29HqZiq
 MeDnCLjvKRhvMTG8u4WNNxXeFZP2nWS/y2IqMpXfP8/5aTTqkRM+0+5tqfX8uxp0HBSD
 4M7VFK2qFJlv+6gZxgBNIu03xTNMtGZpHlLSpuDju1rktYQrIUJFhuZ7cq3+kY/f/nVT
 OOPEX49KMYwrab5j5RXEWo2SIt4UBmJt1fpYE8+D/bQmBaBOZ4Y8rEwp1C0WG4YcVW7C
 1Mlw==
X-Gm-Message-State: AGi0PuYDbou8QiOqlcMH9QkPycFLMXBojdbRv2IoZvtSX3UB6cX2ZkRn
 uHy72Mv2n4QKnGhMALu7pL4iBw==
X-Google-Smtp-Source: APiQypLpzmwAK55Q6bcByw9/mOsMeCSrwopSLlNZzZjOCUNZY2wSGRUxAzSD6HCcRjBTrnsgnfyeJw==
X-Received: by 2002:a62:1648:: with SMTP id 69mr3628656pfw.14.1585643074785;
 Tue, 31 Mar 2020 01:24:34 -0700 (PDT)
Received: from [10.27.1.2] ([45.135.186.113])
 by smtp.gmail.com with ESMTPSA id c128sm11792183pfa.11.2020.03.31.01.24.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 01:24:34 -0700 (PDT)
Subject: Re: [RFC v6 00/24] vSMMUv3/pSMMUv3 2 stage VFIO integration
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <73b1c3e1-a418-f57c-d949-261250d6a79b@linaro.org>
 <c15f98fb-01d7-cb2f-5401-4b648997fcba@redhat.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <fbae2237-11ed-9527-0c01-340d5092ddcc@linaro.org>
Date: Tue, 31 Mar 2020 16:24:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c15f98fb-01d7-cb2f-5401-4b648997fcba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 shameerali.kolothum.thodi@huawei.com, peterx@redhat.com, bbhushan2@marvell.com,
 will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Eric

On 2020/3/31 下午4:12, Auger Eric wrote:
> Hi Zhangfei,
>
> On 3/31/20 8:42 AM, Zhangfei Gao wrote:
>> Hi, Eric
>>
>> On 2020/3/21 上午12:58, Eric Auger wrote:
>>> Up to now vSMMUv3 has not been integrated with VFIO. VFIO
>>> integration requires to program the physical IOMMU consistently
>>> with the guest mappings. However, as opposed to VTD, SMMUv3 has
>>> no "Caching Mode" which allows easy trapping of guest mappings.
>>> This means the vSMMUV3 cannot use the same VFIO integration as VTD.
>>>
>>> However SMMUv3 has 2 translation stages. This was devised with
>>> virtualization use case in mind where stage 1 is "owned" by the
>>> guest whereas the host uses stage 2 for VM isolation.
>>>
>>> This series sets up this nested translation stage. It only works
>>> if there is one physical SMMUv3 used along with QEMU vSMMUv3 (in
>>> other words, it does not work if there is a physical SMMUv2).
>>>
>>> - We force the host to use stage 2 instead of stage 1, when we
>>>     detect a vSMMUV3 is behind a VFIO device. For a VFIO device
>>>     without any virtual IOMMU, we still use stage 1 as many existing
>>>     SMMUs expect this behavior.
>>> - We use PCIPASIDOps to propage guest stage1 config changes on
>>>     STE (Stream Table Entry) changes.
>>> - We implement a specific UNMAP notifier that conveys guest
>>>     IOTLB invalidations to the host
>>> - We register MSI IOVA/GPA bindings to the host so that this latter
>>>     can build a nested stage translation
>>> - As the legacy MAP notifier is not called anymore, we must make
>>>     sure stage 2 mappings are set. This is achieved through another
>>>     prereg memory listener.
>>> - Physical SMMU stage 1 related faults are reported to the guest
>>>     via en eventfd mechanism and exposed trhough a dedicated VFIO-PCI
>>>     region. Then they are reinjected into the guest.
>>>
>>> Best Regards
>>>
>>> Eric
>>>
>>> This series can be found at:
>>> https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6
>>>
>>> Kernel Dependencies:
>>> [1] [PATCH v10 00/11] SMMUv3 Nested Stage Setup (VFIO part)
>>> [2] [PATCH v10 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
>>> branch at:
>>> https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stage-v10
>> Really appreciated that you re-start this work.
>>
>> I tested your branch and some update.
>>
>> Guest: https://github.com/Linaro/linux-kernel-warpdrive/tree/sva-devel
>> <https://github.com/Linaro/linux-kernel-warpdrive/tree/sva-devel>
>> Host:
>> https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stage-v10
>> <https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stage-v10>
>> qemu: https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6
>> <https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6>
>>
>> The guest I am using is contains Jean's sva patches.
>> Since currently they are many patch conflict, so use two different tree.
>>
>> Result
>> No-sva mode works.
>> This mode, guest directly get physical address via ioctl.
> OK thanks for testing
>> While vSVA can not work, there are still much work to do.
>> I am trying to SVA mode, and it fails, so choose no-sva instead.
>> iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)
> Indeed I assume there are plenty of things missing to make vSVM work on
> ARM (iommu, vfio, QEMU). I am currently reviewing Jacob and Yi's kernel
> and QEMU series on Intel side. After that, I will come back to you to
> help. Also vSMMUv3 does not support multiple contexts at the moment. I
> will add this soon.
>
>
> Still the problem I have is testing. Any suggestion welcome.
>
>
To make sure
Do you mean you need a environment for testing?

How about Hisilicon kunpeng920, arm64 platform supporting SVA in host now.
There is such a platform in linaro mlab that I think we can share.
Currently I am testing with uacce,
By testing a user driver (hisi zip accelerator) in guest, we can test 
vSVA and PASID easily.

Thanks


