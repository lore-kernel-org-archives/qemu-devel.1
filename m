Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED84D2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxGAutmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED84D2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4Th-0001p2-Td
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4Sn-0001PF-NL
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4Sk-0002Gq-UV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxvFaqom+skH4O7lWBVhU47oYcowGpvlc8pG2AyZlJ8=;
 b=cxGAutmZPphT1Nqbi3RARKfnLp0+Lu3n0p4E2SX41kyJaO4onlL2aG0U9tCIfL4FaGbbNT
 Bpq9WMxKWEI/3vGRsi/uVc9NEi8ey70nykDyLoDDhped6+i2wjp8+ak5kZF1M91+TETBgp
 N+1EcL6f0nRT9A/ReezfdzjsBc/M8os=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-x-v-E01tN-yhv_-Oi7dyjw-1; Mon, 12 Oct 2020 16:30:27 -0400
X-MC-Unique: x-v-E01tN-yhv_-Oi7dyjw-1
Received: by mail-wm1-f70.google.com with SMTP id u207so6045390wmu.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 13:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qxvFaqom+skH4O7lWBVhU47oYcowGpvlc8pG2AyZlJ8=;
 b=GaxDWPfuhbcCfTbg07jIPgNFH0VZhu8iSckdyoJCyeyQaDEVwhauXafi+DGEgRnhWC
 37h4AHVMrmkTX6InU5msjaWkLdBp00gR7MsOK4J1apJKwL1VA4kZXkL0rwQY3oG6Ir1L
 mQdNvwP2XdOk8DHJuEkZBysNk/7krV+DdejR0Hd6l1kCbi/FGpbJKROpf4vcHBAiP2LO
 NoDnfUDr/im7LlbHhzEHlV7XNYrM69/EddYqWpF13j5w3RRCv2vyS5XO9oQcB5eycr6T
 dUy6KnfqSuq/+GtUBABsU1Q6HFVYcQ3vOMgFbv8BOd1q3r8kpHLJ95puUhZuP1HSd1nu
 tZGA==
X-Gm-Message-State: AOAM532+hOfwwHaDsTT41g3p3Q1fUIPuIMGCDbdeh6h9QzDAz4u5nAj6
 CzS0NvdUFtdsjSyJCtKsKrbejOCc6zhy6XOCdPbR1kG3CKA6LPFwPiuasUdWghyxi+wkBfMGqEO
 bVbRnGfGcXjC0y48=
X-Received: by 2002:a1c:8057:: with SMTP id b84mr12102170wmd.116.1602534626093; 
 Mon, 12 Oct 2020 13:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziuhEhtxgM/aR9Dc2OXEc5/nmukT/LutTzcq/yWKcLfgfuUzEy5uieN2gqXsvtnoWoVCVvKw==
X-Received: by 2002:a1c:8057:: with SMTP id b84mr12102159wmd.116.1602534625870; 
 Mon, 12 Oct 2020 13:30:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5a47:91d0:18ce:e295?
 ([2001:b07:6468:f312:5a47:91d0:18ce:e295])
 by smtp.gmail.com with ESMTPSA id p67sm24766079wmp.11.2020.10.12.13.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 13:30:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] accel: move qtest CpusAccel functions to a common
 location
To: Claudio Fontana <cfontana@suse.de>, Jason Andryuk <jandryuk@gmail.com>,
 qemu-devel@nongnu.org
References: <20201012200725.64137-1-jandryuk@gmail.com>
 <20201012200725.64137-2-jandryuk@gmail.com>
 <f29b58c7-62c5-ad10-91c8-47598759c876@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f99e620-8356-a67f-1741-4e1c607795e1@redhat.com>
Date: Mon, 12 Oct 2020 22:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f29b58c7-62c5-ad10-91c8-47598759c876@suse.de>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/20 22:23, Claudio Fontana wrote:
> On 10/12/20 10:07 PM, Jason Andryuk wrote:
>> Move and rename accel/qtest/qtest-cpu.* files to accel/dummy/ so they
>> can be re-used by Xen.
>>
>> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
>> ---
>>  .../qtest-cpus.c => dummy/dummy-cpus.c}       | 22 +++++--------------
>>  .../qtest-cpus.h => dummy/dummy-cpus.h}       | 10 ++++-----
>>  accel/dummy/meson.build                       |  6 +++++
>>  accel/meson.build                             |  1 +
>>  accel/qtest/meson.build                       |  1 -
>>  accel/qtest/qtest.c                           |  7 +++++-
>>  6 files changed, 23 insertions(+), 24 deletions(-)
>>  rename accel/{qtest/qtest-cpus.c => dummy/dummy-cpus.c} (76%)
>>  rename accel/{qtest/qtest-cpus.h => dummy/dummy-cpus.h} (59%)
>>  create mode 100644 accel/dummy/meson.build

Maybe accel/dummy-cpus.c, no need to add a new directory.

>> diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
>> index 537e8b449c..ac54bc8f52 100644
>> --- a/accel/qtest/qtest.c
>> +++ b/accel/qtest/qtest.c
>> @@ -25,7 +25,12 @@
>>  #include "qemu/main-loop.h"
>>  #include "hw/core/cpu.h"
>>  
>> -#include "qtest-cpus.h"
>> +#include "accel/dummy/dummy-cpus.h"
> 
> this is a bit strange from my perspective, does not look right.
> 
> Maybe this dummy cpu prototype should be somewhere in include/ ,
> like include/sysemu/cpus.h or even better include/sysemu/accel.h

Yes, it should be in include/sysemu/cpus.h.

Paolo

>> +
>> +const CpusAccel qtest_cpus = {
>> +    .create_vcpu_thread = dummy_start_vcpu_thread,
>> +    .get_virtual_clock = qtest_get_virtual_clock,
>> +};
>>  
>>  static int qtest_init_accel(MachineState *ms)
>>  {
>>
> 


