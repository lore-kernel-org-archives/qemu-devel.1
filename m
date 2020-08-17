Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F50C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325E220657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKQXcdnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325E220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7i1O-0005cB-BI
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7hyq-0001aO-Hi
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:27:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7hym-00066u-Ug
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597681643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YacAenn7YhyTH03RT22cutTCboN2Fxlku+b8lV8DbRY=;
 b=EKQXcdnBl11Q9RD2NvIQtvSxvK2Ni4ipXlPpTouFA3An0bOfYAxWZFJMBNyk9oZPuifBPv
 VB134siN/q+TfFpuxJT6M/3IV/olnP27X3eDAvYVB/jmw2Cdv61mm9ygP3uIg8eMfHUTGn
 y+aO4gdC1QOIVXjQYMH5DB7w2ieG7Xc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-J_KRTgaAMLWvFyLtDlrFpQ-1; Mon, 17 Aug 2020 12:27:21 -0400
X-MC-Unique: J_KRTgaAMLWvFyLtDlrFpQ-1
Received: by mail-wm1-f72.google.com with SMTP id a5so6201983wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YacAenn7YhyTH03RT22cutTCboN2Fxlku+b8lV8DbRY=;
 b=Ux1iHHkEOqkofXgOmRsJj0E/fQMFtdlvR7rU/neRXqldc/hv5mlEk22OoZRHPtWAY4
 mGmI58IwNjWkiWwODRJ7z/hN2tx9VVnaWFjnwlYtyTFVnezMhX4Ad7Weq/qSkskyGBN8
 UsHmnGy8ROjU48dOsfUeNOGkWRjBBIlw/UsPmeo1jVCbWKYEoe7/UnBjCPDsLjCLZoQs
 3PWDpsU1579mU8/dgs2RG4ihJEs7Z+WPh+D3NjmLk6o4N5fhBSq1pxNvaBigsFCDqnu2
 v8ZO5RchRcMEa6NuaOU4eIeS/7zsJvJIltItQWuRNNwP9U+x7wCsS+DPlrdTv3ClzuNU
 BwFg==
X-Gm-Message-State: AOAM531nJ4PAKy+3CaqBTnOYBLPQJTc78iYHR84D6+WY4CzbW//xAZub
 dMnVcxIFyZnRnvFOmtwNPGh0QGwD1rY9TUTEYiWLLdEoi82AhBxNGoCfB29HQOv/+MnJpOxPpXz
 QiSUu3JqArLGgXxA=
X-Received: by 2002:a1c:4409:: with SMTP id r9mr14580238wma.114.1597681640738; 
 Mon, 17 Aug 2020 09:27:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAsaaebknlWbBQpGlUBsAlOvShputYr718cH8Xph1I3A55V1vVwSCiMJtXw52/fJbMt0CSuA==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr14580219wma.114.1597681640495; 
 Mon, 17 Aug 2020 09:27:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977?
 ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id f131sm29355950wme.40.2020.08.17.09.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 09:27:19 -0700 (PDT)
Subject: Re: [PATCH] memory: Directly dispatch alias accesses on origin memory
 region
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200816173051.16274-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <706c1969-3e73-7a8e-d4fe-9a2516f44054@redhat.com>
Date: Mon, 17 Aug 2020 18:27:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200816173051.16274-1-f4bug@amsat.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/08/20 19:30, Philippe Mathieu-Daudé wrote:
> There is an issue when accessing an alias memory region via the
> memory_region_dispatch_read() / memory_region_dispatch_write()
> calls:
> 
> The memory_region_init_alias() flow is:
> 
>   memory_region_init_alias()
>   -> memory_region_init()
>      -> object_initialize(TYPE_MEMORY_REGION)
>         -> memory_region_initfn()
>            -> mr->ops = &unassigned_mem_ops;
> 
> Later when accessing the alias, the memory_region_dispatch_read()
> flow is:
> 
>   memory_region_dispatch_read()
>   -> memory_region_access_valid(mr)
>      -> mr->ops->valid.accepts()
>         -> unassigned_mem_accepts()
>         <- false
>      <- false
>    <- MEMTX_DECODE_ERROR
> 
> The caller gets a MEMTX_DECODE_ERROR while the access is OK.

What is the path that leads to this call?

> Fix by directly dispatching aliases accesses to its origin region.
> 
> Fixes: 2cdfcf272d ("memory: assign MemoryRegionOps to all regions")

I don't think the "Fixes" is okay because you'd have gotten a different
bug before.

> +    if (mr->alias) {
> +        addr += mr->alias_offset;
> +        mr = mr->alias;
> +    }

Also, I think this would have to be a while loop.

Paolo


