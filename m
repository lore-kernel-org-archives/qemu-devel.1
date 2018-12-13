Received: from eggs.gnu.org ([2001:4830:134:3::10]:54374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXaPd-000884-IV
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXaPX-0002cB-Mh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:28:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gXaPT-0002Ok-Rr
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:28:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so4093343wmh.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 15:28:49 -0800 (PST)
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
	<20181211164317.32893-5-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af0ed3b1-bb0e-3575-0e3a-7097cd75b621@redhat.com>
Date: Fri, 14 Dec 2018 00:28:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181211164317.32893-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/8] qcow2-threads: split out generic
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, mreitz@redhat.com, den@openvz.org

On 11/12/18 17:43, Vladimir Sementsov-Ogievskiy wrote:
> +    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
> +
> +    while (s->nb_threads >= QCOW2_MAX_THREADS) {
> +        qemu_co_queue_wait(&s->thread_task_queue, NULL);
> +    }
> +
> +    s->nb_threads++;
> +    ret = thread_pool_submit_co(pool, func, arg);
> +    s->nb_threads--;
> +
> +    qemu_co_queue_next(&s->thread_task_queue);

What lock is protecting this manipulation?  I'd rather avoid adding more
users of the AioContext lock, especially manipulation of CoQueues.

One possibility is to do the s->lock unlock/lock here, and then also
rely on that in patch 8.

Paolo
