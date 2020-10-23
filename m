Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDDDC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C982C21D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJ8qkZl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C982C21D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz6c-0005pM-KU
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVysF-0002dE-Lv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVysD-0000Ro-GV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwQgG+/6anMt9QsGbAPRY1hs+7xEUYzUqfM3z9ufaZw=;
 b=OJ8qkZl71F1hNsL2FTI70BpHLbgJbP+BczyH182s0JjzJka7XC3UI/gUMTxoD0QAV5991I
 VaPI/lkJa0CjZ4x7WPO1cy0d21ffQCp4BXwmmVpDy3Dm/oNLFtbeGrSjI/6xm/vBwRxCXT
 RSrU7Hw2LJ/Gq+oqN4m3ifHH1721b0Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-1PQZlZ9lNNWJAbBB0wmv1Q-1; Fri, 23 Oct 2020 11:20:55 -0400
X-MC-Unique: 1PQZlZ9lNNWJAbBB0wmv1Q-1
Received: by mail-wr1-f70.google.com with SMTP id k14so707238wrd.6
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SwQgG+/6anMt9QsGbAPRY1hs+7xEUYzUqfM3z9ufaZw=;
 b=SgWZbrG44nBSM4924h+27v9ownxbm6B8QbeW1AAdDMuYfIQTEqnhnm7D7UPxTipBGb
 KYSjxWVWhioWpUA9yeJ1dEGFUjozyuRrr2k4d7P9XLo5m1szms6vat8M2UsGFezI+rHu
 ktK+Jgy2EYVXYAIlebf6jaWOF+Hfsqc/n1JjnkPuy8R1xH68iaA77x/toadJP9wYJYyM
 QhhSnTF754Rzm8axcOfXG+2XV3UXuTmYNhC7o5KeLz+24OP/2WFbHRj0tmPDQ5jxBfYT
 o/SDsdpbonG/zt1FhVuAI92D9v5WRinFYNOGuRDR/6FqG/SA8OZASGkMVD6LHvm66ady
 +m0g==
X-Gm-Message-State: AOAM5303RR4UpPh466+DTqY8CPI5Smvz4cZhoYMNRHdggcYlhLp24+Ng
 wK7F97j+X2aH+JxROhNI0dtxZWVrlt5giS5/vxiPmv/Sj6zMR/mG98uhmL89HIR31hWHZHVmA72
 UPB3UxDM9NzWLFxM=
X-Received: by 2002:adf:e38e:: with SMTP id e14mr3201117wrm.168.1603466453802; 
 Fri, 23 Oct 2020 08:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF4wPSGox0JGFUQ3ai530cjS58mjn5TE0lD5HgNdn83rNypwFr+Cm732v2IQH+yX9/+adXBg==
X-Received: by 2002:adf:e38e:: with SMTP id e14mr3201101wrm.168.1603466453653; 
 Fri, 23 Oct 2020 08:20:53 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id a185sm3682920wmf.24.2020.10.23.08.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 08:20:53 -0700 (PDT)
Subject: Re: [PATCH RESEND v3 00/10] hw: Let DMA/PCI API propagate MemTxResult
To: qemu-devel@nongnu.org
References: <20201023151923.3243652-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b74503fe-f4f8-7e2a-127f-37eb11f5971a@redhat.com>
Date: Fri, 23 Oct 2020 17:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023151923.3243652-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 5:19 PM, Philippe Mathieu-Daudé wrote:
> Currently the MemTxResult return value is not propagated,
> so lost. The motivation behind this series is to make the
> API more robust to enforce correct use by the consumers.
> 
> All series reviewed.
> 
> Since v2:
> - Rebased
> - Removed patches adding MemTxAttrs argument to DMA/PCI API
>    (we will discuss them later).

Sorry this is not a RESEND, this is first post of v3,
I forgot to use '--clear-subject-prefix' and git-publish
reused the same prefix from v2.


