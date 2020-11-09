Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B49DC5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D21206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+AG3Hrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D21206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCD4-0006Oh-B2
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kcCCL-0005Xp-PY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:47:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kcCCJ-0002OK-Vw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604947643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y53DXKhAw/ZG576P24xIAl7ARW+1l9mWQOTbhLfibms=;
 b=G+AG3Hrkmr2/jYDCx0c2lTQG0TGU7uUxz0sT58YCvAuMxv+B4tfEZpUZbpM/I4KdmlcKva
 qpGlN8XEHfCAonfX4JibY1EVgFmVW2jpehD0STDAa1MMNE/YdEcBFBiPdeHv6bXVABi/3A
 jalQMx3lNoGi66k+Oiprr0PtuJBWxaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-bLQ3wztfOr-v7G8_c5_WlQ-1; Mon, 09 Nov 2020 13:47:21 -0500
X-MC-Unique: bLQ3wztfOr-v7G8_c5_WlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25DE8186DD40;
 Mon,  9 Nov 2020 18:47:20 +0000 (UTC)
Received: from work-vm (ovpn-114-198.ams2.redhat.com [10.36.114.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3C3D5C5FD;
 Mon,  9 Nov 2020 18:47:08 +0000 (UTC)
Date: Mon, 9 Nov 2020 18:47:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH V2] virtiofsd: Use --thread-pool-size=0 to mean no thread
 pool
Message-ID: <20201109184706.GP3024@work-vm>
References: <20201109143548.GA1479853@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201109143548.GA1479853@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, jose.carlos.venegas.munoz@intel.com,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> Right now we create a thread pool and main thread hands over the request
> to thread in thread pool to process. Number of threads in thread pool
> can be managed by option --thread-pool-size.
> 
> In tests we have noted that many of the workloads are getting better
> performance if we don't use a thread pool at all and process all
> the requests in the context of a thread receiving the request.
> 
> Hence give user an option to be able to run virtiofsd without using
> a thread pool.
> 
> To implement this, I have used existing option --thread-pool-size. This
> option defines how many maximum threads can be in the thread pool.
> Thread pool size zero freezes thead pool. I can't see why will one
> start virtiofsd with a frozen thread pool (hence frozen file system).
> So I am redefining --thread-pool-size=0 to mean, don't use a thread pool.
> Instead process the request in the context of thread receiving request
> from the queue.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tools/virtiofsd/fuse_virtio.c | 36 ++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index 83ba07c6cd..944b9a577c 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -588,13 +588,18 @@ static void *fv_queue_thread(void *opaque)
>      struct VuDev *dev = &qi->virtio_dev->dev;
>      struct VuVirtq *q = vu_get_queue(dev, qi->qidx);
>      struct fuse_session *se = qi->virtio_dev->se;
> -    GThreadPool *pool;
> -
> -    pool = g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size, FALSE,
> -                             NULL);
> -    if (!pool) {
> -        fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func__);
> -        return NULL;
> +    GThreadPool *pool = NULL;
> +    GList *req_list = NULL;
> +
> +    if (se->thread_pool_size) {
> +        fuse_log(FUSE_LOG_DEBUG, "%s: Creating thread pool for Queue %d\n",
> +                 __func__, qi->qidx);
> +        pool = g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size,
> +                                 FALSE, NULL);
> +        if (!pool) {
> +            fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func__);
> +            return NULL;
> +        }
>      }
>  
>      fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __func__,
> @@ -669,14 +674,27 @@ static void *fv_queue_thread(void *opaque)
>  
>              req->reply_sent = false;
>  
> -            g_thread_pool_push(pool, req, NULL);
> +            if (!se->thread_pool_size) {
> +                req_list = g_list_prepend(req_list, req);
> +            } else {
> +                g_thread_pool_push(pool, req, NULL);
> +            }
>          }
>  
>          pthread_mutex_unlock(&qi->vq_lock);
>          pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
> +
> +        /* Process all the requests. */
> +        if (!se->thread_pool_size && req_list != NULL) {
> +            g_list_foreach(req_list, fv_queue_worker, qi);
> +            g_list_free(req_list);
> +            req_list = NULL;
> +        }
>      }
>  
> -    g_thread_pool_free(pool, FALSE, TRUE);
> +    if (pool) {
> +        g_thread_pool_free(pool, FALSE, TRUE);
> +    }
>  
>      return NULL;
>  }
> -- 
> 2.25.4
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


