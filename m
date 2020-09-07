Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE2C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B182075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMR2wM+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B182075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDYI-0002x7-OD
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDXF-0002L5-Ry
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDXD-0004XN-Vt
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599471239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uy+81q2nWyy7jCp7PL/e0tHLezhbF9cUHjCEJLoxkoQ=;
 b=GMR2wM+K3+fvFa9+EUHUpNmAu99MQWF/nEqSCmCXrvn78PXHeE8bESYFj74zvKaynbMDKA
 o04TtAcO+VV0vNvDtGUH6+yrwaERvDOE87e1Lnz+PNEiEYPnwgklSJlUySV0CZzAP5Ibju
 8vfg7WY7No2qV5IMZpRh6CsRR/aA69I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393--I00K-UeN_SvTEXobOVIsQ-1; Mon, 07 Sep 2020 05:33:57 -0400
X-MC-Unique: -I00K-UeN_SvTEXobOVIsQ-1
Received: by mail-wr1-f71.google.com with SMTP id l17so5467424wrw.11
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uy+81q2nWyy7jCp7PL/e0tHLezhbF9cUHjCEJLoxkoQ=;
 b=jDeaUVSEyfNSBBm2ALYS+1PpZMdsFaSIsnQ0Pjvn11dK3ykvV+78PJeaek9mPbMlL1
 oMoM+kP6ylne6d52STYPuKQa6p+s7FtQvC85VQOipQiN9OMbkIFzfkLpAJQt/SoQAKKx
 ujYoB/iPkvRIwJYz+fiuLLN3D6wJt2MwvECZrOFpwg7Cdh8tZl5bdCUmun17JR8nUNQ/
 Gtxzlcqim5S43P1hIfNg4OKE2WCx0Dz4r/svnO6iMN+4/SJ1BRywePcLEduGIadHv5BG
 K17ZYVw2bm430f1Kt1QBpzDyH7icGCr8bS3C6iG9DxFJQzf95YyuTUbN89pjC0uJBXlE
 EwSg==
X-Gm-Message-State: AOAM530S3YnFT9qpMvwtK7DME2pif83UtGN7cfPpLXxW6aDRrFo///xv
 4JF3Bu4MZA1L1XXIIeB1KgstYdQVol4VM4Z5qJ2Zd20/5CqMUMmSK3wX5T9rcBmPoJYk1SU126t
 y0XudeMJJWbMR+2o=
X-Received: by 2002:adf:c3cc:: with SMTP id d12mr21015628wrg.399.1599471236606; 
 Mon, 07 Sep 2020 02:33:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqDTz6BjqCctZaPvtwAKZPOnuYn4sMqz8s2OrhsjkMp5nWWH1BNc/d9xwOtHobo4+x6e16yQ==
X-Received: by 2002:adf:c3cc:: with SMTP id d12mr21015609wrg.399.1599471236439; 
 Mon, 07 Sep 2020 02:33:56 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b11sm27468560wrt.38.2020.09.07.02.33.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 02:33:55 -0700 (PDT)
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
To: Klaus Jensen <its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
 <20200907072332.GA690013@apples.localdomain>
 <8651d3fa-becf-7b86-8c16-bbfb8926cec7@redhat.com>
 <20200907085814.GA698329@apples.localdomain>
 <20200907092052.GA706837@apples.localdomain>
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
Message-ID: <7465047d-ad7a-edab-bb65-8ed0a96fe5f6@redhat.com>
Date: Mon, 7 Sep 2020 11:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907092052.GA706837@apples.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 11:20 AM, Klaus Jensen wrote:
> On Sep  7 10:58, Klaus Jensen wrote:
>> On Sep  7 10:36, Philippe Mathieu-Daudé wrote:
>>> On 9/7/20 9:23 AM, Klaus Jensen wrote:
>>>> On Sep  7 04:28, Philippe Mathieu-Daudé wrote:
>>>>> +David in case
>>>>>
>>>>> On 9/4/20 4:19 PM, Klaus Jensen wrote:
>>>>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>>>>
>>>>>> There are two reasons for changing this:
>>>>>>
>>>>>>   1. The nvme device currently uses an internal Intel device id.
>>>>>>
>>>>>>   2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
>>>>>>      support multiple namespaces" the controller device no longer has
>>>>>>      the quirks that the Linux kernel think it has.
>>>>>>
>>>>>>      As the quirks are applied based on pci vendor and device id, change
>>>>>>      them to get rid of the quirks.
>>>>>>
>>>>>> To keep backward compatibility, add a new 'x-use-intel-id' parameter to
>>>>>> the nvme device to force use of the Intel vendor and device id. This is
>>>>>> off by default but add a compat property to set this for 5.1 machines
>>>>>> and older.
>>>>>
>>>>> So now what happens if you start a 5.1 machine with a recent kernel?
>>>>> Simply the kernel will use unnecessary quirks, or are there more
>>>>> changes in behavior?
>>>>>
>>>>
>>>> Yes, the kernel will then just apply unneccesary quirks, these are:
>>>>
>>>>   1. NVME_QUIRK_IDENTIFY_CNS which says that the device does not support
>>>>      anything else than values 0x0 and 0x1 for CNS (Identify Namespace and
>>>>      Identify Namespace). With multiple namespace support, this just
>>>>      means that the kernel will "scan" namespaces instead of using
>>>>      "Active Namespace ID list" (CNS 0x2).
>>>>
>>>>   2. NVME_QUIRK_DISABLE_WRITE_ZEROES. The nvme device started out with a
>>>>      broken Write Zeroes implementation which has since been fixed in
>>>>      commit 9d6459d21a6e ("nvme: fix write zeroes offset and count").
>>>
>>> OK thanks. Can you amend that information in the commit
>>> description please?
>>>
>>
>> Yes, absolutely.
> 
> By the way. Is it correct use of an 'x-' parameter here - since it is
> something that we might remove in the future? I was unable to find any
> documentation on the purpose of the 'x-' prefix, but I was guessing it
> was for stuff like this.

Probably not. 'x-' is for unstable debugging/testing features.


