Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BAC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E9A217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioAsH7qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E9A217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQPzl-0004Uj-Mr
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQPyX-00035t-Dt
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQPyV-0003Bt-Rs
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602140667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08qWo4EpYw9DnUtsKhu8PIQ4TwVPG3MfhOzZ1DCYm2s=;
 b=ioAsH7qytwisC1xtMKsZa1+uubsLMq/XT2d3mTmeyehUb8J8h+oBhDncMNDDZMgSZekWME
 LwFkVsYUM6QA51YXqqnc1nQ07oN/wArH3L85OO9o6tVBcutqWWNHtpGjCeICOO7j+gVOpR
 m7HTrP7BiRIh5wBvXa8GZI//580CaEE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-kpUVCPCkNi20R0bwJs8z6w-1; Thu, 08 Oct 2020 03:04:25 -0400
X-MC-Unique: kpUVCPCkNi20R0bwJs8z6w-1
Received: by mail-wr1-f72.google.com with SMTP id l17so3486674wrw.11
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=08qWo4EpYw9DnUtsKhu8PIQ4TwVPG3MfhOzZ1DCYm2s=;
 b=QXSDxiW7nvm/b1FHB0F3gUrijiCVTxtgwUsPlNhv9O4YGHDfR3VN3sdUh76hr+TQw/
 SgQr0UERCLR9uKC6XAvJsxPJ18P+quyTv/rwB1k6GFbl5uDlMVR2IBCFcRwoZ6j1rVyK
 43NgmSzI3Uf7CgxdlwOfgACMtyzCA/Amn6Qf+tWqG5iYXZe+HWBadFc6YMxUjiuik4Xq
 DTui/D7pzpzkZ8tN8GhMB8t6hZdt3eWfjGPTUc4UunIXRVBV0z87jC8yBaE8NxfMDFfQ
 Vj2R0Vxoe+FkbQzccK3SvIyaw08MLwt9T50MhNNuwgF8/okhD1RgACHTX87lfCaJzxeT
 wd1A==
X-Gm-Message-State: AOAM531/lOAfXxrPVyz547rqKr1aHmyB6H1WIp3demvOa4rfg1rDDyOg
 l+7l0Kwv39A1mQsADMt+MivMDVUfp0FB2A5FTUPDlOQH6jKkCPtV+8o6V++4hrr7dCoCXgS3ajI
 0aZQdFZ3ujdpc748=
X-Received: by 2002:a1c:a9d1:: with SMTP id s200mr7041112wme.107.1602140664359; 
 Thu, 08 Oct 2020 00:04:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7FUAxSXo7TyltjDGvSoOmBAGQKiW2/T43tS1laaeuKyOjGWEO6URLo2f02dnaN9HAjLBGgQ==
X-Received: by 2002:a1c:a9d1:: with SMTP id s200mr7041088wme.107.1602140664053; 
 Thu, 08 Oct 2020 00:04:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id i11sm5748138wre.32.2020.10.08.00.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:04:23 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] fuzz: Add general virtual-device fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-3-alxndr@bu.edu>
 <20200922140350.slchhw6qw4ia3bmp@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ec0a9dc-1754-7873-0789-5170cbe8c898@redhat.com>
Date: Thu, 8 Oct 2020 09:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922140350.slchhw6qw4ia3bmp@mozz.bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 16:03, Alexander Bulekov wrote:
>> +        if ((memory_region_is_ram(mr) ||
>> +            memory_region_is_ram_device(mr) ||
>> +            memory_region_is_rom(mr) ||
>> +            memory_region_is_romd(mr)) == false) {
>> +            name = object_get_canonical_path_component(child);
> This isn't a great way to check whether MRs have ops with code that is
> interesting to fuzz (for example the pflash MemoryRegions do not pass
> these checks, so you can't fuzz the pflash device). Need to think of
> some better checks to identify MRs that we are interested in fuzzing.

I think you can simply remove the ROMD check.

Paolo


