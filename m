Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82112C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B312073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/i29GaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B312073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nA6-0002Cj-HO
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j9n9J-0001c5-BD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j9n9H-0007Z0-Rf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:50:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38430
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j9n9H-0007Xg-Nk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583401833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oYO4NseVO/EVN3mPo7FvqNiB3QzjJhFFu6a7Wy0sKRo=;
 b=M/i29GaBx1ghxobQLJv7f0SFMnP8qgERlSiCiyHQb6GhtSJosgzcwggvyS2Us6c1ph00hd
 nPyEJxy7aXczQJwloT/8z4YvgD9/5rc8JEyufLhLtiEYtpzEEd0mm4XfPi8o9mwFad4Kpv
 1ohz6gGvzeitq3Db9ULamZTTOULFY3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-fB3wazV-O-mdGsF9xJpr8g-1; Thu, 05 Mar 2020 04:50:30 -0500
X-MC-Unique: fB3wazV-O-mdGsF9xJpr8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7140B800D50;
 Thu,  5 Mar 2020 09:50:28 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-110.brq.redhat.com
 [10.40.204.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DBE790538;
 Thu,  5 Mar 2020 09:50:22 +0000 (UTC)
Date: Thu, 5 Mar 2020 10:50:19 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 7/9] arm: pmu: test 32-bit <-> 64-bit
 transitions
