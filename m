Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9D8C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CDE206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CDE206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubil-0003rd-SN
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 08:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hubhr-0003Eq-6F
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hubhp-0001gW-VW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hubhp-0001eT-G8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B68493C93;
 Mon,  5 Aug 2019 12:03:12 +0000 (UTC)
Received: from work-vm (ovpn-117-168.ams2.redhat.com [10.36.117.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA40C60610;
 Mon,  5 Aug 2019 12:02:33 +0000 (UTC)
Date: Mon, 5 Aug 2019 13:02:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190805120231.GL13734@work-vm>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190801165409.20121-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801165409.20121-2-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 05 Aug 2019 12:03:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] virtiofsd: process requests in a
 thread pool
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
Cc: virtio-fs@redhat.com, Liu Bo <bo.liu@linux.alibaba.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> Introduce a thread pool so that fv_queue_thread() just pops
> VuVirtqElements and hands them to the thread pool.  For the time being
> only one worker thread is allowed since passthrough_ll.c is not
> thread-safe yet.  Future patches will lift this restriction so that
> multiple FUSE requests can be processed in parallel.
> 
> The main new concept is struct FVRequest, which contains both
> VuVirtqElement and struct fuse_chan.  We now have fv_VuDev for a device,
> fv_QueueInfo for a virtqueue, and FVRequest for a request.  Some of
> fv_QueueInfo's fields are moved into FVRequest because they are
> per-request.  The name FVRequest conforms to QEMU coding style and I
> expect the struct fv_* types will be renamed in a future refactoring.
> 
> This patch series is not optimal.  fbuf reuse is dropped so each request
> does malloc(se->bufsize), but there is no clean and cheap way to keep
> this with a thread pool.  The vq_lock mutex is held for longer than
> necessary, especially during the eventfd_write() syscall.  Performance
> can be improved in the future.
> 
> prctl(2) had to be added to the seccomp whitelist because glib invokes
> it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied; some comments below.

> +
> +        pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
> +        pthread_mutex_lock(&qi->vq_lock);
> +        vu_queue_push(dev, q, elem, tosend_len);
> +        vu_queue_notify(dev, q);
> +        pthread_mutex_unlock(&qi->vq_lock);
> +        pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);

It surprises me that these paired locks are so common.
>  
>  err:
>  
> @@ -249,9 +268,12 @@ int virtio_send_data_iov(struct fuse_session *se, struct fuse_chan *ch,
>                           struct iovec *iov, int count,
>                           struct fuse_bufvec *buf, size_t len)
>  {
> +        FVRequest *req = container_of(ch, FVRequest, ch);

I can't think of a better answer than the container_of but it does make
me a bit nervous; I guess we need it because 'ch' comes from the generic
fs code so can't be FVRequest*
> +        struct VuDev *dev = &qi->virtio_dev->dev;
> +        FVRequest *req = data;
> +        VuVirtqElement *elem = &req->elem;
> +        struct fuse_buf fbuf = {};
> +        bool allocated_bufv = false;
> +        struct fuse_bufvec bufv;
> +        struct fuse_bufvec *pbufv;
> +
> +        assert(se->bufsize > sizeof(struct fuse_in_header));
> +
> +        /* An element contains one request and the space to send our response
> +         * They're spread over multiple descriptors in a scatter/gather set
> +         * and we can't trust the guest to keep them still; so copy in/out.
> +         */
> +        fbuf.mem = malloc(se->bufsize);
> +        assert(fbuf.mem);

Now we're using thread pools etc, maybe it's time to switch to glib's
g_new/g_malloc etc that never return NULL?

> +        if (se->debug)
> +                fuse_debug("%s: elem %d: with %d out desc of length %zd"
> +                           " bad_in_num=%u bad_out_num=%u\n",
> +                           __func__, elem->index, out_num,
> +                           out_len, req->bad_in_num, req->bad_out_num);

Are the debug/logging calls thread safe?


> diff --git a/contrib/virtiofsd/seccomp.c b/contrib/virtiofsd/seccomp.c
> index cea4cc5f60..5f1c873b82 100644
> --- a/contrib/virtiofsd/seccomp.c
> +++ b/contrib/virtiofsd/seccomp.c
> @@ -58,6 +58,7 @@ static const int syscall_whitelist[] = {
>  	SCMP_SYS(open),
>  	SCMP_SYS(openat),
>  	SCMP_SYS(ppoll),
> +	SCMP_SYS(prctl), /* TODO restrict to just PR_SET_NAME? */

Would seem a good idea because prctl can do lots of crazy things.

Dave

>  	SCMP_SYS(preadv),
>  	SCMP_SYS(pwrite64),
>  	SCMP_SYS(read),
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

