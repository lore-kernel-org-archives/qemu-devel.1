Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160DFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918132071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g80ZQ8Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918132071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEwr-0006gy-IA
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEo3-0006aE-Hf
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:14:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEo2-0008Id-LP
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f66NeRqfpRlgfRe38i1+1ZCvzv5Vy8dQcb2vBsN06fM=;
 b=g80ZQ8Jzidb9LkFxLo5+cTvEb4mZf5y/EK+T4kQJ2qNa7m/vqvReGMEXVZMV/PLRQ35R87
 39NtKeq/Dx0IyYk4rCxS/SS9PpNBE2h9hPt2r6HZevPuWAqLo3iy2se6/7bXWLd6AHi5gk
 MhPrrnfoDHEdQyP1hCS4bJL0TBBhHBY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-7Ha9RwqdNBqoapgdZMkCaw-1; Mon, 25 May 2020 11:14:18 -0400
X-MC-Unique: 7Ha9RwqdNBqoapgdZMkCaw-1
Received: by mail-ed1-f71.google.com with SMTP id dk23so7617273edb.15
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=f66NeRqfpRlgfRe38i1+1ZCvzv5Vy8dQcb2vBsN06fM=;
 b=FIN1YkrVFPNnH0UpRSz7MXNUHJO3Dm6Y68aiA4ZVTWLSBq2uqSaEGorBUD9vUhdTxU
 bL0hNA5svo9nTQtn7KAkE6Fi946Ct82nBGb12j6M1fA3/f+aaBuh7hI6Cspf7/fkGKh/
 vhf9hB+V489GNwjDDrBrl2sYBjb6MIQa/B1S7Z28h+/Kdz32uyIYHYUdOzsHBhZ8QTky
 dBp/NptTqOQPBxkG9G2tAm3wI2JHZ3kiRlPwKWUKO9udY0/iI+6rCvgbl4YQswBjyEYC
 0h+LYI2yBPaD0T+fRkUdtONZQBsAoT1VgetQ5rhuHhly6gJpircuOxyKjlzhS/zFrMEk
 Woww==
X-Gm-Message-State: AOAM531GnbiMXc2/S14GYPbSL0mZWzjzRCP5Wbd2p+rWJGts1R5VwNV1
 fEOMiTTUm4ndoYbOTnU4SMssCF+06juOz4E4yk78MgBVIPJdGr4Z2/cqCh6o0zYC7Sj+ZFXULaq
 SgVBBCS/8hJm5K6c=
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr15501333edj.26.1590419656915; 
 Mon, 25 May 2020 08:14:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygrAFtfsBgdKR7gXOn1iWQt4ztTqHnssuy9AW5rsHgK5+JKrmjv1PlSnDa3wWSVAB1LrAuKg==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr15501316edj.26.1590419656638; 
 Mon, 25 May 2020 08:14:16 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c15sm10979392edm.78.2020.05.25.08.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 08:14:16 -0700 (PDT)
Subject: Re: [RFC v3 2/4] cpu-throttle: new module, extracted from cpus.c
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-3-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <99995c3f-68a3-ce07-72bb-37a9b2263e52@redhat.com>
Date: Mon, 25 May 2020 17:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200525145440.29728-3-cfontana@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:55:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/25/20 4:54 PM, Claudio Fontana wrote:
> move the vcpu throttling functionality into its own module.
> 
> This functionality is not specific to any accelerator,
> and it is used currently by migration to slow down guests to try to
> have migrations converge, and by the cocoa MacOS UI to throttle speed.
> 
> cpu-throttle contains the controls to adjust and inspect throttle
> settings, start (set) and stop vcpu throttling, and the throttling
> function itself that is run periodically on vcpus to make them take a nap.
> 
> Execution of the throttling function on all vcpus is triggered by a timer,
> registered at module initialization.
> 
> No functionality change.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  MAINTAINERS                   |   3 +-
>  include/hw/core/cpu.h         |  37 -------------
>  include/qemu/main-loop.h      |   5 ++
>  include/sysemu/cpu-throttle.h |  50 +++++++++++++++++
>  migration/migration.c         |   1 +
>  migration/ram.c               |   1 +
>  softmmu/Makefile.objs         |   1 +
>  softmmu/cpu-throttle.c        | 122 ++++++++++++++++++++++++++++++++++++++++++
>  softmmu/cpus.c                |  95 +++-----------------------------
>  9 files changed, 190 insertions(+), 125 deletions(-)
>  create mode 100644 include/sysemu/cpu-throttle.h
>  create mode 100644 softmmu/cpu-throttle.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0288ffbc50..708768f120 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2147,13 +2147,14 @@ F: ui/cocoa.m
>  Main loop
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: softmmu/cpus.c
>  F: include/qemu/main-loop.h
>  F: include/sysemu/runstate.h
>  F: util/main-loop.c
>  F: util/qemu-timer.c
>  F: softmmu/vl.c
>  F: softmmu/main.c
> +F: softmmu/cpus.c

This line belong the the previous patch (#1).

> +F: softmmu/cpu-throttle.c
>  F: qapi/run-state.json

Can you reorder patches #1/#2 to avoid moving cpu-throttle code twice?

Otherwise this patch looks good.

[...]


