Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DBEC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A742076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXaEWyRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A742076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRrs5-0000Q9-Ku
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRroB-0006M3-3o
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 02:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRro9-0005LN-By
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 02:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602485984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I++R4X2Q1WCH93mG3gULM0jHEmeH69K6Agxz4RH/n2E=;
 b=VXaEWyRGmb/nP7tF9/PZgRothGWgv1FZruO0rYZX87qQQFDYg58lKhmh72K68a/rRELCxM
 cZPX6B0B1MPjyJL9uCXnqiUijiCnYEiZ4u9NI+KHDXfNRb8ffmSAU6eslTtQZfvkdiyOzS
 kCyyn2py+1nBvXI59FRtWQh6oeLrB5k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-hAlYR8k5O0KpZqYg9KPflw-1; Mon, 12 Oct 2020 02:59:42 -0400
X-MC-Unique: hAlYR8k5O0KpZqYg9KPflw-1
Received: by mail-wm1-f71.google.com with SMTP id p17so4890966wmi.7
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 23:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I++R4X2Q1WCH93mG3gULM0jHEmeH69K6Agxz4RH/n2E=;
 b=K3zOH3/UAau12vEYHD11PwnN0J7omG5PhhgrL4UObeNyrVIsQahWLId0N76D64Lua0
 7EQfDrzxwlr6gtkQfdT6S1nBinUzkaE5KgEL3yEiSaybvGtllLMbV/mKMLqaA+2uKpyM
 Bh8mmZ+sflydC6XADMf/lvFH7LMymHy5JuBJCI53pILbl1HrwoNzO36QyQDxDehQ7Od0
 nbSJju7d5L54KVVZhHVPffuRj3KgWaCTafg/smBMvrx9z30SGxoFzZLAELtbsl9eWjCZ
 M++FhWwetAbWohROj3hgpEwZFXSlWUqPV4B4oZdmgg4d4RykcTpYsEaGs2EqQtKD1jnq
 ql2Q==
X-Gm-Message-State: AOAM532ScrmKeQf6se8+y5nRXP7a4up1vprg2qVDAfwxAtDwq+gYk7dw
 VcJxZB5nQYzKjZKr/kYB+7V6xMfCsEOegQYAo7u/sUddDi8JJEYpF2T3Av7Q97U9wVwKIear/6L
 5eYmhPtuBIRc52S4=
X-Received: by 2002:a1c:3bd4:: with SMTP id i203mr9140739wma.28.1602485981010; 
 Sun, 11 Oct 2020 23:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzmkNhxt0VVCQ5ySvmemOIMlJ0gHL7oGANqZwTV/67QAbjrhfLh9WgXEBvHCtgz9VVvDsXKg==
X-Received: by 2002:a1c:3bd4:: with SMTP id i203mr9140725wma.28.1602485980790; 
 Sun, 11 Oct 2020 23:59:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7ffb:1107:73ba:dbcf?
 ([2001:b07:6468:f312:7ffb:1107:73ba:dbcf])
 by smtp.gmail.com with ESMTPSA id u15sm21457907wml.21.2020.10.11.23.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2020 23:59:40 -0700 (PDT)
Subject: Re: [PATCH v3 05/16] fuzz: Declare DMA Read callback function
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-6-alxndr@bu.edu>
 <6ed304a0-38ee-1013-7d85-7b0ae0e7c4d2@redhat.com>
 <20201011154524.wvq2vsff7eig27c4@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2bc8a9b9-49c1-58cb-4696-fd83f7e3257f@redhat.com>
Date: Mon, 12 Oct 2020 08:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201011154524.wvq2vsff7eig27c4@mozz.bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/10/20 17:45, Alexander Bulekov wrote:
> On 201008 0939, Paolo Bonzini wrote:
>> On 21/09/20 04:24, Alexander Bulekov wrote:
>>> This patch declares the fuzz_dma_read_cb function and uses the
>>> preprocessor and linker(weak symbols) to handle these cases:
>>>
>>> When we build softmmu/all with --enable-fuzzing, there should be no
>>> strong symbol defined for fuzz_dma_read_cb, and we link against a weak
>>> stub function.
>>>
>>> When we build softmmu/fuzz with --enable-fuzzing, we link against the
>>> strong symbol in general_fuzz.c
>>>
>>> When we build softmmu/all without --enable-fuzzing, fuzz_dma_read_cb is
>>> an empty, inlined function. As long as we don't call any other functions
>>> when building the arguments, there should be no overhead.
>>
>> Can you move the weak function somewhere in tests/qtest/fuzz instead?
>> Then you don't need an #ifdef because you can add it to specific_fuzz_ss.
> 
> If I understand correctly, specific_fuzz_ss is only used to build
> qemu-fuzz targets. The goal here was to support building qemu-system
> with --enable-fuzzing (ie CONFIG_FUZZ=y), where specific_fuzz isn't
> used. If its too ugly, we could make a stub file under tests/qtest/fuzz
> and add it to specific_ss when: 'CONFIG_FUZZ'.

You're right.

Paolo


