Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD4BC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800962146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPwLLLGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800962146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDA5f-0007f1-Jc
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDA3q-0006C5-3o
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDA3p-0004e4-0f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:22:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDA3o-0004di-Q7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:22:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id i1so7684238wro.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8TiHYtplUFlHSQa11Zm3hwHiJ5Q/LMI+3K9BEAU6K9c=;
 b=rPwLLLGKvsSLetLUK4ymZC+VstIZ0SvO0sn7/f0tBKPRo+Cs2UiHtEbmbgcT6SfMOk
 LkZ/Bbn4GkVNfioc88K0u0rE7mah7TJ/Sk3fsaie9bsQIKeemhs58Q35r6Brj7pJ3G+b
 PIL+6hwmg46BaotoBBj3kHNvhyspxZciYlCwnG1QuI/UFZzTU19+LdXUOJV7XRDuoSi5
 150Mh+M/gRgLZsHayxtgrG4aJiM8V6FxRiE6VDifnAQ9HUnjkqhKRxCLnP0I/prtm1nZ
 NHaXIuHjTvBMjylkUFS6moXFUmH3YeMfXJunJJy3N8OfUufOEgFL1JggBoemIvPjskH5
 KC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8TiHYtplUFlHSQa11Zm3hwHiJ5Q/LMI+3K9BEAU6K9c=;
 b=ATfS3mDj81J93+bC0bV3KGFhf3MuFdKo/gcvc2HC70DoDpx+OTpXLIsjXzjp+vRr5f
 PYNz2aGEasYmrXZ3xUQlJPpdVIPOtX4jeUPA1+KbcsBjYxsbX4fcOHhQElV3BQ4T7bcQ
 EVEgsNPVnaa+Dvhb2ALUlGiQWQe8srf7YuAhFF+QP2o+VLzO2eVmVKAde5bwL/Z/Kb7J
 ojxtZxXGv+Q2Ir+1IfklwLfnAGy6Iv7dq4omPhaYfgcNtlcHa3G9JlP1/0JpUqUDf6ij
 bCBX2izzXN+ZeHBsWtkfJPi5wgsMDqQbc+GAQxoHurpdM+ECLen1OjirEvQ7g3PPn4q1
 wAZg==
X-Gm-Message-State: APjAAAWcHfV5/+eBszTV1/IXL94EARn0ZUB3P9UJYIcjNEAsZdK8000f
 vlFYelEzqzlQHOKirSHRSYAi5w==
X-Google-Smtp-Source: APXvYqyprjnW8CXRw1NNksBckBn6XR4xHmThiQNwwXd91DruDyTAtyU28pS1hoETuCeCCnpQs9D/Dw==
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr10373468wrb.233.1569428555548; 
 Wed, 25 Sep 2019 09:22:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm5020991wrv.63.2019.09.25.09.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:22:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3CEC21FF87;
 Wed, 25 Sep 2019 17:22:34 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-14-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 13/16] cputlb: Remove cpu->mem_io_vaddr
In-reply-to: <20190923230004.9231-14-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 17:22:34 +0100
Message-ID: <87mues9whh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> With the merge of notdirty handling into store_helper,
> the last user of cpu->mem_io_vaddr was removed.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/hw/core/cpu.h | 2 --
>  accel/tcg/cputlb.c    | 2 --
>  hw/core/cpu.c         | 1 -
>  3 files changed, 5 deletions(-)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index c7cda65c66..031f587e51 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -338,7 +338,6 @@ struct qemu_work_item;
>   * @next_cpu: Next CPU sharing TB cache.
>   * @opaque: User data.
>   * @mem_io_pc: Host Program Counter at which the memory was accessed.
> - * @mem_io_vaddr: Target virtual address at which the memory was accesse=
d.
>   * @kvm_fd: vCPU file descriptor for KVM.
>   * @work_mutex: Lock to prevent multiple access to queued_work_*.
>   * @queued_work_first: First asynchronous work pending.
> @@ -413,7 +412,6 @@ struct CPUState {
>       * we store some rarely used information in the CPU context.
>       */
>      uintptr_t mem_io_pc;
> -    vaddr mem_io_vaddr;
>      /*
>       * This is only needed for the legacy cpu_unassigned_access() hook;
>       * when all targets using it have been converted to use
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d0bdef1eb3..0ca6ee60b3 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -927,7 +927,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
>          cpu_io_recompile(cpu, retaddr);
>      }
>
> -    cpu->mem_io_vaddr =3D addr;
>      cpu->mem_io_access_type =3D access_type;
>
>      if (mr->global_locking && !qemu_mutex_iothread_locked()) {
> @@ -967,7 +966,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntr=
y *iotlbentry,
>      if (!cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
> -    cpu->mem_io_vaddr =3D addr;
>      cpu->mem_io_pc =3D retaddr;
>
>      if (mr->global_locking && !qemu_mutex_iothread_locked()) {
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 0035845511..73b1ee34d0 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -261,7 +261,6 @@ static void cpu_common_reset(CPUState *cpu)
>      cpu->interrupt_request =3D 0;
>      cpu->halted =3D 0;
>      cpu->mem_io_pc =3D 0;
> -    cpu->mem_io_vaddr =3D 0;
>      cpu->icount_extra =3D 0;
>      atomic_set(&cpu->icount_decr_ptr->u32, 0);
>      cpu->can_do_io =3D 1;


--
Alex Benn=C3=A9e

