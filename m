Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64049C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 10:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298F22077D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 10:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeSNC3yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298F22077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcnlL-0005Vk-Al
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 06:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcnkl-000551-HT
 for qemu-devel@nongnu.org; Sun, 24 May 2020 06:21:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcnkg-0001c1-MD
 for qemu-devel@nongnu.org; Sun, 24 May 2020 06:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590315664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AvnijKzGXQOW5GBXx+hJrxkJ7cEgN2jA8BnHoZAskOg=;
 b=KeSNC3yNNxzCAII1B6+ClqepA+Bp4nCCiCnLueBO/6zZQV2yY5qo7kd26vazZ3F2lCbe4k
 a8PvUDf62UgButjeav+0/SJ8F4C6M82zepgrxV31VksJ5S8q3BjnIF604vqNIr2xljW15r
 7JtCF9h/aLbW79/L7LtREoRsk1jkK5Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-ngTVa8qVM1yBrDNcpegCjw-1; Sun, 24 May 2020 06:21:02 -0400
X-MC-Unique: ngTVa8qVM1yBrDNcpegCjw-1
Received: by mail-wr1-f71.google.com with SMTP id w4so1111174wrl.13
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 03:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=AvnijKzGXQOW5GBXx+hJrxkJ7cEgN2jA8BnHoZAskOg=;
 b=PNDSJZUMMXbuBMjCigivzs1uqHyok5VH4yAILnxEDfmaJReF+K8nBi+8Ky2pnENktR
 T12W2CKdmv7+Zqw1TOK/yAtJx+mCk04K6l/5QQSIwZlOBNIpw69hry0Woenq181s+/G+
 j4URczWp/OwXxxoAZ6p/mticMexmZENNF7O2nHjXRHsyylEJ2bVhg/9R4Cq6THRtZpMI
 u9xqSeCs6J/LtwKuzGcFpmbB6QbT4c3vmKF+x+WJnf4jgym4pDGbGKu98ufW742W7ThP
 kJh4pXi+R7iIWBxHh/4r+AcCljwdjvSfFvPo7KD3E4Spz9sIcaRxqICSefcq2LsRmtGL
 EhBw==
X-Gm-Message-State: AOAM532qSf15P5Z9AdyJHzlvBjusTU7TLnBUAQlRuAswebuPTa0mVwOI
 NBFOwoAti1kun5N41L1uzy8uBYScdubZEIb2EhSk0zCgnWKRzb4iH+MST0HapWrSv9hJmTztCDI
 h5RzV4ApSRUU5oV4=
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr40836wmi.186.1590315661619; 
 Sun, 24 May 2020 03:21:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF/dJegdiFcOF9B1TwSrG+vP41ME+XZPve1mpQBF4Imo6T+F3zsjFWHA4TWpPuaXSA6N3gGQ==
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr40822wmi.186.1590315661337; 
 Sun, 24 May 2020 03:21:01 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id l204sm4721813wmf.19.2020.05.24.03.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 03:21:00 -0700 (PDT)
Subject: Re: [PATCH 02/19] cpu: convert queued work to a QSIMPLEQ
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-3-robert.foley@linaro.org>
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
Message-ID: <c9800478-e184-32ad-6cec-3f8ad4e3bed1@redhat.com>
Date: Sun, 24 May 2020 12:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200522160755.886-3-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 06:21:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 6:07 PM, Robert Foley wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Instead of open-coding it.

Please use a full sentence (repeating the patch subject):

"Convert queued work to a QSIMPLEQ instead of open-coding it."

