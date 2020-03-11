Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C17C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5405A2074C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caf5N9mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5405A2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC8C6-0007CH-Am
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 16:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC8BU-0006hC-9A
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC8BT-0007DT-9R
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:42:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC8BT-0007Ba-5K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583959350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQQk9Q7y0NU29jsUZYKM3wrCFGT7iesL1SKUq5KVYr4=;
 b=caf5N9mxpz7D+0WTEtohRHAV3r4XoDZbybYoYOP7+aHIlp7jg9Pnt+mAsTMPoajiUAjZYF
 MOifGd7v0nUUXA2WbqgLGsVtYKAn/SgSJY5wr22zWdxMtlblKOJvOnfSNjfdJe6JQ2b9mI
 sXpgIvk35hUlSsiUCLFfssHlmSEJdgM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-Y8_O9Up-PYGsMxexGwsPdg-1; Wed, 11 Mar 2020 16:42:28 -0400
X-MC-Unique: Y8_O9Up-PYGsMxexGwsPdg-1
Received: by mail-wm1-f69.google.com with SMTP id t2so1033335wmj.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 13:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VQQk9Q7y0NU29jsUZYKM3wrCFGT7iesL1SKUq5KVYr4=;
 b=pQarTOv7dJy56cnFiD/4uVU8tC9lGU8kh9a8WekjNb0glfmbXUwxT3mUKxa2HGGN30
 PkApWoVQnBRX8NvWMvXyE/ehWSAxIYLs4jEYSypw/MkEJDDDEy1lD3PeQ3UFxhu+6ppn
 yYaSKwr7ryPEx2hYzNKZJVyPLsTtQsREvb76iy3CfsGZYejggak/GWqVqUOr0+GrmXlO
 elbRPbUHZKeiWGAdT2fuWzn5a68mAd8o905g2/mhbbfytzBCOCWbp4GOjVte3jhwxIdz
 REBh/u3mwKrDjute+b57ApwQioeS5xDUdJgac2Yldr8ZO5OEaFQn0v9O3MZJ8aMsb3RN
 Zg9g==
X-Gm-Message-State: ANhLgQ0WKsNPty+ZAfPQFJjV2EpjxOrQJvfVS8pKkLniyNH/iMkF3J7k
 Ma/HN4Z6UnuopdzYg0VPq3u7b5pdZvk98WhEapShW6aPlcArHH1K0pMnm6CZQbfWB1Wq8o3IrRp
 6r/p8chnbnop1hdg=
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr524184wmi.89.1583959346622;
 Wed, 11 Mar 2020 13:42:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvoVsly06psfgOOUKMVpS4CbY+zArS2l8iYMFmU4l0WDnRTEjt0U/69otqpzx6/SAzoypQCFg==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr524119wmi.89.1583959345480;
 Wed, 11 Mar 2020 13:42:25 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i67sm50400363wri.50.2020.03.11.13.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 13:42:24 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
To: Maxime Villard <max@m00nbsd.net>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com> <20200206213232.1918-4-n54@gmx.com>
 <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
 <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
 <CABgObfZjnFFV3hosrP+sf5d3KmPPGuFJZo-oY5=u340wtxLYGg@mail.gmail.com>
 <a646f01d-fcf5-5984-d7ea-ccbb9a20ce2b@m00nbsd.net>
 <24fe7b93-8a34-e5d7-18b5-0f7607221ad3@redhat.com>
 <85e4202d-91dd-0d31-373a-febe566353ab@m00nbsd.net>
 <93e2e198-26ed-c8c7-b47e-977915156a17@redhat.com>
 <f48f9c36-5104-1346-cb91-d52c2887097b@m00nbsd.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <050cacce-41fc-db89-ded9-5cdf6c20a2de@redhat.com>
Date: Wed, 11 Mar 2020 21:42:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f48f9c36-5104-1346-cb91-d52c2887097b@m00nbsd.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, jmcneill@invisible.ca, Kamil Rytarowski <n54@gmx.com>,
 philmd@redhat.com, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/03/20 21:14, Maxime Villard wrote:
>> The problem is that qcpu->stop is checked _before_ entering the
>> hypervisor and not after, so there is a small race window.
> Ok. I don't understand what's supposed to be the race here. If we get an
> IPI between the check and the call to nvmm_vcpu_run() then we'll just do
> one run and stop in the next iteration, because the IPI will have set
> qcpu->stop. Is this extra iteration undesired?

Yes, you don't know how long that run would take.  I don't know about
NVMM but for KVM it may even never leave if the guest is in HLT state.

Paolo


