Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB993C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822D620771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJaV8CHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822D620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDV2-0001Ym-K4
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDU3-0000yi-Lj
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:04:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDU1-0005lO-Qt
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mV66PB7m3yf7oVVuigVjZH4PSb7D7KkAeg8aL8WPTeY=;
 b=eJaV8CHYg/J29s3rSGE4ccG79MpqahKOdCR2CIgFotI7YRHNRkCPr7p6qV80GxsESnb352
 br1ISTqfv4sKyHzUIry4G5ih2DBSNXNUnqdZFDX0lJYZmy/PjKDObCpjD4reyE2FPACpkn
 q4sQMWpnKVo96Ggf2qHbCKHSEd3cp3w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-YFyz4MdJNpS7nuCDtpcFsQ-1; Wed, 22 Jul 2020 08:04:23 -0400
X-MC-Unique: YFyz4MdJNpS7nuCDtpcFsQ-1
Received: by mail-wr1-f70.google.com with SMTP id b8so542039wro.19
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mV66PB7m3yf7oVVuigVjZH4PSb7D7KkAeg8aL8WPTeY=;
 b=iVS9TDgx4nDEROPqllVjTxXo3GEUu2CeMWwGPaayXEezwNeWx5UEPcwMNogp6elCWP
 x9bII1wBMQgEg8AKjeFRszcTC9YAEGO1J8GItswyJf3heFeOUxpHn0IY/iYweD9zzmin
 rzvbbBGljeJsgzd67nS4d3WtVwfwMCVU73b5tO1A7NzEwYfkuwN2AFhvqM/S6nifzkZD
 NBN2RfRVUeVjI3CNhGqYhGxWDMEMAiejZ7WV0gczcqAMUHPtaOya++eIutoohEaNr8eL
 48ONjBaRn00N7e1fZJlNz2W/UCrEL6RtY8gnH1MD0dJMpIl0cMVvS09tSYf+Vy/XSN+s
 GDPg==
X-Gm-Message-State: AOAM533hz2ldBj0YsJFq3QvPheNyG1T5Bbd9LvSyU+LNs5xA7BCmip14
 FaYveF1asWcJZOWm4zvJnLCdEkahRB25d6W4ONhFaIvsEbrsmtrwcoPVs+A236/WAQwJXM56yJb
 2x7Qx+r8hylEIb+0=
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr1527680wmj.174.1595419461390; 
 Wed, 22 Jul 2020 05:04:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwRYGmcujUtVZ3JTjdVYugu0dDG8YKyXbsFGHdrP0CA1oCAXNp+d1v6TCLySD/5SnfpoykFQ==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr1527655wmj.174.1595419461129; 
 Wed, 22 Jul 2020 05:04:21 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 z6sm6830553wmf.33.2020.07.22.05.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:04:20 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:04:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] virtio-balloon: always indicate S_DONE when migration
 fails
Message-ID: <20200722080356-mutt-send-email-mst@kernel.org>
References: <20200629080615.26022-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629080615.26022-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-dev@lists.oasis-open.org,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 10:06:15AM +0200, David Hildenbrand wrote:
> If something goes wrong during precopy, before stopping the VM, we will
> never send a S_DONE indication to the VM, resulting in the hinted pages
> not getting released to be used by the guest OS (e.g., Linux).
> 
> Easy to reproduce:
> 1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
> 2. Cancel migration (e.g., HMP "migrate_cancel")
> 3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
>    no free memory left.
> 
> While at it, add similar locking to virtio_balloon_free_page_done() as
> done in virtio_balloon_free_page_stop. Locking is still weird, but that
> has to be sorted out separately.
> 
> There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
> comments regarding S_DONE handling.
> 
> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

IIUC this is superceded by Alexander's patches right?
If not pls rebase ...

> ---
>  hw/virtio/virtio-balloon.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 10507b2a43..8a84718490 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -628,8 +628,13 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
>  
> -    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
> -    virtio_notify_config(vdev);
> +    if (s->free_page_report_status != FREE_PAGE_REPORT_S_DONE) {
> +        /* See virtio_balloon_free_page_stop() */
> +        qemu_mutex_lock(&s->free_page_lock);
> +        s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
> +        qemu_mutex_unlock(&s->free_page_lock);
> +        virtio_notify_config(vdev);
> +    }
>  }
>  
>  static int
> @@ -653,17 +658,26 @@ virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
>      case PRECOPY_NOTIFY_SETUP:
>          precopy_enable_free_page_optimization();
>          break;
> -    case PRECOPY_NOTIFY_COMPLETE:
> -    case PRECOPY_NOTIFY_CLEANUP:
>      case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
>          virtio_balloon_free_page_stop(dev);
>          break;
>      case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
>          if (vdev->vm_running) {
>              virtio_balloon_free_page_start(dev);
> -        } else {
> -            virtio_balloon_free_page_done(dev);
> +            break;
>          }
> +        /*
> +         * Set S_DONE before migrating the vmstate, so the guest will reuse
> +         * all hinted pages once running on the destination. Fall through.
> +         */
> +    case PRECOPY_NOTIFY_CLEANUP:
> +        /*
> +         * Especially, if something goes wrong during precopy or if migration
> +         * is canceled, we have to properly communicate S_DONE to the VM.
> +         */
> +        virtio_balloon_free_page_done(dev);
> +        break;
> +    case PRECOPY_NOTIFY_COMPLETE:
>          break;
>      default:
>          virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
> -- 
> 2.26.2


