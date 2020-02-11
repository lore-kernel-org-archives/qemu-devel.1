Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAF0C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0BF20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQMSEfVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0BF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TWH-0002OS-UJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1TVH-0001bO-FI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1TVG-00022b-DT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:14:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1TVG-00020x-96
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581419693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pzvBIvPHKSR9VgLIUP6NgvFYhD5xyHRf1ewEeG/P6c=;
 b=VQMSEfVzrRTlZMLNZIjSCdg1rCxCsoPvS0Xy9vIN9BVEdNO3AsjHKMGyjQraWxw9UPKeg7
 WJclnpls2skwidOIxNaEzALLwMuwoJDpOslwU/hiH5c6JnmbhSYlOWFfJiDEGSDYvnJhea
 RgrhazLgeg7eWxDSOFPraYQ9niKKnu8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-HsE6s7aJNqCP_e5hVk9vHQ-1; Tue, 11 Feb 2020 06:14:49 -0500
Received: by mail-qk1-f200.google.com with SMTP id z64so6814995qke.10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 03:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i64HviBme2Pz18uHeGw1tj3lHgv6ae4i2ihKiY1Sg+w=;
 b=B3UgPa520u1DgMhDCjjWVzt38vLy5oyJNarZ8dldOyUMTrWLMJuwOi3jU8nwnelADq
 TV8H1Qlvuk91H6reHOAK8MG5CUGuEQaotq7/ZGyQn4e5+iQKVljilJfQNTR4V1gcDbAD
 kXRlmLqiJir63h+8rOAWAZIRPu2yY6VsPFBUZKyAapcAnpyV+rgNH6Vd7PMr0cWxNbXw
 KsNa0CDAxPovJySwnBMXslEyJ2L1ot5u809HCNalI8mCPvcKcI4k0m6P36qorh6fbXWj
 VbJ4/GqrFauj3lLD4FOcU5xQ7MqFuBSI1SYUePC4bbCy1qw849aRGhbfhii2cxKXxJtj
 i1qA==
X-Gm-Message-State: APjAAAVbHgDcFUO4ccbEhjLzBSrPCcTkLzFrNqBjZRziO34z5k9SA8GP
 KE2Ys9WOKiQlszFOU6aywsKAVbNwO/t6JzrXiUwGcQe92pa5kXnKVzRF0yBmHr1Gb6CES1HdujY
 7t3XyOhATUL5gvPI=
X-Received: by 2002:aed:3109:: with SMTP id 9mr14435455qtg.166.1581419689077; 
 Tue, 11 Feb 2020 03:14:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLxRMntZl/rmTH1PsMTVPwnKKD+vZxzh00c1RAAnvkD1CE3PAe5M25dTlN82sQ46lo8t4E8w==
X-Received: by 2002:aed:3109:: with SMTP id 9mr14435436qtg.166.1581419688863; 
 Tue, 11 Feb 2020 03:14:48 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id x41sm1996691qtj.52.2020.02.11.03.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 03:14:48 -0800 (PST)
Date: Tue, 11 Feb 2020 06:14:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zha Bin <zhabin@linux.alibaba.com>
Subject: Re: [PATCH v2 5/5] x86: virtio-mmio: support virtio-mmio with MSI
 for x86
Message-ID: <20200211061148-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <946b71e77a34666a9b8c419c5a467d1628b50fa0.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <946b71e77a34666a9b8c419c5a467d1628b50fa0.1581305609.git.zhabin@linux.alibaba.com>
X-MC-Unique: HsE6s7aJNqCP_e5hVk9vHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, jasowang@redhat.com,
 jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 05:05:21PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> virtio-mmio supports a generic MSI irq domain for all archs. This
> patch adds the x86 architecture support.
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/x86/kernel/apic/msi.c | 11 ++++++++++-

Patches like this need to CC x86 maintainers.


>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 159bd0c..2fcd602 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -45,7 +45,11 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg,=
 struct msi_msg *msg)
>  =09=09MSI_DATA_VECTOR(cfg->vector);
>  }
> =20
> -static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *m=
sg)
> +/*
> + * x86 PCI-MSI/HPET/DMAR related method.
> + * Also can be used as arch specific method for virtio-mmio MSI.
> + */
> +void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  =09__irq_msi_compose_msg(irqd_cfg(data), msg);
>  }
> @@ -166,6 +170,11 @@ static void irq_msi_update_msg(struct irq_data *irqd=
, struct irq_cfg *cfg)
>  =09return ret;
>  }
> =20
> +struct irq_domain *arch_msi_root_irq_domain(void)
> +{
> +=09return x86_vector_domain;
> +}
> +
>  /*
>   * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
>   * which implement the MSI or MSI-X Capability Structure.


So there's a new non-static functions with no callers here,
and a previously static irq_msi_compose_msg is not longer
static. No callers so how does this help anyone?
And how does this achieve the goal of enabling virtio mmio?


> --=20
> 1.8.3.1


