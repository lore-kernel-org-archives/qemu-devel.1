Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E8EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCAF206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCAF206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtB6X-0005Tu-7K
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 10:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtB5a-0004vW-OX
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 10:30:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:53226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtB5Y-0002ah-17
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 10:30:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CFC6CAC40;
 Wed,  8 Jul 2020 14:30:18 +0000 (UTC)
Subject: Re: [RFC v2 1/6] cpus: extract out TCG-specific code to accel/tcg
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200707135808.9241-1-cfontana@suse.de>
 <20200707135808.9241-2-cfontana@suse.de>
 <e8e8eab6-370b-46c9-ba51-e1e1416aaac2@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <2c2b0f73-bf29-1e99-9917-82b7b63b1fd7@suse.de>
Date: Wed, 8 Jul 2020 16:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e8e8eab6-370b-46c9-ba51-e1e1416aaac2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:20:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 6:58 PM, Paolo Bonzini wrote:
> On 07/07/20 15:58, Claudio Fontana wrote:
>> +
>> +CpusAccel tcg_cpus = {
>> +    .create_vcpu_thread = tcg_start_vcpu_thread,
>> +    .kick_vcpu_thread = tcg_kick_vcpu_thread,
>> +
>> +    .synchronize_post_reset = tcg_cpu_synchronize_noop,
>> +    .synchronize_post_init = tcg_cpu_synchronize_noop,
>> +    .synchronize_state = tcg_cpu_synchronize_noop,
>> +    .synchronize_pre_loadvm = tcg_cpu_synchronize_noop,
>> +};
> 
> Could this struct reside in AccelClass instead, so that there's no need
> to register the operations explicitly?

This I tried a few times before, you can dig the history a bit of the comments.

The result of my attempts is that you end up replacing an "explicit registration", with an explicit internal copy from a structure defined in kvm-cpus.c
(for example) to the accelerator state, so you just switch one registration for another.

The result is a pile of boilerplate of no use that is just confusing for the reader. 

> We could still cache it in a
> global variable in accel_init_machine, in order to avoid pointer chasing.

Indeed, the "cache" though ends up being the only useful thing,
and it can be even more confusing for the reader to see the whole machinery in AccelClass.

> 
> Thanks,
> 
> Paolo
> 

Still if you are interested to see what the result ends up being I can share it, will need some fiddling..

Ciao,

Claudio


