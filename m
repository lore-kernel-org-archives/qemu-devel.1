Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0822FC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D052225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCDheynv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D052225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQcu-0004v2-Dm
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUQb6-0003J6-3g
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUQb2-0005fj-Ql
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603096364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbwLflhmkiULMtKyfyda6km5Kzz93JkQZU4miCkExu8=;
 b=iCDheynv2LVowocdncaVD6WjXOWR9RJuSUIROEApLxamf2rHvwQstHLjo7aPpJ0QXz53Rh
 dqKowz6n+YBPJOxsbKPccN2+0cHFAqUTVe79YMjp76gvt6hUknWwToAc3v4o9NqMBTxxLH
 XNjcIXYzI7wWQHy+AtR2L5/bfjjARnQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-5MOtIktSN1iwc0PbaRQ0Nw-1; Mon, 19 Oct 2020 04:32:43 -0400
X-MC-Unique: 5MOtIktSN1iwc0PbaRQ0Nw-1
Received: by mail-wr1-f69.google.com with SMTP id i6so7083910wrx.11
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 01:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wbwLflhmkiULMtKyfyda6km5Kzz93JkQZU4miCkExu8=;
 b=QtgEBuQCZX8yvIzcwTAo5DXBqZqk5M1rxE8QwGZdi6gZinWksbgosUH0W0Lv1eSt3Y
 HnZ5Ag6iTbjCnpH6D2KvOafFPKj4RJd424b8pkLQf6575uCTAFyCuPA99nvLFvYwNbMo
 5EYhgpTDLa23JZ/m+DeQAFKQFc0YHiu/MBIyXDL3ww4mLzpZhCrSw6YTwiLcNkJhDWzh
 wQTqkrQPZdBNLuApRZw+CttBRSQPCay2Z9pOiP8Z1Xn91Dik0mvahxeQXcm/4RrfF+EW
 OBsnMYYSOoBf4WXEbppzRtavpgNlIlNUq4XQBkm9EwFxBEf9X36KdUZfMVDQqy+4y7qc
 tOVQ==
X-Gm-Message-State: AOAM530XQ6JU2M+C6bc/WEGGVBYj3n/M0krvFoRO46CuJj4ClvZ1h4mN
 MkOwd3W7PYSF/EvbH0J5es2F546JkdmGKxiHaTB4Ln2UXO7Viy7o/pJ4rjBIozOF87jeWESu+J4
 yM6jdYQkRu8dKvCk=
X-Received: by 2002:adf:bc0f:: with SMTP id s15mr18326465wrg.83.1603096361819; 
 Mon, 19 Oct 2020 01:32:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUwOfHX0WT4BoXo8PXFzt8L4wayNnOZIXdpDEDfpRwN7Ftpby52Xc0BLMdOfrvVEtjFlPT4A==
X-Received: by 2002:adf:bc0f:: with SMTP id s15mr18326453wrg.83.1603096361644; 
 Mon, 19 Oct 2020 01:32:41 -0700 (PDT)
Received: from [192.168.1.36] (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id x22sm1865177wmj.25.2020.10.19.01.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 01:32:40 -0700 (PDT)
Subject: Re: [PATCH 0/4] RfC: microvm: add second ioapic
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20201016114328.18835-1-kraxel@redhat.com>
 <ffd81f03-b2a0-2c58-9f13-c956dfd1ca17@redhat.com>
 <20201019070704.a2tjfea4sycivmnt@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f84056d-e5b6-cc5d-20ea-4fe3f9f8ee9d@redhat.com>
Date: Mon, 19 Oct 2020 10:32:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019070704.a2tjfea4sycivmnt@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 9:07 AM, Gerd Hoffmann wrote:
> On Fri, Oct 16, 2020 at 03:16:20PM +0200, Philippe Mathieu-DaudÃ© wrote:
>> On 10/16/20 1:43 PM, Gerd Hoffmann wrote:
>>> Add a second ioapic to microvm.  Gives us more IRQ lines we can
>>> use for virtio-mmio devices.  Bump number of possible virtio-mmio
>>> devices from 8 to 24.
>>>
>>> Gerd Hoffmann (4):
>>>     microvm: make number of virtio transports runtime configurable
>>>     microvm: make pcie irq base runtime configurable
>>>     microvm: add second ioapic
>>>     microvm: reconfigure irqs if second ioapic is available
>>
>> After looking at Laurent's m68k virt machine,
>> I wonder if it is possible to use the Goldfish-PIC
>> with the MicroVM instead (or another Goldfish machine
>> type).
> 
> /me updates the WIP microvm blog post ;)
> 
> Problem with goldfish is that it tries to drag over stuff from the arm
> world to x86.  Specifically device trees.  On arm this works reasonable
> well meanwhile.  Firmware and bootloaders have support for using device
> trees and passing them on in the boot chain, so the linux kernel has a
> device tree which it can use to figure which hardware is present on the
> system.
> 
> On x86 this doesn't work at all, so you'll end up building a custom
> kernel for the goldfish platform.  A stock distro kernel is not going
> to work.
> 
> I'm to driving microvm the opposite direction:  Add acpi support.  That
> is the standard x86 way to do hardware discovery (for hardware you can't
> detect in other ways like pci devices).  Which in turn allows us to drop
> microvm-specific quirks (like adding virtio-mmio devices to the kernel
> command line) when booting linux.

My x86 knowledge is limited to asm, not to the architecture.
While this might be obvious for some, it helped me to better
understand, so thank you for the explanation :)

> So, for microvm this is not going to happen.  But feel free to add a
> goldfish machine type if you want play with that.  The microvm merge
> also cleaned up the x86 code base which in turn should make this
> relatively easy now.
> 
> take care,
>    Gerd
> 


