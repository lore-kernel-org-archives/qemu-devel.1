Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B17C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 20:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF68B2067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 20:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hs0BuDV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF68B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhfKm-00035h-5q
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 16:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jhfK1-0002TQ-3p
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 16:21:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jhfJz-0000YI-N0
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 16:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591474898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4jqwUMVsfsSvwCMKervPyctKjmw5vEX56fqpclyMnA=;
 b=Hs0BuDV7J94R/R/Z5TPQQjiP/lZA8FWNhCF94XsGVd7eCDAUBfzrW3V4cQqJVIvW0mIvI3
 rfHW4Ql9vUbgXDKQk0Qzx59BD/elJpO3Kp10eBcuHBDBnseJoN2U8VjOFQFgfUisq13OIv
 qZFJyB20anH85pewvJahRzpR6CmsQoM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-1MjYjaCsPluoDOUCyoY8mA-1; Sat, 06 Jun 2020 16:21:36 -0400
X-MC-Unique: 1MjYjaCsPluoDOUCyoY8mA-1
Received: by mail-wr1-f70.google.com with SMTP id t5so5341815wro.20
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 13:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o4jqwUMVsfsSvwCMKervPyctKjmw5vEX56fqpclyMnA=;
 b=iEY/cPAtGf5llyKplOs5U00u35X0DlzYuHaxC/6YU4fxlO052ptcIyFnrJOp7j78MT
 3Qxi64iWlyLOldhgC/4yY9eshSMyNHeq4gVEAT7bXi+0B+cemenXhbr3MYANEd0zoym3
 CblVO7819TEfc8wjkzsgsM8CXL+32AbGpjAET3ma7qDZHLOIhPyTXG6TZuMeAewqRnAZ
 EGqc4bXgUGLE+40XEicwT9lf2TC2rXrlC1iJlqpA3Iao/MTUw6z4sUIdSQBQ3rirqFnE
 NnOx6biayZMeSXjMQv/0VRo2FBX3KrPSnaFm7/5CH/cpftFdCs5bZvrCoSk/kLjRjyWu
 dUXg==
X-Gm-Message-State: AOAM531KslkXvXrY0zxw4QcF5TMg5t4jR8oQowmB4HQlxhyR+Ipgz6Ln
 qyUGOeheg+iYEvukJNgcN0U46vymCVMoFLagp27vp3NDWz0CIrNdnDfuZ8KbotOyQMvtU7/IBJS
 G8iULGmTvqcnjkAQ=
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr8676877wme.130.1591474895393; 
 Sat, 06 Jun 2020 13:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD8oca7c9F3z/cHyLGoqmFQRETj0bXMVLckH6LgfSMPy8x0Bsfwmowbutieyi6uCszvoqWhA==
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr8676852wme.130.1591474894974; 
 Sat, 06 Jun 2020 13:21:34 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 t189sm16775933wma.4.2020.06.06.13.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2020 13:21:34 -0700 (PDT)
Date: Sat, 6 Jun 2020 16:21:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 18/18] guest memory protection: Alter virtio default
 properties for protected guests
Message-ID: <20200606162014-mutt-send-email-mst@kernel.org>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-19-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-19-david@gibson.dropbear.id.au>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 16:21:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, cohuck@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 01:43:04PM +1000, David Gibson wrote:
> The default behaviour for virtio devices is not to use the platforms normal
> DMA paths, but instead to use the fact that it's running in a hypervisor
> to directly access guest memory.  That doesn't work if the guest's memory
> is protected from hypervisor access, such as with AMD's SEV or POWER's PEF.
> 
> So, if a guest memory protection mechanism is enabled, then apply the
> iommu_platform=on option so it will go through normal DMA mechanisms.
> Those will presumably have some way of marking memory as shared with the
> hypervisor or hardware so that DMA will work.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/core/machine.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 88d699bceb..cb6580954e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,8 @@
>  #include "hw/mem/nvdimm.h"
>  #include "migration/vmstate.h"
>  #include "exec/guest-memory-protection.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-pci.h"
>  
>  GlobalProperty hw_compat_5_0[] = {};
>  const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
> @@ -1159,6 +1161,15 @@ void machine_run_board_init(MachineState *machine)
>           * areas.
>           */
>          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> +
> +        /*
> +         * Virtio devices can't count on directly accessing guest
> +         * memory, so they need iommu_platform=on to use normal DMA
> +         * mechanisms.  That requires disabling legacy virtio support
> +         * for virtio pci devices
> +         */
> +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy", "on");
> +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platform", "on");
>      }
>  

I think it's a reasonable way to address this overall.
As Cornelia has commented, addressing ccw as well as cases where user has
specified the property manually could be worth-while.

>      machine_class->init(machine);
> -- 
> 2.26.2


