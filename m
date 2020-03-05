Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C7CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C23B2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHz4UCYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C23B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mxH-0008Tw-OE
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j9mwZ-000851-4X
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j9mwX-0005QQ-R4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:37:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j9mwX-0005Q3-NL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583401045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+FCFIRFbznBQRS5RiI1oKiCG0Ih5s+Wl3PBFLEoSi4=;
 b=bHz4UCYQBHab0u8WzqM3FiEb7wfFVPuea91IkYZu9eqfbQcCaqLu7w2k2MdkPBtwt3ENxW
 X7XsAVXyOdtr0uPKv8sSnixxsBjINVAGnQHuFkR/W+Hlc5hg1U+/wLXk379lULfDLGZyS7
 +NCmVDhjV0hRJgvRtWF+DIYR51Awfds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-EoOYzJSpNP6oNmtkXi4aGQ-1; Thu, 05 Mar 2020 04:37:23 -0500
X-MC-Unique: EoOYzJSpNP6oNmtkXi4aGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF678800D6C;
 Thu,  5 Mar 2020 09:37:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-110.brq.redhat.com
 [10.40.204.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84A6D90795;
 Thu,  5 Mar 2020 09:37:15 +0000 (UTC)
Date: Thu, 5 Mar 2020 10:37:12 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 6/9] arm: pmu: Test chained counter
Message-ID: <20200305093712.moxksc534hprwu5o@kamzik.brq.redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130112510.15154-7-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, kvm@vger.kernel.org, maz@kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, andre.przywara@arm.com,
 andrew.murray@arm.com, alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 12:25:07PM +0100, Eric Auger wrote:
> Add 2 tests exercising chained counters. The first one uses
> CPU_CYCLES and the second one uses SW_INCR.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arm/pmu.c         | 128 ++++++++++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg |  12 +++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index 1b0101f..538fbeb 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -113,6 +113,8 @@ static void test_event_introspection(void) {}
>  static void test_event_counter_config(void) {}
>  static void test_basic_event_count(void) {}
>  static void test_mem_access(void) {}
> +static void test_chained_counters(void) {}
> +static void test_chained_sw_incr(void) {}
>  
>  #elif defined(__aarch64__)
>  #define ID_AA64DFR0_PERFMON_SHIFT 8
> @@ -458,6 +460,126 @@ static void test_mem_access(void)
>  			read_sysreg(pmovsclr_el0));
>  }
>  
> +static void test_chained_counters(void)
> +{
> +	uint32_t events[] = { 0x11 /* CPU_CYCLES */, 0x1E /* CHAIN */};
> +
> +	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> +		return;
> +
> +	pmu_reset();
> +
> +	write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	/* enable counters #0 and #1 */
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	/* preset counter #0 at 0xFFFFFFF0 */
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +
> +	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> +
> +	report(read_regn(pmevcntr, 1) == 1, "CHAIN counter #1 incremented");
> +	report(!read_sysreg(pmovsclr_el0), "check no overflow is recorded");
> +
> +	/* test 64b overflow */
> +
> +	pmu_reset();
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_regn(pmevcntr, 1, 0x1);
> +	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
> +	report(read_regn(pmevcntr, 1) == 2, "CHAIN counter #1 incremented");
> +	report(!read_sysreg(pmovsclr_el0), "check no overflow is recorded");
> +
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_regn(pmevcntr, 1, 0xFFFFFFFF);
> +
> +	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
> +	report(!read_regn(pmevcntr, 1), "CHAIN counter #1 wrapped");
> +	report(read_sysreg(pmovsclr_el0) == 0x2,
> +		"check no overflow is recorded");
> +}
> +
> +static void test_chained_sw_incr(void)
> +{
> +	uint32_t events[] = { 0x0 /* SW_INCR */, 0x0 /* SW_INCR */};
> +	int i;
> +
> +	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> +		return;
> +
> +	pmu_reset();
> +
> +	write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	/* enable counters #0 and #1 */
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +
> +	/* preset counter #0 at 0xFFFFFFF0 */
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +
> +	for (i = 0; i < 100; i++)
> +		write_sysreg(0x1, pmswinc_el0);
> +
> +	report_info("SW_INCR counter #0 has value %ld", read_regn(pmevcntr, 0));
> +	report(read_regn(pmevcntr, 0) == 0xFFFFFFF0,
> +		"PWSYNC does not increment if PMCR.E is unset");
> +
> +	pmu_reset();
> +
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
> +
> +	for (i = 0; i < 100; i++)
> +		write_sysreg(0x3, pmswinc_el0);
> +
> +	report(read_regn(pmevcntr, 0)  == 84, "counter #1 after + 100 SW_INCR");
> +	report(read_regn(pmevcntr, 1)  == 100,
> +		"counter #0 after + 100 SW_INCR");
> +	report_info("counter values after 100 SW_INCR #0=%ld #1=%ld",
> +		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
> +	report(read_sysreg(pmovsclr_el0) == 0x1,
> +		"overflow reg after 100 SW_INCR");
> +
> +	/* 64b SW_INCR */
> +	pmu_reset();
> +
> +	events[1] = 0x1E /* CHAIN */;
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
> +	for (i = 0; i < 100; i++)
> +		write_sysreg(0x3, pmswinc_el0);
> +
> +	report(!read_sysreg(pmovsclr_el0) && (read_regn(pmevcntr, 1) == 1),
> +		"overflow reg after 100 SW_INCR/CHAIN");
> +	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
> +		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
> +
> +	/* 64b SW_INCR and overflow on CHAIN counter*/
> +	pmu_reset();
> +
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_regn(pmevcntr, 1, 0xFFFFFFFF);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
> +	for (i = 0; i < 100; i++)
> +		write_sysreg(0x3, pmswinc_el0);
> +
> +	report((read_sysreg(pmovsclr_el0) == 0x2) &&
> +		(read_regn(pmevcntr, 1) == 0) &&
> +		(read_regn(pmevcntr, 0) == 84),
> +		"overflow reg after 100 SW_INCR/CHAIN");
> +	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
> +		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
> +}
> +
>  #endif
>  
>  /*
> @@ -657,6 +779,12 @@ int main(int argc, char *argv[])
>  	} else if (strcmp(argv[1], "mem-access") == 0) {
>  		report_prefix_push(argv[1]);
>  		test_mem_access();
> +	} else if (strcmp(argv[1], "chained-counters") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_chained_counters();
> +	} else if (strcmp(argv[1], "chained-sw-incr") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_chained_sw_incr();
>  	} else {
>  		report_abort("Unknown sub-test '%s'", argv[1]);
>  	}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index 7a59403..1bd4319 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -90,6 +90,18 @@ groups = pmu
>  arch = arm64
>  extra_params = -append 'mem-access'
>  
> +[pmu-chained-counters]
> +file = pmu.flat
> +groups = pmu
> +arch = arm64
> +extra_params = -append 'chained-counters'
> +
> +[pmu-chained-sw-incr]
> +file = pmu.flat
> +groups = pmu
> +arch = arm64
> +extra_params = -append 'chained-sw-incr'
> +
>  # Test PMU support (TCG) with -icount IPC=1
>  #[pmu-tcg-icount-1]
>  #file = pmu.flat
> -- 
> 2.20.1
> 
> 

Same comments as previous patch

Thanks,
drew


