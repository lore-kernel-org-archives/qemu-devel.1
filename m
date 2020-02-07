Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF9C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605A721741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cv6KPEgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605A721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02Ub-0006it-KR
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j02Tg-0006DX-Pe
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j02Tf-0002F6-FS
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:11:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29515
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j02Tf-00025n-Ad
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581077476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ha8p3Y8w7TUoTeJEAe0zMDx8bCokWL2pCDEb/sxa6Jc=;
 b=cv6KPEglXafHd/E/7d37iV/XRGT3aV4KSMFByfV5NPgm3L1Q+vDU/mIFq2EaS5YvUem9ju
 SZrAZofoTmxFnjOFkCdiVgSZ1mUvItTs5Sdnr2w1PFq4L+CDdjx/QAND+rn75s3UUBNkHS
 ArgC/glMpe2jFHVuhyhZBx4AXtSiFqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-On0-zrUEOAaqMZfS-Bg4EA-1; Fri, 07 Feb 2020 07:11:12 -0500
X-MC-Unique: On0-zrUEOAaqMZfS-Bg4EA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90DF71081FA0;
 Fri,  7 Feb 2020 12:11:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 057DE790D8;
 Fri,  7 Feb 2020 12:11:05 +0000 (UTC)
Date: Fri, 7 Feb 2020 13:11:03 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 06/14] arm/arm64: gicv3: Set the LPI
 config and pending tables
