Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B4B2074F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4g0RquB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B4B2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNOU-0008Uw-0k
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsNNr-00083f-Rq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:25:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33020
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsNNp-0006mR-RQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594027551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qu/YN4+1H4tQ/iCO0+23CiAjwQSMobfRLiYXwc9luvA=;
 b=c4g0RquBPieNxCq/eYh0Wy8SZwV6GvS4I/t/BKHzXWvyibofNkjlwFDBW0XNMujrD83EN6
 5IX6lxP7VQj1DCo+8tg20arjFOCVyxVbJxiDKef5FzksMcGhKULzY3Ddj3jnSRpmyRx3Dh
 DcdG2/VHqyFfFPlkSi8xzjQcedSm2Bg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-AXuRteMOO8W3G8SqAym1lw-1; Mon, 06 Jul 2020 05:25:49 -0400
X-MC-Unique: AXuRteMOO8W3G8SqAym1lw-1
Received: by mail-wm1-f71.google.com with SMTP id g6so39455249wmk.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 02:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qu/YN4+1H4tQ/iCO0+23CiAjwQSMobfRLiYXwc9luvA=;
 b=m9Jto3DfzwhAARDJl7sPKhvKHGzYDYCOxlqV692uY26QFmLqGO/BFo9lWXMI8IteDw
 mg42qb7eijuj5P5PyOrTeW3H+vU2qquDxq/zgl4FRMWlTV4JhjPQsDkeNMEAh85jBEaN
 ZLrtUm+kdmQtXVxy5+SjqPTHy0ZqWxzYpEl7caDgZQAYD29+R+AQ+M4D8gSatYEtAiiC
 sNULc5rZAhThMxAzWNquS0y/zjqUO0zC6HHPWdV5lT6t0oOuzCE72MAqCOpEePJHPjDu
 R6igngloZJHh0WSPrWrwkqDWY1+We+4RiMKaJdEkY0tiU0LIdhzqcrTACRtXyZAEo/jO
 xRRQ==
X-Gm-Message-State: AOAM533R6AmNlgiI6kRedRk4ggHwMPlvZd5gVoIho/hrkMIVqsNRdxwC
 ddUkgWZXAUBqmZJUVNTw5dd29YM6v1QLMm3hxUHvAtf/f1VH4U4DuXV5snENkvvqjmNApbqQv1F
 81C9bvBkryh6160o=
X-Received: by 2002:adf:e908:: with SMTP id f8mr46788493wrm.3.1594027548257;
 Mon, 06 Jul 2020 02:25:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB6ndnGk4S/ucPxR0Gkanub9g96/76QBoMQnQDuo68VnmmKKAIzpK1N78OkYPeaXIaTMbS9A==
X-Received: by 2002:adf:e908:: with SMTP id f8mr46788482wrm.3.1594027548058;
 Mon, 06 Jul 2020 02:25:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3181:5745:c591:c33e?
 ([2001:b07:6468:f312:3181:5745:c591:c33e])
 by smtp.gmail.com with ESMTPSA id v7sm24322271wrp.45.2020.07.06.02.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 02:25:47 -0700 (PDT)
Subject: Re: [PATCH 0/2] Add new features for intel processor
To: Cathy Zhang <cathy.zhang@intel.com>, qemu-devel@nongnu.org
References: <1593991036-12183-1-git-send-email-cathy.zhang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40aa88ed-fc49-935a-18b6-96861e51b7c1@redhat.com>
Date: Mon, 6 Jul 2020 11:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1593991036-12183-1-git-send-email-cathy.zhang@intel.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/07/20 01:17, Cathy Zhang wrote:
> This patchset is to add two new features for intel processors
> which support them, like Sapphire Rapids. SERIALIZE is a faster
> serializing instruction which does not modify registers,
> arithmetic flags or memory, will not cause VM exit. TSX suspend
> load tracking instruction aims to give a way to choose which
> memory accesses do not need to be tracked in the TSX read set.
> 
> Cathy Zhang (2):
>   target/i386: Add SERIALIZE cpu feature
>   target/i386: Enable TSX Suspend Load Address Tracking feature
> 
>  target/i386/cpu.c | 4 ++--
>  target/i386/cpu.h | 4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> --
> 1.8.3.1
> 

Queued, thanks.

Paolo


