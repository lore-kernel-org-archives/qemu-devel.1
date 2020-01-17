Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493CFC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BF92072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg4fr+gS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BF92072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isYlf-0002NA-5M
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 16:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1isYkf-0001aQ-Vv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1isYke-0004DH-EK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:01:57 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:37133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1isYke-0004CY-9X
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:01:56 -0500
Received: by mail-qv1-xf44.google.com with SMTP id f16so11341909qvi.4
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 13:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kiUukwd4mg8ssVMVdhOABYVtemuBuBFjegzFBONPi7w=;
 b=Pg4fr+gSa0rO26A7QJZrNOraH/uAAOX809S46tIAF61P8INNDcjAWqLjwr3XXu/UUU
 eVn4gcRxZCkWzd2rq1/AE6W4jsYsTaPUtjx2IUIoKPtjSg27WO+r2+W9t3cgIg0LP4vv
 IrCgcy4/D7uH9hpC2Nj5D5QybqpZeTbCYIfhgpN6XSzQzMH7jRelqUqBHeCCLzVV5B2M
 p0tZ8byYngkYL5uMhQLTkZz3BH6AVhG2EA66e/i1RWK9d+5d6ZgzDPoeWKISuPN/kzLD
 e1AajXfDcwU9hUkuriPyUvJN5Rf/jbmUBFLkdZCQwEBSExj3gfSoro7XzhVm8wgG8Ekx
 zRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kiUukwd4mg8ssVMVdhOABYVtemuBuBFjegzFBONPi7w=;
 b=Sbl8bC4e1Z1+1FiF7m5nz2CcbaOyGn222jT+col6RzSGTda8PjwQzXpJ310VjIyrfV
 V13CS0uxJivWSOwmBAEezCPsJx3GdMtX+hfmHxsBDLchN4F7bz5cVEvrwEn6LnaTNvb3
 ZJRao1P4BrNnc4CrL0P1XJbQOOiGr3qTDE1qntW01E+JgN3QOGVzVwAK25HQmATvtyQB
 RrUElMVpj8FZgTiwdM8Q33p53f9MisDEm2mQwJc4zk4QcbpyUyEFz8+YX6jdJgua5/VL
 E+JPBKpEnGupe7XqE+P6AY4oBta0DCkO1NuJ97Y01wtvmCHRzABVGS5iBrA1uMr7Dr8Q
 7fPw==
X-Gm-Message-State: APjAAAXUx+vGb2r7ugH8INyrOB5WUgxMNGCYswILR0Rp5Ak9Dmd79JJ0
 p8uY0s2efcHSOrSSG1azFg==
X-Google-Smtp-Source: APXvYqxhU1HgtE1WXsrDRJhsUxvHZ9f56tS5oDOPfsR71x4Pi8H7fdv/Pg1KhcBpudboQzkGawAMzQ==
X-Received: by 2002:a0c:e610:: with SMTP id z16mr9654286qvm.215.1579294915300; 
 Fri, 17 Jan 2020 13:01:55 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id w60sm13423204qte.39.2020.01.17.13.01.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 13:01:54 -0800 (PST)
Date: Fri, 17 Jan 2020 16:01:49 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 039/104] virtiofsd: Plumb fuse_bufvec through to
 do_write_buf
