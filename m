Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E665C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78A22177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A22177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GRn-0007Gc-5L
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3GPf-00052U-Ao
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:12:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3GPd-0001mU-9r
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:12:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3599EB07B;
 Wed,  5 Aug 2020 10:13:00 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 v3 1/2] exec: Restrict icount to softmmu
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200805100126.25583-1-philmd@redhat.com>
 <20200805100126.25583-2-philmd@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <f29544ab-d583-d6ed-48da-aa49c05ab966@suse.de>
Date: Wed, 5 Aug 2020 12:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200805100126.25583-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:43:27
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

could you take a look if this series already addresses the issue?

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00067.html

Everything icount related is already moved to softmmu and made TCG only.

I will post a new version of the series today with a couple changes;

the series could then be ready if HVF is already ready with its synchronize_state implementation? Otherwise we'd have to hold back the HVF patch.

Thanks!

Claudio


On 8/5/20 12:01 PM, Philippe Mathieu-Daudé wrote:
> 'icount' feature is only meaningful when using softmmu.
> Move it out of the globally used exec.c, and define it as
> 'false' in user-mode emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/sysemu/cpus.h | 4 ++++
>  exec.c                | 4 ----
>  softmmu/cpus.c        | 7 +++++++
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 3c1da6a018..d8442aa9f0 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -11,9 +11,13 @@ void pause_all_vcpus(void);
>  void cpu_stop_current(void);
>  void cpu_ticks_init(void);
>  
> +#if !defined(CONFIG_USER_ONLY)
>  void configure_icount(QemuOpts *opts, Error **errp);
>  extern int use_icount;
>  extern int icount_align_option;
> +#else
> +#define use_icount false
> +#endif
>  
>  /* drift information for info jit command */
>  extern int64_t max_delay;
> diff --git a/exec.c b/exec.c
> index 6f381f98e2..a89ffa93c1 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -102,10 +102,6 @@ uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
>  
>  #if !defined(CONFIG_USER_ONLY)
> -/* 0 = Do not count executed instructions.
> -   1 = Precise instruction counting.
> -   2 = Adaptive rate instruction counting.  */
> -int use_icount;
>  
>  typedef struct PhysPageEntry PhysPageEntry;
>  
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index a802e899ab..a4772034c0 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -81,6 +81,13 @@
>  
>  #endif /* CONFIG_LINUX */
>  
> +/*
> + * 0 = Do not count executed instructions.
> + * 1 = Precise instruction counting.
> + * 2 = Adaptive rate instruction counting.
> + */
> +int use_icount;
> +
>  static QemuMutex qemu_global_mutex;
>  
>  int64_t max_delay;
> 


