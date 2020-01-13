Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3370C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFB1207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tyy5hYm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFB1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2zY-0002VX-Fd
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ir2yV-00017e-GH
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ir2yU-0004S9-9t
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:53:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24899
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ir2yU-0004R8-6D
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578934437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CKtxRdjCaSaqdi2jWz4A6HjyFFAIp8K+BeneL4oy634=;
 b=Tyy5hYm3c+N8Gr1wdbU8fkB+h6/KrlwIsViDYohSjwZqPHqX2SqcYM8edg6iCrffLBnV+/
 XUUbSRUJSZPW4S9CBe2LqVqW99sq+7Iz5KxFdPjlaGOAOd4qEjfM8voorPCggYcz+jjdjU
 p37hZz66/ttLY0dPM+18YlHn4jtM6Dw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-FbMHeSghMTyHtWaMDHSR7w-1; Mon, 13 Jan 2020 11:53:53 -0500
X-MC-Unique: FbMHeSghMTyHtWaMDHSR7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75E441800D78;
 Mon, 13 Jan 2020 16:53:51 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D82CD5C1B0;
 Mon, 13 Jan 2020 16:53:46 +0000 (UTC)
Date: Mon, 13 Jan 2020 17:53:44 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 03/16] arm/arm64: gic: Introduce
 setup_irq() helper
Message-ID: <20200113165344.2focia4mhxtixutg@kamzik.brq.redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
 <20200110145412.14937-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145412.14937-4-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, yuzenghui@huawei.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 03:53:59PM +0100, Eric Auger wrote:
> ipi_enable() code would be reusable for other interrupts
> than IPI. Let's rename it setup_irq() and pass an interrupt
> handler pointer. We also export it to use it in other tests
> such as the PMU's one.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arm/gic.c         | 24 +++---------------------
>  lib/arm/asm/gic.h |  3 +++
>  lib/arm/gic.c     | 11 +++++++++++
>  3 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index fcf4c1f..ba43ae5 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -215,20 +215,9 @@ static void ipi_test_smp(void)
>  	report_prefix_pop();
>  }
>  
> -static void ipi_enable(void)
> -{
> -	gic_enable_defaults();
> -#ifdef __arm__
> -	install_exception_handler(EXCPTN_IRQ, ipi_handler);
> -#else
> -	install_irq_handler(EL1H_IRQ, ipi_handler);
> -#endif
> -	local_irq_enable();
> -}
> -
>  static void ipi_send(void)
>  {
> -	ipi_enable();
> +	setup_irq(ipi_handler);
>  	wait_on_ready();
>  	ipi_test_self();
>  	ipi_test_smp();
> @@ -238,7 +227,7 @@ static void ipi_send(void)
>  
>  static void ipi_recv(void)
>  {
> -	ipi_enable();
> +	setup_irq(ipi_handler);
>  	cpumask_set_cpu(smp_processor_id(), &ready);
>  	while (1)
>  		wfi();
> @@ -295,14 +284,7 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
>  static void run_active_clear_test(void)
>  {
>  	report_prefix_push("active");
> -	gic_enable_defaults();
> -#ifdef __arm__
> -	install_exception_handler(EXCPTN_IRQ, ipi_clear_active_handler);
> -#else
> -	install_irq_handler(EL1H_IRQ, ipi_clear_active_handler);
> -#endif
> -	local_irq_enable();
> -
> +	setup_irq(ipi_clear_active_handler);
>  	ipi_test_self();
>  	report_prefix_pop();
>  }
> diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
> index 21cdb58..55dd84b 100644
> --- a/lib/arm/asm/gic.h
> +++ b/lib/arm/asm/gic.h
> @@ -82,5 +82,8 @@ void gic_set_irq_target(int irq, int cpu);
>  void gic_set_irq_group(int irq, int group);
>  int gic_get_irq_group(int irq);
>  
> +typedef void (*handler_t)(struct pt_regs *regs __unused);
> +extern void setup_irq(handler_t handler);
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASMARM_GIC_H_ */
> diff --git a/lib/arm/gic.c b/lib/arm/gic.c
> index aa9cb86..8416dde 100644
> --- a/lib/arm/gic.c
> +++ b/lib/arm/gic.c
> @@ -236,3 +236,14 @@ int gic_get_irq_group(int irq)
>  {
>  	return gic_masked_irq_bits(irq, GICD_IGROUPR, 1, 0, ACCESS_READ);
>  }
> +
> +void setup_irq(handler_t handler)
> +{
> +	gic_enable_defaults();
> +#ifdef __arm__
> +	install_exception_handler(EXCPTN_IRQ, handler);
> +#else
> +	install_irq_handler(EL1H_IRQ, handler);
> +#endif
> +	local_irq_enable();
> +}
> -- 
> 2.20.1
>

I'd rather not add this function to the common code, at least not without
calling it something with 'defaults' in the name. Also I'd prefer unit
tests to call local_irq_enable()/disable() themselves. I think it's fine
to implement this in arm/gic.c and duplicate it in arm/pmu.c, if needed.

Thanks,
drew


