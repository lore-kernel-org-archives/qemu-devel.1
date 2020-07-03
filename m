Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51097C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200CF20708
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbLaXMMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200CF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPNy-0007ly-CM
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrPNA-0006u8-Vx
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 13:21:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrPN8-0003tb-6i
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 13:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593796868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlwSTebW+qTtLG9e8+NMsZaIsihTzmVa3T3GHJZByFc=;
 b=FbLaXMMb8GsndGg5EumGb2LqrGHGlVcDmdrM/pzb2nkjmA4OTRJPgnyOrU+jGn8CFWKY2W
 fJ2uDGSR83sPGmQiGOD9juIjBNqnNNZL6Bjy8RIrTwTMaTws+aXZ7XSwKSNVt+llEUAqEt
 HgbYnqtk0TS7967M5wImiMVExMPcSAQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-3uSJKtyvOhu1OM0R_NErBQ-1; Fri, 03 Jul 2020 13:21:05 -0400
X-MC-Unique: 3uSJKtyvOhu1OM0R_NErBQ-1
Received: by mail-wm1-f70.google.com with SMTP id o13so35836144wmh.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 10:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mlwSTebW+qTtLG9e8+NMsZaIsihTzmVa3T3GHJZByFc=;
 b=hR3tQzH/KmGy9uMTQBVuxyNdR148p8WKI1S1J3VtxUtADbJOMY2Gy3yHyPF4Ao/RoV
 duOlwXTzHP/w+RXSc6DYbSBaIx2hIYnnY6oEGWbrG/OTBFNJEWuIXzX4MT0445XyzCjC
 U4WXP1Xj2vAijN4R1Qm3ivI3AufiSY8rZBRBbqJi6+HBpx5XXIjjU0zkQ/OojZSYLTUq
 YeGBxz11GQhPTkx9GO503y61ZCff+fRuARDwWGb8tFjreoJKj0NunxD/wvmf2euV937C
 LcvDbYgWUShUVT++v6viaEoewhhGz9EIA2zttrFpWrRzb6KlHWzQhdQTfGwDlN6EyqLT
 92fg==
X-Gm-Message-State: AOAM5311uASUqR8hNdfGcC316Yn9tdjIrjBOVhURpUFqBK+DFFa3/nxR
 WYcSwSjUYT9Yep+uyODAGz3dN943+P/72XmlSxibyW3P/iyTyophex8aORrL//6JQLqRLvE8W53
 /T4jV5NZ47ODsnw4=
X-Received: by 2002:a1c:7510:: with SMTP id o16mr25386306wmc.146.1593796864509; 
 Fri, 03 Jul 2020 10:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6eqyigWWCqZQ65+Krk0FqelWGg0c2uu3A9ka+W58ar2hnmIRfvGCAc5J5GYTNW2qEv2SDKA==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr25386279wmc.146.1593796864294; 
 Fri, 03 Jul 2020 10:21:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5cf9:fc14:deb7:51fc?
 ([2001:b07:6468:f312:5cf9:fc14:deb7:51fc])
 by smtp.gmail.com with ESMTPSA id e5sm15110032wrs.33.2020.07.03.10.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 10:21:03 -0700 (PDT)
