Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8AFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6F1207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6F1207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1cD-0006PG-Ju
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jh1bi-0005xa-E1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 21:57:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:47465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jh1bg-00063U-Ua
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 21:57:18 -0400
IronPort-SDR: smHpSY8GqLFdJ8kjYPRdEOX/EHMpa4+68GD06/6IrxJJLvkz2eifD04/i7TGQDRTIESm7X9PhZ
 yr1mhbQ4Wfew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:57:12 -0700
IronPort-SDR: HIXxoyO/PCscPKLBTKn6VPU1cZFQufCvumE5wTrv0vRUbMaa27IsSAw7NXJw4GQKnbToINtAMw
 6Th53IT0eeUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,474,1583222400"; d="scan'208";a="445722546"
Received: from unknown (HELO [10.239.13.113]) ([10.239.13.113])
 by orsmga005.jf.intel.com with ESMTP; 04 Jun 2020 18:57:08 -0700
Message-ID: <5ED9A81F.6070008@intel.com>
Date: Fri, 05 Jun 2020 10:04:15 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Richard Henderson <richard.henderson@linaro.org>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3] migration/xbzrle: add encoding rate
References: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
 <CAFXwXrm4R5nxk6ruTJ2kP5dUnF7Qm3TfRRiKVAUDNA1uwYf65w@mail.gmail.com>
 <5ED86344.4020505@intel.com>
 <4b9cd244-0d96-d1c8-11ec-b61a6bc2bfaa@linaro.org>
 <20200604093828.GB2851@work-vm> <5ED8CC78.90006@intel.com>
 <26a232a7-8ec6-da2c-348f-41da899cdc9a@linaro.org>
In-Reply-To: <26a232a7-8ec6-da2c-348f-41da899cdc9a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wei.w.wang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:57:14
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kevin.tian@intel.com, Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/2020 12:57 AM, Richard Henderson wrote:
> On 6/4/20 3:27 AM, Wei Wang wrote:
>> On 06/04/2020 05:38 PM, Dr. David Alan Gilbert wrote:
>>> Hmm OK; I'll admit to not liking NaN/Inf in output.
>>>
>>> Dave
>>>
>> OK. To deal with the reported issue, how about using FLT_MAX (as opposed to
>> UINT64_MAX or inf):
>> xbzrle_counters.encoding_rate = FLT_MAX;
> So you'd rather see 340282346638528859811704183484516925440.00 printed?
>
> It's arbitrary and not correct in any mathematical sense.
>
> If you *really* insist on not printing Inf (which may have some diagnostic
> value), then 0 is just as arbitrary, and at least smaller in the output.

0 works fine (though it logically means the lowest encoding rate).
I slightly prefer the biggest number or inf, which naturally means it's 
very encoding friendly.
Let's see if Dave has any thought about the choices :)

Best,
Wei


