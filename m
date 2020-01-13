Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87892C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C05207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8pbuSBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C05207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3gi-0002N2-85
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ir3fC-0008OF-Ph
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ir3fB-00036Y-Ns
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:38:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ir3fB-000365-Hg
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578937085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uceV03oHRXx1E3vMv+AQpLYa8pUwxWrhcTUjGT9wAgg=;
 b=J8pbuSBpre48bblyCitvXaNDA6I/kPUiSQgicqCwyO4iYfxKftXEwgz/xDC+JdjB1trmT8
 y9/rv2DTUwsj0tmbF20ohfVHQ98+Tzp3us76zjkbNJ7HG+Fv11lVDNoqVpbEHJc8bom2ca
 wURys69TEQnEfe8uwbpNXUOyB83PlD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-e3PBCRvpP2ix9wg3H9ZurA-1; Mon, 13 Jan 2020 12:38:01 -0500
X-MC-Unique: e3PBCRvpP2ix9wg3H9ZurA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED7FA107ACC4;
 Mon, 13 Jan 2020 17:37:58 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83C367E58B;
 Mon, 13 Jan 2020 17:37:53 +0000 (UTC)
Date: Mon, 13 Jan 2020 18:37:51 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 08/16] arm/arm64: ITS: Init the command
 queue
Message-ID: <20200113173751.q344krmw7bdhrrtg@kamzik.brq.redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
 <20200110145412.14937-9-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145412.14937-9-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Fri, Jan 10, 2020 at 03:54:04PM +0100, Eric Auger wrote:
> Allocate the command queue and initialize related registers:
> CBASER, CREADR, CWRITER.
> 
> The command queue is 64kB. This aims at not bothing with fullness.

I think these means that the goal isn't completeness? If so, please
write "minimal implementation" or nothing, as all of kvm-unit-tests
is a minimal implementation.

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - removed readr
> ---
>  lib/arm/asm/gic-v3-its.h |  6 ++++++
>  lib/arm/gic-v3-its.c     | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 2f8b8f1..93814f7 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -75,10 +75,16 @@ struct its_baser {
>  	int esz;
>  };
>  
> +struct its_cmd_block {
> +	u64     raw_cmd[4];

Do we need these spaces (not even a tab) after the u64?

> +};
> +
>  struct its_data {
>  	void *base;
>  	struct its_typer typer;
>  	struct its_baser baser[GITS_BASER_NR_REGS];
> +	struct its_cmd_block *cmd_base;
> +	struct its_cmd_block *cmd_write;
>  };
>  
>  extern struct its_data its_data;
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index 6c97569..3037c84 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -177,3 +177,25 @@ void set_pending_table_bit(int rdist, int n, bool set)
>  		byte &= ~mask;
>  	*ptr = byte;
>  }
> +
> +/**
> + * init_cmd_queue: Allocate the command queue and initialize
> + * CBASER, CREADR, CWRITER
> + */
> +void init_cmd_queue(void);
> +void init_cmd_queue(void)

its_cmd_queue_init

> +{
> +	unsigned long n = SZ_64K >> PAGE_SHIFT;
> +	unsigned long order = fls(n);
> +	u64 cbaser;
> +
> +	its_data.cmd_base = (void *)virt_to_phys(alloc_pages(order));
> +
> +	cbaser = ((u64)its_data.cmd_base | (SZ_64K / SZ_4K - 1)	|
> +			GITS_CBASER_VALID);

120 chars

> +
> +	writeq(cbaser, its_data.base + GITS_CBASER);
> +
> +	its_data.cmd_write = its_data.cmd_base;
> +	writeq(0, its_data.base + GITS_CWRITER);
> +}
> -- 
> 2.20.1
>

Thanks,
drew 


