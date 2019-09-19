Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B2CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AB421924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AB421924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAv25-0001rv-Ex
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iAuyQ-00055K-49
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iAulK-0000vb-4h
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:38:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iAulI-0000uN-SA; Thu, 19 Sep 2019 07:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32738A3D39E;
 Thu, 19 Sep 2019 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.116.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B87B5D9E5;
 Thu, 19 Sep 2019 11:38:02 +0000 (UTC)
Date: Thu, 19 Sep 2019 13:38:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190919113801.GD10163@localhost.localdomain>
References: <20190916112411.21636-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916112411.21636-1-slp@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 19 Sep 2019 11:38:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] virtio-blk: schedule
 virtio_notify_config to run on main context
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
Cc: mreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.09.2019 um 13:24 hat Sergio Lopez geschrieben:
> virtio_notify_config() needs to acquire the global mutex, which isn't
> allowed from an iothread, and may lead to a deadlock like this:
> 
>  - main thead
>   * Has acquired: qemu_global_mutex.
>   * Is trying the acquire: iothread AioContext lock via
>     AIO_WAIT_WHILE (after aio_poll).
> 
>  - iothread
>   * Has acquired: AioContext lock.
>   * Is trying to acquire: qemu_global_mutex (via
>     virtio_notify_config->prepare_mmio_access).
> 
> If virtio_blk_resize() is called from an iothread, schedule
> virtio_notify_config() to be run in the main context BH.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changelog
> 
> v3:
>  - Unconditionally schedule the work to be done in the main context BH
>    (thanks John Snow and Kevin Wolf).
> 
> v2:
>  - Use aio_bh_schedule_oneshot instead of scheduling a coroutine
>    (thanks Kevin Wolf).
>  - Switch from RFC to v2 patch.
> ---
>  hw/block/virtio-blk.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 18851601cb..0163285f6f 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -16,6 +16,7 @@
>  #include "qemu/iov.h"
>  #include "qemu/module.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
>  #include "trace.h"
>  #include "hw/block/block.h"
>  #include "hw/qdev-properties.h"
> @@ -1086,11 +1087,25 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
>      return 0;
>  }
>  
> +static void virtio_resize_cb(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +
> +    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> +    virtio_notify_config(vdev);
> +}
> +
>  static void virtio_blk_resize(void *opaque)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>  
> -    virtio_notify_config(vdev);
> +    /*
> +     * virtio_notify_config() needs to acquire the global mutex,
> +     * so it can't be called from an iothread. Instead, schedule
> +     * it to be run in the main context BH.
> +     */
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                            virtio_resize_cb, vdev);

This fits on a single line. With this fixed:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

