Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA6C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F90206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XizbppCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F90206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aKf-0001kv-HZ
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j1aJO-0000aO-2K
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j1aJN-0000yw-1C
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:31:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j1aJM-0000y3-TD
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581445864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQe3nGagGzeCsufC3rqZRuUQ8B4VGRBcrcOfQrGBV8w=;
 b=XizbppCkcIq3S0jPR6Yg3/Y+HDcyF02GFLkUuS+eqEqnhruL49WoKpIjI40/YDmU0CcGE5
 FxxH19lIGS8qlUcOo+uE6iQwKluCR30kSE1VFvNyGnzE0Uigbzn3EgNZc2JYdQYSq3FxwQ
 KQvD88omyJGCgb1qA5XQDq1/s5+E8G0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-MhMVp186MkW1lxqSwApFkQ-1; Tue, 11 Feb 2020 13:31:00 -0500
X-MC-Unique: MhMVp186MkW1lxqSwApFkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ED611005510;
 Tue, 11 Feb 2020 18:30:58 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8935689F38;
 Tue, 11 Feb 2020 18:30:53 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 6/9] arm: pmu: Test chained counter
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-7-eric.auger@redhat.com>
 <CAFEAcA_jfZKjey8komTt97Mu-oFjWyFNG2cY4-o8yFAP1oGiug@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5f11c69b-655a-2fa9-462f-9fd6ebdb501d@redhat.com>
Date: Tue, 11 Feb 2020 19:30:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_jfZKjey8komTt97Mu-oFjWyFNG2cY4-o8yFAP1oGiug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Andrew Jones <drjones@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Murray <andrew.murray@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, kvmarm@lists.cs.columbia.edu,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/11/20 5:24 PM, Peter Maydell wrote:
> On Thu, 30 Jan 2020 at 11:26, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Add 2 tests exercising chained counters. The first one uses
>> CPU_CYCLES and the second one uses SW_INCR.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> +static void test_chained_sw_incr(void)
>> +{
>> +       uint32_t events[] = { 0x0 /* SW_INCR */, 0x0 /* SW_INCR */};
> 
> Cut-n-paste error? This test relies on the CHAIN event but it
> isn't present in this list of events to pass to satisfy_prerequisites(),
> so I suspect the second element should be "0x1e /* CHAIN */" ?
No that's not a cut-n-paste error. I may rename the test into test_sw_incr.

It starts by testing unchained SW_INCR.

chained SW_INCR testing start with
/* 64b SW_INCR */


> 
> (This makes the test fail on QEMU TCG, because we don't implement
> CHAIN.)
OK

Thanks

Eric
> 
> thanks
> -- PMM
> 


