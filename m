Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554CFC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C632071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRlJ8zeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C632071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQ5G-0003Wx-6J
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDQ3q-0001lu-Uw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:32:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDQ3o-0004rC-Vy
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599042732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRUlzfvsrvOthE2gqfOlIs+PryRqo3WH7GaI4+tUqfg=;
 b=MRlJ8zeRPvCZPGjYlJGMI/AG8QZJyiYUx1xb+wfijp/Zd3zPUsCM+J6LDq1iqyNqNHSYpE
 RTQ5y4zR0Wxv6NXX9O+7mUakifXFE7YkcaFEStnDPHq3vwvknUy1LOpfZJdTDXUY57J6T8
 uuCtE+lP3ft+XFt5kKKpucmek/aSfAQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-5PFqxnfDNSqgs9Ky0Qnc_Q-1; Wed, 02 Sep 2020 06:32:10 -0400
X-MC-Unique: 5PFqxnfDNSqgs9Ky0Qnc_Q-1
Received: by mail-wr1-f71.google.com with SMTP id e14so1805114wrr.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 03:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jRUlzfvsrvOthE2gqfOlIs+PryRqo3WH7GaI4+tUqfg=;
 b=Nu0Fr0kcbkzmX6XKwFLeVu+vFlGacLEFiuD5aZ+1BJyp2UYrtw47+mX/Yv5OUCJds8
 x6V3jfnhvpF0yNWbKUD/iO0InscI6wsB/g13ojwaGhUQvysXcjZgdbyYvCnYV0AZb1dQ
 yfZtphOHQ2vK3z5wgZg9GZsuVl/Qym8SNWfRjaDGc9aJR9q4Ve2sEFPrZXdC0Gb3yczt
 oj4qpEjJTrDCuFchglwelKMoj1L8EKcj33EXDFXribAYwdHNEWRPC+fab3klz4ur0Kg5
 SQNGlnfMhxk8DmIzfbqcXDOeTwKrHIjqR6ackRDp7uQsQVHCA/seyHzSMZY/sug7jf/p
 nfqQ==
X-Gm-Message-State: AOAM530dquxK+ul6Dl+UplaAly/04yQTcIlJ9Re9XpY+4lPrl90MEKuJ
 sFXy0BHtVt0dbdfc211mPS3td2a6QmZFVCtk2F0E1wdSXpG8xWXs2qdxXeE/pg++slJMC+vmmt2
 B6Gq4sRtB2xG8gFA=
X-Received: by 2002:a1c:6607:: with SMTP id a7mr5975495wmc.142.1599042729443; 
 Wed, 02 Sep 2020 03:32:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznC9hqf+BCj8+LdVDb3vgMq+KxqSqESJYwj+OpSlnaXQ+lWlqgybiyCFFU+54gwjQsBDmrJg==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr5975480wmc.142.1599042729195; 
 Wed, 02 Sep 2020 03:32:09 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id n11sm6500264wrx.91.2020.09.02.03.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 03:32:08 -0700 (PDT)
Subject: Re: [PATCH] stubs: Move qemu_timer_notify_cb() and remove
 qemu_notify_event() stub
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200902102433.304737-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb02c4e8-6bc4-733e-ead9-bdbf5cd95b83@redhat.com>
Date: Wed, 2 Sep 2020 12:32:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902102433.304737-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 12:24, Thomas Huth wrote:
> When cross-compiling with MinGW, there are sometimes some weird linker
> errors like:
> 
> ibqemuutil.a(util_main-loop.c.obj): In function `qemu_notify_event':
> /builds/huth/qemu/build/../util/main-loop.c:139: multiple definition of
>  `qemu_notify_event'
> libqemuutil.a(stubs_notify-event.c.obj):/builds/huth/qemu/stubs/notify-event.c:5:
>  first defined here
> collect2: error: ld returned 1 exit status
> /builds/huth/qemu/rules.mak:88: recipe for target 'tests/test-timed-average.exe'
>  failed
> 
> It seems like it works better when the qemu_timer_notify_cb() stub (which
> calls qemu_notify_event()) is in a separate file - then we can also even
> remove the qemu_notify_event() stub now.
> 
> This patch is based on ideas from the patch "stubs: Remove qemu_notify_event()"
> by Philippe Mathieu-Daudé and the patch "cpu-timers, icount: new modules" from
> Claudio Fontana.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  stubs/cpu-get-icount.c       | 5 -----
>  stubs/meson.build            | 2 +-
>  stubs/notify-event.c         | 6 ------
>  stubs/qemu-timer-notify-cb.c | 8 ++++++++
>  4 files changed, 9 insertions(+), 12 deletions(-)
>  delete mode 100644 stubs/notify-event.c
>  create mode 100644 stubs/qemu-timer-notify-cb.c
> 
> diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
> index b35f844638..4001613240 100644
> --- a/stubs/cpu-get-icount.c
> +++ b/stubs/cpu-get-icount.c
> @@ -14,8 +14,3 @@ int64_t cpu_get_icount_raw(void)
>  {
>      abort();
>  }
> -
> -void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> -{
> -    qemu_notify_event();
> -}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 019bd79c7a..e2dfedc2a7 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -24,9 +24,9 @@ stub_ss.add(files('machine-init-done.c'))
>  stub_ss.add(files('migr-blocker.c'))
>  stub_ss.add(files('monitor.c'))
>  stub_ss.add(files('monitor-core.c'))
> -stub_ss.add(files('notify-event.c'))
>  stub_ss.add(files('pci-bus.c'))
>  stub_ss.add(files('pci-host-piix.c'))
> +stub_ss.add(files('qemu-timer-notify-cb.c'))
>  stub_ss.add(files('qmp_memory_device.c'))
>  stub_ss.add(files('qtest.c'))
>  stub_ss.add(files('ram-block.c'))
> diff --git a/stubs/notify-event.c b/stubs/notify-event.c
> deleted file mode 100644
> index 827bb52d1a..0000000000
> --- a/stubs/notify-event.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "qemu/main-loop.h"
> -
> -void qemu_notify_event(void)
> -{
> -}
> diff --git a/stubs/qemu-timer-notify-cb.c b/stubs/qemu-timer-notify-cb.c
> new file mode 100644
> index 0000000000..054b408b1c
> --- /dev/null
> +++ b/stubs/qemu-timer-notify-cb.c
> @@ -0,0 +1,8 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/cpus.h"
> +#include "qemu/main-loop.h"
> +
> +void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> +{
> +    qemu_notify_event();
> +}
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


