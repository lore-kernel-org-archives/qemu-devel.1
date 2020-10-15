Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA222224A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5KuLLnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA222224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSzrJ-0000Aq-UF
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 05:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kSzqE-0007gs-84
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 05:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kSzqC-0002BY-6I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 05:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602755191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ode6UcIWYhpQvEXXR5okb7CD7U/FXBjyVZQJp0nxho=;
 b=i5KuLLnJQyk+IIaNLLhSywuUj6KWI2MGBSdAeW14za8MHREH+MiDILpBUCx/0QVISJ9btP
 vuEBjSlRG0WlAcmd8lq1AUyPasqG1AyXPMCL9P13vBNKadHug2P+LqJENmj8bJbq6HyIUh
 fEt/Nse9qI/Ap8yWPPhufblpLxEsg+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-yN7c2T2eMiOYo_ZQQWzmUA-1; Thu, 15 Oct 2020 05:46:29 -0400
X-MC-Unique: yN7c2T2eMiOYo_ZQQWzmUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87FEE9CC07;
 Thu, 15 Oct 2020 09:46:28 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 525A85C1BD;
 Thu, 15 Oct 2020 09:46:24 +0000 (UTC)
Date: Thu, 15 Oct 2020 11:46:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 03/20] fuse: Implement standard FUSE operations
Message-ID: <20201015094622.GC4610@merkur.fritz.box>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-4-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922104932.46384-4-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
> This makes the export actually useful instead of only producing errors
> whenever it is accessed.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/export/fuse.c | 226 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 226 insertions(+)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 75f11d2514..8fc667231d 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -32,6 +32,10 @@
>  #include <fuse_lowlevel.h>
>  
>  
> +/* Prevent overly long bounce buffer allocations */
> +#define FUSE_MAX_BOUNCE_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
> +
> +
>  typedef struct FuseExport {
>      BlockExport common;
>  
> @@ -241,7 +245,229 @@ static bool is_regular_file(const char *path, Error **errp)
>      return true;
>  }
>  
> +
> +/**
> + * Let clients look up files.  Always return ENOENT because we only
> + * care about the mountpoint itself.
> + */
> +static void fuse_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
> +{
> +    fuse_reply_err(req, ENOENT);
> +}
> +
> +/**
> + * Let clients get file attributes (i.e., stat() the file).
> + */
> +static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
> +                         struct fuse_file_info *fi)
> +{
> +    struct stat statbuf;
> +    int64_t length, allocated_blocks;
> +    time_t now = time(NULL);
> +    ImageInfo *info = NULL;
> +    FuseExport *exp = fuse_req_userdata(req);
> +    mode_t mode;
> +    Error *local_error = NULL;
> +
> +    length = blk_getlength(exp->common.blk);
> +    if (length < 0) {
> +        fuse_reply_err(req, -length);
> +        return;
> +    }
> +
> +    bdrv_query_image_info(blk_bs(exp->common.blk), &info, &local_error);
> +    if (local_error) {
> +        allocated_blocks = DIV_ROUND_UP(length, 512);
> +    } else {
> +        allocated_blocks = DIV_ROUND_UP(info->actual_size, 512);
> +    }
> +
> +    qapi_free_ImageInfo(info);
> +    error_free(local_error);
> +    local_error = NULL;

If you only use info->actual_size, why not directly call
bdrv_get_allocated_file_size()?

> +
> +    mode = S_IFREG | S_IRUSR;
> +    if (exp->writable) {
> +        mode |= S_IWUSR;
> +    }
> +
> +    statbuf = (struct stat) {
> +        .st_ino     = inode,
> +        .st_mode    = mode,
> +        .st_nlink   = 1,
> +        .st_uid     = getuid(),
> +        .st_gid     = getgid(),
> +        .st_size    = length,
> +        .st_blksize = blk_bs(exp->common.blk)->bl.request_alignment,
> +        .st_blocks  = allocated_blocks,
> +        .st_atime   = now,
> +        .st_mtime   = now,
> +        .st_ctime   = now,
> +    };
> +
> +    fuse_reply_attr(req, &statbuf, 1.);
> +}
> +
> +static int fuse_do_truncate(const FuseExport *exp, int64_t size,
> +                            PreallocMode prealloc)
> +{
> +    uint64_t blk_perm, blk_shared_perm;
> +    int ret;
> +
> +    blk_get_perm(exp->common.blk, &blk_perm, &blk_shared_perm);
> +
> +    ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
> +                       blk_shared_perm, NULL);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = blk_truncate(exp->common.blk, size, true, prealloc, 0, NULL);
> +
> +    /* Must succeed, because we are only giving up the RESIZE permission */
> +    blk_set_perm(exp->common.blk, blk_perm, blk_shared_perm, &error_abort);
> +
> +    return ret;
> +}
> +
> +/**
> + * Let clients set file attributes.  Only resizing is supported.
> + */
> +static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
> +                         int to_set, struct fuse_file_info *fi)
> +{
> +    FuseExport *exp = fuse_req_userdata(req);
> +    int ret;
> +
> +    if (!exp->writable) {
> +        fuse_reply_err(req, EACCES);
> +        return;
> +    }
> +
> +    if (to_set & ~FUSE_SET_ATTR_SIZE) {
> +        fuse_reply_err(req, ENOTSUP);
> +        return;
> +    }
> +
> +    ret = fuse_do_truncate(exp, statbuf->st_size, PREALLOC_MODE_OFF);
> +    if (ret < 0) {
> +        fuse_reply_err(req, -ret);
> +        return;
> +    }
> +
> +    fuse_getattr(req, inode, fi);
> +}
> +
> +/**
> + * Let clients open a file (i.e., the exported image).
> + */
> +static void fuse_open(fuse_req_t req, fuse_ino_t inode,
> +                      struct fuse_file_info *fi)
> +{
> +    fuse_reply_open(req, fi);
> +}
> +
> +/**
> + * Handle client reads from the exported image.
> + */
> +static void fuse_read(fuse_req_t req, fuse_ino_t inode,
> +                      size_t size, off_t offset, struct fuse_file_info *fi)
> +{
> +    FuseExport *exp = fuse_req_userdata(req);
> +    int64_t length;
> +    void *buf;
> +    int ret;
> +
> +    /**
> +     * Clients will expect short reads at EOF, so we have to limit
> +     * offset+size to the image length.
> +     */
> +    length = blk_getlength(exp->common.blk);
> +    if (length < 0) {
> +        fuse_reply_err(req, -length);
> +        return;
> +    }
> +
> +    size = MIN(size, FUSE_MAX_BOUNCE_BYTES);

"Read should send exactly the number of bytes requested except on EOF or
error, otherwise the rest of the data will be substituted with zeroes."

Do we corrupt huge reads with this, so that read() succeeds, but the
buffer is zeroed above 64M instead of containing the correct data? Maybe
we should return an error instead?

(It's kind of sad that we need a bounce buffer from which data is later
copied instead of being provided the right memory by the kernel.)

> +    if (offset + size > length) {
> +        size = length - offset;
> +    }
> +
> +    buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
> +    if (!buf) {
> +        fuse_reply_err(req, ENOMEM);
> +        return;
> +    }
> +
> +    ret = blk_pread(exp->common.blk, offset, buf, size);
> +    if (ret >= 0) {
> +        fuse_reply_buf(req, buf, size);
> +    } else {
> +        fuse_reply_err(req, -ret);
> +    }
> +
> +    qemu_vfree(buf);
> +}
> +
> +/**
> + * Handle client writes to the exported image.
> + */
> +static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
> +                       size_t size, off_t offset, struct fuse_file_info *fi)
> +{
> +    FuseExport *exp = fuse_req_userdata(req);
> +    int64_t length;
> +    int ret;
> +
> +    if (!exp->writable) {
> +        fuse_reply_err(req, EACCES);
> +        return;
> +    }
> +
> +    /**
> +     * Clients will expect short writes at EOF, so we have to limit
> +     * offset+size to the image length.
> +     */
> +    length = blk_getlength(exp->common.blk);
> +    if (length < 0) {
> +        fuse_reply_err(req, -length);
> +        return;
> +    }
> +
> +    size = MIN(size, BDRV_REQUEST_MAX_BYTES);

We're only supposed to do short writes on EOF, so this has a similar
problem as in fuse_read, except that BDRV_REQUEST_MAX_BYTES is much
higher and it's not specified what the resulting misbehaviour could be
(possibly the kernel not retrying write for the rest of the buffer?)

> +    if (offset + size > length) {
> +        size = length - offset;
> +    }
> +
> +    ret = blk_pwrite(exp->common.blk, offset, buf, size, 0);
> +    if (ret >= 0) {
> +        fuse_reply_write(req, size);
> +    } else {
> +        fuse_reply_err(req, -ret);
> +    }
> +}
> +
> +/**
> + * Let clients flush the exported image.
> + */
> +static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
> +                       struct fuse_file_info *fi)
> +{
> +    FuseExport *exp = fuse_req_userdata(req);
> +    int ret;
> +
> +    ret = blk_flush(exp->common.blk);
> +    fuse_reply_err(req, ret < 0 ? -ret : 0);
> +}

This seems to be an implementation for .fsync rather than for .flush.

Hmm, or maybe actually for both? We usually do bdrv_flush() during
close, so it would be consistent to do the same here. It's our last
chance to report an error to the user before the file is closed.

>  static const struct fuse_lowlevel_ops fuse_ops = {
> +    .lookup     = fuse_lookup,
> +    .getattr    = fuse_getattr,
> +    .setattr    = fuse_setattr,
> +    .open       = fuse_open,
> +    .read       = fuse_read,
> +    .write      = fuse_write,
> +    .flush      = fuse_flush,
>  };

Kevin