Message-ID: <20200207121103.p3vry5cucdaikj6x@kamzik.brq.redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128103459.19413-7-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, yuzenghui@huawei.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 11:34:51AM +0100, Eric Auger wrote:
> Allocate the LPI configuration and per re-distributor pending table.
> Set redistributor's PROPBASER and PENDBASER. The LPIs are enabled
> by default in the config table.
> 
> Also introduce a helper routine that allows to set the pending table
> bit for a given LPI.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - Move the helpers in lib/arm/gic-v3.c and prefix them with "gicv3_"
>   and add _lpi prefix too
> 
> v1 -> v2:
> - remove memory attributes
> ---
>  lib/arm/asm/gic-v3.h | 16 +++++++++++
>  lib/arm/gic-v3.c     | 64 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
> index ffb2e26..ec2a6f0 100644
> --- a/lib/arm/asm/gic-v3.h
> +++ b/lib/arm/asm/gic-v3.h
> @@ -48,6 +48,16 @@
>  #define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
>  	(MPIDR_AFFINITY_LEVEL(cluster_id, level) << ICC_SGI1R_AFFINITY_## level ## _SHIFT)
>  
> +#define GICR_PROPBASER_IDBITS_MASK                      (0x1f)
> +
> +#define GICR_PENDBASER_PTZ                              BIT_ULL(62)

Strange indent here, too far and not tabs

> +
> +#define LPI_PROP_GROUP1		(1 << 1)
> +#define LPI_PROP_ENABLED	(1 << 0)
> +#define LPI_PROP_DEFAULT_PRIO   0xa0
> +#define LPI_PROP_DEFAULT	(LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1 | \
> +				 LPI_PROP_ENABLED)
> +
>  #include <asm/arch_gicv3.h>
>  
>  #ifndef __ASSEMBLY__
> @@ -64,6 +74,8 @@ struct gicv3_data {
>  	void *dist_base;
>  	void *redist_bases[GICV3_NR_REDISTS];
>  	void *redist_base[NR_CPUS];
> +	void *lpi_prop;
> +	void *lpi_pend[NR_CPUS];
>  	unsigned int irq_nr;
>  };
>  extern struct gicv3_data gicv3_data;
> @@ -80,6 +92,10 @@ extern void gicv3_write_eoir(u32 irqstat);
>  extern void gicv3_ipi_send_single(int irq, int cpu);
>  extern void gicv3_ipi_send_mask(int irq, const cpumask_t *dest);
>  extern void gicv3_set_redist_base(size_t stride);
> +extern void gicv3_lpi_set_config(int n, u8 val);
> +extern u8 gicv3_lpi_get_config(int n);
> +extern void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set);
> +extern void gicv3_lpi_alloc_tables(void);
>  
>  static inline void gicv3_do_wait_for_rwp(void *base)
>  {
> diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
> index feecb5e..c33f883 100644
> --- a/lib/arm/gic-v3.c
> +++ b/lib/arm/gic-v3.c
> @@ -5,6 +5,7 @@
>   */
>  #include <asm/gic.h>
>  #include <asm/io.h>
> +#include <alloc_page.h>
>  
>  void gicv3_set_redist_base(size_t stride)
>  {
> @@ -147,3 +148,66 @@ void gicv3_ipi_send_single(int irq, int cpu)
>  	cpumask_set_cpu(cpu, &dest);
>  	gicv3_ipi_send_mask(irq, &dest);
>  }
> +
> +#if defined(__aarch64__)
> +/* alloc_lpi_tables: Allocate LPI config and pending tables */
> +void gicv3_lpi_alloc_tables(void)
> +{
> +	unsigned long n = SZ_64K >> PAGE_SHIFT;
> +	unsigned long order = fls(n);
> +	u64 prop_val;
> +	int cpu;
> +
> +	gicv3_data.lpi_prop = (void *)virt_to_phys(alloc_pages(order));
> +
> +	/* ID bits = 13, ie. up to 14b LPI INTID */
> +	prop_val = (u64)gicv3_data.lpi_prop | 13;
> +
> +	/*
> +	 * Allocate pending tables for each redistributor
> +	 * and set PROPBASER and PENDBASER
> +	 */
> +	for_each_present_cpu(cpu) {
> +		u64 pend_val;
> +		void *ptr;
> +
> +		ptr = gicv3_data.redist_base[cpu];
> +
> +		writeq(prop_val, ptr + GICR_PROPBASER);
> +
> +		gicv3_data.lpi_pend[cpu] = (void *)virt_to_phys(alloc_pages(order));
> +
> +		pend_val = (u64)gicv3_data.lpi_pend[cpu];
> +
> +		writeq(pend_val, ptr + GICR_PENDBASER);

nit: probably don't need all the blank lines

> +	}
> +}
> +
> +void gicv3_lpi_set_config(int n, u8 value)
> +{
> +	u8 *entry = (u8 *)(gicv3_data.lpi_prop + (n - 8192));
> +
> +	*entry = value;
> +}
> +
> +u8 gicv3_lpi_get_config(int n)
> +{
> +	u8 *entry = (u8 *)(gicv3_data.lpi_prop + (n - 8192));
> +
> +	return *entry;
> +}

We probably need a define for the 8192. LPI_ID_BASE? And, like PPI and SPI
maybe we need an LPI(id)? '#define LPI(id) ((id) + LPI_ID_BASE)'?

Also, is lpi_prop an array of u8's? If so, then I'd think we could
declare it as a u8 * in gicv3_data. Then, instead of the above two
functions just do something like

 #define gicv3_lpi_set_config(n, val) ({
     gicv3_data.lpi_prop[n] = (val);
 })
 #define gicv3_lpi_get_config(n) (gicv3_data.lpi_prop[n])

> +
> +void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set)

These types of functions that can be used both as a setter and clearer
usually have a name like foo_set_clr_bar(). That would make this long
name a bit longer, but do we need the '_table_bit' part of the name?

> +{
> +	u8 *ptr = phys_to_virt((phys_addr_t)gicv3_data.lpi_pend[rdist]);

If lpi_pend is a physical address then why not declare it like that
in gicv3_data, i.e. phys_addr_t lpi_pend[NR_CPUS] ?

> +	u8 mask = 1 << (n % 8), byte;
> +
> +	ptr += (n / 8);
> +	byte = *ptr;

And Zenghui already pointed out that this doesn't look right for
a physical address.

> +	if (set)
> +		byte |=  mask;
> +	else
> +		byte &= ~mask;
> +	*ptr = byte;
> +}
> +#endif /* __aarch64__ */
> -- 
> 2.20.1
> 
>

Thanks,
drew


