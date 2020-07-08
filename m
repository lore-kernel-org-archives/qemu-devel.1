Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E935C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 07:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EAF20739
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 07:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EAF20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt4hy-0006qy-Cy
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 03:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jt4hQ-0006SS-8V
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 03:41:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jt4hO-0002E2-Mj
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 03:40:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5E228AC40;
 Wed,  8 Jul 2020 07:40:56 +0000 (UTC)
Subject: Re: [RFC v2 3/6] cpus: extract out kvm-specific code to accel/kvm
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200707135808.9241-1-cfontana@suse.de>
 <20200707135808.9241-4-cfontana@suse.de>
 <dc01dc35-c053-656c-72f5-87cad56706fb@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <3f7f56ea-7b1d-106d-9f84-2d618aa5e7c9@suse.de>
Date: Wed, 8 Jul 2020 09:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <dc01dc35-c053-656c-72f5-87cad56706fb@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ciao Paolo,

On 7/7/20 7:01 PM, Paolo Bonzini wrote:
> On 07/07/20 15:58, Claudio Fontana wrote:
>> +static void kvm_kick_vcpu_thread(CPUState *cpu)
>> +{
>> +    cpus_kick_thread(cpu);
>> +}
>> +
> 
> I would just use cpus_kick_thread instead of wrapping it (and likewise

Here I left the common code in cpus_kick_thread, which is just used "as is" for kvm,
but for hax f.e. we have:

void hax_kick_vcpu_thread(CPUState *cpu)
{
    /*
     * FIXME: race condition with the exit_request check in
     * hax_vcpu_hax_exec
     */
    cpu->exit_request = 1;
    cpus_kick_thread(cpu);
}

Maybe we will need additional code that specializes the kick also for HVF?

I cannot run cpus_kick_thread for _all_ accels, because it is not good for Windows (whpx and hax-windows).


> would provide a global function for noop synchronization).

I will look into providing global noops, thanks!

> 
> start_vcpu_thread is also a candidate for abstraction, so that

Thanks, will look into this!
The accel that I expect will resist this will be tcg, but will try to fit it.


> kvm_start_vcpu_thread(CPUState *cpu) would be just
> 
> 	qemu_start_vcpu_thread(cpu, "KVM", kvm_vcpu_thread_fn);
> 
> Paolo
> 
> 

Ciao,

Claudio

