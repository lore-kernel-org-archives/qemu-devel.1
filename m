Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4C9C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1622084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZ+jUNut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1622084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0hr-0008NI-8F
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:05:43 -0500
Received: from [2001:470:142:3::10] (port=35660 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iz0fM-0005UJ-Fl
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iz0fH-0002lF-HG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:03:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iz0fH-0002gs-Bz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yFkhfzESVTTuJzAgAmxEzcx/Fa2CyHOyWD736BEROw=;
 b=QZ+jUNutn3Qts47AJxZXLFM6Yw3GcStOz7XU3/ue2z9xmBIZ6tHkwx/Bp7cRvTi5bRzSW2
 COIF/KS/XVobAY8BIOPa/RaM6+3NIS9UlbtspVtUCkgKfH7ppBOAPczdifVyZiaFYOqVjb
 iguoFH4pwav895ws7Jl0Li+T4w4+Yp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-f2rCEVfQPWiWkogDmwRHXw-1; Tue, 04 Feb 2020 11:02:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94C268010F1;
 Tue,  4 Feb 2020 16:02:48 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF5ED19486;
 Tue,  4 Feb 2020 16:02:41 +0000 (UTC)
Date: Tue, 4 Feb 2020 17:02:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: clean up when virtio_queue_set_rings() fails
Message-ID: <20200204170239.49deb13a.cohuck@redhat.com>
In-Reply-To: <20200204151618.39296-1-stefanha@redhat.com>
References: <20200204151618.39296-1-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: f2rCEVfQPWiWkogDmwRHXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  4 Feb 2020 15:16:18 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> hw/virtio.c checks vq->vring.desc != NULL to see if the vring has been
> set up successfully.
> 
> When virtio_queue_set_rings() fails due to an invalid vring memory
> address it must clear vq->vring.desc (and related fields) so we don't
> treat this virtqueue as successfully initialized later on.
> 
> This bug was found by device fuzzing and can be triggered as follows:
> 
>   $ qemu -M pc -device virtio-blk-pci,id=drv0,drive=drive0,addr=4.0 \
>          -drive if=none,id=drive0,file=null-co://,format=raw,auto-read-only=off \
>          -drive if=none,id=drive1,file=null-co://,file.read-zeroes=on,format=raw \
>          -display none \
>          -qtest stdio
>   endianness
>   outl 0xcf8 0x80002020
>   outl 0xcfc 0xe0000000
>   outl 0xcf8 0x80002004
>   outw 0xcfc 0x7
>   write 0xe0000000 0x24 0x00ffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab5cffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab0000000001
>   inb 0x4
>   writew 0xe000001c 0x1
>   write 0xe0000014 0x1 0x0d
> 
> The following error message is produced:
> 
>   qemu-system-x86_64: /home/stefanha/qemu/hw/virtio/virtio.c:286: vring_get_region_caches: Assertion `caches != NULL' failed.
> 
> The backtrace looks like this:
> 
>   #0  0x00007ffff5520625 in raise () at /lib64/libc.so.6
>   #1  0x00007ffff55098d9 in abort () at /lib64/libc.so.6
>   #2  0x00007ffff55097a9 in _nl_load_domain.cold () at /lib64/libc.so.6
>   #3  0x00007ffff5518a66 in annobin_assert.c_end () at /lib64/libc.so.6
>   #4  0x00005555559073da in vring_get_region_caches (vq=<optimized out>) at qemu/hw/virtio/virtio.c:286
>   #5  vring_get_region_caches (vq=<optimized out>) at qemu/hw/virtio/virtio.c:283
>   #6  0x000055555590818d in vring_used_flags_set_bit (mask=1, vq=0x5555575ceea0) at qemu/hw/virtio/virtio.c:398
>   #7  virtio_queue_split_set_notification (enable=0, vq=0x5555575ceea0) at qemu/hw/virtio/virtio.c:398
>   #8  virtio_queue_set_notification (vq=vq@entry=0x5555575ceea0, enable=enable@entry=0) at qemu/hw/virtio/virtio.c:451
>   #9  0x0000555555908512 in virtio_queue_set_notification (vq=vq@entry=0x5555575ceea0, enable=enable@entry=0) at qemu/hw/virtio/virtio.c:444
>   #10 0x00005555558c697a in virtio_blk_handle_vq (s=0x5555575c57e0, vq=0x5555575ceea0) at qemu/hw/block/virtio-blk.c:775
>   #11 0x0000555555907836 in virtio_queue_notify_aio_vq (vq=0x5555575ceea0) at qemu/hw/virtio/virtio.c:2244
>   #12 0x0000555555cb5dd7 in aio_dispatch_handlers (ctx=ctx@entry=0x55555671a420) at util/aio-posix.c:429
>   #13 0x0000555555cb67a8 in aio_dispatch (ctx=0x55555671a420) at util/aio-posix.c:460
>   #14 0x0000555555cb307e in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:260
>   #15 0x00007ffff7bbc510 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
>   #16 0x0000555555cb5848 in glib_pollfds_poll () at util/main-loop.c:219
>   #17 os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:242
>   #18 main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:518
>   #19 0x00005555559b20c9 in main_loop () at vl.c:1683
>   #20 0x0000555555838115 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4441
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 2c5410e981..5d7f619a1e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2163,6 +2163,11 @@ void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
>      vdev->vq[n].vring.avail = avail;
>      vdev->vq[n].vring.used = used;
>      virtio_init_region_cache(vdev, n);
> +    if (vdev->broken) {
> +        vdev->vq[n].vring.desc = 0;
> +        vdev->vq[n].vring.avail = 0;
> +        vdev->vq[n].vring.used = 0;
> +    }
>  }
>  
>  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)

This looks correct; but shouldn't virtio_queue_set_addr() also set
.desc to 0 on failure?


