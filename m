Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC2BC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFE620691
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwA2hIfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFE620691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC5iC-0008VM-5c
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 14:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC5hV-00083O-Pa
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC5hU-0002ir-QT
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:03:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52836
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC5hU-0002iY-Ma
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583949804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLjXKuC7hEZG7V2G6Tmy0IM2YPX8kqaCUXUAcjbRgxI=;
 b=WwA2hIfVA4GjxwTO4QD6BoTxMKQpuwhQOyBGhpqgfDSooWfztV8YRg45jw+lq3sygOrH7S
 hnRjaW0in+4HdvyMhX91JkZ4hY+t/0nJ2YgN2M/XdVkRhBp/13VsqtZPmyPrDFIHcUZ2ki
 3qSvgNPNYkORMBrNCtlx6P9S5trD+24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-WqTtiK7NNhemUFs-gXqGHw-1; Wed, 11 Mar 2020 14:03:19 -0400
X-MC-Unique: WqTtiK7NNhemUFs-gXqGHw-1
Received: by mail-wm1-f71.google.com with SMTP id 20so921141wmk.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 11:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oLjXKuC7hEZG7V2G6Tmy0IM2YPX8kqaCUXUAcjbRgxI=;
 b=tsHAMyty7TTngfp7rXuMPgcrYEEkw6rADHAqd6eE0X1FVM9ZqrcqYZ1pmq14uOR//e
 1tgVk2QjWCkX/6tYyDmgE6L8G/LfedIgoenmhONg4g5MbzhosFTd8lWWWu/QrXd9nnjY
 6C4/g1mJUJR+KFgXE+0q82jQupUu1+l0nPq18ct2W/kq1mu78V1svy1ZbOsXRtiJM6e/
 bS6YvtUtnlqzEs7dfKKLNyqvzlq22U/oI5FcSGprVtMh8qj37UdwqD7kZht0i85HOzPB
 2gVWhM9QoZSRwq7AaPUc7Lc5dW5YsnhvNPzDBUb+88KgvbPCDTYVrGKi2T4xBjNBxJqt
 28lA==
X-Gm-Message-State: ANhLgQ1ib6Ao0WVLn8GLCICFSDJUB54rAVWC6Vb5sD/6it0LiJt/QQ0e
 O0N5cyJXzeXo52Dr6LLJRxr+jFyLHsEkxMT4CisjKdbJ+yXIiDsB5VQ+uP5wCTw5rItnIGMZ+C7
 711Dzj+CZ2+jpIrs=
X-Received: by 2002:adf:a1cd:: with SMTP id v13mr5626863wrv.402.1583949797967; 
 Wed, 11 Mar 2020 11:03:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsUB/C1+VDLVCoUkzVuoFTI4ThoSkE68DyUDDbxf49LfacSIqhVVlxuTbIyhhNG7Ole7FIk3A==
X-Received: by 2002:adf:a1cd:: with SMTP id v13mr5626836wrv.402.1583949797740; 
 Wed, 11 Mar 2020 11:03:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8?
 ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
 by smtp.gmail.com with ESMTPSA id f17sm63632540wrj.28.2020.03.11.11.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 11:03:16 -0700 (PDT)
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
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93e2e198-26ed-c8c7-b47e-977915156a17@redhat.com>
Date: Wed, 11 Mar 2020 19:03:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <85e4202d-91dd-0d31-373a-febe566353ab@m00nbsd.net>
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

On 10/03/20 20:14, Maxime Villard wrote:
> Maybe, whpx_vcpu_kick() causes a WHvRunVpExitReasonCanceled in the
> WHvRunVirtualProcessor() call that follows, which in turn causes "ret=1"
> to leave the loop. That is, maybe the next WHvRunVirtualProcessor() acks
> the cancellation and leaves without doing anything, even if the
> cancellation was received when this function wasn't executing. So there is
> no bad effect, given that we still end up leaving the loop, which is the
> desired functional behavior.

Yes, that's exactly the effect, and it solves the race in the same way
as KVM's run->immediate_exit flag.

> Looking at NVMM now, it seems to me there is the same thing. We do a
> self-kick but we're the calling thread and know the VCPU isn't executing.
> As a result of the self-kick the IPI handler sets
> 	qcpu->stop = true;
> And in the next iteration of the loop, we break because this bool is set

The problem is that qcpu->stop is checked _before_ entering the
hypervisor and not after, so there is a small race window.

Paolo


