Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48FBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA5B20781
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHIrpmHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA5B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jom7Y-000881-Qw
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jom60-0006yL-Qp
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:00:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jom5y-0006RR-VY
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593169234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/yykV+lwvVzOYy2lLamhstqzS+CbiCk+L/CLfyRGNk=;
 b=BHIrpmHQZBeqOqDsA4ltjcbbDd+Unb8xxoEZjoCuH7wwf6IuY4gTYv7eBH4hlx48tSZ4dC
 4xKQYOf81m4K8kFeR+xAsXy0cCFDogWgIWvRe0+/0QfnaBb1Ay3h/dkIcujf9tXjKfbOLF
 /beS0RfHXNKDo5jWd0ew0SHDU/I+1Cg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-J7e6M59mMdC8UrSxSeJX3Q-1; Fri, 26 Jun 2020 07:00:31 -0400
X-MC-Unique: J7e6M59mMdC8UrSxSeJX3Q-1
Received: by mail-wr1-f69.google.com with SMTP id p10so10234038wrn.19
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r/yykV+lwvVzOYy2lLamhstqzS+CbiCk+L/CLfyRGNk=;
 b=qjWzCoo4kRLSct/POpC8LkKEluFb3rZ0C1+kllYRDbjfrbMHijju19k3OVCXlypBf0
 L3toRfC4xmvBCaPV5Pf6AH5wDAajVikZhyI4rDRhNFeLzRJJNOPb+VgoSvLza0oIwuNN
 nVEzlO10OEGG0P8yM+5TUTh5varAxtil2AXDiINToOxV/gfKO0oLuvc7adZ9SOUqDQu+
 7b77pLnkuAecG41flhyCZit8SGqonZhxtdNnMy7o/SlmNm7Qs58oXBs+OtGsChxbgy4a
 /gyo9vwx4wkd6pSGD+tj3I0RVB+pxAGm1C/KAVy+lHGSxmzF0DiXRTIgLwtzbaVDERwa
 IOng==
X-Gm-Message-State: AOAM5339QPRoz52DyBZVhtpvUO2hqyiPTz/mgP9mgL75AbhhQ/RvWnjZ
 Q0q5SZd/HOtaUqh+JIpccIN6PEk9GU6A15f291ZICofR8MAudd8kFGVl+tWZoCFX8Y8/wydPvs3
 ilN2UIqgFYD0CBgM=
X-Received: by 2002:adf:f751:: with SMTP id z17mr3286776wrp.114.1593169230860; 
 Fri, 26 Jun 2020 04:00:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPWZZcACd9drtmL7bIvHzcyGYYMdYb11fWo/NwKUZtaNy3Pb+ddyaSkoBmKt006/hlnv6kLA==
X-Received: by 2002:adf:f751:: with SMTP id z17mr3286755wrp.114.1593169230665; 
 Fri, 26 Jun 2020 04:00:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80?
 ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
 by smtp.gmail.com with ESMTPSA id a12sm26355761wrv.41.2020.06.26.04.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 04:00:30 -0700 (PDT)
Subject: Re: [PATCH 0/2] target/i386: SSE floating-point fixes
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006252355430.3832@digraph.polyomino.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec870b14-786d-5f77-0175-66161b338a2e@redhat.com>
Date: Fri, 26 Jun 2020 13:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006252355430.3832@digraph.polyomino.org.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/20 01:57, Joseph Myers wrote:
> Fix some issues relating to SSE floating-point emulation.  The first
> patch fixes a problem with the handling of the FTZ bit that was found
> through the testcase written for the second patch.  Rather than
> writing a separate standalone test for that bug, it seemed sufficient
> for the testcase in the second patch to cover both patches.
> 
> The style checker will produce its usual inapplicable warnings about
> use of "volatile" in the testcase and about C99 hex float constants.
> 
> Joseph Myers (2):
>   target/i386: set SSE FTZ in correct floating-point state
>   target/i386: fix IEEE SSE floating-point exception raising
> 
>  target/i386/cpu.h                         |   1 +
>  target/i386/fpu_helper.c                  |  35 +-
>  target/i386/gdbstub.c                     |   1 +
>  target/i386/helper.c                      |   1 +
>  target/i386/helper.h                      |   1 +
>  target/i386/ops_sse.h                     |  28 +-
>  target/i386/translate.c                   |   1 +
>  tests/tcg/i386/Makefile.target            |   4 +
>  tests/tcg/i386/test-i386-sse-exceptions.c | 813 ++++++++++++++++++++++
>  9 files changed, 872 insertions(+), 13 deletions(-)
>  create mode 100644 tests/tcg/i386/test-i386-sse-exceptions.c
> 

Queued, thanks.

Paolo