Message-ID: <20200117210149.cvj3lb2tufz54hcg@gabell>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-40-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212163904.159893-40-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:59PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Let fuse_session_process_buf_int take a fuse_bufvec * instead of a
> fuse_buf;  and then through to do_write_buf - where in the best
> case it can pass that straight through to op.write_buf without copying
> (other than skipping a header).
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/fuse_i.h        |  2 +-
>  tools/virtiofsd/fuse_lowlevel.c | 61 ++++++++++++++++++++++-----------
>  tools/virtiofsd/fuse_virtio.c   |  3 +-
>  3 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> index cb1ca70ffa..d0679508cd 100644
> --- a/tools/virtiofsd/fuse_i.h
> +++ b/tools/virtiofsd/fuse_i.h
> @@ -119,7 +119,7 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *iov,
>  void fuse_free_req(fuse_req_t req);
>  
>  void fuse_session_process_buf_int(struct fuse_session *se,
> -                                  const struct fuse_buf *buf,
> +                                  struct fuse_bufvec *bufv,
>                                    struct fuse_chan *ch);
>  
>  
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index bea092b454..7d33bbf539 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -1006,11 +1006,12 @@ static void do_write(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
>  }
>  
>  static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid, const void *inarg,
> -                         const struct fuse_buf *ibuf)
> +                         struct fuse_bufvec *ibufv)
>  {
>      struct fuse_session *se = req->se;
> -    struct fuse_bufvec bufv = {
> -        .buf[0] = *ibuf,
> +    struct fuse_bufvec *pbufv = ibufv;
> +    struct fuse_bufvec tmpbufv = {
> +        .buf[0] = ibufv->buf[0],
>          .count = 1,
>      };
>      struct fuse_write_in *arg = (struct fuse_write_in *)inarg;
> @@ -1020,22 +1021,31 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid, const void *inarg,
>      fi.fh = arg->fh;
>      fi.writepage = arg->write_flags & FUSE_WRITE_CACHE;
>  
> -    fi.lock_owner = arg->lock_owner;
> -    fi.flags = arg->flags;
> -    if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD)) {
> -        bufv.buf[0].mem = PARAM(arg);
> -    }
> -
> -    bufv.buf[0].size -=
> -        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in);
> -    if (bufv.buf[0].size < arg->size) {
> -        fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small\n");
> -        fuse_reply_err(req, EIO);
> -        return;
> +    if (ibufv->count == 1) {
> +        fi.lock_owner = arg->lock_owner;
> +        fi.flags = arg->flags;
> +        if (!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD)) {
> +            tmpbufv.buf[0].mem = PARAM(arg);
> +        }
> +        tmpbufv.buf[0].size -=
> +            sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in);
> +        if (tmpbufv.buf[0].size < arg->size) {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "fuse: do_write_buf: buffer size too small\n");
> +            fuse_reply_err(req, EIO);
> +            return;
> +        }
> +        tmpbufv.buf[0].size = arg->size;
> +        pbufv = &tmpbufv;
> +    } else {
> +        /*
> +         *  Input bufv contains the headers in the first element
> +         * and the data in the rest, we need to skip that first element
> +         */
> +        ibufv->buf[0].size = 0;
>      }
> -    bufv.buf[0].size = arg->size;
>  
> -    se->op.write_buf(req, nodeid, &bufv, arg->offset, &fi);
> +    se->op.write_buf(req, nodeid, pbufv, arg->offset, &fi);
>  }
>  
>  static void do_flush(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
> @@ -2027,13 +2037,24 @@ static const char *opname(enum fuse_opcode opcode)
>  void fuse_session_process_buf(struct fuse_session *se,
>                                const struct fuse_buf *buf)
>  {
> -    fuse_session_process_buf_int(se, buf, NULL);
> +    struct fuse_bufvec bufv = { .buf[0] = *buf, .count = 1 };
> +    fuse_session_process_buf_int(se, &bufv, NULL);
>  }
>  
> +/*
> + * Restriction:
> + *   bufv is normally a single entry buffer, except for a write
> + *   where (if it's in memory) then the bufv may be multiple entries,
> + *   where the first entry contains all headers and subsequent entries
> + *   contain data
> + *   bufv shall not use any offsets etc to make the data anything
> + *   other than contiguous starting from 0.
> + */
>  void fuse_session_process_buf_int(struct fuse_session *se,
> -                                  const struct fuse_buf *buf,
> +                                  struct fuse_bufvec *bufv,
>                                    struct fuse_chan *ch)
>  {
> +    const struct fuse_buf *buf = bufv->buf;
>      struct fuse_in_header *in;
>      const void *inarg;
>      struct fuse_req *req;
> @@ -2111,7 +2132,7 @@ void fuse_session_process_buf_int(struct fuse_session *se,
>  
>      inarg = (void *)&in[1];
>      if (in->opcode == FUSE_WRITE && se->op.write_buf) {
> -        do_write_buf(req, in->nodeid, inarg, buf);
> +        do_write_buf(req, in->nodeid, inarg, bufv);
>      } else {
>          fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
>      }
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index fa6e53e7d0..99c877ea2e 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -499,7 +499,8 @@ static void *fv_queue_thread(void *opaque)
>              /* TODO! Endianness of header */
>  
>              /* TODO: Add checks for fuse_session_exited */
> -            fuse_session_process_buf_int(se, &fbuf, &ch);
> +            struct fuse_bufvec bufv = { .buf[0] = fbuf, .count = 1 };
> +            fuse_session_process_buf_int(se, &bufv, &ch);
>  
>              if (!qi->reply_sent) {
>                  fuse_log(FUSE_LOG_DEBUG, "%s: elem %d no reply sent\n",

Looks good to me.

Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