Message-ID: <20200305095019.tw2bfwdmihcpuphc@kamzik.brq.redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130112510.15154-8-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Thu, Jan 30, 2020 at 12:25:08PM +0100, Eric Auger wrote:
> Test configurations where we transit from 32b to 64b
> counters and conversely. Also tests configuration where
> chain counters are configured but only one counter is
> enabled.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arm/pmu.c         | 136 ++++++++++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg |   6 ++
>  2 files changed, 142 insertions(+)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index 538fbeb..fa77ab3 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -115,6 +115,7 @@ static void test_basic_event_count(void) {}
>  static void test_mem_access(void) {}
>  static void test_chained_counters(void) {}
>  static void test_chained_sw_incr(void) {}
> +static void test_chain_promotion(void) {}
>  
>  #elif defined(__aarch64__)
>  #define ID_AA64DFR0_PERFMON_SHIFT 8
> @@ -580,6 +581,138 @@ static void test_chained_sw_incr(void)
>  		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
>  }
>  
> +static void test_chain_promotion(void)
> +{
> +	uint32_t events[] = { 0x13 /* MEM_ACCESS */, 0x1E /* CHAIN */};
> +	void *addr = malloc(PAGE_SIZE);
> +
> +	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> +		return;
> +
> +	/* Only enable CHAIN counter */
> +	pmu_reset();
> +	write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	write_sysreg_s(0x2, PMCNTENSET_EL0);
> +	isb();
> +
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report(!read_regn(pmevcntr, 0),
> +		"chain counter not counting if even counter is disabled");
> +
> +	/* Only enable even counter */
> +	pmu_reset();
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_sysreg_s(0x1, PMCNTENSET_EL0);
> +	isb();
> +
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report(!read_regn(pmevcntr, 1) && (read_sysreg(pmovsclr_el0) == 0x1),
> +		"odd counter did not increment on overflow if disabled");
> +	report_info("MEM_ACCESS counter #0 has value %ld",
> +		    read_regn(pmevcntr, 0));
> +	report_info("CHAIN counter #1 has value %ld",
> +		    read_regn(pmevcntr, 1));
> +	report_info("overflow counter %ld", read_sysreg(pmovsclr_el0));
> +
> +	/* start at 0xFFFFFFDC, +20 with CHAIN enabled, +20 with CHAIN disabled */
> +	pmu_reset();
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	write_regn(pmevcntr, 0, 0xFFFFFFDC);
> +	isb();
> +
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("MEM_ACCESS counter #0 has value 0x%lx",
> +		    read_regn(pmevcntr, 0));
> +
> +	/* disable the CHAIN event */
> +	write_sysreg_s(0x2, PMCNTENCLR_EL0);
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("MEM_ACCESS counter #0 has value 0x%lx",
> +		    read_regn(pmevcntr, 0));
> +	report(read_sysreg(pmovsclr_el0) == 0x1,
> +		"should have triggered an overflow on #0");
> +	report(!read_regn(pmevcntr, 1),
> +		"CHAIN counter #1 shouldn't have incremented");
> +
> +	/* start at 0xFFFFFFDC, +20 with CHAIN disabled, +20 with CHAIN enabled */
> +
> +	pmu_reset();
> +	write_sysreg_s(0x1, PMCNTENSET_EL0);
> +	write_regn(pmevcntr, 0, 0xFFFFFFDC);
> +	isb();
> +	report_info("counter #0 = 0x%lx, counter #1 = 0x%lx overflow=0x%lx",
> +		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1),
> +		    read_sysreg(pmovsclr_el0));
> +
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("MEM_ACCESS counter #0 has value 0x%lx",
> +		    read_regn(pmevcntr, 0));
> +
> +	/* enable the CHAIN event */
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	isb();
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("MEM_ACCESS counter #0 has value 0x%lx",
> +		    read_regn(pmevcntr, 0));
> +
> +	report((read_regn(pmevcntr, 1) == 1) && !read_sysreg(pmovsclr_el0),
> +		"CHAIN counter #1 should have incremented and no overflow expected");
> +
> +	report_info("CHAIN counter #1 = 0x%lx, overflow=0x%lx",
> +		read_regn(pmevcntr, 1), read_sysreg(pmovsclr_el0));
> +
> +	/* start as MEM_ACCESS/CPU_CYCLES and move to CHAIN/MEM_ACCESS */
> +	pmu_reset();
> +	write_regn(pmevtyper, 0, 0x13 /* MEM_ACCESS */ | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevtyper, 1, 0x11 /* CPU_CYCLES */ | PMEVTYPER_EXCLUDE_EL0);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	write_regn(pmevcntr, 0, 0xFFFFFFDC);
> +	isb();
> +
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("MEM_ACCESS counter #0 has value 0x%lx",
> +		    read_regn(pmevcntr, 0));
> +
> +	/* 0 becomes CHAINED */
> +	write_sysreg_s(0x0, PMCNTENSET_EL0);
> +	write_regn(pmevtyper, 1, 0x1E /* CHAIN */ | PMEVTYPER_EXCLUDE_EL0);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	write_regn(pmevcntr, 1, 0x0);
> +
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("MEM_ACCESS counter #0 has value 0x%lx",
> +		    read_regn(pmevcntr, 0));
> +
> +	report((read_regn(pmevcntr, 1) == 1) && !read_sysreg(pmovsclr_el0),
> +		"CHAIN counter #1 should have incremented and no overflow expected");
> +
> +	report_info("CHAIN counter #1 = 0x%lx, overflow=0x%lx",
> +		read_regn(pmevcntr, 1), read_sysreg(pmovsclr_el0));
> +
> +	/* start as CHAIN/MEM_ACCESS and move to MEM_ACCESS/CPU_CYCLES */
> +	pmu_reset();
> +	write_regn(pmevtyper, 0, 0x13 /* MEM_ACCESS */ | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevtyper, 1, 0x1E /* CHAIN */ | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevcntr, 0, 0xFFFFFFDC);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("counter #0=0x%lx, counter #1=0x%lx",
> +			read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
> +
> +	write_sysreg_s(0x0, PMCNTENSET_EL0);
> +	write_regn(pmevtyper, 1, 0x11 /* CPU_CYCLES */ | PMEVTYPER_EXCLUDE_EL0);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +
> +	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
> +	report(read_sysreg(pmovsclr_el0) == 1,
> +		"overflow is expected on counter 0");
> +	report_info("counter #0=0x%lx, counter #1=0x%lx overflow=0x%lx",
> +			read_regn(pmevcntr, 0), read_regn(pmevcntr, 1),
> +			read_sysreg(pmovsclr_el0));
> +}
> +
>  #endif
>  
>  /*
> @@ -785,6 +918,9 @@ int main(int argc, char *argv[])
>  	} else if (strcmp(argv[1], "chained-sw-incr") == 0) {
>  		report_prefix_push(argv[1]);
>  		test_chained_sw_incr();
> +	} else if (strcmp(argv[1], "chain-promotion") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_chain_promotion();
>  	} else {
>  		report_abort("Unknown sub-test '%s'", argv[1]);
>  	}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index 1bd4319..eb6e87e 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -102,6 +102,12 @@ groups = pmu
>  arch = arm64
>  extra_params = -append 'chained-sw-incr'
>  
> +[pmu-chain-promotion]
> +file = pmu.flat
> +groups = pmu
> +arch = arm64
> +extra_params = -append 'chain-promotion'
> +
>  # Test PMU support (TCG) with -icount IPC=1
>  #[pmu-tcg-icount-1]
>  #file = pmu.flat
> -- 
> 2.20.1
> 
> 

same comments as previous patches

Thanks,
drew


