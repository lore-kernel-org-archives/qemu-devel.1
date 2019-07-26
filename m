Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC4C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9CB22CE2
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9CB22CE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwkj-0001DQ-2a
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqwkT-0000q9-Pq
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqwkS-0005jx-90
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:42:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqwkS-0005ex-15
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:42:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so577177wrt.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wF43L5ODq82m/aaZH6JvCrqDzt7rrqkx7lANGQIqKSg=;
 b=UASoRdw9P0Ou1y5AitW7elvZoBuGjRggjCYY83blGXBIpB/ZeyFoA6clkrGWTFwOQH
 M21n6fcMMIk01mHLJdVEkZUK8E7ptZ97nSWb9GGdF6rBYq7NnEb26GpvMufxEWN+htsr
 qihQPlny+G4K912Z1E7XvG+A4PT2dcq5Ei+iUsF0ggRjoRkXBv6AeaYLjkI3IQ3B0Qbs
 HbIP/pAPXv2Ndn+aGzJi+OBrAUuhwDJq1ZNmpomrEwSct58pPCONESXMiP1cjpdPNpqS
 2vMaFBSHJ9GyvMhBq4Dyai14GhlrL83HUJga9thb4sx5ZnSoyUaRWjyHZD6Nu0qwBIcX
 uyTA==
X-Gm-Message-State: APjAAAU2fYdmSbFyYf5FhV/3ekew2FeXq1kBtmjCbVffyhekemtJ9v+B
 k77rs+FFZ1RqqBwhIafVZZgcWw==
X-Google-Smtp-Source: APXvYqzBXC9/ldP7d1AokvgqEW1XvY4ypUX92+Oxc07k2OBsYsm6ty7N8nYut6TpZoONpd0XzLTTMQ==
X-Received: by 2002:adf:8183:: with SMTP id 3mr101056013wra.181.1564134166819; 
 Fri, 26 Jul 2019 02:42:46 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id v204sm55312987wma.20.2019.07.26.02.42.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 02:42:46 -0700 (PDT)
Date: Fri, 26 Jul 2019 11:42:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190726094244.dyjwewyatjdptmex@steredhat>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724171239.8764-5-mreitz@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 04/11] block: Implement
 .bdrv_has_zero_init_truncate()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 07:12:32PM +0200, Max Reitz wrote:
> We need to implement .bdrv_has_zero_init_truncate() for every block
> driver that supports truncation and has a .bdrv_has_zero_init()
> implementation.
> 
> Implement it the same way each driver implements .bdrv_has_zero_init().
> This is at least not any more unsafe than what we had before.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 1 +
>  block/file-win32.c | 1 +
>  block/gluster.c    | 4 ++++
>  block/nfs.c        | 1 +
>  block/qcow2.c      | 1 +
>  block/qed.c        | 1 +
>  block/raw-format.c | 6 ++++++
>  block/rbd.c        | 1 +
>  block/sheepdog.c   | 1 +
>  block/ssh.c        | 1 +
>  10 files changed, 18 insertions(+)
> 

