Received: from eggs.gnu.org ([2001:4830:134:3::10]:34072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT70D-0006Az-Bm
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT708-0002NB-9w
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:07:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT708-0002Mx-4K
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:07:08 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E4864E4D0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 13:07:08 +0000 (UTC)
Date: Mon, 16 Jan 2017 21:07:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116130702.GG14226@lemon.Home>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/16] block: explicitly acquire aiocontext
 in timers that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Fri, 01/13 14:17, Paolo Bonzini wrote:
> diff --git a/block/qed.c b/block/qed.c
> index 7f1c508..a21d025 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -345,10 +345,22 @@ static void qed_need_check_timer_cb(void *opaque)
>  
>      trace_qed_need_check_timer_cb(s);
>  
> +    qed_acquire(s);
>      qed_plug_allocating_write_reqs(s);
>  
>      /* Ensure writes are on disk before clearing flag */
>      bdrv_aio_flush(s->bs->file->bs, qed_clear_need_check, s);
> +    qed_release(s);
> +}
> +
> +void qed_acquire(BDRVQEDState *s)
> +{
> +    aio_context_acquire(bdrv_get_aio_context(s->bs));
> +}
> +
> +void qed_release(BDRVQEDState *s)
> +{
> +    aio_context_release(bdrv_get_aio_context(s->bs));
>  }
>  
>  static void qed_start_need_check_timer(BDRVQEDState *s)
> diff --git a/block/qed.h b/block/qed.h
> index 9676ab9..ce8c314 100644
> --- a/block/qed.h
> +++ b/block/qed.h
> @@ -198,6 +198,9 @@ enum {
>   */
>  typedef void QEDFindClusterFunc(void *opaque, int ret, uint64_t offset, size_t len);
>  
> +void qed_acquire(BDRVQEDState *s);
> +void qed_release(BDRVQEDState *s);
> +

Why cannot these be local (static) functions, in block/qed.c?

>  /**
>   * Generic callback for chaining async callbacks
>   */

Fam
