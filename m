Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C082C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EA9207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUz1zbml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EA9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3nT-00072i-3d
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ir3mC-00065B-Ic
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ir3mB-0004MW-56
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:45:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43617
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ir3mA-0004Km-VL
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578937517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZjupOVr34zDecwnMFqtNXPvApC4Q2OCWXOaNuSUosdM=;
 b=OUz1zbmlFyfKsy8aq822AesXDhNIiPxfF1FYRsN4aVwyfhKj1G84GIIz/2GbKoQ/llDCDs
 r4RXzfDvHX1TPgzdK5XUxyCPJSrzWbargUL4Azqsy8a8R1KP9nMFmaqWBA5fVBX1HCpKVR
 eJfZhso//FywyCGUBQIHwbxVy5EgnLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-EQyERcpHO2KS3VKae6uwbg-1; Mon, 13 Jan 2020 12:45:14 -0500
X-MC-Unique: EQyERcpHO2KS3VKae6uwbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43FE018B9FC1;
 Mon, 13 Jan 2020 17:45:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB418886A;
 Mon, 13 Jan 2020 17:44:59 +0000 (UTC)
Date: Mon, 13 Jan 2020 18:44:57 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 09/16] arm/arm64: ITS: Enable/Disable
 LPIs at re-distributor level
Message-ID: <20200113174457.gg35yyeaftbadqki@kamzik.brq.redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
 <20200110145412.14937-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145412.14937-10-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

On Fri, Jan 10, 2020 at 03:54:05PM +0100, Eric Auger wrote:
> This helper function enables or disables the signaling of LPIs
> at redistributor level.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  lib/arm/asm/gic-v3-its.h |  1 +
>  lib/arm/gic-v3-its.c     | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 93814f7..d2db292 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -99,6 +99,7 @@ extern struct its_baser *its_lookup_baser(int type);
>  extern void set_lpi_config(int n, u8 val);
>  extern u8 get_lpi_config(int n);
>  extern void set_pending_table_bit(int rdist, int n, bool set);
> +extern void gicv3_rdist_ctrl_lpi(u32 redist, bool set);
>  
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASMARM_GIC_V3_ITS_H_ */
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index 3037c84..c7c6f80 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -199,3 +199,21 @@ void init_cmd_queue(void)
>  	its_data.cmd_write = its_data.cmd_base;
>  	writeq(0, its_data.base + GITS_CWRITER);
>  }
> +
> +void gicv3_rdist_ctrl_lpi(u32 redist, bool set)
> +{
> +	void *ptr;
> +	u64 val;
> +
> +	if (redist >= nr_cpus)
> +		report_abort("%s redist=%d >= cpu_count=%d\n",
> +			     __func__, redist, nr_cpus);

I'd use {} here because of the multiline call. But, we don't
use the report API in common code. Well, apparently s390 has
report calls in lib/s390x/interrupt.c, but I don't really
agree with that. IMO, common code failures should always
be unexpected and just assert/assert_msg.

> +
> +	ptr = gicv3_data.redist_base[redist];
> +	val = readl(ptr + GICR_CTLR);
> +	if (set)
> +		val |= GICR_CTLR_ENABLE_LPIS;
> +	else
> +		val &= ~GICR_CTLR_ENABLE_LPIS;
> +	writel(val,  ptr + GICR_CTLR);
> +}
> -- 
> 2.20.1
> 

Also, you can squash this patch into whatever is going to make use
of this new helper.

Thanks,
drew


