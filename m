Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E2EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE3A21897
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE3A21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i17Pn-0003LU-0w
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 07:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i17Oa-0002r7-7O
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i17OY-0002CF-M5
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i17OY-0002AQ-Er
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 701AA18C4271;
 Fri, 23 Aug 2019 11:06:13 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 523D661785;
 Fri, 23 Aug 2019 11:06:12 +0000 (UTC)
Date: Fri, 23 Aug 2019 12:06:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>, berrange@redhat.com
Message-ID: <20190823110609.GF2784@work-vm>
References: <20190731144225.3784-1-richardw.yang@linux.intel.com>
 <20190731144225.3784-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731144225.3784-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 23 Aug 2019 11:06:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/qemu-file: fix potential buf
 waste for extra buf_index adjustment
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(Copying Dan in)

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
> this happens, buf_index is reset. Currently, this is not checked and
> buf_index would always been adjust with buf size.
> 
> This is not harmful, but will waste some space in file buffer.

That's a nice find.

> This patch make add_to_iovec() return 1 when it has flushed the file.
> Then the caller could check the return value to see whether it is
> necessary to adjust the buf_index any more.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I wonder if there's a way to wrap that little add_to_iovec, check, add
to index, flush in a little wrapper).

Dave

> ---
>  migration/qemu-file.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 35c22605dd..05d9f42ddb 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -343,8 +343,16 @@ int qemu_fclose(QEMUFile *f)
>      return ret;
>  }
>  
> -static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
> -                         bool may_free)
> +/*
> + * Add buf to iovec. Do flush if iovec is full.
> + *
> + * Return values:
> + * 1 iovec is full and flushed
> + * 0 iovec is not flushed
> + *
> + */
> +static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
> +                        bool may_free)
>  {
>      /* check for adjacent buffer and coalesce them */
>      if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
> @@ -362,7 +370,10 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>  
>      if (f->iovcnt >= MAX_IOV_SIZE) {
>          qemu_fflush(f);
> +        return 1;
>      }
> +
> +    return 0;
>  }
>  
>  void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
> @@ -391,10 +402,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>          }
>          memcpy(f->buf + f->buf_index, buf, l);
>          f->bytes_xfer += l;
> -        add_to_iovec(f, f->buf + f->buf_index, l, false);
> -        f->buf_index += l;
> -        if (f->buf_index == IO_BUF_SIZE) {
> -            qemu_fflush(f);
> +        if (!add_to_iovec(f, f->buf + f->buf_index, l, false)) {
> +            f->buf_index += l;
> +            if (f->buf_index == IO_BUF_SIZE) {
> +                qemu_fflush(f);
> +            }
>          }
>          if (qemu_file_get_error(f)) {
>              break;
> @@ -412,10 +424,11 @@ void qemu_put_byte(QEMUFile *f, int v)
>  
>      f->buf[f->buf_index] = v;
>      f->bytes_xfer++;
> -    add_to_iovec(f, f->buf + f->buf_index, 1, false);
> -    f->buf_index++;
> -    if (f->buf_index == IO_BUF_SIZE) {
> -        qemu_fflush(f);
> +    if (!add_to_iovec(f, f->buf + f->buf_index, 1, false)) {
> +        f->buf_index++;
> +        if (f->buf_index == IO_BUF_SIZE) {
> +            qemu_fflush(f);
> +        }
>      }
>  }
>  
> @@ -717,10 +730,11 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
>      }
>  
>      qemu_put_be32(f, blen);
> -    add_to_iovec(f, f->buf + f->buf_index, blen, false);
> -    f->buf_index += blen;
> -    if (f->buf_index == IO_BUF_SIZE) {
> -        qemu_fflush(f);
> +    if (!add_to_iovec(f, f->buf + f->buf_index, blen, false)) {
> +        f->buf_index += blen;
> +        if (f->buf_index == IO_BUF_SIZE) {
> +            qemu_fflush(f);
> +        }
>      }
>      return blen + sizeof(int32_t);
>  }
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

