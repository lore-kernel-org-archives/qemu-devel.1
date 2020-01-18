Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF74DC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FC72468C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbyPegBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FC72468C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isqt7-0005Ev-Kl
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 11:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1isqsO-0004l6-8R
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1isqsM-0006ob-JM
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:23:08 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1isqsM-0006oJ-DT
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:23:06 -0500
Received: by mail-qk1-x741.google.com with SMTP id x1so25859523qkl.12
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Gx9tiPr0ZfW8neO3Gt8oCD59DOYqym2Uv1ACtnuZYUg=;
 b=MbyPegBVTSJKexdmG1RBVx54QHqOa2dKQ+4QgFnndP4XPXCw6vNABpVYzs+snvW57N
 9EK3MYph9rco/7E+G/fvOv47tIs12ayAN4l6k6MhRtPoBjPmy2wqfMGYVXXIYcl689+c
 6pezWwnmVv8PUJueyGQjkkAkNYWR/WAo1crCm7VCQiXwP3C9fVfRvRSZwdzfOQ3gZfOC
 KDCaj+3IzviVzyVQP+iqQpll/Pr0JpvMSjtqzYB0pAMVDtTTGpn8qBPQvUokcnFfMnRe
 BNwjldf9vCUAIeCLac/CJEtTwvWbnoHmI1EQNT6ZcUNsl+L3efgskADj+P8rc2ROsXzf
 8a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gx9tiPr0ZfW8neO3Gt8oCD59DOYqym2Uv1ACtnuZYUg=;
 b=lawzjzHpl3ilBm8pmuJCfLT8lvUPM85LcMbNy9E+DgSVXyTBpuadTnYGvNIK0R69KO
 cOhcwZRczmFQ3Km50REM3ZtH+dxfZVbn2ii6AyGQb4U9JnEhwMSijrLqEJoMzRUnJYvy
 mG2DdX1XS0Q9Exe0hWYXAZkX9V2AUec8RYYvJpxhLHSHH3Fwpq6oTwqfYCh1Xux1FIQW
 7bwRcKfxZCCAjbePDe7iUB1T4eyVs4zQ42Q64D7c2ykmv3yF0yofdMs0PcvunW+2Q6dR
 IE0ZaoT24s3Bd7nzEoB7K1aoct1JGoJ5uALJ6HCzELEUoWtuLPaekSF7P3a4PJn1t1eX
 SHRw==
X-Gm-Message-State: APjAAAXDZxDG5AHFTrF+d/807v1sVS6Jzjg7ZTWhOo+yNXroEyfvfRaS
 v3xoWYo2j2ZAF3nJILMGxQ==
X-Google-Smtp-Source: APXvYqxPeoBLRNdYtu+oip/EMB7bcc/2yKf72WuCAKvEkYhq5eADm88l6dkd92/563W3C8ryBERbEw==
X-Received: by 2002:ae9:f009:: with SMTP id l9mr43085707qkg.259.1579364585690; 
 Sat, 18 Jan 2020 08:23:05 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id r37sm14732369qtj.44.2020.01.18.08.23.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 18 Jan 2020 08:23:04 -0800 (PST)
Date: Sat, 18 Jan 2020 11:22:59 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 037/104] virtiofsd: passthrough_ll: add fallback for racy
 ops
Message-ID: <20200118162259.t5rawdrjgf6t7hjz@gabell>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-38-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212163904.159893-38-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

