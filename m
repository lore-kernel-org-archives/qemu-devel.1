Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F423CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3902065F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3902065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5oo-00068P-2F
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jw5nx-0005bc-F6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:28:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:63254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jw5nu-0003PW-Kc
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:28:13 -0400
IronPort-SDR: IJCm5k0fnG4pyvfCvN0Pj5rFM2yRyW4T18+LyBiMCEODj6SJP4XY0Glk+LYOg6QVEWKmIyoeUQ
 IOMpcA1O1PKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="150783934"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; d="scan'208";a="150783934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 08:28:07 -0700
IronPort-SDR: n9UnzSGcLfDfzqPR9H+ltEaXZBH5uL9Is/cpeRjuIAYDdsNKogwIYOKQA5f4GFgZsSvw6WOvjx
 rTkGxRcTlmfA==
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; d="scan'208";a="460510984"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.31.173])
 ([10.255.31.173])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 08:28:06 -0700
Subject: Re: [PATCH 2/2] i386/cpu: Mask off unsupported XSAVE components
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200716082019.215316-1-xiaoyao.li@intel.com>
 <20200716082019.215316-3-xiaoyao.li@intel.com>
 <20200716151431.GK1274972@habkost.net>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <690a1ec5-e32c-7def-da27-16858d110e89@intel.com>
Date: Thu, 16 Jul 2020 23:28:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716151431.GK1274972@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 11:28:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/2020 11:14 PM, Eduardo Habkost wrote:
> On Thu, Jul 16, 2020 at 04:20:19PM +0800, Xiaoyao Li wrote:
>> When setting up XSAVE components, it needs to mask off those unsupported
>> by KVM.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> We must never disable CPUID features silently based on host
> capabilities, otherwise we can't guarantee guest ABI stability
> when migrating to another host.  Filtering of features should
> involve a call to mark_unavailable_features() (or some equivalent
> mechanism) so we can report the missing features properly through
> QMP.
> 
> Could you explain what's the bug you are trying to fix?  The loop
> at x86_cpu_filter_features() is already supposed to disable
> features unsupported by the host.

Sorry, I forgot x86_cpu_filter_features() totally when code inspection.

>> ---
>>   target/i386/cpu.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index f5f11603e805..efc92334b7b1 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6274,8 +6274,10 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>>           }
>>       }
>>   
>> -    env->features[FEAT_XSAVE_COMP_LO] = mask;
>> -    env->features[FEAT_XSAVE_COMP_HI] = mask >> 32;
>> +    env->features[FEAT_XSAVE_COMP_LO] = mask &
>> +        x86_cpu_get_supported_feature_word(FEAT_XSAVE_COMP_LO, cpu->migratable);
>> +    env->features[FEAT_XSAVE_COMP_HI] = (mask >> 32) &
>> +        x86_cpu_get_supported_feature_word(FEAT_XSAVE_COMP_HI, cpu->migratable);
>>   }
>>   
>>   /***** Steps involved on loading and filtering CPUID data
>> -- 
>> 2.18.4
>>
> 


