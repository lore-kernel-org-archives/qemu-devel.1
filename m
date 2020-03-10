Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4ABC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E842464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fj5t5XMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E842464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdXp-0002kc-PT
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jBdVI-00089K-7t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jBdVG-0002RZ-61
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:56:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23151
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jBdVG-0002OU-1l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkbbEKW7QEXShSOEzrtREPglmDREmtovE720FoZTixg=;
 b=Fj5t5XMnV1YL3LKRFGqEAgpyYeGy+0kCX5hX/oCGEi5TvUlqDCI86rrK+ae2NIbDFcR0cV
 2Bpe26cp46cro89qnTLFmGl7hICkLxv5F7RhBCMLKUNm5ZZNDi1YUidXMmSDyJtqLgg1Cn
 4Aa1c7+OrnbjHd7mkgFZ4PCvxBFdKHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-7XoWPANpNouHhszEpiwCag-1; Tue, 10 Mar 2020 07:56:51 -0400
X-MC-Unique: 7XoWPANpNouHhszEpiwCag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F13800EBD;
 Tue, 10 Mar 2020 11:56:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58D325C545;
 Tue, 10 Mar 2020 11:56:44 +0000 (UTC)
Date: Tue, 10 Mar 2020 12:56:42 +0100
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 03/13] arm/arm64: gic: Introduce
 setup_irq() helper
Message-ID: <20200310115642.vr7rx3gacl6xpjrf@kamzik.brq.redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
 <20200309102420.24498-4-eric.auger@redhat.com>
 <20200309105601.3hm2kfhuufgxoydl@kamzik.brq.redhat.com>
 <3e1e2c24-2f30-03f2-ca9c-a2d99aba0740@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1e2c24-2f30-03f2-ca9c-a2d99aba0740@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

On Tue, Mar 10, 2020 at 12:00:19PM +0100, Auger Eric wrote:
> Hi Drew,
> On 3/9/20 11:56 AM, Andrew Jones wrote:
> > On Mon, Mar 09, 2020 at 11:24:10AM +0100, Eric Auger wrote:
> >> ipi_enable() code would be reusable for other interrupts
> >> than IPI. Let's rename it setup_irq() and pass an interrupt
> >> handler pointer.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >>
> >> v2 -> v3:
> >> - do not export setup_irq anymore
> >> ---
> >>  arm/gic.c | 20 +++++++-------------
> >>  1 file changed, 7 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/arm/gic.c b/arm/gic.c
> >> index fcf4c1f..abf08c7 100644
> >> --- a/arm/gic.c
> >> +++ b/arm/gic.c
> >> @@ -34,6 +34,7 @@ static struct gic *gic;
> >>  static int acked[NR_CPUS], spurious[NR_CPUS];
> >>  static int bad_sender[NR_CPUS], bad_irq[NR_CPUS];
> >>  static cpumask_t ready;
> >> +typedef void (*handler_t)(struct pt_regs *regs __unused);
> > 
> > This is just irq_handler_fn, which is already defined in processor.h.
> > We don't need the __unused, not since 6b07148d06b1 ("Replace -Wextra
> > with a saner list of warning flags").
> Shall I duplicate it into ./lib/arm/asm/processor.h as well?

Yes, please do

Thanks,
drew
> 
> Thanks
> 
> Eric
> > 
> >>  
> >>  static void nr_cpu_check(int nr)
> >>  {
> >> @@ -215,20 +216,20 @@ static void ipi_test_smp(void)
> >>  	report_prefix_pop();
> >>  }
> >>  
> >> -static void ipi_enable(void)
> >> +static void setup_irq(handler_t handler)
> >>  {
> >>  	gic_enable_defaults();
> >>  #ifdef __arm__
> >> -	install_exception_handler(EXCPTN_IRQ, ipi_handler);
> >> +	install_exception_handler(EXCPTN_IRQ, handler);
> >>  #else
> >> -	install_irq_handler(EL1H_IRQ, ipi_handler);
> >> +	install_irq_handler(EL1H_IRQ, handler);
> >>  #endif
> >>  	local_irq_enable();
> >>  }
> >>  
> >>  static void ipi_send(void)
> >>  {
> >> -	ipi_enable();
> >> +	setup_irq(ipi_handler);
> >>  	wait_on_ready();
> >>  	ipi_test_self();
> >>  	ipi_test_smp();
> >> @@ -238,7 +239,7 @@ static void ipi_send(void)
> >>  
> >>  static void ipi_recv(void)
> >>  {
> >> -	ipi_enable();
> >> +	setup_irq(ipi_handler);
> >>  	cpumask_set_cpu(smp_processor_id(), &ready);
> >>  	while (1)
> >>  		wfi();
> >> @@ -295,14 +296,7 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
> >>  static void run_active_clear_test(void)
> >>  {
> >>  	report_prefix_push("active");
> >> -	gic_enable_defaults();
> >> -#ifdef __arm__
> >> -	install_exception_handler(EXCPTN_IRQ, ipi_clear_active_handler);
> >> -#else
> >> -	install_irq_handler(EL1H_IRQ, ipi_clear_active_handler);
> >> -#endif
> >> -	local_irq_enable();
> >> -
> >> +	setup_irq(ipi_clear_active_handler);
> >>  	ipi_test_self();
> >>  	report_prefix_pop();
> >>  }
> >> -- 
> >> 2.20.1
> >>
> 
> 


