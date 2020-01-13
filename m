Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B4C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080E4206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGegURhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080E4206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3a3-0003Ts-7J
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ir3Yr-00028r-29
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ir3Yp-0003bz-Kc
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:31:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ir3Yn-0003Wj-Ct
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578936688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEBUDqgM3gGBMdV6rvvSSOuZuUWDxugabavxa54G2Vg=;
 b=NGegURhWWn0YD9lif458ntfbu3ZcyeOFy8exy7jaxapiwg8POa6uoi5z/ds/1tzz8ZQIGM
 1hVZbkFQ9wY2KrgR+eNOk5CbIn+Vtx0MBKA6//vNlwniWx5JGmytuNieyn6hxYwCwlpMm6
 i1pI5n8z9G3qDI6BRdyKZDFpwoEYbhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-1XCR-LcoPaekVf8yIqT8Lw-1; Mon, 13 Jan 2020 12:31:24 -0500
X-MC-Unique: 1XCR-LcoPaekVf8yIqT8Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 520648024CC;
 Mon, 13 Jan 2020 17:31:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0332C10841ED;
 Mon, 13 Jan 2020 17:31:16 +0000 (UTC)
Date: Mon, 13 Jan 2020 18:31:14 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 07/16] arm/arm64: ITS: Set the LPI
 config and pending tables
Message-ID: <20200113173114.4cjfqebzrfb7iepg@kamzik.brq.redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
 <20200110145412.14937-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145412.14937-8-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On Fri, Jan 10, 2020 at 03:54:03PM +0100, Eric Auger wrote:
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
> v1 -> v2:
> - remove memory attributes
> ---
>  lib/arm/asm/gic-v3-its.h |  3 ++
>  lib/arm/asm/gic-v3.h     | 12 ++++++++
>  lib/arm/gic-v3-its.c     | 60 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 5a4dfe9..2f8b8f1 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -90,6 +90,9 @@ extern void its_init(void);
>  extern int its_parse_baser(int i, struct its_baser *baser);
>  extern void its_setup_baser(int i, struct its_baser *baser);
>  extern struct its_baser *its_lookup_baser(int type);
> +extern void set_lpi_config(int n, u8 val);
> +extern u8 get_lpi_config(int n);
> +extern void set_pending_table_bit(int rdist, int n, bool set);

Please prefix with 'its' or at least swap the 'lpi' and verb. E.g.
lpi_set_config, its_set_pending_table_bit.


>  
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASMARM_GIC_V3_ITS_H_ */
> diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
> index ffb2e26..90a7304 100644
> --- a/lib/arm/asm/gic-v3.h
> +++ b/lib/arm/asm/gic-v3.h
> @@ -48,6 +48,16 @@
>  #define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
>  	(MPIDR_AFFINITY_LEVEL(cluster_id, level) << ICC_SGI1R_AFFINITY_## level ## _SHIFT)
>  
> +#define GICR_PROPBASER_IDBITS_MASK                      (0x1f)
> +
> +#define GICR_PENDBASER_PTZ                              BIT_ULL(62)
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
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index 79946c3..6c97569 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -117,3 +117,63 @@ void its_setup_baser(int i, struct its_baser *baser)
>  	writeq(val, gicv3_its_base() + GITS_BASER + i * 8);
>  }
>  
> +inline void set_lpi_config(int n, u8 value)
> +{
> +	u8 *entry = (u8 *)(gicv3_data.lpi_prop + (n - 8192));
> +	*entry = value;
> +}
> +
> +inline u8 get_lpi_config(int n)
> +{
> +	u8 *entry = (u8 *)(gicv3_data.lpi_prop + (n - 8192));
> +	return *entry;
> +}

Probably don't need the 'inline', but ok.

> +
> +/* alloc_lpi_tables: Allocate LPI config and pending tables */
> +void alloc_lpi_tables(void);
> +void alloc_lpi_tables(void)

Why not add this to the header (renamed to lpi_alloc_tables)? Or should
this function be static?

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
> +		gicv3_data.lpi_pend[cpu] =
> +			(void *)virt_to_phys(alloc_pages(order));

nit: I think these line brakes on = or worse than going over 80 chars.
And, you don't need to worry about 80 chars anyway. See the README, we
allow 120.

> +
> +		pend_val = (u64)gicv3_data.lpi_pend[cpu];
> +
> +		writeq(pend_val, ptr + GICR_PENDBASER);
> +	}
> +}
> +
> +void set_pending_table_bit(int rdist, int n, bool set)
> +{
> +	u8 *ptr = phys_to_virt((phys_addr_t)gicv3_data.lpi_pend[rdist]);
> +	u8 mask = 1 << (n % 8), byte;
> +
> +	ptr += (n / 8);
> +	byte = *ptr;
> +	if (set)
> +		byte |=  mask;
> +	else
> +		byte &= ~mask;
> +	*ptr = byte;
> +}
> -- 
> 2.20.1
> 

Thanks,
drew


