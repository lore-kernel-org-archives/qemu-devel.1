Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2153C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03E420738
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlKpjlhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03E420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCKTI-0005iG-Th
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 06:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCKSR-0005H4-Pb
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 06:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCKSO-0006SC-6i
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 06:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598782847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HVJwDki3kZxZ1umV5kRr9clk/ROkA8N4HoflS0Wg4s=;
 b=HlKpjlhhw+z+J+3W8dy5ecIU3OvHVk1Uar1s3rvZPkGP65NXcV4ZQoFjRD/6s9VfTbaC+h
 dmpQdD5JA8yCcpGjjRTu1QXY+pJ0SzYdeOPcdVNQ+tl4inzlZjX4yyuxkca9EJl0DCkRAT
 203UZZdjQC0wYb/WMuDVHfr1r99bceM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-RaZE98YaPtKK10acwiXYmA-1; Sun, 30 Aug 2020 06:20:45 -0400
X-MC-Unique: RaZE98YaPtKK10acwiXYmA-1
Received: by mail-wr1-f70.google.com with SMTP id i6so1910814wrs.13
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 03:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6HVJwDki3kZxZ1umV5kRr9clk/ROkA8N4HoflS0Wg4s=;
 b=M+7y6H1N8B9dTBnYwAg14qGOdI4ZmGdSxhSjoWGyDQkv0cud3Cai/bL9N9VlMdpEuV
 sgGsaWn1z1152o1Xc65BzRPiK/GGMsUkJwrLg7/ZxiMuSM/rzAtAsiEd2A7XFAsSks+3
 l6l+GmDzAFLooDVUbjc9soykfJzYlGRaC+zRs+rXx4bHul7LTvuCzlU1WvJz0dil1i9s
 N1Ti5+JOH6f7lLAMpu8NDAtAauyyft8Rzf5kYHwl7g5f494rxff/aZkhZNBVdnrzpxrV
 XFQ9nRrGAAi4TO4ZvUVPc8i5D4s6rwhBd45qwxWm8eqs+GTokOgdAeMzioiZXq5ucR0+
 v6KQ==
X-Gm-Message-State: AOAM530nzfaUPzkcoF95BJYuTTUWC4xT3P0VtA+yY7aPLKj0b8iHzQbr
 tJpcepOK7V+cHsGn4xwonEuXIfBqy0Skw/X3rJ54JZz9M0HXL0FP6enEEADmbnhNGBO8iBxQ7NW
 oxYTLk2qYDZcYwwA=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr25098wrr.111.1598782844773;
 Sun, 30 Aug 2020 03:20:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYJfLB0RzIokJbo4PYJr2AShKwm7OYucGIUGoK3ThflDK70HbRF0HOBUIaZOaFZG0oNp67Mw==
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr25084wrr.111.1598782844559;
 Sun, 30 Aug 2020 03:20:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d8:ed0a:2dde:9ff7?
 ([2001:b07:6468:f312:9d8:ed0a:2dde:9ff7])
 by smtp.gmail.com with ESMTPSA id n124sm6476642wmn.29.2020.08.30.03.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 03:20:43 -0700 (PDT)
Subject: Re: [PATCH v2] memory: Directly dispatch alias accesses on origin
 memory region
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200822161449.1327517-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37c7c3b8-d2f0-cfb1-728d-92aa20633fc6@redhat.com>
Date: Sun, 30 Aug 2020 12:20:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200822161449.1327517-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 05:37:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/20 18:14, Philippe Mathieu-Daudé wrote:
> There is an issue when accessing an alias memory region via the
> memory_region_dispatch_read() / memory_region_dispatch_write()
> calls.
> 
> Since commit 2cdfcf272d ("memory: assign MemoryRegionOps to all
> regions") we assign &unassigned_mem_ops to all MemoryRegions.
> 
> The memory_region_init_alias() flow is:
> 
>   memory_region_init_alias()
>   -> memory_region_init()
>      -> object_initialize(TYPE_MEMORY_REGION)
>         -> memory_region_initfn()
>            -> mr->ops = &unassigned_mem_ops;
> 
> When accessing the alias using memory_region_dispatch_read(),
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
> 
> Fix by directly dispatching aliases accesses to its origin region.
> 
> Fixes: 2cdfcf272d ("memory: assign MemoryRegionOps to all regions")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

It's still not clear from the commit message what is the case where you
get this.  I can integrate it in the commit message myself, but can you
explain it and/or link to a bug report?

Paolo


