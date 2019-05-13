Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25864C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0075208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0075208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55357 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ98g-0001x5-O4
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:29:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQ97a-0001Zd-5u
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQ96R-0000cX-PV
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:26:44 -0400
Received: from foss.arm.com ([217.140.101.70]:49710)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hQ96Q-0000bT-0x; Mon, 13 May 2019 07:26:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57CCF374;
	Mon, 13 May 2019 04:26:40 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD5993F703;
	Mon, 13 May 2019 04:26:38 -0700 (PDT)
Date: Mon, 13 May 2019 12:26:36 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190513112635.GD28398@e103592.cambridge.arm.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-12-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512083624.8916-12-drjones@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [PATCH 11/13] target/arm/cpu64: max cpu: Introduce
 sve-vls-map
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 12, 2019 at 09:36:22AM +0100, Andrew Jones wrote:
> Introduce another cpu property to control SVE vector lengths,
> sve-vls-map, which allows the user to explicitly select the
> set of vector lengths the guest can use. The map must conform
> to QEMU's limits and architectural constraints, checked when
> the property is set. Inconsistencies with sve-max-vq are also
> checked. The bit number of a set bit in the map represents the
> allowed vector length in number of quadwords.
> 
> Note, as the map is implemented with a single 64-bit word we
> currently only support up to 8192-bit vectors. As QEMU and
> KVM only support up to 2048-bit vectors then this sufficient
> now, and probably for some time. Extending the bitmap beyond
> a single word will likely require changing the property to
> a string and adding yet another parser to QEMU.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.c     |  4 +++
>  target/arm/cpu.h     |  3 ++
>  target/arm/cpu64.c   | 70 +++++++++++++++++++++++++++++++++++++++++---
>  target/arm/helper.c  | 10 ++++++-
>  target/arm/monitor.c |  9 ++++--
>  5 files changed, 88 insertions(+), 8 deletions(-)
> 

[...]

> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8292d547e8f9..f0d0ce759ba8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -920,6 +920,9 @@ struct ARMCPU {
>  
>      /* Used to set the maximum vector length the cpu will support.  */
>      uint32_t sve_max_vq;
> +
> +    /* Each bit represents a supported vector length of (bitnum * 16) bytes */
> +    uint64_t sve_vls_map;

Just to be clear, the representation here is different from the
representation in KVM_REG_ARM64_SVE_VLS?

In the latter, bit n represents vector length ((n + 1) * 16) bytes.

(QEMU is free to choose its own internal representation, naturally.)

[...]

> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c

[...]

> +static void cpu_set_sve_vls_map(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    Error *err = NULL;
> +    uint64_t mask = ~(BIT_MASK(ARM_MAX_VQ - 1) - 1);
> +    int i;
> +
> +    visit_type_uint64(v, name, &cpu->sve_vls_map, errp);
> +
> +    if (!err) {
> +        if (cpu->sve_vls_map == 0) {
> +            error_setg(&err, "SVE vector length map cannot be zero");

Maybe say "empty" here, since the map represents a set?

(But it this is just for debug rather than reporting errors to the user,
it probably doesn't matter much.)

[...]

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 1e6eb0d0f360..bedec1ea0b27 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5254,12 +5254,20 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
>  static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                        uint64_t value)
>  {
> +    ARMCPU *cpu = arm_env_get_cpu(env);
>      int cur_el = arm_current_el(env);
>      int old_len = sve_zcr_len_for_el(env, cur_el);
>      int new_len;
>  
>      /* Bits other than [3:0] are RAZ/WI.  */
> -    raw_write(env, ri, value & 0xf);
> +    value &= 0xf;

You might want to sanity-check that the max vq you configured for the
vcpu is <= 16 here.

> +
> +    if (value && !(BIT_MASK(value) & cpu->sve_vls_map)) {
> +        uint64_t map = cpu->sve_vls_map & (BIT_MASK(value) - 1);
> +        value = arm_cpu_fls64(map) - 1;
> +    }
> +
> +    raw_write(env, ri, value);

[...]

Cheers
---Dave

