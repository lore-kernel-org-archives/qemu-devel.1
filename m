Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA50C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B6E2071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B6E2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFG9-00045c-3n
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdFFI-0003g6-0s
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdFFH-0006EC-2H
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:42:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6C169B229;
 Mon, 25 May 2020 15:42:31 +0000 (UTC)
Subject: Re: [RFC v3 2/4] cpu-throttle: new module, extracted from cpus.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-3-cfontana@suse.de>
 <99995c3f-68a3-ce07-72bb-37a9b2263e52@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <c1387681-fe93-d42b-c2b6-40b91c6801f1@suse.de>
Date: Mon, 25 May 2020 17:42:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <99995c3f-68a3-ce07-72bb-37a9b2263e52@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:03:51
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Colin Xu <colin.xu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 5:14 PM, Philippe Mathieu-Daudé wrote:
> On 5/25/20 4:54 PM, Claudio Fontana wrote:
>> move the vcpu throttling functionality into its own module.
>>
>> This functionality is not specific to any accelerator,
>> and it is used currently by migration to slow down guests to try to
>> have migrations converge, and by the cocoa MacOS UI to throttle speed.
>>
>> cpu-throttle contains the controls to adjust and inspect throttle
>> settings, start (set) and stop vcpu throttling, and the throttling
>> function itself that is run periodically on vcpus to make them take a nap.
>>
>> Execution of the throttling function on all vcpus is triggered by a timer,
>> registered at module initialization.
>>
>> No functionality change.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  MAINTAINERS                   |   3 +-
>>  include/hw/core/cpu.h         |  37 -------------
>>  include/qemu/main-loop.h      |   5 ++
>>  include/sysemu/cpu-throttle.h |  50 +++++++++++++++++
>>  migration/migration.c         |   1 +
>>  migration/ram.c               |   1 +
>>  softmmu/Makefile.objs         |   1 +
>>  softmmu/cpu-throttle.c        | 122 ++++++++++++++++++++++++++++++++++++++++++
>>  softmmu/cpus.c                |  95 +++-----------------------------
>>  9 files changed, 190 insertions(+), 125 deletions(-)
>>  create mode 100644 include/sysemu/cpu-throttle.h
>>  create mode 100644 softmmu/cpu-throttle.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0288ffbc50..708768f120 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2147,13 +2147,14 @@ F: ui/cocoa.m
>>  Main loop
>>  M: Paolo Bonzini <pbonzini@redhat.com>
>>  S: Maintained
>> -F: softmmu/cpus.c
>>  F: include/qemu/main-loop.h
>>  F: include/sysemu/runstate.h
>>  F: util/main-loop.c
>>  F: util/qemu-timer.c
>>  F: softmmu/vl.c
>>  F: softmmu/main.c
>> +F: softmmu/cpus.c
> 
> This line belong the the previous patch (#1).

right

> 
>> +F: softmmu/cpu-throttle.c
>>  F: qapi/run-state.json
> 
> Can you reorder patches #1/#2 to avoid moving cpu-throttle code twice?


I have no preference, will wait for more comments then, as you suggested elsewhere.


> 
> Otherwise this patch looks good.
> 
> [...]
> 
> 