LGTM.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> diff --git a/block/file-posix.c b/block/file-posix.c
> index 4479cc7ab4..0208006f3c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2924,6 +2924,7 @@ BlockDriver bdrv_file = {
>      .bdrv_co_create = raw_co_create,
>      .bdrv_co_create_opts = raw_co_create_opts,
>      .bdrv_has_zero_init = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate = bdrv_has_zero_init_1,
>      .bdrv_co_block_status = raw_co_block_status,
>      .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
>      .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
> diff --git a/block/file-win32.c b/block/file-win32.c
> index 6b2d67b239..41f55dfece 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -635,6 +635,7 @@ BlockDriver bdrv_file = {
>      .bdrv_close         = raw_close,
>      .bdrv_co_create_opts = raw_co_create_opts,
>      .bdrv_has_zero_init = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate = bdrv_has_zero_init_1,
>  
>      .bdrv_aio_preadv    = raw_aio_preadv,
>      .bdrv_aio_pwritev   = raw_aio_pwritev,
> diff --git a/block/gluster.c b/block/gluster.c
> index f64dc5b01e..64028b2cba 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -1567,6 +1567,7 @@ static BlockDriver bdrv_gluster = {
>      .bdrv_co_writev               = qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
>      .bdrv_has_zero_init           = qemu_gluster_has_zero_init,
> +    .bdrv_has_zero_init_truncate  = qemu_gluster_has_zero_init,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             = qemu_gluster_co_pdiscard,
>  #endif
> @@ -1598,6 +1599,7 @@ static BlockDriver bdrv_gluster_tcp = {
>      .bdrv_co_writev               = qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
>      .bdrv_has_zero_init           = qemu_gluster_has_zero_init,
> +    .bdrv_has_zero_init_truncate  = qemu_gluster_has_zero_init,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             = qemu_gluster_co_pdiscard,
>  #endif
> @@ -1629,6 +1631,7 @@ static BlockDriver bdrv_gluster_unix = {
>      .bdrv_co_writev               = qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
>      .bdrv_has_zero_init           = qemu_gluster_has_zero_init,
> +    .bdrv_has_zero_init_truncate  = qemu_gluster_has_zero_init,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             = qemu_gluster_co_pdiscard,
>  #endif
> @@ -1666,6 +1669,7 @@ static BlockDriver bdrv_gluster_rdma = {
>      .bdrv_co_writev               = qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
>      .bdrv_has_zero_init           = qemu_gluster_has_zero_init,
> +    .bdrv_has_zero_init_truncate  = qemu_gluster_has_zero_init,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             = qemu_gluster_co_pdiscard,
>  #endif
> diff --git a/block/nfs.c b/block/nfs.c
> index d93241b3bb..97c815085f 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -863,6 +863,7 @@ static BlockDriver bdrv_nfs = {
>      .create_opts                    = &nfs_create_opts,
>  
>      .bdrv_has_zero_init             = nfs_has_zero_init,
> +    .bdrv_has_zero_init_truncate    = nfs_has_zero_init,
>      .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
>      .bdrv_co_truncate               = nfs_file_co_truncate,
>  
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 039bdc2f7e..5c40f54d64 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5187,6 +5187,7 @@ BlockDriver bdrv_qcow2 = {
>      .bdrv_co_create_opts  = qcow2_co_create_opts,
>      .bdrv_co_create       = qcow2_co_create,
>      .bdrv_has_zero_init = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate = bdrv_has_zero_init_1,
>      .bdrv_co_block_status = qcow2_co_block_status,
>  
>      .bdrv_co_preadv         = qcow2_co_preadv,
> diff --git a/block/qed.c b/block/qed.c
> index 77c7cef175..daaedb6864 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -1668,6 +1668,7 @@ static BlockDriver bdrv_qed = {
>      .bdrv_co_create           = bdrv_qed_co_create,
>      .bdrv_co_create_opts      = bdrv_qed_co_create_opts,
>      .bdrv_has_zero_init       = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate = bdrv_has_zero_init_1,
>      .bdrv_co_block_status     = bdrv_qed_co_block_status,
>      .bdrv_co_readv            = bdrv_qed_co_readv,
>      .bdrv_co_writev           = bdrv_qed_co_writev,
> diff --git a/block/raw-format.c b/block/raw-format.c
> index bffd424dd0..42c28cc29a 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -413,6 +413,11 @@ static int raw_has_zero_init(BlockDriverState *bs)
>      return bdrv_has_zero_init(bs->file->bs);
>  }
>  
> +static int raw_has_zero_init_truncate(BlockDriverState *bs)
> +{
> +    return bdrv_has_zero_init_truncate(bs->file->bs);
> +}
> +
>  static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
>                                             Error **errp)
>  {
> @@ -572,6 +577,7 @@ BlockDriver bdrv_raw = {
>      .bdrv_co_ioctl        = &raw_co_ioctl,
>      .create_opts          = &raw_create_opts,
>      .bdrv_has_zero_init   = &raw_has_zero_init,
> +    .bdrv_has_zero_init_truncate = &raw_has_zero_init_truncate,
>      .strong_runtime_opts  = raw_strong_runtime_opts,
>      .mutable_opts         = mutable_opts,
>  };
> diff --git a/block/rbd.c b/block/rbd.c
> index 59757b3120..057af43d48 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1288,6 +1288,7 @@ static BlockDriver bdrv_rbd = {
>      .bdrv_co_create         = qemu_rbd_co_create,
>      .bdrv_co_create_opts    = qemu_rbd_co_create_opts,
>      .bdrv_has_zero_init     = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate = bdrv_has_zero_init_1,
>      .bdrv_get_info          = qemu_rbd_getinfo,
>      .create_opts            = &qemu_rbd_create_opts,
>      .bdrv_getlength         = qemu_rbd_getlength,
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 6f402e5d4d..a4e111f981 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -3228,6 +3228,7 @@ static BlockDriver bdrv_sheepdog = {
>      .bdrv_co_create               = sd_co_create,
>      .bdrv_co_create_opts          = sd_co_create_opts,
>      .bdrv_has_zero_init           = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate  = bdrv_has_zero_init_1,
>      .bdrv_getlength               = sd_getlength,
>      .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
>      .bdrv_co_truncate             = sd_co_truncate,
> diff --git a/block/ssh.c b/block/ssh.c
> index 501933b855..84d01e892b 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -1390,6 +1390,7 @@ static BlockDriver bdrv_ssh = {
>      .bdrv_co_create_opts          = ssh_co_create_opts,
>      .bdrv_close                   = ssh_close,
>      .bdrv_has_zero_init           = ssh_has_zero_init,
> +    .bdrv_has_zero_init_truncate  = ssh_has_zero_init,
>      .bdrv_co_readv                = ssh_co_readv,
>      .bdrv_co_writev               = ssh_co_writev,
>      .bdrv_getlength               = ssh_getlength,
> -- 
> 2.21.0
> 

-- 

