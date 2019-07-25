Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D26C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA712190F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bcGQNJ5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA712190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaKY-00085P-DD
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42730)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liam.merwick@oracle.com>) id 1hqaKH-0007XU-4R
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1hqaKF-00055v-L5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:46:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1hqaKF-00053i-BH
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:46:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P9iPuW098035;
 Thu, 25 Jul 2019 09:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=8rVE59fSvofdzftgjEnvEqGH1fzEcFUZ+tkNP/jMPgs=;
 b=bcGQNJ5BvuJehPqZX/YuMXz9vcgJgF21XBsqHPNzHrETfoKyYNxTxW1sY4A8lh4khoSm
 pFOrnj4L/JI0St6QO4gCXFqAr44Nj2yUcjJs5zHstJLfslQSgH8bfS6q3o0aC426pKoK
 sySr2Db8RBij6WbHIuchWXXNFwtbburuBNkeRBobUkH4cFL4Crh9tD+brs3b64M8hxa7
 i72WO3lEgxJj08D7gYNFKaYgg096yDsm1knx38YA7AjE4aaRjuAwvJYFq0J49/N8A5fd
 evEq8/sNqhcht7mTa9LxIvemxGrEi9CWLpOYw++Iyu7WCBP557hLxZpetrOvJbxylq1j 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2tx61c2t0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 09:46:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P9h4U9091927;
 Thu, 25 Jul 2019 09:46:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2tx60yvdnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 09:46:10 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6P9k7kB002529;
 Thu, 25 Jul 2019 09:46:08 GMT
Received: from dhcp-10-159-254-29.vpn.oracle.com (/10.159.254.29)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 25 Jul 2019 02:46:07 -0700
From: Liam Merwick <liam.merwick@oracle.com>
To: Sergio Lopez <slp@redhat.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 maran.wilson@oracle.com, sgarzare@redhat.com, kraxel@redhat.com
References: <20190702121106.28374-1-slp@redhat.com>
 <20190702121106.28374-2-slp@redhat.com>
Message-ID: <aca80a5c-40b9-ca31-2e22-c2bf5005f7e5@oracle.com>
Date: Thu, 25 Jul 2019 10:46:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190702121106.28374-2-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250117
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH v3 1/4] hw/virtio: Factorize virtio-mmio
 headers
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/2019 13:11, Sergio Lopez wrote:
> Put QOM and main struct definition in a separate header file, so it
> can be accesed from other components.

typo: accesed -> accessed

> 
> This is needed for the microvm machine type implementation.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>

One nit below, either way

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   hw/virtio/virtio-mmio.c | 35 +-----------------------
>   hw/virtio/virtio-mmio.h | 60 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+), 34 deletions(-)
>   create mode 100644 hw/virtio/virtio-mmio.h
> 
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 97b7f35496..87c7fe4d8d 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -26,44 +26,11 @@
>   #include "qemu/host-utils.h"
>   #include "qemu/module.h"
>   #include "sysemu/kvm.h"
> -#include "hw/virtio/virtio-bus.h"
> +#include "virtio-mmio.h"


Virtually all the other includes of virtio-xxx.h files in hw/virtio use 
the full path - e.g. "hw/virtio/virtio-mmio.h" - maybe do the same to be 
consistent.


>   #include "qemu/error-report.h"
>   #include "qemu/log.h"
>   #include "trace.h"
>   
> -/* QOM macros */
> -/* virtio-mmio-bus */
> -#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
> -#define VIRTIO_MMIO_BUS(obj) \
> -        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
> -#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
> -#define VIRTIO_MMIO_BUS_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
> -
> -/* virtio-mmio */
> -#define TYPE_VIRTIO_MMIO "virtio-mmio"
> -#define VIRTIO_MMIO(obj) \
> -        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
> -
> -#define VIRT_MAGIC 0x74726976 /* 'virt' */
> -#define VIRT_VERSION 1
> -#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
> -
> -typedef struct {
> -    /* Generic */
> -    SysBusDevice parent_obj;
> -    MemoryRegion iomem;
> -    qemu_irq irq;
> -    /* Guest accessible state needing migration and reset */
> -    uint32_t host_features_sel;
> -    uint32_t guest_features_sel;
> -    uint32_t guest_page_shift;
> -    /* virtio-bus */
> -    VirtioBusState bus;
> -    bool format_transport_address;
> -} VirtIOMMIOProxy;
> -
>   static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
>   {
>       return kvm_eventfds_enabled();
> diff --git a/hw/virtio/virtio-mmio.h b/hw/virtio/virtio-mmio.h
> new file mode 100644
> index 0000000000..2f3973f8c7
> --- /dev/null
> +++ b/hw/virtio/virtio-mmio.h
> @@ -0,0 +1,60 @@
> +/*
> + * Virtio MMIO bindings
> + *
> + * Copyright (c) 2011 Linaro Limited
> + *
> + * Author:
> + *  Peter Maydell <peter.maydell@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef QEMU_VIRTIO_MMIO_H
> +#define QEMU_VIRTIO_MMIO_H
> +
> +#include "hw/virtio/virtio-bus.h"
> +
> +/* QOM macros */
> +/* virtio-mmio-bus */
> +#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
> +#define VIRTIO_MMIO_BUS(obj) \
> +        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
> +#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
> +#define VIRTIO_MMIO_BUS_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
> +
> +/* virtio-mmio */
> +#define TYPE_VIRTIO_MMIO "virtio-mmio"
> +#define VIRTIO_MMIO(obj) \
> +        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
> +
> +#define VIRT_MAGIC 0x74726976 /* 'virt' */
> +#define VIRT_VERSION 1
> +#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
> +
> +typedef struct {
> +    /* Generic */
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +    /* Guest accessible state needing migration and reset */
> +    uint32_t host_features_sel;
> +    uint32_t guest_features_sel;
> +    uint32_t guest_page_shift;
> +    /* virtio-bus */
> +    VirtioBusState bus;
> +    bool format_transport_address;
> +} VirtIOMMIOProxy;
> +
> +#endif
> 


