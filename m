Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E09C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BE72078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkT4//gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BE72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtaUi-0001J3-Es
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtaTm-0000TT-BS
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:37:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38528
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtaTj-0006zt-VC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594316218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVUb4tfk9KaR1fPLxGix7oqimYrSpvXuTXhClyaohVM=;
 b=AkT4//gDHDCmyl0GNVc+VWw0DioeT4Tcnsp/XRFgGfRBo1mCWkUum+sehAaWp6VCbVVEn8
 xLgkFjWiuyP+12mIGUTearRK53QMNcexGItHImEJXCDQBRhXGPEESPm2sKVKurfamgjt4+
 j99yfgSXNyq8q9AQem3S6bhyiJo7Hds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-XJNZaSMxNp2nQshIVdfJxg-1; Thu, 09 Jul 2020 13:36:56 -0400
X-MC-Unique: XJNZaSMxNp2nQshIVdfJxg-1
Received: by mail-wr1-f71.google.com with SMTP id i12so2582990wrx.11
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 10:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BVUb4tfk9KaR1fPLxGix7oqimYrSpvXuTXhClyaohVM=;
 b=AyKrzAqc81CVD3r7qvQUo7E/ecfbnC2YBEIkR2io3zITUCV9Nkw1ErF8fRw0nxpKl+
 RboeA4fsNd844EVY/LQ3jkGdF2zR2Q44f2e4galOM3zsg9XU9nlYUvBUIvXF8bmhy9p/
 l+L+7eYDam8eAGTKxB1TvyDpQPzBsVB+GY2gdOlDlNyPquD1aD94wNuoPJqa/7NGkw8l
 8QALUy16/6aIMPXcvx3DQDyj6DTaqa/yFsydyejmBD0qOAzpAvQIQB4b07/tsYYK5ZeN
 tvLYXMDYO3Z7vQ0+CXi0q1WZN+G8Zu6L2a4nA6f0E0ksMwj6LMagiMR29wOOQOtJqn53
 m+Gg==
X-Gm-Message-State: AOAM533LXKpuaNNRj76XAHUWPevHG7kCatTjBDGqdG2ex54PyNfNvOAk
 GK4IesBCKwJq7XbPezhxnhLsFz04ExlBOFynHFyOefni9x0vmjgn+YcKir7ttbzrOyBUCfBEpT3
 cxy90L/94jhlbm/g=
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr1142292wml.142.1594316215538; 
 Thu, 09 Jul 2020 10:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB99NjZSafJTgT1SGrTU0G/ZhvcWD8z+wOiCaPoSK5k6MqFJEQPjC92voVsQyOchkVYv68HQ==
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr1142282wml.142.1594316215347; 
 Thu, 09 Jul 2020 10:36:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id m4sm5470891wmi.48.2020.07.09.10.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 10:36:54 -0700 (PDT)
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Li Qiang <liq3ea@gmail.com>, Bug 1886362 <1886362@bugs.launchpad.net>,
 Jason Wang <jasowang@redhat.com>
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
Date: Thu, 9 Jul 2020 19:36:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 10:34:01
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
Cc: Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 17:51, Li Qiang wrote:
> Maybe we should check whether the address is a RAM address in 'dma_memory_rw'?
> But it is a hot path. I'm not sure it is right. Hope more discussion.

Half of the purpose of dma-helpers.c (as opposed to address_space_*
functions in exec.c) is exactly to support writes to MMIO.  This is
especially true of dma_blk_io, which takes care of doing the DMA via a
bounce buffer, possibly in multiple steps and even blocking due to
cpu_register_map_client.

For dma_memory_rw this is not needed, so it only needs to handle
QEMUSGList, but I think the design should be the same.

However, this is indeed a nightmare for re-entrancy.  The easiest
solution is to delay processing of descriptors to a bottom half whenever
MMIO is doing something complicated.  This is also better for latency
because it will free the vCPU thread more quickly and leave the work to
the I/O thread.

Paolo


