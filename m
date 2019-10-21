Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FFDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100CA2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPspGTeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100CA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZ9I-0006Nf-7n
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iMZ8N-0005ZB-HY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iMZ8M-0004hG-0Y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iMZ8L-0004gW-LY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id c22so4034228wmd.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GV8VBCAu2JxgCRGqtCKdh8Aky8ZmilATmKzlv8Gfcns=;
 b=EPspGTeMLbJNPycsq2lEoKVxSzjKyosLsMTlkg5KQefDu8wrgnOjs1uGgAvpTkAQoz
 GMj7ylmcXPtj4DzmofcQaLDT6OvlEODleQQ/HOxhp/4pQ7M3wcaRUaFd2hofZ4eTsUYS
 SAk6x8CbLyEAln2Qv8Yd7riQiHa5ZtPnFxPBcln70uhb5par5RcDLPoKZUHprnnyRAW8
 SOSFIqg93GIVjh0HLO6Khnea7ic/tzTdb7MIi6UcnV7ubgzaLAjWXAKzGFo2LyvPLMFe
 Mng2RKSC4Qmd+TBhrWau6kgwanILnoEeeK/FcJeSyjLWOraaTp2iBCotpZePI9Q+FcUq
 eY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GV8VBCAu2JxgCRGqtCKdh8Aky8ZmilATmKzlv8Gfcns=;
 b=ffmpmvclKGaIQ7b38/Fyr6Ek5EGChzeIezbeDEsZSeAvQqA9kTeNsTbXBSYzSq1Mtx
 9oDgQ1tiCetpj+saRL/W4WR3/KHNMhdezINPhzXLi2T3CvmFr4CbSLRGwG2HL2zd1BNG
 12eQzFwDGkmY+dgfBHE+Cvk4A+Qm/6JjroUe8ItQ6g9+mCwp7ZcyO0Yy41oOQKToS3bM
 I/9lnQsl7s5bNeoqt4yGPkytC9QhuMODY/0QytD5IxiTAklanlJdA2wRePnBy0uytxzj
 glBtA4BIS0SDmmSzzSfohvUO3+J5X2ESLNna6MzbfdXVAhxC1L227zabtH+4cX4cHVgx
 sZvg==
X-Gm-Message-State: APjAAAXTxSjTUg5PJ+M0QO4o14MqR1ZiXczXobrMBrS/9MzUaM1x3GIy
 O1HdLO539JnIkGPNJT9WISMW3q6E6Cgn3WKzLnc=
X-Google-Smtp-Source: APXvYqzl4HMDn5lyIA3s+Ymia28qjTQyeh3xESC/e8aplo1s2P5yXMd+vY1exHeUz9z3fFamsQfSJHeUuCwZ0Cz9Wqc=
X-Received: by 2002:a7b:c631:: with SMTP id p17mr19880066wmk.5.1571669887957; 
 Mon, 21 Oct 2019 07:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191021105832.36574-22-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-22-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 21 Oct 2019 16:57:56 +0200
