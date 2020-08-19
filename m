Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D55C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6FF204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6FF204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8OV9-000665-D6
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k8OUW-0005FG-RI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k8OUV-0003XS-7G
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:51:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 723B3B181;
 Wed, 19 Aug 2020 13:51:24 +0000 (UTC)
Subject: Re: [PATCH v5 10/14] cpus: add handle_interrupt to the CpusAccel
 interface
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-11-cfontana@suse.de>
 <ee2b8640-2446-32f8-47c3-b327db42f7b7@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <334f0459-0947-ac98-418f-6118c1b99eec@suse.de>
Date: Wed, 19 Aug 2020 15:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ee2b8640-2446-32f8-47c3-b327db42f7b7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:55:57
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 11:01 PM, Richard Henderson wrote:
> On 8/12/20 11:32 AM, Claudio Fontana wrote:
>> +static void generic_handle_interrupt(CPUState *cpu, int mask)
>> +{
>> +    cpu->interrupt_request |= mask;
>> +
>> +    if (!qemu_cpu_is_self(cpu)) {
>> +        qemu_cpu_kick(cpu);
>> +    }
>> +}
>> +
>> +void cpu_interrupt(CPUState *cpu, int mask)
>> +{
>> +    if (cpus_accel && cpus_accel->handle_interrupt) {
>> +        cpus_accel->handle_interrupt(cpu, mask);
>> +    } else {
>> +        generic_handle_interrupt(cpu, mask);
>> +    }
>> +}
> 
> First, by this point you have converted all of the accelerators, so I would
> expect cpus_accel to always be non-null.  I would expect a patch immediately
> preceding this one to place an assert to that effect somewhere in the startup
> code, and to remove all of the checks.

Ok.

> 
> Second, I would prefer that all methods be non-null, so that you don't need to
> check that either.  

This contrasts a bit with the previous comments by Paolo to try to express only the "interesting" bits in the CpusAccel struct in each module.


> This patch would add generic_handle_interrupt (perhaps
> named cpus_accel_default_handle_interrupt declared in sysemu/cpus.h?) to the
> CpusAccel structure of all except TCG.
> 
> Similarly for all other methods that are checking non-null-ness of the method
> pointer.  Perhaps assert non-null for each method in cpus_register_accel().
> 
> 
> r~
> 

That was my initial approach in very old versions of the series (all fields as explicit and mandatory),
I changed direction there due to Paolo's comments. For me both solutions are fine, each has its merits and downsides.

Thanks,

Claudio



