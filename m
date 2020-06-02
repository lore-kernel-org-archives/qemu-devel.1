Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38BB206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIkQo9dN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38BB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxw6-000148-7f
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfxvV-0000KY-90
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:49:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfxvT-0005Ff-Fi
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591069758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExLd1Z+1FIxt0ntrrBRLTV4rcrryp6L3gYgD3JMEe7Y=;
 b=VIkQo9dNOzPblclGDX9OTxqa+sxRIGC5S6ErfCX9mZboPj4e3nS8pXLWtkyev0tWP3krDk
 fO1NdcDaPR2DkdAQ+BrkjJQ66vqY4467/A3ttIJfcSVgJIRmttKGsNrYEpzmWIj+2fsjnL
 SmBuBt+j/c1F5LjrDHqlPIhOT0i10yg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-MbdGOPKAM0SG23m6XNS8JA-1; Mon, 01 Jun 2020 23:49:16 -0400
X-MC-Unique: MbdGOPKAM0SG23m6XNS8JA-1
Received: by mail-wr1-f70.google.com with SMTP id h6so831231wrx.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UPZhIAGyj/VLbIsoUlC2KngQ5PLwTgQRP4hRk68ZAN8=;
 b=ul/+CZ9qW3XQ5MIwEhuA3rtq1WkPZO3/A1PTxfY4+xldWa1QjOq0JPoe/oZErbKrpX
 JfYKt5D6LRzgExkRraAbSc5YInUEKoPR1VDaXRQah9q9XJw8PYSwHoTchR9zNpg25CrT
 JqWM6GKsvGvas/NVp/wdn66Xhe1LuCY5meX6vKmICDu9VEG58Mlc681/++uFBbrjN2Bn
 MGTx+rkScooZ34Xcg5qTVrQEt1NKrkmkxvofX2jmrrP4+o/BdTIjTetwXp3zveY3ZYKw
 /yDgWPC6Z1r6oX9sp3NrJZJBnVMJleCTkMDo1eezeU2DQuTW718pitUCHzATywCsJIVd
 0siw==
X-Gm-Message-State: AOAM532o2PW6+EBytr4oCjwoo8zfN5ihY8TS4mvzJYTH5lk9ScPmxeA2
 jP98jsMQZxA+HtGPBaN4kLlY8PerC/SOZML86gbDEm0tkFt/+kGmjEMzhdbYEV/89Y5xveCoNTR
 3vmBHDXmXRO8SFd0=
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr25958781wrs.115.1591069755281; 
 Mon, 01 Jun 2020 20:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbFuz2uv/TDCU4M0qN37P/g2y+Wa4iddh/8yNcs/CsBmvsOG4NKyvS+2vtx6Nf23TXqpMcXQ==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr25958746wrs.115.1591069754999; 
 Mon, 01 Jun 2020 20:49:14 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 g18sm1578601wme.17.2020.06.01.20.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 20:49:14 -0700 (PDT)
Date: Mon, 1 Jun 2020 23:49:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 0/8] hw: Fix some incomplete memory region size
Message-ID: <20200601234822-mutt-send-email-mst@kernel.org>
References: <20200601142930.29408-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200601142930.29408-1-f4bug@amsat.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 01, 2020 at 04:29:22PM +0200, Philippe Mathieu-Daudé wrote:
> Series fully reviewed.
> 
> Since v1:
> - Add parenthesis on the Xen patch (Paul Durrant)
> - Add Peter's R-b tags


PCI things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I'll queue pci patches in my tree.

> memory_region_set_size() handle the 16 Exabytes limit by
> special-casing the UINT64_MAX value.
> This is not a problem for the 32-bit maximum, 4 GiB, but
> in some places we incorrectly use UINT32_MAX instead of
> 4 GiB, and end up missing 1 byte in the memory region.
> 
> This series fixes the cases I encountered.
> Also included few patches while reviewing, I replaced some
> magic values by the IEC binary prefix equivalent.
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (8):
>   hw/arm/aspeed: Correct DRAM container region size
>   hw/pci-host/prep: Correct RAVEN bus bridge memory region size
>   hw/pci/pci_bridge: Correct pci_bridge_io memory region size
>   hw/pci/pci_bridge: Use the IEC binary prefix definitions
>   hw/pci-host: Use the IEC binary prefix definitions
>   hw/hppa/dino: Use the IEC binary prefix definitions
>   hw/i386/xen/xen-hvm: Use the IEC binary prefix definitions
>   target/i386/cpu: Use the IEC binary prefix definitions
> 
>  hw/arm/aspeed.c         | 2 +-
>  hw/hppa/dino.c          | 4 ++--
>  hw/i386/xen/xen-hvm.c   | 3 ++-
>  hw/pci-host/i440fx.c    | 3 ++-
>  hw/pci-host/prep.c      | 2 +-
>  hw/pci-host/q35.c       | 2 +-
>  hw/pci-host/versatile.c | 5 +++--
>  hw/pci/pci_bridge.c     | 7 ++++---
>  target/i386/cpu.c       | 2 +-
>  9 files changed, 17 insertions(+), 13 deletions(-)
> 
> -- 
> 2.21.3


