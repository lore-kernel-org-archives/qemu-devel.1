Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B025FC56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025F620684
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8CniogT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025F620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc49t-0000WP-Vd
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kc48s-0007bZ-Pv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kc48q-0003e4-Tq
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604916676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EbSFT4UQTx0TP7UQk3z6+DZ44LhApXMSvZhL50keook=;
 b=P8CniogTtof+Ju7mjCPntjcnmjQTsGY5QYxrqnu+zVzt9iBCzgIkwHwJHbwHFF7u2HZb7y
 f8ENMxbwZF1GV7YQ92Clpi1oX77J6qS2IAlNF3ocGLbAVa0exV+KQ7ElgWoKW0UJ8zQay2
 vbKVA5qqsgiX7BoaKH/RMeGXNxUJZb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-ZvZzj-5BMEG6JslY4JbxGA-1; Mon, 09 Nov 2020 05:11:14 -0500
X-MC-Unique: ZvZzj-5BMEG6JslY4JbxGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F1121009E35;
 Mon,  9 Nov 2020 10:11:13 +0000 (UTC)
Received: from work-vm (ovpn-114-198.ams2.redhat.com [10.36.114.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60D746EF6B;
 Mon,  9 Nov 2020 10:11:05 +0000 (UTC)
Date: Mon, 9 Nov 2020 10:11:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] virtiofsd: Use --thread-pool-size=0 to mean no thread pool
Message-ID: <20201109101102.GE3024@work-vm>
References: <20201105194416.GA1384085@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201105194416.GA1384085@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> There is a chance that in case of some workloads, we might get better
> performance if we don't handover the request to a different thread
> and process in the context of thread receiving the request.
> 
> To implement that, redefine the meaning of --thread-pool-size=0 to
> mean that don't use a thread pool. Instead process the request in
> the context of thread receiving request from the queue.
> 
> I can't think how --thread-pool-size=0 is useful and hence using
> that. If it is already useful somehow, I could look at defining
> a new option say "--no-thread-pool".
> 
> I think this patch will be used more as a debug help to do comparison
> when it is more effecient to do not hand over the requests to a
> thread pool.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

I think this is OK, but you need to fix the style to match qemu rather
than kernel style.
(See qemu's scripts/checpatch.pl)

Dave

> ---
>  tools/virtiofsd/fuse_virtio.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index ff86f6d1ce..60aa7cd3e5 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -695,13 +695,17 @@ static void *fv_queue_thread(void *opaque)
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
> +        fuse_log(FUSE_LOG_DEBUG, "%s: Creating thread pool for Queue %d\n", __func__, qi->qidx);
> +        pool = g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size,
> +                                 FALSE, NULL);
> +        if (!pool) {
> +            fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func__);
> +            return NULL;
> +        }
>      }
>  
>      fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __func__,
> @@ -780,14 +784,25 @@ static void *fv_queue_thread(void *opaque)
>              req->bad_in_num = bad_in_num;
>              req->bad_out_num = bad_out_num;
>  
> -            g_thread_pool_push(pool, req, NULL);
> +            if (!se->thread_pool_size)
> +                req_list = g_list_prepend(req_list, req);
> +            else
> +                g_thread_pool_push(pool, req, NULL);
>          }
>  
>          pthread_mutex_unlock(&qi->vq_lock);
>          pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
> +
> +        // Process all the requests.
> +        if (!se->thread_pool_size && req_list != NULL) {
> +	    g_list_foreach(req_list, fv_queue_worker, qi);
> +	    g_list_free(req_list);
> +            req_list = NULL;
> +	}
>      }
>  
> -    g_thread_pool_free(pool, FALSE, TRUE);
> +    if (pool)
> +        g_thread_pool_free(pool, FALSE, TRUE);
>  
>      return NULL;
>  }
> -- 
> 2.25.4
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


