Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D603DC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 22:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890D321582
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 22:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVYNVedJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890D321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isaC6-0006FY-Ko
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 17:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1isaA4-00059e-CN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 17:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1isaA2-0000uo-K5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 17:32:16 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1isaA2-0000uI-Eb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 17:32:14 -0500
Received: by mail-qt1-x842.google.com with SMTP id c24so12235132qtp.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 14:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uxvwmC9Ti/VrjWwjYNWerN2MykrSlGzoAjuozmlLVRQ=;
 b=UVYNVedJcvaxehdaP0uBp7dTjoM4ttOBQ0tVrAFoEDCQhlAMKRZqqsl8JpEU6vjxf0
 sP1PwNnCY/gJeuG02QN4fF8a9aWEoycSSBiDPPc0+POdMvyPVTPcf61Ck05ceAIwh4Lq
 5mFGQDxAoeVXqQ5lrPUqcL8n0FQ7i3t2/YEpgod/9yGJO2LKOFYiRnK4F2XRhFXJLaUd
 NUHfDzvH0Cyi8wjNcvP2JVFd7E0G5PJ5Acm6ce34n63pZUvLW0ohZGZguH8fsyB8VOfM
 uBofIRDBfGLScIgD2/DHMBMYapl4MyQ0PHn3s9+fvMPSidTvwlFSERJm77qYdv4tZw/F
 mpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uxvwmC9Ti/VrjWwjYNWerN2MykrSlGzoAjuozmlLVRQ=;
 b=i2hxlEqaniXJtk+hGG/X3eDo+RqHaXypWYv32WJRS9pMyhqel4sdzkECzvRLKtBIQk
 lgE+NzI0oP0ZXhYNr8UwPs1zp4Irpqh0/6Hrq393DQD7bQ7KGwin7UAQbaC13Hfo0rPg
 HIBlyfB/H48B+22gYSPFT9HzggAOry0Z+V0OWEbjRG9sJTu6UMX7BO6z2NxCi8xZyNME
 VMjq1yRtqdfxIyh4iAtcT+3vUYbKeAh3tQS3usdhFHIYO0lUyvpEYrZlIE2VdffvKnl0
 SiSYnCOC+8qFB+Wwp3J4s1BwRUId4p1zs/D1GG3JHRkIAMV6uhUv6AF+jQHI+bDtTuD1
 hZ6g==
X-Gm-Message-State: APjAAAU8axE4UsqukiN2dwejC0FY6JKdcYsVS2uQR9nnqY3XayUZnVPk
 OoEpdhZqsiEedBc4jkPdYQ==
X-Google-Smtp-Source: APXvYqxFrnRbbugPvQXekAoIFbfYgeRyYexQ7yYzJOjBw/UlK1UZirQJ8M1OjA68317aR/EaI393hA==
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr9641639qtt.257.1579300333628; 
 Fri, 17 Jan 2020 14:32:13 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id r205sm12476487qke.34.2020.01.17.14.32.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 14:32:13 -0800 (PST)
Date: Fri, 17 Jan 2020 17:32:08 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 036/104] virtiofsd: passthrough_ll: add fd_map to hide
 file descriptors
Message-ID: <20200117223208.kvk7n5mqiq7ztnvr@gabell>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-37-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212163904.159893-37-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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

