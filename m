Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083EFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD270207DD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJYoSvwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD270207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm9zm-0004Nq-Sk
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 01:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jm9z7-0003um-LS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 01:54:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jm9z5-0004JO-NZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 01:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592546079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Rz6au7tJFYCX+MvEeobUfi7nRGNtBn67k7m44fVYLTM=;
 b=gJYoSvwM/yTfUgv5+wfx5FOr4CmUDgmI9DkMLtfBQJBmKg9ws6xt1SIQa0hz7JnJv6DPbz
 lULEadCeQkVIhxFNdxytwedwwh08pTA9RPsNtZTefon87D0IJ+Equ30zY3WYgAXQx2pvUB
 jIhG6cjP0BrOfkKIRhNCqOCpS8Rso3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-WpD9cgayNRud9esbc80dEQ-1; Fri, 19 Jun 2020 01:54:37 -0400
X-MC-Unique: WpD9cgayNRud9esbc80dEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 976CB800053;
 Fri, 19 Jun 2020 05:54:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-152.ams2.redhat.com [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD9B81002394;
 Fri, 19 Jun 2020 05:54:31 +0000 (UTC)
Subject: Re: [RFC v6 3/4] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200618190401.4895-1-cfontana@suse.de>
 <20200618190401.4895-4-cfontana@suse.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3c15cb29-d78a-effd-d1b9-3f3c61e2fd27@redhat.com>
Date: Fri, 19 Jun 2020 07:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200618190401.4895-4-cfontana@suse.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/2020 21.04, Claudio Fontana wrote:
> refactoring of cpus.c continues with cpu timer state extraction.
> 
> cpu-timers: responsible for the cpu timers state, and for access to
> cpu clocks and ticks.
> 
> icount: counts the TCG instructions executed. As such it is specific to
> the TCG accelerator. Therefore, it is built only under CONFIG_TCG.
> 
> One complication is due to qtest, which misuses icount to warp time
> (qtest_clock_warp). In order to solve this problem, detach instead qtest
> from icount, and use a trivial separate counter for it.
> 
> This requires fixing assumptions scattered in the code that
> qtest_enabled() implies icount_enabled().
> 
> No functionality change.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  MAINTAINERS                  |   2 +
>  accel/qtest.c                |   6 +-
>  accel/tcg/cpu-exec.c         |  43 ++-
>  accel/tcg/tcg-all.c          |   7 +-
>  accel/tcg/translate-all.c    |   3 +-
>  docs/replay.txt              |   6 +-
>  exec.c                       |   4 -
>  hw/core/ptimer.c             |   8 +-
>  hw/i386/x86.c                |   1 +
>  include/exec/cpu-all.h       |   4 +
>  include/exec/exec-all.h      |   4 +-
>  include/qemu/timer.h         |  22 +-
>  include/sysemu/cpu-timers.h  |  81 +++++
>  include/sysemu/cpus.h        |  12 +-
>  include/sysemu/qtest.h       |   2 +
>  include/sysemu/replay.h      |   4 +-
>  replay/replay.c              |   6 +-
>  softmmu/Makefile.objs        |   2 +
>  softmmu/cpu-timers.c         | 284 ++++++++++++++++
>  softmmu/cpus.c               | 750 +------------------------------------------
>  softmmu/icount.c             | 499 ++++++++++++++++++++++++++++
>  softmmu/qtest.c              |  34 +-
>  softmmu/timers-state.h       |  69 ++++
>  softmmu/vl.c                 |   8 +-
>  stubs/Makefile.objs          |   3 +-
>  stubs/clock-warp.c           |   4 +-
>  stubs/cpu-get-clock.c        |   3 +-
>  stubs/cpu-get-icount.c       |  21 --
>  stubs/icount.c               |  22 ++
>  stubs/qemu-timer-notify-cb.c |   8 +
>  stubs/qtest.c                |   5 +
>  target/alpha/translate.c     |   3 +-
>  target/arm/helper.c          |   7 +-
>  target/riscv/csr.c           |   8 +-
>  tests/ptimer-test-stubs.c    |   7 +-
>  tests/test-timed-average.c   |   2 +-
>  util/main-loop.c             |   4 +-
>  util/qemu-timer.c            |  12 +-
>  38 files changed, 1119 insertions(+), 851 deletions(-)
>  create mode 100644 include/sysemu/cpu-timers.h
>  create mode 100644 softmmu/cpu-timers.c
>  create mode 100644 softmmu/icount.c
>  create mode 100644 softmmu/timers-state.h
>  delete mode 100644 stubs/cpu-get-icount.c
>  create mode 100644 stubs/icount.c
>  create mode 100644 stubs/qemu-timer-notify-cb.c

This is missing a modification to dma-helpers.c that also uses
use_icount (see the mail from patchew).

 Thomas


