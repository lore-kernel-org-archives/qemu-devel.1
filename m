Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B7C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 19:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60432206CD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 19:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60432206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i87tL-00025j-IN
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 15:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i87s4-0001Eg-R7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i87s3-0003Ac-EP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i87s3-0003AA-6Z
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:01:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6DD393091740;
 Wed, 11 Sep 2019 19:01:38 +0000 (UTC)
Received: from work-vm (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45EB55D6A5;
 Wed, 11 Sep 2019 19:01:37 +0000 (UTC)
Date: Wed, 11 Sep 2019 20:01:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190911190134.GP2894@work-vm>
References: <20190911132839.23336-1-richard.weiyang@gmail.com>
 <20190911132839.23336-3-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911132839.23336-3-richard.weiyang@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 11 Sep 2019 19:01:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 2/2] migration/qemu-file: fix potential
 buf waste for extra buf_index adjustment
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richard.weiyang@gmail.com) wrote:
> From: Wei Yang <richardw.yang@linux.intel.com>
> 
> In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
> this happens, buf_index is reset. Currently, this is not checked and
> buf_index would always been adjust with buf size.
> 
> This is not harmful, but will waste some space in file buffer.
> 
> This patch make add_to_iovec() return 1 when it has flushed the file.
> Then the caller could check the return value to see whether it is
> necessary to adjust the buf_index any more.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> ---
> v2:
>    * wrap these common steps into add_buf_to_iovec()
> ---
>  migration/qemu-file.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 47f16d0e54..417eeba64b 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -382,8 +382,16 @@ int qemu_fclose(QEMUFile *f)
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
> @@ -401,6 +409,19 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>  
>      if (f->iovcnt >= MAX_IOV_SIZE) {
>          qemu_fflush(f);
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void add_buf_to_iovec(QEMUFile *f, size_t len)
> +{
> +    if (!add_to_iovec(f, f->buf + f->buf_index, len, false)) {
> +        f->buf_index += len;
> +        if (f->buf_index == IO_BUF_SIZE) {
> +            qemu_fflush(f);
> +        }

Yep, that's better.

Dave

>      }
>  }
>  
> @@ -430,11 +451,7 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>          }
>          memcpy(f->buf + f->buf_index, buf, l);
>          f->bytes_xfer += l;
> -        add_to_iovec(f, f->buf + f->buf_index, l, false);
> -        f->buf_index += l;
> -        if (f->buf_index == IO_BUF_SIZE) {
> -            qemu_fflush(f);
> -        }
> +        add_buf_to_iovec(f, l);
>          if (qemu_file_get_error(f)) {
>              break;
>          }
> @@ -451,11 +468,7 @@ void qemu_put_byte(QEMUFile *f, int v)
>  
>      f->buf[f->buf_index] = v;
>      f->bytes_xfer++;
> -    add_to_iovec(f, f->buf + f->buf_index, 1, false);
> -    f->buf_index++;
> -    if (f->buf_index == IO_BUF_SIZE) {
> -        qemu_fflush(f);
> -    }
> +    add_buf_to_iovec(f, 1);
>  }
>  
>  void qemu_file_skip(QEMUFile *f, int size)
> @@ -761,11 +774,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
>      }
>  
>      qemu_put_be32(f, blen);
> -    add_to_iovec(f, f->buf + f->buf_index, blen, false);
> -    f->buf_index += blen;
> -    if (f->buf_index == IO_BUF_SIZE) {
> -        qemu_fflush(f);
> -    }
> +    add_buf_to_iovec(f, blen);
>      return blen + sizeof(int32_t);
>  }
>  
> -- 
> 2.15.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

