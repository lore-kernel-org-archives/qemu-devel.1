Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A0C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002102098B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu3OdeOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002102098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS5py-00009Y-4s
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS5ov-0007Ry-O9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS5ot-00040L-SK
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:25:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS5os-0003mH-Sj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587763509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eY9B9SRLnhvWtyvbtdlRb9FcMjhsCxf4urFuKbSFtLk=;
 b=Wu3OdeOU7ycqMif21a1xhE0eDI3/E4vts9tg2qKTePNQU69FbWDmpbq9GHzHVS8SGOyI6R
 R0LGpJd87nMyPqctzDA2UhqlaXZvT5aMG4D3mCKHicXHjP4Mk4Nhlzdqi1UcCaX0hcIcSe
 Rql2RvNVgJmp9o3ydPWmElhBNvdo0yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-FquNBG__OB6iOoShdhvTGg-1; Fri, 24 Apr 2020 17:25:07 -0400
X-MC-Unique: FquNBG__OB6iOoShdhvTGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA2351895A28;
 Fri, 24 Apr 2020 21:25:05 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAA5560606;
 Fri, 24 Apr 2020 21:25:04 +0000 (UTC)
Subject: Re: [RFC patch v1 2/3] qemu-file: add buffered mode
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9bb27377-49e5-75de-fc7e-4846f05478e2@redhat.com>
Date: Fri, 24 Apr 2020 16:25:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: den@openvz.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 6:12 AM, Denis Plotnikov wrote:
> The patch adds ability to qemu-file to write the data
> asynchronously to improve the performance on writing.
> Before, only synchronous writing was supported.
> 
> Enabling of the asyncronous mode is managed by new

asynchronous

> "enabled_buffered" callback.

The term "enabled_buffered" does not appear in the patch.  Did you mean...

> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   include/qemu/typedefs.h |   1 +
>   migration/qemu-file.c   | 351 +++++++++++++++++++++++++++++++++++++++++++++---
>   migration/qemu-file.h   |   9 ++
>   3 files changed, 339 insertions(+), 22 deletions(-)
> 

> @@ -60,6 +66,22 @@ struct QEMUFile {
>       bool shutdown;
>       /* currently used buffer */
>       QEMUFileBuffer *current_buf;
> +    /*
> +     * with buffered_mode enabled all the data copied to 512 byte
> +     * aligned buffer, including iov data. Then the buffer is passed
> +     * to writev_buffer callback.
> +     */
> +    bool buffered_mode;

..."Asynchronous mode is managed by setting the new buffered_mode flag"? 
  ...


> +    /* for async buffer writing */
> +    AioTaskPool *pool;
> +    /* the list of free buffers, currently used on is NOT there */

s/on/one/

> +    QLIST_HEAD(, QEMUFileBuffer) free_buffers;
> +};
> +
> +struct QEMUFileAioTask {
> +    AioTask task;
> +    QEMUFile *f;
> +    QEMUFileBuffer *fb;
>   };
>   
>   /*
> @@ -115,10 +137,42 @@ QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops)
>       f->opaque = opaque;
>       f->ops = ops;
>   
> -    f->current_buf = g_new0(QEMUFileBuffer, 1);
> -    f->current_buf->buf = g_malloc(IO_BUF_SIZE);
> -    f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
> -    f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
> +    if (f->ops->enable_buffered) {
> +        f->buffered_mode = f->ops->enable_buffered(f->opaque);

...ah, you meant 'enable_buffered'.  But still, why do we need a 
callback function?  Is it not sufficient to just have a bool flag?


> +static size_t get_buf_free_size(QEMUFile *f)
> +{
> +    QEMUFileBuffer *fb = f->current_buf;
> +    /* buf_index can't be greated than buf_size */

greater

> +    assert(fb->buf_size >= fb->buf_index);
> +    return fb->buf_size - fb->buf_index;
> +}
> +

> +static int write_task_fn(AioTask *task)
> +{

> +    /*
> +     * Increment file position.
> +     * This needs to be here before calling writev_buffer, because
> +     * writev_buffer is asynchronous and there could be more than one
> +     * writev_buffer started simultaniously. Each writev_buffer should

simultaneously

> +     * use its own file pos to write to. writev_buffer may write less
> +     * than buf_index bytes but we treat this situation as an error.
> +     * If error appeared, further file using is meaningless.

s/using/use/

> +     * We expect that, the most of the time the full buffer is written,
> +     * (when buf_size == buf_index). The only case when the non-full
> +     * buffer is written (buf_size != buf_index) is file close,
> +     * when we need to flush the rest of the buffer content.

We expect that most of the time, the full buffer will be written 
(buf_size == buf_index), with the exception at file close where we need 
to flush the final partial buffer.

> +     */
> +    f->pos += fb->buf_index;
> +
> +    ret = f->ops->writev_buffer(f->opaque, &v, 1, pos, &local_error);
> +
> +    /* return the just written buffer to the free list */
> +    QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
> +
> +    /* check that we have written everything */
> +    if (ret != fb->buf_index) {
> +        qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
> +    }
> +
> +    /*
> +     * always return 0 - don't use task error handling, relay on

rely

> +     * qemu file error handling
> +     */
> +    return 0;
> +}
> +
> +static void qemu_file_switch_current_buf(QEMUFile *f)
> +{
> +    /*
> +     * if the list is empty, wait until some task returns a buffer
> +     * to the list of free buffers.
> +     */
> +    if (QLIST_EMPTY(&f->free_buffers)) {
> +        aio_task_pool_wait_slot(f->pool);
> +    }
> +
> +    /*
> +     * sanity check that the list isn't empty
> +     * if the free list was empty, we waited for a task complition,

completion

> +     * and the pompleted task must return a buffer to a list of free buffers

completed

> +     */
> +    assert(!QLIST_EMPTY(&f->free_buffers));
> +
> +    /* set the current buffer for using from the free list */
> +    f->current_buf = QLIST_FIRST(&f->free_buffers);
> +    reset_buf(f);
> +
> +    QLIST_REMOVE(f->current_buf, link);
> +}
> +

>   
>   /*
> + * Copy an external buffer to the intenal current buffer.

internal

> + */
> +static void copy_buf(QEMUFile *f, const uint8_t *buf, size_t size,
> +                     bool may_free)
> +{

> +++ b/migration/qemu-file.h
> @@ -103,6 +103,14 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaque);
>   typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr,
>                                      Error **errp);
>   
> +/*
> + * Enables or disables the buffered mode
> + * Existing blocking reads/writes must be woken
> + * Returns true if the buffered mode has to be enabled,
> + * false if it has to be disabled.
> + */
> +typedef bool (QEMUFileEnableBufferedFunc)(void *opaque);

If this never gets called outside of initial creation of the QemuFile 
(that is, it is not dynamic), then making it a straight flag instead of 
a callback function is simpler.

> +
>   typedef struct QEMUFileOps {
>       QEMUFileGetBufferFunc *get_buffer;
>       QEMUFileCloseFunc *close;
> @@ -110,6 +118,7 @@ typedef struct QEMUFileOps {
>       QEMUFileWritevBufferFunc *writev_buffer;
>       QEMURetPathFunc *get_return_path;
>       QEMUFileShutdownFunc *shut_down;
> +    QEMUFileEnableBufferedFunc *enable_buffered;
>   } QEMUFileOps;
>   
>   typedef struct QEMUFileHooks {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


