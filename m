Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219C4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2442071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2442071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFBZ-00088x-5g
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdFAt-0007DF-Og
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:38:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdFAr-0005N8-EK
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:37:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A667EAC6D;
 Mon, 25 May 2020 15:37:58 +0000 (UTC)
Subject: Re: [RFC v3 4/4] cpus: extract out accel-specific code to each accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-5-cfontana@suse.de>
 <13391945-0948-1236-f854-57aa68601662@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <73820c78-f0b9-18d3-5ce0-0e9d73b6a92c@suse.de>
Date: Mon, 25 May 2020 17:37:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <13391945-0948-1236-f854-57aa68601662@redhat.com>
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
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, haxm-team@intel.com,
 Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 5:22 PM, Philippe Mathieu-Daudé wrote:
> On 5/25/20 4:54 PM, Claudio Fontana wrote:
>> each accelerator registers a new "CpusAccelInterface"
>> on initialization, providing functions for starting a vcpu,
>> kicking a vcpu, and sychronizing state.
>>
>> This way the code in cpus.cc is now all general softmmu code,
>> nothing (or almost nothing) accelerator-specific anymore.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  MAINTAINERS                          |   1 +
>>  accel/kvm/Makefile.objs              |   2 +
>>  accel/kvm/kvm-all.c                  |  15 +-
>>  accel/kvm/kvm-cpus-interface.c       |  94 ++++
>>  accel/kvm/kvm-cpus-interface.h       |   8 +
>>  accel/qtest.c                        |  82 ++++
>>  accel/stubs/kvm-stub.c               |   3 +-
>>  accel/tcg/Makefile.objs              |   1 +
>>  accel/tcg/tcg-all.c                  |  12 +-
>>  accel/tcg/tcg-cpus-interface.c       | 523 ++++++++++++++++++++
>>  accel/tcg/tcg-cpus-interface.h       |   8 +
>>  hw/core/cpu.c                        |   1 +
>>  include/sysemu/cpus.h                |  32 ++
>>  include/sysemu/hvf.h                 |   1 -
>>  include/sysemu/hw_accel.h            |  57 +--
>>  include/sysemu/kvm.h                 |   2 +-
>>  softmmu/cpus.c                       | 911 +++--------------------------------
>>  stubs/Makefile.objs                  |   1 +
>>  stubs/cpu-synchronize-state.c        |  15 +
>>  target/i386/Makefile.objs            |   7 +-
>>  target/i386/hax-all.c                |   6 +-
>>  target/i386/hax-cpus-interface.c     |  85 ++++
>>  target/i386/hax-cpus-interface.h     |   8 +
>>  target/i386/hax-i386.h               |   2 +
>>  target/i386/hax-posix.c              |  12 +
>>  target/i386/hax-windows.c            |  20 +
>>  target/i386/hvf/Makefile.objs        |   2 +-
>>  target/i386/hvf/hvf-cpus-interface.c |  92 ++++
>>  target/i386/hvf/hvf-cpus-interface.h |   8 +
>>  target/i386/hvf/hvf.c                |   5 +-
>>  target/i386/whpx-all.c               |   3 +
>>  target/i386/whpx-cpus-interface.c    |  96 ++++
>>  target/i386/whpx-cpus-interface.h    |   8 +
>>  33 files changed, 1220 insertions(+), 903 deletions(-)
>>  create mode 100644 accel/kvm/kvm-cpus-interface.c
>>  create mode 100644 accel/kvm/kvm-cpus-interface.h
>>  create mode 100644 accel/tcg/tcg-cpus-interface.c
>>  create mode 100644 accel/tcg/tcg-cpus-interface.h
>>  create mode 100644 stubs/cpu-synchronize-state.c
>>  create mode 100644 target/i386/hax-cpus-interface.c
>>  create mode 100644 target/i386/hax-cpus-interface.h
>>  create mode 100644 target/i386/hvf/hvf-cpus-interface.c
>>  create mode 100644 target/i386/hvf/hvf-cpus-interface.h
>>  create mode 100644 target/i386/whpx-cpus-interface.c
>>  create mode 100644 target/i386/whpx-cpus-interface.h
> 
> Patch looks good, but remember to add proper license headers to all new
> files when removing the RFC tag.
> 

Will do, thanks!

Ciao,

Claudio