(Not all email clients display the subject preceding the content).

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> While at it, make sure that all accesses to the list are
> performed while holding the list's lock.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  cpus-common.c         | 25 ++++++++-----------------
>  cpus.c                | 14 ++++++++++++--
>  hw/core/cpu.c         |  1 +
>  include/hw/core/cpu.h |  6 +++---
>  4 files changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/cpus-common.c b/cpus-common.c
> index 55d5df8923..210fc7fc39 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -97,7 +97,7 @@ void cpu_list_remove(CPUState *cpu)
>  }
>  
>  struct qemu_work_item {
> -    struct qemu_work_item *next;
> +    QSIMPLEQ_ENTRY(qemu_work_item) node;
>      run_on_cpu_func func;
>      run_on_cpu_data data;
>      bool free, exclusive, done;
> @@ -106,13 +106,7 @@ struct qemu_work_item {
>  static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
>  {
>      qemu_mutex_lock(&cpu->work_mutex);
> -    if (cpu->queued_work_first == NULL) {
> -        cpu->queued_work_first = wi;
> -    } else {
> -        cpu->queued_work_last->next = wi;
> -    }
> -    cpu->queued_work_last = wi;
> -    wi->next = NULL;
> +    QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
>      wi->done = false;
>      qemu_mutex_unlock(&cpu->work_mutex);
>  
> @@ -306,17 +300,14 @@ void process_queued_cpu_work(CPUState *cpu)
>  {
>      struct qemu_work_item *wi;
>  
> -    if (cpu->queued_work_first == NULL) {
> +    qemu_mutex_lock(&cpu->work_mutex);
> +    if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
> +        qemu_mutex_unlock(&cpu->work_mutex);
>          return;
>      }
> -
> -    qemu_mutex_lock(&cpu->work_mutex);
> -    while (cpu->queued_work_first != NULL) {
> -        wi = cpu->queued_work_first;
> -        cpu->queued_work_first = wi->next;
> -        if (!cpu->queued_work_first) {
> -            cpu->queued_work_last = NULL;
> -        }
> +    while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
> +        wi = QSIMPLEQ_FIRST(&cpu->work_list);
> +        QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
>          qemu_mutex_unlock(&cpu->work_mutex);
>          if (wi->exclusive) {
>              /* Running work items outside the BQL avoids the following deadlock:
> diff --git a/cpus.c b/cpus.c
> index 5670c96bcf..af44027549 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -97,9 +97,19 @@ bool cpu_is_stopped(CPUState *cpu)
>      return cpu->stopped || !runstate_is_running();
>  }
>  
> +static inline bool cpu_work_list_empty(CPUState *cpu)
> +{
> +    bool ret;
> +
> +    qemu_mutex_lock(&cpu->work_mutex);
> +    ret = QSIMPLEQ_EMPTY(&cpu->work_list);
> +    qemu_mutex_unlock(&cpu->work_mutex);
> +    return ret;
> +}
> +
>  static bool cpu_thread_is_idle(CPUState *cpu)
>  {
> -    if (cpu->stop || cpu->queued_work_first) {
> +    if (cpu->stop || !cpu_work_list_empty(cpu)) {
>          return false;
>      }
>      if (cpu_is_stopped(cpu)) {
> @@ -1498,7 +1508,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>              cpu = first_cpu;
>          }
>  
> -        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
> +        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
>  
>              atomic_mb_set(&tcg_current_rr_cpu, cpu);
>              current_cpu = cpu;
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 5284d384fb..77703d62b7 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -368,6 +368,7 @@ static void cpu_common_initfn(Object *obj)
>      cpu->nr_threads = 1;
>  
>      qemu_mutex_init(&cpu->work_mutex);
> +    QSIMPLEQ_INIT(&cpu->work_list);
>      QTAILQ_INIT(&cpu->breakpoints);
>      QTAILQ_INIT(&cpu->watchpoints);
>  
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 07f7698155..d78ff1d165 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -331,8 +331,8 @@ struct qemu_work_item;
>   * @opaque: User data.
>   * @mem_io_pc: Host Program Counter at which the memory was accessed.
>   * @kvm_fd: vCPU file descriptor for KVM.
> - * @work_mutex: Lock to prevent multiple access to queued_work_*.
> - * @queued_work_first: First asynchronous work pending.
> + * @work_mutex: Lock to prevent multiple access to @work_list.
> + * @work_list: List of pending asynchronous work.
>   * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
>   *                        to @trace_dstate).
>   * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
> @@ -376,7 +376,7 @@ struct CPUState {
>      sigjmp_buf jmp_env;
>  
>      QemuMutex work_mutex;
> -    struct qemu_work_item *queued_work_first, *queued_work_last;
> +    QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>  
>      CPUAddressSpace *cpu_ases;
>      int num_ases;
> 


