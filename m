Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D84C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DB620656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agVMmBG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DB620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT2fs-00026X-Dq
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jT2es-0001Cl-6M
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jT2eq-0000Ei-EW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:14:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jT2ep-0000EV-Ss
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587989682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xajyIX+8DkyiWehk2vPlHHr/c/pZ/rktYi+Zy4BQDO0=;
 b=agVMmBG1BW/0FmQE0aBqbJkt9UXUjwQ0lMzGFWPT8h58KKtm4AHhqUEicRkmsdsvWF/QcS
 VlFJWroqFZEPr4IMuhfYf3oPvisRTD0KBe+SCIPYf4uOLtN21tUvqtUxLXYSrN/NpuSQcY
 Ugk6UnHrHuVqfcDNSGEC9FsbA/2Bim8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-9K0UumCQNHSPpA54N-0avA-1; Mon, 27 Apr 2020 08:14:38 -0400
X-MC-Unique: 9K0UumCQNHSPpA54N-0avA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C01B8107BEF5;
 Mon, 27 Apr 2020 12:14:37 +0000 (UTC)
Received: from work-vm (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A0D66106A;
 Mon, 27 Apr 2020 12:14:36 +0000 (UTC)
Date: Mon, 27 Apr 2020 13:14:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [RFC patch v1 2/3] qemu-file: add buffered mode
Message-ID: <20200427121433.GI2923@work-vm>
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: den@openvz.org, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> The patch adds ability to qemu-file to write the data
> asynchronously to improve the performance on writing.
> Before, only synchronous writing was supported.
>=20
> Enabling of the asyncronous mode is managed by new
> "enabled_buffered" callback.

It's a bit invasive isn't it - changes a lot of functions in a lot of
places!
The multifd code separated the control headers from the data on separate
fd's - but that doesn't help your case.

Is there any chance you could do this by using the existing 'save_page'
hook (that RDMA uses).

In the cover letter you mention direct qemu_fflush calls - have we got a
few too many in some palces that you think we can clean out?

Dave

> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  include/qemu/typedefs.h |   1 +
>  migration/qemu-file.c   | 351 ++++++++++++++++++++++++++++++++++++++++++=
+++---
>  migration/qemu-file.h   |   9 ++
>  3 files changed, 339 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 88dce54..9b388c8 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -98,6 +98,7 @@ typedef struct QEMUBH QEMUBH;
>  typedef struct QemuConsole QemuConsole;
>  typedef struct QEMUFile QEMUFile;
>  typedef struct QEMUFileBuffer QEMUFileBuffer;
> +typedef struct QEMUFileAioTask QEMUFileAioTask;
>  typedef struct QemuLockable QemuLockable;
>  typedef struct QemuMutex QemuMutex;
>  typedef struct QemuOpt QemuOpt;
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 285c6ef..f42f949 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -29,19 +29,25 @@
>  #include "qemu-file.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "block/aio_task.h"
> =20
> -#define IO_BUF_SIZE 32768
> +#define IO_BUF_SIZE (1024 * 1024)
>  #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
> +#define IO_BUF_NUM 2
> +#define IO_BUF_ALIGNMENT 512
> =20
> -QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, 512));
> +QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, IO_BUF_ALIGNMENT));
> +QEMU_BUILD_BUG_ON(IO_BUF_SIZE > INT_MAX);
> +QEMU_BUILD_BUG_ON(IO_BUF_NUM <=3D 0);
> =20
>  struct QEMUFileBuffer {
>      int buf_index;
> -    int buf_size; /* 0 when writing */
> +    int buf_size; /* 0 when non-buffered writing */
>      uint8_t *buf;
>      unsigned long *may_free;
>      struct iovec *iov;
>      unsigned int iovcnt;
> +    QLIST_ENTRY(QEMUFileBuffer) link;
>  };
> =20
>  struct QEMUFile {
> @@ -60,6 +66,22 @@ struct QEMUFile {
>      bool shutdown;
>      /* currently used buffer */
>      QEMUFileBuffer *current_buf;
> +    /*
> +     * with buffered_mode enabled all the data copied to 512 byte
> +     * aligned buffer, including iov data. Then the buffer is passed
> +     * to writev_buffer callback.
> +     */
> +    bool buffered_mode;
> +    /* for async buffer writing */
> +    AioTaskPool *pool;
> +    /* the list of free buffers, currently used on is NOT there */
> +    QLIST_HEAD(, QEMUFileBuffer) free_buffers;
> +};
> +
> +struct QEMUFileAioTask {
> +    AioTask task;
> +    QEMUFile *f;
> +    QEMUFileBuffer *fb;
>  };
> =20
>  /*
> @@ -115,10 +137,42 @@ QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFi=
leOps *ops)
>      f->opaque =3D opaque;
>      f->ops =3D ops;
> =20
> -    f->current_buf =3D g_new0(QEMUFileBuffer, 1);
> -    f->current_buf->buf =3D g_malloc(IO_BUF_SIZE);
> -    f->current_buf->iov =3D g_new0(struct iovec, MAX_IOV_SIZE);
> -    f->current_buf->may_free =3D bitmap_new(MAX_IOV_SIZE);
> +    if (f->ops->enable_buffered) {
> +        f->buffered_mode =3D f->ops->enable_buffered(f->opaque);
> +    }
> +
> +    if (f->buffered_mode && qemu_file_is_writable(f)) {
> +        int i;
> +        /*
> +         * in buffered_mode we don't use internal io vectors
> +         * and may_free bitmap, because we copy the data to be
> +         * written right away to the buffer
> +         */
> +        f->pool =3D aio_task_pool_new(IO_BUF_NUM);
> +
> +        /* allocate io buffers */
> +        for (i =3D 0; i < IO_BUF_NUM; i++) {
> +            QEMUFileBuffer *fb =3D g_new0(QEMUFileBuffer, 1);
> +
> +            fb->buf =3D qemu_memalign(IO_BUF_ALIGNMENT, IO_BUF_SIZE);
> +            fb->buf_size =3D IO_BUF_SIZE;
> +
> +            /*
> +             * put the first buffer to the current buf and the rest
> +             * to the list of free buffers
> +             */
> +            if (i =3D=3D 0) {
> +                f->current_buf =3D fb;
> +            } else {
> +                QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
> +            }
> +        }
> +    } else {
> +        f->current_buf =3D g_new0(QEMUFileBuffer, 1);
> +        f->current_buf->buf =3D g_malloc(IO_BUF_SIZE);
> +        f->current_buf->iov =3D g_new0(struct iovec, MAX_IOV_SIZE);
> +        f->current_buf->may_free =3D bitmap_new(MAX_IOV_SIZE);
> +    }
> =20
>      return f;
>  }
> @@ -190,6 +244,8 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>      unsigned long idx;
>      QEMUFileBuffer *fb =3D f->current_buf;
> =20
> +    assert(!f->buffered_mode);
> +
>      /* Find and release all the contiguous memory ranges marked as may_f=
ree. */
>      idx =3D find_next_bit(fb->may_free, fb->iovcnt, 0);
>      if (idx >=3D fb->iovcnt) {
> @@ -221,6 +277,147 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>      bitmap_zero(fb->may_free, MAX_IOV_SIZE);
>  }
> =20
> +static void advance_buf_ptr(QEMUFile *f, size_t size)
> +{
> +    QEMUFileBuffer *fb =3D f->current_buf;
> +    /* must not advance to 0 */
> +    assert(size);
> +    /* must not overflow buf_index (int) */
> +    assert(fb->buf_index + size <=3D INT_MAX);
> +    /* must not exceed buf_size */
> +    assert(fb->buf_index + size <=3D fb->buf_size);
> +
> +    fb->buf_index +=3D size;
> +}
> +
> +static size_t get_buf_free_size(QEMUFile *f)
> +{
> +    QEMUFileBuffer *fb =3D f->current_buf;
> +    /* buf_index can't be greated than buf_size */
> +    assert(fb->buf_size >=3D fb->buf_index);
> +    return fb->buf_size - fb->buf_index;
> +}
> +
> +static size_t get_buf_used_size(QEMUFile *f)
> +{
> +    QEMUFileBuffer *fb =3D f->current_buf;
> +    return fb->buf_index;
> +}
> +
> +static uint8_t *get_buf_ptr(QEMUFile *f)
> +{
> +    QEMUFileBuffer *fb =3D f->current_buf;
> +    /* protects from out of bound reading */
> +    assert(fb->buf_index <=3D IO_BUF_SIZE);
> +    return fb->buf + fb->buf_index;
> +}
> +
> +static bool buf_is_full(QEMUFile *f)
> +{
> +    return get_buf_free_size(f) =3D=3D 0;
> +}
> +
> +static void reset_buf(QEMUFile *f)
> +{
> +    QEMUFileBuffer *fb =3D f->current_buf;
> +    fb->buf_index =3D 0;
> +}
> +
> +static int write_task_fn(AioTask *task)
> +{
> +    int ret;
> +    Error *local_error =3D NULL;
> +    QEMUFileAioTask *t =3D (QEMUFileAioTask *) task;
> +    QEMUFile *f =3D t->f;
> +    QEMUFileBuffer *fb =3D t->fb;
> +    uint64_t pos =3D f->pos;
> +    struct iovec v =3D (struct iovec) {
> +        .iov_base =3D fb->buf,
> +        .iov_len =3D fb->buf_index,
> +    };
> +
> +    assert(f->buffered_mode);
> +
> +    /*
> +     * Increment file position.
> +     * This needs to be here before calling writev_buffer, because
> +     * writev_buffer is asynchronous and there could be more than one
> +     * writev_buffer started simultaniously. Each writev_buffer should
> +     * use its own file pos to write to. writev_buffer may write less
> +     * than buf_index bytes but we treat this situation as an error.
> +     * If error appeared, further file using is meaningless.
> +     * We expect that, the most of the time the full buffer is written,
> +     * (when buf_size =3D=3D buf_index). The only case when the non-full
> +     * buffer is written (buf_size !=3D buf_index) is file close,
> +     * when we need to flush the rest of the buffer content.
> +     */
> +    f->pos +=3D fb->buf_index;
> +
> +    ret =3D f->ops->writev_buffer(f->opaque, &v, 1, pos, &local_error);
> +
> +    /* return the just written buffer to the free list */
> +    QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
> +
> +    /* check that we have written everything */
> +    if (ret !=3D fb->buf_index) {
> +        qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
> +    }
> +
> +    /*
> +     * always return 0 - don't use task error handling, relay on
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
> +     * and the pompleted task must return a buffer to a list of free buf=
fers
> +     */
> +    assert(!QLIST_EMPTY(&f->free_buffers));
> +
> +    /* set the current buffer for using from the free list */
> +    f->current_buf =3D QLIST_FIRST(&f->free_buffers);
> +    reset_buf(f);
> +
> +    QLIST_REMOVE(f->current_buf, link);
> +}
> +
> +/**
> + *  Asynchronously flushes QEMUFile buffer
> + *
> + * This will flush all pending data. If data was only partially flushed,=
 it
> + * will set an error state. The function may return before the data actu=
ally
> + * written.
> + */
> +static void flush_buffer(QEMUFile *f)
> +{
> +    QEMUFileAioTask *t =3D g_new(QEMUFileAioTask, 1);
> +
> +    *t =3D (QEMUFileAioTask) {
> +        .task.func =3D &write_task_fn,
> +        .f =3D f,
> +        .fb =3D f->current_buf,
> +    };
> +
> +    /* aio_task_pool should free t for us */
> +    aio_task_pool_start_task(f->pool, (AioTask *) t);
> +
> +    /* if no errors this will switch the buffer */
> +    qemu_file_switch_current_buf(f);
> +}
> +
>  /**
>   * Flushes QEMUFile buffer
>   *
> @@ -241,7 +438,13 @@ void qemu_fflush(QEMUFile *f)
>      if (f->shutdown) {
>          return;
>      }
> +
> +    if (f->buffered_mode) {
> +        return;
> +    }
> +
>      if (fb->iovcnt > 0) {
> +        /* this is non-buffered mode */
>          expect =3D iov_size(fb->iov, fb->iovcnt);
>          ret =3D f->ops->writev_buffer(f->opaque, fb->iov, fb->iovcnt, f-=
>pos,
>                                      &local_error);
> @@ -378,6 +581,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
> =20
>  void qemu_update_position(QEMUFile *f, size_t size)
>  {
> +    assert(!f->buffered_mode);
>      f->pos +=3D size;
>  }
> =20
> @@ -392,7 +596,18 @@ void qemu_update_position(QEMUFile *f, size_t size)
>  int qemu_fclose(QEMUFile *f)
>  {
>      int ret;
> -    qemu_fflush(f);
> +
> +    if (qemu_file_is_writable(f) && f->buffered_mode) {
> +        ret =3D qemu_file_get_error(f);
> +        if (!ret) {
> +            flush_buffer(f);
> +        }
> +        /* wait until all tasks are done */
> +        aio_task_pool_wait_all(f->pool);
> +    } else {
> +        qemu_fflush(f);
> +    }
> +
>      ret =3D qemu_file_get_error(f);
> =20
>      if (f->ops->close) {
> @@ -408,16 +623,77 @@ int qemu_fclose(QEMUFile *f)
>          ret =3D f->last_error;
>      }
>      error_free(f->last_error_obj);
> -    g_free(f->current_buf->buf);
> -    g_free(f->current_buf->iov);
> -    g_free(f->current_buf->may_free);
> -    g_free(f->current_buf);
> +
> +    if (f->buffered_mode) {
> +        QEMUFileBuffer *fb, *next;
> +        /*
> +         * put the current back to the free buffers list
> +         * to destroy all the buffers in one loop
> +         */
> +        QLIST_INSERT_HEAD(&f->free_buffers, f->current_buf, link);
> +
> +        /* destroy all the buffers */
> +        QLIST_FOREACH_SAFE(fb, &f->free_buffers, link, next) {
> +            QLIST_REMOVE(fb, link);
> +            /* looks like qemu_vfree pairs with qemu_memalign */
> +            qemu_vfree(fb->buf);
> +            g_free(fb);
> +        }
> +        g_free(f->pool);
> +    } else {
> +        g_free(f->current_buf->buf);
> +        g_free(f->current_buf->iov);
> +        g_free(f->current_buf->may_free);
> +        g_free(f->current_buf);
> +    }
> +
>      g_free(f);
>      trace_qemu_file_fclose();
>      return ret;
>  }
> =20
>  /*
> + * Copy an external buffer to the intenal current buffer.
> + */
> +static void copy_buf(QEMUFile *f, const uint8_t *buf, size_t size,
> +                     bool may_free)
> +{
> +    size_t data_size =3D size;
> +    const uint8_t *src_ptr =3D buf;
> +
> +    assert(f->buffered_mode);
> +    assert(size <=3D INT_MAX);
> +
> +    while (data_size > 0) {
> +        size_t chunk_size;
> +
> +        if (buf_is_full(f)) {
> +            flush_buffer(f);
> +            if (qemu_file_get_error(f)) {
> +                return;
> +            }
> +        }
> +
> +        chunk_size =3D MIN(get_buf_free_size(f), data_size);
> +
> +        memcpy(get_buf_ptr(f), src_ptr, chunk_size);
> +
> +        advance_buf_ptr(f, chunk_size);
> +
> +        src_ptr +=3D chunk_size;
> +        data_size -=3D chunk_size;
> +        f->bytes_xfer +=3D chunk_size;
> +    }
> +
> +    if (may_free) {
> +        if (qemu_madvise((void *) buf, size, QEMU_MADV_DONTNEED) < 0) {
> +            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
> +                         buf, size, strerror(errno));
> +        }
> +    }
> +}
> +
> +/*
>   * Add buf to iovec. Do flush if iovec is full.
>   *
>   * Return values:
> @@ -454,6 +730,9 @@ static int add_to_iovec(QEMUFile *f, const uint8_t *b=
uf, size_t size,
>  static void add_buf_to_iovec(QEMUFile *f, size_t len)
>  {
>      QEMUFileBuffer *fb =3D f->current_buf;
> +
> +    assert(!f->buffered_mode);
> +
>      if (!add_to_iovec(f, fb->buf + fb->buf_index, len, false)) {
>          fb->buf_index +=3D len;
>          if (fb->buf_index =3D=3D IO_BUF_SIZE) {
> @@ -469,8 +748,12 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_=
t *buf, size_t size,
>          return;
>      }
> =20
> -    f->bytes_xfer +=3D size;
> -    add_to_iovec(f, buf, size, may_free);
> +    if (f->buffered_mode) {
> +        copy_buf(f, buf, size, may_free);
> +    } else {
> +        f->bytes_xfer +=3D size;
> +        add_to_iovec(f, buf, size, may_free);
> +    }
>  }
> =20
>  void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
> @@ -482,6 +765,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf=
, size_t size)
>          return;
>      }
> =20
> +    if (f->buffered_mode) {
> +        copy_buf(f, buf, size, false);
> +        return;
> +    }
> +
>      while (size > 0) {
>          l =3D IO_BUF_SIZE - fb->buf_index;
>          if (l > size) {
> @@ -506,15 +794,21 @@ void qemu_put_byte(QEMUFile *f, int v)
>          return;
>      }
> =20
> -    fb->buf[fb->buf_index] =3D v;
> -    f->bytes_xfer++;
> -    add_buf_to_iovec(f, 1);
> +    if (f->buffered_mode) {
> +        copy_buf(f, (const uint8_t *) &v, 1, false);
> +    } else {
> +        fb->buf[fb->buf_index] =3D v;
> +        add_buf_to_iovec(f, 1);
> +        f->bytes_xfer++;
> +    }
>  }
> =20
>  void qemu_file_skip(QEMUFile *f, int size)
>  {
>      QEMUFileBuffer *fb =3D f->current_buf;
> =20
> +    assert(!f->buffered_mode);
> +
>      if (fb->buf_index + size <=3D fb->buf_size) {
>          fb->buf_index +=3D size;
>      }
> @@ -672,10 +966,14 @@ int64_t qemu_ftell_fast(QEMUFile *f)
>  {
>      int64_t ret =3D f->pos;
>      int i;
> -    QEMUFileBuffer *fb =3D f->current_buf;
> =20
> -    for (i =3D 0; i < fb->iovcnt; i++) {
> -        ret +=3D fb->iov[i].iov_len;
> +    if (f->buffered_mode) {
> +        ret +=3D get_buf_used_size(f);
> +    } else {
> +        QEMUFileBuffer *fb =3D f->current_buf;
> +        for (i =3D 0; i < fb->iovcnt; i++) {
> +            ret +=3D fb->iov[i].iov_len;
> +        }
>      }
> =20
>      return ret;
> @@ -683,8 +981,12 @@ int64_t qemu_ftell_fast(QEMUFile *f)
> =20
>  int64_t qemu_ftell(QEMUFile *f)
>  {
> -    qemu_fflush(f);
> -    return f->pos;
> +    if (f->buffered_mode) {
> +        return qemu_ftell_fast(f);
> +    } else {
> +        qemu_fflush(f);
> +        return f->pos;
> +    }
>  }
> =20
>  int qemu_file_rate_limit(QEMUFile *f)
> @@ -803,6 +1105,8 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_str=
eam *stream,
>      QEMUFileBuffer *fb =3D f->current_buf;
>      ssize_t blen =3D IO_BUF_SIZE - fb->buf_index - sizeof(int32_t);
> =20
> +    assert(!f->buffered_mode);
> +
>      if (blen < compressBound(size)) {
>          return -1;
>      }
> @@ -827,6 +1131,9 @@ int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_=
src)
>      int len =3D 0;
>      QEMUFileBuffer *fb_src =3D f_src->current_buf;
> =20
> +    assert(!f_des->buffered_mode);
> +    assert(!f_src->buffered_mode);
> +
>      if (fb_src->buf_index > 0) {
>          len =3D fb_src->buf_index;
>          qemu_put_buffer(f_des, fb_src->buf, fb_src->buf_index);
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index a9b6d6c..08655d2 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -103,6 +103,14 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaque);
>  typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr,
>                                     Error **errp);
> =20
> +/*
> + * Enables or disables the buffered mode
> + * Existing blocking reads/writes must be woken
> + * Returns true if the buffered mode has to be enabled,
> + * false if it has to be disabled.
> + */
> +typedef bool (QEMUFileEnableBufferedFunc)(void *opaque);
> +
>  typedef struct QEMUFileOps {
>      QEMUFileGetBufferFunc *get_buffer;
>      QEMUFileCloseFunc *close;
> @@ -110,6 +118,7 @@ typedef struct QEMUFileOps {
>      QEMUFileWritevBufferFunc *writev_buffer;
>      QEMURetPathFunc *get_return_path;
>      QEMUFileShutdownFunc *shut_down;
> +    QEMUFileEnableBufferedFunc *enable_buffered;
>  } QEMUFileOps;
> =20
>  typedef struct QEMUFileHooks {
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


