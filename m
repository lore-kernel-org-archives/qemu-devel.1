Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44170C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2100F207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2100F207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFvO-0000JB-B9
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 14:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jlFuR-0007ui-1X
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 14:02:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jlFuO-0000cR-I0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 14:02:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7B55FAF34;
 Tue, 16 Jun 2020 18:02:06 +0000 (UTC)
Subject: Re: [RFC v5 4/4] cpus: extract out accel-specific code to each accel
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200615180346.3992-1-cfontana@suse.de>
 <20200615180346.3992-5-cfontana@suse.de> <87y2onyu39.fsf@linaro.org>
 <75a85b11-6241-ebce-9fb9-ca92fdfba5de@suse.de> <87wo46yk1y.fsf@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <51d850dc-b488-e1d8-2e96-f1eb0df67f50@suse.de>
Date: Tue, 16 Jun 2020 20:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87wo46yk1y.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 23:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 7:52 PM, Alex Bennée wrote:
> 
> Claudio Fontana <cfontana@suse.de> writes:
> 
>> Hi Alex,
>>
>> thanks for looking at this,
>>
>> On 6/16/20 4:16 PM, Alex Bennée wrote:
>>>
>>> Claudio Fontana <cfontana@suse.de> writes:
>>>
>>>> each accelerator registers a new "CpusAccel" interface
>>>> implementation on initialization, providing functions for
>>>> starting a vcpu, kicking a vcpu, and sychronizing state.
>>>>
>>>> This way the code in cpus.c is now all general softmmu code,
>>>> nothing accelerator-specific anymore.
>>>>
>>>> There is still some ifdeffery for WIN32 though.
>>>>
>>>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>>>> ---
>>>>  MAINTAINERS                   |   1 +
>>>>  accel/Makefile.objs           |   2 +-
>>>>  accel/kvm/Makefile.objs       |   2 +
>>>>  accel/kvm/kvm-all.c           |  15 +-
>>>>  accel/kvm/kvm-cpus.c          |  94 +++++
>>>>  accel/kvm/kvm-cpus.h          |  17 +
>>>>  accel/qtest/Makefile.objs     |   2 +
>>>>  accel/qtest/qtest-cpus.c      | 105 +++++
>>>>  accel/qtest/qtest-cpus.h      |  17 +
>>>>  accel/{ => qtest}/qtest.c     |   7 +
>>>>  accel/stubs/kvm-stub.c        |   3 +-
>>>>  accel/tcg/Makefile.objs       |   1 +
>>>>  accel/tcg/tcg-all.c           |  12 +-
>>>>  accel/tcg/tcg-cpus.c          | 523 ++++++++++++++++++++++++
>>>>  accel/tcg/tcg-cpus.h          |  17 +
>>>>  hw/core/cpu.c                 |   1 +
>>>>  include/sysemu/cpus.h         |  32 ++
>>>>  include/sysemu/hw_accel.h     |  57 +--
>>>>  include/sysemu/kvm.h          |   2 +-
>>>>  softmmu/cpus.c                | 911 ++++--------------------------------------
>>>>  stubs/Makefile.objs           |   1 +
>>>>  stubs/cpu-synchronize-state.c |  15 +
>>>>  target/i386/Makefile.objs     |   7 +-
>>>>  target/i386/hax-all.c         |   6 +-
>>>>  target/i386/hax-cpus.c        |  85 ++++
>>>>  target/i386/hax-cpus.h        |  17 +
>>>>  target/i386/hax-i386.h        |   2 +
>>>>  target/i386/hax-posix.c       |  12 +
>>>>  target/i386/hax-windows.c     |  20 +
>>>>  target/i386/hvf/Makefile.objs |   2 +-
>>>>  target/i386/hvf/hvf-cpus.c    | 141 +++++++
>>>>  target/i386/hvf/hvf-cpus.h    |  17 +
>>>>  target/i386/hvf/hvf.c         |   3 +
>>>>  target/i386/whpx-all.c        |   3 +
>>>>  target/i386/whpx-cpus.c       |  96 +++++
>>>>  target/i386/whpx-cpus.h       |  17 +
>>>>  36 files changed, 1362 insertions(+), 903 deletions(-)
>>>>  create mode 100644 accel/kvm/kvm-cpus.c
>>>>  create mode 100644 accel/kvm/kvm-cpus.h
>>>>  create mode 100644 accel/qtest/Makefile.objs
>>>>  create mode 100644 accel/qtest/qtest-cpus.c
>>>>  create mode 100644 accel/qtest/qtest-cpus.h
>>>>  rename accel/{ => qtest}/qtest.c (86%)
>>>>  create mode 100644 accel/tcg/tcg-cpus.c
>>>>  create mode 100644 accel/tcg/tcg-cpus.h
>>>>  create mode 100644 stubs/cpu-synchronize-state.c
>>>>  create mode 100644 target/i386/hax-cpus.c
>>>>  create mode 100644 target/i386/hax-cpus.h
>>>>  create mode 100644 target/i386/hvf/hvf-cpus.c
>>>>  create mode 100644 target/i386/hvf/hvf-cpus.h
>>>>  create mode 100644 target/i386/whpx-cpus.c
>>>>  create mode 100644 target/i386/whpx-cpus.h
>>>
>>> Predictably for such a spider patch I got a bunch of conflicts
>>> attempting to merge on my testing branch so only a few comments.
>>>
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index f308537d42..ef8cbb2680 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -427,6 +427,7 @@ WHPX CPUs
>>>>  M: Sunil Muthuswamy <sunilmut@microsoft.com>
>>>>  S: Supported
>>>>  F: target/i386/whpx-all.c
>>>> +F: target/i386/whpx-cpus.c
>>>>  F: target/i386/whp-dispatch.h
>>>>  F: accel/stubs/whpx-stub.c
>>>>  F: include/sysemu/whpx.h
>>>> diff --git a/accel/Makefile.objs b/accel/Makefile.objs
>>>> index ff72f0d030..c5e58eb53d 100644
>>>> --- a/accel/Makefile.objs
>>>> +++ b/accel/Makefile.objs
>>>> @@ -1,5 +1,5 @@
>>>>  common-obj-$(CONFIG_SOFTMMU) += accel.o
>>>> -obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
>>>> +obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest/
>>>
>>> This does raise the question if qtest is "just another" accelerator then
>>> should we not be creating a CONFIG_QTEST symbol for explicitness?
>>>
>>>>  obj-$(CONFIG_KVM) += kvm/
>>>>  obj-$(CONFIG_TCG) += tcg/
>>>>  obj-$(CONFIG_XEN) += xen/
>>> <snip>
>>>> +static void *qtest_cpu_thread_fn(void *arg)
>>>> +{
>>>> +#ifdef _WIN32
>>>> +    error_report("qtest is not supported under Windows");
>>>> +    exit(1);
>>>> +#else
>>>
>>> This is literally impossible to build isn't it?
>>>>  
>>>>  static int qtest_init_accel(MachineState *ms)
>>>>  {
>>>> +    cpus_register_accel(&qtest_cpus);
>>>>      return 0;
>>>>  }
>>>
>>> I wonder if these register functions could be moved to initfns like we
>>> use for our hardware models?
>>
>> The context is the configure_accelerator() in vl.c , where we loop over possible candidate accelerators
>> and try to initialize them.
>>
>> In this RFC the cpus_register_accel is triggered at accel_init_machine() time,
>> in the accelerator class init_machine() method, where we are trying to use a specific accelerator.
>>
>> This is the case for qtest like for the other AccelClass types (tcg and the hardware accelerators).
>>
>> If not in init_machine(), where would the registration best happen?
> 
> Ahh I see - this is once the decision about which accelerator has been
> made. I was thinking along the lines of the init functions driven by:
> 
>   #define type_init(function) module_init(function, MODULE_INIT_QOM)
> 
> which would then populate the list of available accelerators in a more
> QOM like manner. I assume having a completely configurable set of
> accelerators is the eventual aim of this?


Yes, in my plan the change to add target-specific modules and eventually CONFIG_TCG=m, CONFIG_KVM=m etc is basically the last step, the way I see it.

tentative plan is at:

https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html


> 
>>
>>>
>>> <snip>
>>>>  
>>>> +/*
>>>> + * every accelerator is supposed to register this.
>>>> + * Could be in the AccelClass instead, but ends up being too complicated
>>>> + * to access in practice, and inefficient for each call of each method.
>>>> + */
>>>> +static CpusAccel cpus_accel;
>>>> +
>>>
>>> wait what? Does an indirection cause that much trouble? I'm surprised
>>> given how often we use it elsewhere in the code. I guess others might
>>
>> CpusAccel is not used elsewhere currently in the codebase, it's new, or what do you mean?
>>
>>> argue for a full QOM-ification of the accelerator but I think we can at
>>> least have an indirection rather than a copy of the structure.
>>>
>>>
>>
>> As mentioned in v3 and v2, this is what we end up if we put CpusAccel inside the AccelClass,
>> every time we need a vcpu kick, sync state, etc:
>>
>> 1) current_accel() function call
>> 2) pointer dereference (->accelerator)
>> 3) object_class_dynamic_cast_assert function call (ACCEL_GET_CLASS -> OBJECT_CLASS_CHECK)
>> 4) pointer dereference (-> AccelCpusInterface)
>> 5) pointer dereference (-> method)
>> 6) function call ( ->synchronize_state(cpu))
>>
>> So the code then would look like this (more or less, probably I would put also an assert for non-NULL in there):
>>
>> VERSION A)
>>
>> void cpu_synchronize_state(CPUState *cpu)
>> {
>>     ACCEL_GET_CLASS(current_accel())->cpus_int->synchronize_state(cpu);
>> }
> 
> I don't think it has to be quite so extreme. I was just arguing for
> something along the lines of:
> 
> static CpuAccel *accel;
> 
> and
> 
> void cpu_synchronize_state(CPUState *cpu)
> {
>    if (accel && accel->synchronize_state) {
>       accel->synchronize_state(cpu);
>    }
> }
> 
>> Instead with the current RFC code, this is what we end up with every
>> time we need a vcpu kick, sync state, etc:
> 
> I don't think a pointer de-reference alone is super critical for
> something that happens on the outside of the main run loop. It might be
> a different argument if this was somewhere in the hot path.
> 
>> Are you arguing in favor of VERSION A) here?
> 
> Version C ;-)

Aha, ok I am comfortable with version C.

> 
>>
>> I would like to have an ACK from the owners of the hardware accels especially that the additional overhead in this code path
>> is of negligible importance..
>>
>>
>> Thank you for your comments,
>>

Ciao,

Claudio

