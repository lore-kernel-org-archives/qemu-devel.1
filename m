Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48230C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C6620838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8KyB5Su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C6620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02cj-0003jo-98
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j02by-00039j-GJ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j02bw-0000mc-NK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:19:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56127
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j02bw-0000iy-JW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581077991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTNUC9fsNE6VxpNL7r78PwDWNHM+b+0JIyuBMuACd1o=;
 b=A8KyB5Su9G77Uvw2+tiojlwY0ppqMnwGX0bUq8IwwJfNZgkSdTW4BRBxcEXQVaWPNfaKuG
 CyLtNewi7BGR68c+ugHJYgiy+h+6bOqncSldDKeUTEj4PT5WwEQJfW1c5rmXKu+FjnFgcg
 6+hi2ANDbhPdIbpWxvCBuhoE8EZzF78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-L5xCDUqvPKSy6tgTy0YJPw-1; Fri, 07 Feb 2020 07:19:47 -0500
X-MC-Unique: L5xCDUqvPKSy6tgTy0YJPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A17ED108838A;
 Fri,  7 Feb 2020 12:19:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18FEB60BEC;
 Fri,  7 Feb 2020 12:19:40 +0000 (UTC)
Date: Fri, 7 Feb 2020 13:19:37 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 07/14] arm/arm64: gicv3: Enable/Disable
 LPIs at re-distributor level
Message-ID: <20200207121937.qstc3m55icpcn5rr@kamzik.brq.redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-8-eric.auger@redhat.com>
 <20200207121437.qtvonx2x2xh3dvgc@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207121437.qtvonx2x2xh3dvgc@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Fri, Feb 07, 2020 at 01:14:37PM +0100, Andrew Jones wrote:
> On Tue, Jan 28, 2020 at 11:34:52AM +0100, Eric Auger wrote:
> > This helper function controls the signaling of LPIs at
> > redistributor level.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > 
> > ---
> > 
> > v2 -> v3:
> > - move the helper in lib/arm/gic-v3.c
> > - rename the function with gicv3_lpi_ prefix
> > - s/report_abort/assert
> > ---
> >  lib/arm/asm/gic-v3.h |  1 +
> >  lib/arm/gic-v3.c     | 17 +++++++++++++++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
> > index ec2a6f0..734c0c0 100644
> > --- a/lib/arm/asm/gic-v3.h
> > +++ b/lib/arm/asm/gic-v3.h
> > @@ -96,6 +96,7 @@ extern void gicv3_lpi_set_config(int n, u8 val);
> >  extern u8 gicv3_lpi_get_config(int n);
> >  extern void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set);
> >  extern void gicv3_lpi_alloc_tables(void);
> > +extern void gicv3_lpi_rdist_ctrl(u32 redist, bool set);
> >  
> >  static inline void gicv3_do_wait_for_rwp(void *base)
> >  {
> > diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
> > index c33f883..7865d01 100644
> > --- a/lib/arm/gic-v3.c
> > +++ b/lib/arm/gic-v3.c
> > @@ -210,4 +210,21 @@ void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set)
> >  		byte &= ~mask;
> >  	*ptr = byte;
> >  }
> > +
> > +void gicv3_lpi_rdist_ctrl(u32 redist, bool set)
> 
> _set_clr_ ?

No, probably not _set_clr_ here. The function could be
static though, with other functions to enable/disable

void gicv3_lpi_rdist_enable(redist) { gicv3_lpi_rdist_ctrl(redist, true); }
void gicv3_lpi_rdist_disable(redist) { gicv3_lpi_rdist_ctrl(redist, false); }

But whatever.

> 
> > +{
> > +	void *ptr;
> > +	u64 val;
> > +
> > +	assert(redist < nr_cpus);
> > +
> > +	ptr = gicv3_data.redist_base[redist];
> > +	val = readl(ptr + GICR_CTLR);
> > +	if (set)
> > +		val |= GICR_CTLR_ENABLE_LPIS;
> > +	else
> > +		val &= ~GICR_CTLR_ENABLE_LPIS;
> > +	writel(val,  ptr + GICR_CTLR);
> > +}
> >  #endif /* __aarch64__ */
> > +
> 
> stray blank line here
> 
> > -- 
> > 2.20.1
> >
> 
> I'm not sure why this needs its own patch. I could just be part of the
> next patch.
> 
> Thanks,
> drew
> 


