Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09730C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F1F2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F1F2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc5Kh-0002Ga-TV
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 06:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jc5Jw-0001dI-OV
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:54:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:38024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jc5Jv-0002TJ-Tw
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:54:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 40F51AC37;
 Fri, 22 May 2020 10:54:32 +0000 (UTC)
Subject: Re: [RFC 1/3] cpu-throttle: new module, extracted from cpus.c
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200521185407.25311-1-cfontana@suse.de>
 <20200521185407.25311-2-cfontana@suse.de>
 <1934989075.27890087.1590127622669.JavaMail.zimbra@redhat.com>
 <e64d5b81-8759-15ca-2486-dcc8ed10edc0@suse.de> <87r1vce04i.fsf@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <e3c07225-b502-6bbc-3c6d-eda54b429c91@suse.de>
Date: Fri, 22 May 2020 12:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1vce04i.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 23:56:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>, Colin Xu <colin.xu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 12:26 PM, Alex Bennée wrote:
> 
> Claudio Fontana <cfontana@suse.de> writes:
> 
>> On 5/22/20 8:07 AM, Thomas Huth wrote:
>>>> From: "Claudio Fontana" <cfontana@suse.de>
>>>> Sent: Thursday, May 21, 2020 8:54:05 PM
>>>>
>>>> this is a first step in the refactoring of cpus.c.
>>>
>>> Could you maybe extend the commit message in the next version a little bit? ... say something about *what* you are moving to a separate file (and maybe why it is ok to move it), etc.?
>>>
>>>  Thanks,
>>>   Thomas
>>>
>>>
>>
>> Hello Thomas,
>>
>> thanks for taking a look, I will add an explanatory message.
>>
>> I was thinking something along the lines of:
>>
>> "
>> move the vcpu throttling functionality into its own module.
>> It contains the controls to adjust and inspect vcpu throttling settings, start (set) and stop
>> vcpu throttling, and the throttling function itself that is run periodically on vcpus
>> to make them take a nap.
>> Execution of the throttling function on all vcpus is triggered by a timer,
>> registered at module initialization.
>>
>> No functionality change.
>> "
> 
> Is vcpu throttling a TCG only feature?
> 

No, are you suggesting we only refactor code out of cpus.c based on whether it's tcg or not?

Ciao,

Claudio