On Thu, Dec 12, 2019 at 04:37:56PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Do not expose file descriptor numbers to clients.  This prevents the
> abuse of internal file descriptors (like stdin/stdout).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> dgilbert:
>   Added lseek
> ---
>  tools/virtiofsd/passthrough_ll.c | 114 +++++++++++++++++++++++++------
>  1 file changed, 93 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index face8910b0..93e74cce21 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -60,6 +60,7 @@ struct lo_map_elem {
>      union {
>          struct lo_inode *inode;
>          struct lo_dirp *dirp;
> +        int fd;
>          ssize_t freelist;
>      };
>      bool in_use;
> @@ -107,6 +108,7 @@ struct lo_data {
>      struct lo_inode root; /* protected by lo->mutex */
>      struct lo_map ino_map; /* protected by lo->mutex */
>      struct lo_map dirp_map; /* protected by lo->mutex */
> +    struct lo_map fd_map; /* protected by lo->mutex */
>  };
>  
>  static const struct fuse_opt lo_opts[] = {
> @@ -236,6 +238,20 @@ static void lo_map_remove(struct lo_map *map, size_t key)
>      map->freelist = key;
>  }
>  
> +/* Assumes lo->mutex is held */
> +static ssize_t lo_add_fd_mapping(fuse_req_t req, int fd)
> +{
> +    struct lo_map_elem *elem;
> +
> +    elem = lo_map_alloc_elem(&lo_data(req)->fd_map);
> +    if (!elem) {
> +        return -1;
> +    }
> +
> +    elem->fd = fd;
> +    return elem - lo_data(req)->fd_map.elems;
> +}
> +
>  /* Assumes lo->mutex is held */
>  static ssize_t lo_add_dirp_mapping(fuse_req_t req, struct lo_dirp *dirp)
>  {
> @@ -350,6 +366,22 @@ static int utimensat_empty_nofollow(struct lo_inode *inode,
>      return utimensat(AT_FDCWD, procname, tv, 0);
>  }
>  
> +static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
> +{
> +    struct lo_data *lo = lo_data(req);
> +    struct lo_map_elem *elem;
> +
> +    pthread_mutex_lock(&lo->mutex);
> +    elem = lo_map_get(&lo->fd_map, fi->fh);
> +    pthread_mutex_unlock(&lo->mutex);
> +
> +    if (!elem) {
> +        return -1;
> +    }
> +
> +    return elem->fd;
> +}
> +
>  static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>                         int valid, struct fuse_file_info *fi)
>  {
> @@ -358,6 +390,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>      struct lo_inode *inode;
>      int ifd;
>      int res;
> +    int fd;
>  
>      inode = lo_inode(req, ino);
>      if (!inode) {
> @@ -367,9 +400,14 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>  
>      ifd = inode->fd;
>  
> +    /* If fi->fh is invalid we'll report EBADF later */
> +    if (fi) {
> +        fd = lo_fi_fd(req, fi);
> +    }
> +
>      if (valid & FUSE_SET_ATTR_MODE) {
>          if (fi) {
> -            res = fchmod(fi->fh, attr->st_mode);
> +            res = fchmod(fd, attr->st_mode);
>          } else {
>              sprintf(procname, "/proc/self/fd/%i", ifd);
>              res = chmod(procname, attr->st_mode);
> @@ -389,7 +427,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>      }
>      if (valid & FUSE_SET_ATTR_SIZE) {
>          if (fi) {
> -            res = ftruncate(fi->fh, attr->st_size);
> +            res = ftruncate(fd, attr->st_size);
>          } else {
>              sprintf(procname, "/proc/self/fd/%i", ifd);
>              res = truncate(procname, attr->st_size);
> @@ -419,7 +457,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>          }
>  
>          if (fi) {
> -            res = futimens(fi->fh, tv);
> +            res = futimens(fd, tv);
>          } else {
>              res = utimensat_empty_nofollow(inode, tv);
>          }
> @@ -1079,7 +1117,18 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
>      lo_restore_cred(&old);
>  
>      if (!err) {
> -        fi->fh = fd;
> +        ssize_t fh;
> +
> +        pthread_mutex_lock(&lo->mutex);
> +        fh = lo_add_fd_mapping(req, fd);
> +        pthread_mutex_unlock(&lo->mutex);
> +        if (fh == -1) {
> +            close(fd);
> +            fuse_reply_err(req, ENOMEM);
> +            return;
> +        }
> +
> +        fi->fh = fh;
>          err = lo_do_lookup(req, parent, name, &e);
>      }
>      if (lo->cache == CACHE_NEVER) {
> @@ -1123,6 +1172,7 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
>  static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>  {
>      int fd;
> +    ssize_t fh;
>      char buf[64];
>      struct lo_data *lo = lo_data(req);
>  
> @@ -1158,7 +1208,16 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>          return (void)fuse_reply_err(req, errno);
>      }
>  
> -    fi->fh = fd;
> +    pthread_mutex_lock(&lo->mutex);
> +    fh = lo_add_fd_mapping(req, fd);
> +    pthread_mutex_unlock(&lo->mutex);
> +    if (fh == -1) {
> +        close(fd);
> +        fuse_reply_err(req, ENOMEM);
> +        return;
> +    }
> +
> +    fi->fh = fh;
>      if (lo->cache == CACHE_NEVER) {
>          fi->direct_io = 1;
>      } else if (lo->cache == CACHE_ALWAYS) {
> @@ -1170,9 +1229,18 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>  static void lo_release(fuse_req_t req, fuse_ino_t ino,
>                         struct fuse_file_info *fi)
>  {
> +    struct lo_data *lo = lo_data(req);
> +    int fd;
> +
>      (void)ino;
>  
> -    close(fi->fh);
> +    fd = lo_fi_fd(req, fi);
> +
> +    pthread_mutex_lock(&lo->mutex);
> +    lo_map_remove(&lo->fd_map, fi->fh);
> +    pthread_mutex_unlock(&lo->mutex);
> +
> +    close(fd);
>      fuse_reply_err(req, 0);
>  }
>  
> @@ -1180,7 +1248,7 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>  {
>      int res;
>      (void)ino;
> -    res = close(dup(fi->fh));
> +    res = close(dup(lo_fi_fd(req, fi)));
>      fuse_reply_err(req, res == -1 ? errno : 0);
>  }
>  
> @@ -1207,7 +1275,7 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
>              return (void)fuse_reply_err(req, errno);
>          }
>      } else {
> -        fd = fi->fh;
> +        fd = lo_fi_fd(req, fi);
>      }
>  
>      if (datasync) {
> @@ -1234,7 +1302,7 @@ static void lo_read(fuse_req_t req, fuse_ino_t ino, size_t size, off_t offset,
>      }
>  
>      buf.buf[0].flags = FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
> -    buf.buf[0].fd = fi->fh;
> +    buf.buf[0].fd = lo_fi_fd(req, fi);
>      buf.buf[0].pos = offset;
>  
>      fuse_reply_data(req, &buf, FUSE_BUF_SPLICE_MOVE);
> @@ -1249,7 +1317,7 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
>      struct fuse_bufvec out_buf = FUSE_BUFVEC_INIT(fuse_buf_size(in_buf));
>  
>      out_buf.buf[0].flags = FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
> -    out_buf.buf[0].fd = fi->fh;
> +    out_buf.buf[0].fd = lo_fi_fd(req, fi);
>      out_buf.buf[0].pos = off;
>  
>      if (lo_debug(req)) {
> @@ -1297,7 +1365,7 @@ static void lo_fallocate(fuse_req_t req, fuse_ino_t ino, int mode, off_t offset,
>          return;
>      }
>  
> -    err = posix_fallocate(fi->fh, offset, length);
> +    err = posix_fallocate(lo_fi_fd(req, fi), offset, length);
>  #endif
>  
>      fuse_reply_err(req, err);
> @@ -1309,7 +1377,7 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi,
>      int res;
>      (void)ino;
>  
> -    res = flock(fi->fh, op);
> +    res = flock(lo_fi_fd(req, fi), op);
>  
>      fuse_reply_err(req, res == -1 ? errno : 0);
>  }
> @@ -1534,17 +1602,19 @@ static void lo_copy_file_range(fuse_req_t req, fuse_ino_t ino_in, off_t off_in,
>                                 off_t off_out, struct fuse_file_info *fi_out,
>                                 size_t len, int flags)
>  {
> +    int in_fd, out_fd;
>      ssize_t res;
>  
> -    if (lo_debug(req))
> -        fuse_log(FUSE_LOG_DEBUG,
> -                 "lo_copy_file_range(ino=%" PRIu64 "/fd=%lu, "
> -                 "off=%lu, ino=%" PRIu64 "/fd=%lu, "
> -                 "off=%lu, size=%zd, flags=0x%x)\n",
> -                 ino_in, fi_in->fh, off_in, ino_out, fi_out->fh, off_out, len,
> -                 flags);
> +    in_fd = lo_fi_fd(req, fi_in);
> +    out_fd = lo_fi_fd(req, fi_out);
> +
> +    fuse_log(FUSE_LOG_DEBUG,
> +             "lo_copy_file_range(ino=%" PRIu64 "/fd=%d, "
> +             "off=%lu, ino=%" PRIu64 "/fd=%d, "
> +             "off=%lu, size=%zd, flags=0x%x)\n",
> +             ino_in, in_fd, off_in, ino_out, out_fd, off_out, len, flags);
>  
> -    res = copy_file_range(fi_in->fh, &off_in, fi_out->fh, &off_out, len, flags);
> +    res = copy_file_range(in_fd, &off_in, out_fd, &off_out, len, flags);
>      if (res < 0) {
>          fuse_reply_err(req, -errno);
>      } else {
> @@ -1559,7 +1629,7 @@ static void lo_lseek(fuse_req_t req, fuse_ino_t ino, off_t off, int whence,
>      off_t res;
>  
>      (void)ino;
> -    res = lseek(fi->fh, off, whence);
> +    res = lseek(lo_fi_fd(req, fi), off, whence);
>      if (res != -1) {
>          fuse_reply_lseek(req, res);
>      } else {
> @@ -1644,6 +1714,7 @@ int main(int argc, char *argv[])
>      root_elem->inode = &lo.root;
>  
>      lo_map_init(&lo.dirp_map);
> +    lo_map_init(&lo.fd_map);
>  
>      if (fuse_parse_cmdline(&args, &opts) != 0) {
>          return 1;
> @@ -1741,6 +1812,7 @@ err_out2:
>  err_out1:
>      fuse_opt_free_args(&args);
>  
> +    lo_map_destroy(&lo.fd_map);
>      lo_map_destroy(&lo.dirp_map);
>      lo_map_destroy(&lo.ino_map);
>  
> -- 

Looks good to me.

Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