On Thu, Dec 12, 2019 at 04:37:57PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> We have two operations that cannot be done race-free on a symlink in
> certain cases: utimes and link.
> 
> Add racy fallback for these if the race-free method doesn't work.  We do
> our best to avoid races even in this case:
> 
>   - get absolute path by reading /proc/self/fd/NN symlink
> 
>   - lookup parent directory: after this we are safe against renames in
>     ancestors
> 
>   - lookup name in parent directory, and verify that we got to the original
>     inode,  if not retry the whole thing
> 
> Both utimes(2) and link(2) hold i_lock on the inode across the operation,
> so a racing rename/delete by this fuse instance is not possible, only from
> other entities changing the filesystem.
> 
> If the "norace" option is given, then disable the racy fallbacks.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 159 +++++++++++++++++++++++++++----
>  1 file changed, 142 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 93e74cce21..1faae2753f 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -98,6 +98,7 @@ enum {
>  struct lo_data {
>      pthread_mutex_t mutex;
>      int debug;
> +    int norace;
>      int writeback;
>      int flock;
>      int xattr;
> @@ -124,10 +125,15 @@ static const struct fuse_opt lo_opts[] = {
>      { "cache=never", offsetof(struct lo_data, cache), CACHE_NEVER },
>      { "cache=auto", offsetof(struct lo_data, cache), CACHE_NORMAL },
>      { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
> -
> +    { "norace", offsetof(struct lo_data, norace), 1 },
>      FUSE_OPT_END
>  };
>  
> +static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64_t n);
> +
> +static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st);
> +
> +
>  static struct lo_data *lo_data(fuse_req_t req)
>  {
>      return (struct lo_data *)fuse_req_userdata(req);
> @@ -347,23 +353,127 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
>      fuse_reply_attr(req, &buf, lo->timeout);
>  }
>  > -static int utimensat_empty_nofollow(struct lo_inode *inode,
> -                                    const struct timespec *tv)
> +static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *inode,
> +                              char path[PATH_MAX], struct lo_inode **parent)
>  {
> -    int res;
>      char procname[64];
> +    char *last;
> +    struct stat stat;
> +    struct lo_inode *p;
> +    int retries = 2;
> +    int res;
> +
> +retry:
> +    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> +
> +    res = readlink(procname, path, PATH_MAX);
> +    if (res < 0) {

> +        fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink failed: %m\n");

I think it's better to use __func__ macro in case the function name is
changed in the future.

           fuse_log(FUSE_LOG_WARNING, "%s: readlink failed: %m\n", __func__);

> +        goto fail_noretry;
> +    }
> +
> +    if (res >= PATH_MAX) {

> +        fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink overflowed\n");

           fuse_log(FUSE_LOG_WARNING, "%s: readlink overflowed\n", __func__);

> +        goto fail_noretry;
> +    }
> +    path[res] = '\0';
> +
> +    last = strrchr(path, '/');
> +    if (last == NULL) {
> +        /* Shouldn't happen */

> +        fuse_log(
> +            FUSE_LOG_WARNING,
> +            "lo_parent_and_name: INTERNAL ERROR: bad path read from proc\n");

           fuse_log(
               FUSE_LOG_WARNING,
            "%s: INTERNAL ERROR: bad path read from proc\n", __func__);

> +        goto fail_noretry;
> +    }
> +    if (last == path) {
> +        p = &lo->root;
> +        pthread_mutex_lock(&lo->mutex);
> +        p->refcount++;
> +        pthread_mutex_unlock(&lo->mutex);
> +    } else {
> +        *last = '\0';
> +        res = fstatat(AT_FDCWD, last == path ? "/" : path, &stat, 0);
> +        if (res == -1) {
> +            if (!retries) {

> +                fuse_log(FUSE_LOG_WARNING,
> +                         "lo_parent_and_name: failed to stat parent: %m\n");

                   fuse_log(FUSE_LOG_WARNING,
                            "%s: failed to stat parent: %m\n", __func__);

> +            }
> +            goto fail;
> +        }
> +        p = lo_find(lo, &stat);
> +        if (p == NULL) {
> +            if (!retries) {

> +                fuse_log(FUSE_LOG_WARNING,
> +                         "lo_parent_and_name: failed to find parent\n");

                   fuse_log(FUSE_LOG_WARNING,
                         "%s: failed to find parent\n", __func__);

> +            }
> +            goto fail;
> +        }
> +    }
> +    last++;
> +    res = fstatat(p->fd, last, &stat, AT_SYMLINK_NOFOLLOW);
> +    if (res == -1) {
> +        if (!retries) {

> +            fuse_log(FUSE_LOG_WARNING,
> +                     "lo_parent_and_name: failed to stat last\n");

               fuse_log(FUSE_LOG_WARNING,
                     "%s: failed to stat last\n", __func__);

> +        }
> +        goto fail_unref;
> +    }
> +    if (stat.st_dev != inode->dev || stat.st_ino != inode->ino) {
> +        if (!retries) {

> +            fuse_log(FUSE_LOG_WARNING,
> +                     "lo_parent_and_name: failed to match last\n");

               fuse_log(FUSE_LOG_WARNING,
                        "%s: failed to match last\n", __func__);

> +        }
> +        goto fail_unref;
> +    }
> +    *parent = p;
> +    memmove(path, last, strlen(last) + 1);
> +
> +    return 0;
> +
> +fail_unref:
> +    unref_inode(lo, p, 1);
> +fail:
> +    if (retries) {
> +        retries--;
> +        goto retry;
> +    }
> +fail_noretry:
> +    errno = EIO;
> +    return -1;
> +}
> +
> +static int utimensat_empty(struct lo_data *lo, struct lo_inode *inode,
> +                           const struct timespec *tv)
> +{
> +    int res;
> +    struct lo_inode *parent;
> +    char path[PATH_MAX];
>  
>      if (inode->is_symlink) {
> -        res = utimensat(inode->fd, "", tv, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
> +        res = utimensat(inode->fd, "", tv, AT_EMPTY_PATH);
>          if (res == -1 && errno == EINVAL) {
>              /* Sorry, no race free way to set times on symlink. */
> -            errno = EPERM;
> +            if (lo->norace) {
> +                errno = EPERM;
> +            } else {
> +                goto fallback;
> +            }
>          }
>          return res;
>      }
> -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> +    sprintf(path, "/proc/self/fd/%i", inode->fd);
> +
> +    return utimensat(AT_FDCWD, path, tv, 0);
>  
> -    return utimensat(AT_FDCWD, procname, tv, 0);
> +fallback:
> +    res = lo_parent_and_name(lo, inode, path, &parent);
> +    if (res != -1) {
> +        res = utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
> +        unref_inode(lo, parent, 1);
> +    }
> +
> +    return res;
>  }
>  
>  static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
> @@ -387,6 +497,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>  {
>      int saverr;
>      char procname[64];
> +    struct lo_data *lo = lo_data(req);
>      struct lo_inode *inode;
>      int ifd;
>      int res;
> @@ -459,7 +570,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>          if (fi) {
>              res = futimens(fd, tv);
>          } else {
> -            res = utimensat_empty_nofollow(inode, tv);
> +            res = utimensat_empty(lo, inode, tv);
>          }
>          if (res == -1) {
>              goto out_err;
> @@ -692,24 +803,38 @@ static void lo_symlink(fuse_req_t req, const char *link, fuse_ino_t parent,
>      lo_mknod_symlink(req, parent, name, S_IFLNK, 0, link);
>  }
>  
> -static int linkat_empty_nofollow(struct lo_inode *inode, int dfd,
> -                                 const char *name)
> +static int linkat_empty_nofollow(struct lo_data *lo, struct lo_inode *inode,
> +                                 int dfd, const char *name)
>  {
>      int res;
> -    char procname[64];
> +    struct lo_inode *parent;
> +    char path[PATH_MAX];
>  
>      if (inode->is_symlink) {
>          res = linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
>          if (res == -1 && (errno == ENOENT || errno == EINVAL)) {
>              /* Sorry, no race free way to hard-link a symlink. */
> -            errno = EPERM;
> +            if (lo->norace) {
> +                errno = EPERM;
> +            } else {
> +                goto fallback;
> +            }
>          }
>          return res;
>      }
>  
> -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> +    sprintf(path, "/proc/self/fd/%i", inode->fd);
> +
> +    return linkat(AT_FDCWD, path, dfd, name, AT_SYMLINK_FOLLOW);
> +
> +fallback:
> +    res = lo_parent_and_name(lo, inode, path, &parent);
> +    if (res != -1) {
> +        res = linkat(parent->fd, path, dfd, name, 0);
> +        unref_inode(lo, parent, 1);
> +    }
>  
> -    return linkat(AT_FDCWD, procname, dfd, name, AT_SYMLINK_FOLLOW);
> +    return res;
>  }
>  
>  static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
> @@ -731,7 +856,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
>      e.attr_timeout = lo->timeout;
>      e.entry_timeout = lo->timeout;
>  
> -    res = linkat_empty_nofollow(inode, lo_fd(req, parent), name);
> +    res = linkat_empty_nofollow(lo, inode, lo_fd(req, parent), name);
>      if (res == -1) {
>          goto out_err;
>      }
> @@ -1544,7 +1669,7 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
>      }
>  
>      if (inode->is_symlink) {
> -        /* Sorry, no race free way to setxattr on symlink. */
> +        /* Sorry, no race free way to removexattr on symlink. */
>          saverr = EPERM;
>          goto out;
>      }

Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

