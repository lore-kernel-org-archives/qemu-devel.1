Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7186C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB712225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVp36Dfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB712225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQueT-0007XE-2x
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kQudC-00075M-Ox
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kQud9-00085C-DB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602258505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owaindMyLhIAH/J2944aY891LF7tAEUEV8ivsVgZfgw=;
 b=CVp36DfzJr4+AJpAtcga7ED/KVB1SJ9eWH88KtbCarSsSjTWXP7Dpd6JoPO6davNo+oVEh
 VkvHKvts4B7InFohfXx0i7AiuLk0Jnw4MdrXKYjpzTShcqgnPDATHCcNiqsu9D2T/+GR7P
 xuCBWf5Vsn6svUH6qSAW4hwQMbp58aM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-UJFqftlUPC-QpjCRkZOVoA-1; Fri, 09 Oct 2020 11:48:23 -0400
X-MC-Unique: UJFqftlUPC-QpjCRkZOVoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3521A8015B0;
 Fri,  9 Oct 2020 15:48:22 +0000 (UTC)
Received: from gondolin (ovpn-113-40.ams2.redhat.com [10.36.113.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CC021A887;
 Fri,  9 Oct 2020 15:48:10 +0000 (UTC)
Date: Fri, 9 Oct 2020 17:48:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v3 10/10] s390x/pci: get zPCI function info from host
Message-ID: <20201009174807.6d800999.cohuck@redhat.com>
In-Reply-To: <1602097455-15658-11-git-send-email-mjrosato@linux.ibm.com>
References: <1602097455-15658-1-git-send-email-mjrosato@linux.ibm.com>
 <1602097455-15658-11-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  7 Oct 2020 15:04:15 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> We use the capability chains of the VFIO_DEVICE_GET_INFO ioctl to retrieve
> the CLP information that the kernel exports.
> 
> To be compatible with previous kernel versions we fall back on previous
> predefined values, same as the emulation values, when the ioctl is found
> to not support capability chains. If individual CLP capabilities are not
> found, we fall back on default values for only those capabilities missing
> from the chain.
> 
> This patch is based on work previously done by Pierre Morel.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/meson.build             |   1 +
>  hw/s390x/s390-pci-bus.c          |  10 +-
>  hw/s390x/s390-pci-vfio.c         | 197 +++++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/s390-pci-bus.h  |   1 +
>  include/hw/s390x/s390-pci-clp.h  |  12 ++-
>  include/hw/s390x/s390-pci-vfio.h |  19 ++++
>  6 files changed, 233 insertions(+), 7 deletions(-)
>  create mode 100644 hw/s390x/s390-pci-vfio.c
>  create mode 100644 include/hw/s390x/s390-pci-vfio.h

(...)

> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> new file mode 100644
> index 0000000..43684c6
> --- /dev/null
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -0,0 +1,197 @@
> +/*
> + * s390 vfio-pci interfaces
> + *
> + * Copyright 2020 IBM Corp.
> + * Author(s): Matthew Rosato <mjrosato@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include <linux/vfio_zdev.h>
> +
> +#include "qemu/osdep.h"
> +#include "hw/s390x/s390-pci-bus.h"
> +#include "hw/s390x/s390-pci-clp.h"
> +#include "hw/s390x/s390-pci-vfio.h"
> +#include "hw/vfio/pci.h"
> +
> +#ifndef DEBUG_S390PCI_VFIO
> +#define DEBUG_S390PCI_VFIO  0
> +#endif
> +
> +#define DPRINTF(fmt, ...)                                          \
> +    do {                                                           \
> +        if (DEBUG_S390PCI_VFIO) {                                  \
> +            fprintf(stderr, "S390pci-vfio: " fmt, ## __VA_ARGS__); \
> +        }                                                          \
> +    } while (0)

Not really a fan of DPRINTF. Can you maybe use trace events instead?

Other than that, looks good to me.