Message-ID: <CAJ+F1CJ+P2Um+SGFu4dMoxcgWXTq3ZXqeTBjW01hgaJS3V2s-g@mail.gmail.com>
Subject: Re: [PATCH 21/30] virtiofsd: Start reading commands from queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 piaojun@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 1:09 PM Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Pop queue elements off queues, copy the data from them and
> pass that to fuse.
>
>   Note: 'out' in a VuVirtqElement is from QEMU
>         'in' in libfuse is into the daemon
>
>   So we read from the out iov's to get a fuse_in_header
>
> When we get a kick we've got to read all the elements until the queue
> is empty.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/virtiofsd/fuse_i.h      |  2 +
>  contrib/virtiofsd/fuse_virtio.c | 99 ++++++++++++++++++++++++++++++++-
>  2 files changed, 98 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
> index ea55f618a5..5b6ef09df5 100644
> --- a/contrib/virtiofsd/fuse_i.h
> +++ b/contrib/virtiofsd/fuse_i.h
> @@ -14,6 +14,7 @@
>  #include "fuse_lowlevel.h"
>
>  struct fv_VuDev;
> +struct fv_QueueInfo;
>
>  struct fuse_req {
>         struct fuse_session *se;
> @@ -75,6 +76,7 @@ struct fuse_chan {
>         pthread_mutex_t lock;
>         int ctr;
>         int fd;
> +       struct fv_QueueInfo *qi;
>  };
>
>  /**
> diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_vir=
tio.c
> index 0513531c13..e189511729 100644
> --- a/contrib/virtiofsd/fuse_virtio.c
> +++ b/contrib/virtiofsd/fuse_virtio.c
> @@ -32,6 +32,7 @@
>
>  #include "contrib/libvhost-user/libvhost-user.h"
>
> +struct fv_VuDev;
>  struct fv_QueueInfo {
>      pthread_t thread;
>      struct fv_VuDev *virtio_dev;
> @@ -101,10 +102,42 @@ static void fv_panic(VuDev *dev, const char *err)
>      exit(EXIT_FAILURE);
>  }
>
> +/*
> + * Copy from an iovec into a fuse_buf (memory only)
> + * Caller must ensure there is space
> + */
> +static void copy_from_iov(struct fuse_buf *buf, size_t out_num,
> +                          const struct iovec *out_sg)
> +{
> +    void *dest =3D buf->mem;
> +
> +    while (out_num) {
> +        size_t onelen =3D out_sg->iov_len;
> +        memcpy(dest, out_sg->iov_base, onelen);
> +        dest +=3D onelen;
> +        out_sg++;
> +        out_num--;
> +    }
> +}

Or iov_to_buf()

Just found out that vhost-user-blk.c should probably link too with
util/iov.o, instead of copying the code.

> +
>  /* Thread function for individual queues, created when a queue is 'start=
ed' */
>  static void *fv_queue_thread(void *opaque)
>  {
>      struct fv_QueueInfo *qi =3D opaque;
> +    struct VuDev *dev =3D &qi->virtio_dev->dev;
> +    struct VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
> +    struct fuse_session *se =3D qi->virtio_dev->se;
> +    struct fuse_chan ch;
> +    struct fuse_buf fbuf;
> +
> +    fbuf.mem =3D NULL;
> +    fbuf.flags =3D 0;
> +
> +    fuse_mutex_init(&ch.lock);
> +    ch.fd =3D (int)0xdaff0d111;
> +    ch.ctr =3D 1;
> +    ch.qi =3D qi;
> +
>      fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __fun=
c__,
>               qi->qidx, qi->kick_fd);
>      while (1) {
> @@ -141,11 +174,71 @@ static void *fv_queue_thread(void *opaque)
>              fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
>              break;
>          }
> -        if (qi->virtio_dev->se->debug) {
> -            fprintf(stderr, "%s: Queue %d gave evalue: %zx\n", __func__,
> -                    qi->qidx, (size_t)evalue);
> +        /* out is from guest, in is too guest */
> +        unsigned int in_bytes, out_bytes;
> +        vu_queue_get_avail_bytes(dev, q, &in_bytes, &out_bytes, ~0, ~0);
> +
> +        fuse_log(FUSE_LOG_DEBUG,
> +                 "%s: Queue %d gave evalue: %zx available: in: %u out: %=
u\n",
> +                 __func__, qi->qidx, (size_t)evalue, in_bytes, out_bytes=
);
> +
> +        while (1) {
> +            /*
> +             * An element contains one request and the space to send our
> +             * response They're spread over multiple descriptors in a
> +             * scatter/gather set and we can't trust the guest to keep t=
hem
> +             * still; so copy in/out.
> +             */
> +            VuVirtqElement *elem =3D vu_queue_pop(dev, q, sizeof(VuVirtq=
Element));
> +            if (!elem) {
> +                break;
> +            }
> +
> +            if (!fbuf.mem) {
> +                fbuf.mem =3D malloc(se->bufsize);
> +                assert(fbuf.mem);
> +                assert(se->bufsize > sizeof(struct fuse_in_header));
> +            }
> +            /* The 'out' part of the elem is from qemu */
> +            unsigned int out_num =3D elem->out_num;
> +            struct iovec *out_sg =3D elem->out_sg;
> +            size_t out_len =3D iov_length(out_sg, out_num);
> +            fuse_log(FUSE_LOG_DEBUG,
> +                     "%s: elem %d: with %d out desc of length %zd\n", __=
func__,
> +                     elem->index, out_num, out_len);
> +
> +            /*
> +             * The elem should contain a 'fuse_in_header' (in to fuse)
> +             * plus the data based on the len in the header.
> +             */
> +            if (out_len < sizeof(struct fuse_in_header)) {
> +                fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for in_hea=
der\n",
> +                         __func__, elem->index);
> +                assert(0); /* TODO */
> +            }
> +            if (out_len > se->bufsize) {
> +                fuse_log(FUSE_LOG_ERR, "%s: elem %d too large for buffer=
\n",
> +                         __func__, elem->index);
> +                assert(0); /* TODO */
> +            }
> +            copy_from_iov(&fbuf, out_num, out_sg);
> +            fbuf.size =3D out_len;
> +
> +            /* TODO! Endianness of header */
> +
> +            /* TODO: Fixup fuse_send_msg */
> +            /* TODO: Add checks for fuse_session_exited */
> +            fuse_session_process_buf_int(se, &fbuf, &ch);
> +
> +            /* TODO: vu_queue_push(dev, q, elem, qi->write_count); */
> +            vu_queue_notify(dev, q);
> +
> +            free(elem);
> +            elem =3D NULL;
>          }
>      }
> +    pthread_mutex_destroy(&ch.lock);
> +    free(fbuf.mem);
>
>      return NULL;
>  }
> --
> 2.23.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

