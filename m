Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F777C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 03:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77ED821534
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 03:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KblytfLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77ED821534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVRKB-00039V-9S
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 23:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVRJR-0002hd-Go
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 23:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVRJM-0000AA-Re
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 23:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603337442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbEzL39UwHPzed5dXHZVGSR8O0Zg+l594+sIhvZ7GKo=;
 b=KblytfLc0qisZ0xb6URgK36JUzmJrGn7Ei0B/gwdtpxP7Dk/SqbIM92AUJpujuiA9ojUjU
 DCfY97pXn9Rz+waAg5aox/r/ofnf9LOnUXLMxpZpROHLrRWBbdHwvCVa8Q5/9iG8sc+1BB
 /+2e3aMRQKchCq/c5mRsHzjtWrQ+S8U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-BzTkTafaNL6NcxuasXTBhg-1; Wed, 21 Oct 2020 23:30:40 -0400
X-MC-Unique: BzTkTafaNL6NcxuasXTBhg-1
Received: by mail-wr1-f70.google.com with SMTP id m20so54036wrb.21
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZbEzL39UwHPzed5dXHZVGSR8O0Zg+l594+sIhvZ7GKo=;
 b=nq5WJMo1mcY5eElglee4RMyFs7GosYp6RVUI3rJpah0iAiqPIChQx2trasJSCoadx4
 ALHEUVVMATaMdxxzXzZDsRsAQ6HUxibuFBJl67BtmzWp7xwzPEoM4U8eZ6R91xdz8OQC
 ZnsOHbeZYDem7dFeX+6Zc4CAW4qoxwJn7B597+zXbVe1c/cc+3PB4pk4gBMf8XKUDwW7
 BdGKOYdYxRjpnIpWNEWjqaJqOfp6z7W1Jf55lRoPTrIIFY616V6TOa0GDx7xLqmGJLFc
 pRHrGkFDKyqWf4qHLekPbtGmEc0RhYs3kKz05M4oNLLzynLf2Ljx/6EEZVFTHyA88dkw
 AS2A==
X-Gm-Message-State: AOAM531gSd0tog7isxAbBHxwKLcAnFvT7TyYTkiDkBgkV/reqIEwIa5K
 oPhhKNldLsPchslQdemyidur3in739uVr7pF5wXZDAZ5V6plP7MgHj8E4JZcpy/R/kDPLmKiYlF
 U3mB0nt3RpylMozY=
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr482617wmb.114.1603337439190;
 Wed, 21 Oct 2020 20:30:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysfObg9K3nV0dg1JeW/3a00K4Z+2T/KDsNZqn09z+oU4cUAaKxQ+N+bs2CgRTr5x2fFC+bTA==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr482607wmb.114.1603337438997;
 Wed, 21 Oct 2020 20:30:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y2sm685774wrh.0.2020.10.21.20.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 20:30:38 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1w?=
 =?UTF-8?Q?lify=28=29_for_cpu_vendor_zhaoxin?=
To: FelixCui-oc <FelixCui-oc@zhaoxin.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
 <20201019130206.1d3baffc@w520.home>
 <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
 <20201020164437.5e3cb4ce@w520.home>
 <783b5ef0-277c-363d-f342-7c0351f9ac16@redhat.com>
 <20201021124908.53c7a98b@w520.home>
 <eaab570f-741e-7397-09c2-8e47f0a6d32c@redhat.com>
 <0e275d4de640431cb07de7fafb4d9ef1@zhaoxin.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <606cf65a-a614-5c9b-705f-3a8f3707fb10@redhat.com>
Date: Thu, 22 Oct 2020 05:30:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <0e275d4de640431cb07de7fafb4d9ef1@zhaoxin.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: CobeChen-oc <CobeChen-oc@zhaoxin.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, RockCui-oc <RockCui-oc@zhaoxin.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/20 05:02, FelixCui-oc wrote:
> In addition, before write pam registers, flatview_simplify() has merged
> a very large range.For example,
> 
> this large range is 0xc0000-0xbfffffff. So even if EHCI is configured to
> not allocate buffers in low memory,
> 
> this bug will still occur.Thanks.

So removing flatview_simplify() works because the higher area (0x10000
and above) remains the same.  I guess the simplest thing to do is to
apply flatview_simplify() only to I/O areas, though we can also consider
removing it completely.  I'm not sure in which case it would provide a
noticeable improvement.

Paolo