Subject: Re: [PATCH 1/3] softmmu: move softmmu only files from root
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-2-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1d977b1-cb3a-d79e-a586-e85c3ecfefd8@redhat.com>
Date: Fri, 3 Jul 2020 19:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200629093504.3228-2-cfontana@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 11:35, Claudio Fontana wrote:
> move arch_init, balloon, cpus, ioport, memory, memory_mapping, qtest.
> 
> They are all specific to CONFIG_SOFTMMU.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                  | 12 ++++++------
>  Makefile.target                              |  7 ++-----
>  softmmu/Makefile.objs                        | 10 ++++++++++
>  arch_init.c => softmmu/arch_init.c           |  0
>  balloon.c => softmmu/balloon.c               |  0
>  cpus.c => softmmu/cpus.c                     |  0
>  ioport.c => softmmu/ioport.c                 |  0
>  memory.c => softmmu/memory.c                 |  0
>  memory_mapping.c => softmmu/memory_mapping.c |  0
>  qtest.c => softmmu/qtest.c                   |  0
>  10 files changed, 18 insertions(+), 11 deletions(-)
>  rename arch_init.c => softmmu/arch_init.c (100%)
>  rename balloon.c => softmmu/balloon.c (100%)
>  rename cpus.c => softmmu/cpus.c (100%)
>  rename ioport.c => softmmu/ioport.c (100%)
>  rename memory.c => softmmu/memory.c (100%)
>  rename memory_mapping.c => softmmu/memory_mapping.c (100%)
>  rename qtest.c => softmmu/qtest.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..7214f59383 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -115,7 +115,7 @@ Overall TCG CPUs
>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: cpus.c
> +F: softmmu/cpus.c
>  F: cpus-common.c
>  F: exec.c
>  F: accel/tcg/
> @@ -1708,7 +1708,7 @@ M: David Hildenbrand <david@redhat.com>
>  S: Maintained
>  F: hw/virtio/virtio-balloon*.c
>  F: include/hw/virtio/virtio-balloon.h
> -F: balloon.c
> +F: softmmu/balloon.c
>  F: include/sysemu/balloon.h
>  
>  virtio-9p
> @@ -2177,12 +2177,12 @@ Memory API
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Supported
>  F: include/exec/ioport.h
> -F: ioport.c
>  F: include/exec/memop.h
>  F: include/exec/memory.h
>  F: include/exec/ram_addr.h
>  F: include/exec/ramblock.h
> -F: memory.c
> +F: softmmu/ioport.c
> +F: softmmu/memory.c
>  F: include/exec/memory-internal.h
>  F: exec.c
>  F: scripts/coccinelle/memory-region-housekeeping.cocci
> @@ -2214,13 +2214,13 @@ F: ui/cocoa.m
>  Main loop
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: cpus.c
>  F: include/qemu/main-loop.h
>  F: include/sysemu/runstate.h
>  F: util/main-loop.c
>  F: util/qemu-timer.c
>  F: softmmu/vl.c
>  F: softmmu/main.c
> +F: softmmu/cpus.c
>  F: qapi/run-state.json
>  
>  Human Monitor (HMP)
> @@ -2375,7 +2375,7 @@ M: Thomas Huth <thuth@redhat.com>
>  M: Laurent Vivier <lvivier@redhat.com>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: qtest.c
> +F: softmmu/qtest.c
>  F: accel/qtest.c
>  F: tests/qtest/
>  X: tests/qtest/bios-tables-test-allowed-diff.h
> diff --git a/Makefile.target b/Makefile.target
> index 8ed1eba95b..7fbf5d8b92 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -152,16 +152,13 @@ endif #CONFIG_BSD_USER
>  #########################################################
>  # System emulator target
>  ifdef CONFIG_SOFTMMU
> -obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
> -obj-y += qtest.o
> +obj-y += softmmu/
> +obj-y += gdbstub.o
>  obj-y += dump/
>  obj-y += hw/
>  obj-y += monitor/
>  obj-y += qapi/
> -obj-y += memory.o
> -obj-y += memory_mapping.o
>  obj-y += migration/ram.o
> -obj-y += softmmu/
>  LIBS := $(libs_softmmu) $(LIBS)
>  
>  # Hardware support
> diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
> index dd15c24346..a4bd9f2f52 100644
> --- a/softmmu/Makefile.objs
> +++ b/softmmu/Makefile.objs
> @@ -1,3 +1,13 @@
>  softmmu-main-y = softmmu/main.o
> +
> +obj-y += arch_init.o
> +obj-y += cpus.o
> +obj-y += balloon.o
> +obj-y += ioport.o
> +obj-y += memory.o
> +obj-y += memory_mapping.o
> +
> +obj-y += qtest.o
> +
>  obj-y += vl.o
>  vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
> diff --git a/arch_init.c b/softmmu/arch_init.c
> similarity index 100%
> rename from arch_init.c
> rename to softmmu/arch_init.c
> diff --git a/balloon.c b/softmmu/balloon.c
> similarity index 100%
> rename from balloon.c
> rename to softmmu/balloon.c
> diff --git a/cpus.c b/softmmu/cpus.c
> similarity index 100%
> rename from cpus.c
> rename to softmmu/cpus.c
> diff --git a/ioport.c b/softmmu/ioport.c
> similarity index 100%
> rename from ioport.c
> rename to softmmu/ioport.c
> diff --git a/memory.c b/softmmu/memory.c
> similarity index 100%
> rename from memory.c
> rename to softmmu/memory.c
> diff --git a/memory_mapping.c b/softmmu/memory_mapping.c
> similarity index 100%
> rename from memory_mapping.c
> rename to softmmu/memory_mapping.c
> diff --git a/qtest.c b/softmmu/qtest.c
> similarity index 100%
> rename from qtest.c
> rename to softmmu/qtest.c
> 

Queued, thanks.  But I only got patch 1/3.

Paolo


