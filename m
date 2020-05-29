Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F067CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 19:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF39820723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 19:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhtWsy75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF39820723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jekUu-0004Zf-SD
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 15:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jekTv-00044s-G0
 for qemu-devel@nongnu.org; Fri, 29 May 2020 15:15:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jekTt-0002qR-OU
 for qemu-devel@nongnu.org; Fri, 29 May 2020 15:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590779748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ni2SCCER3UNGWqfqa279zkhyG843/oQGODL5vhgL0s=;
 b=KhtWsy75vIjGp/XP/FrJshiN6EF6ppARwZb0U+I3gyVxc1zJShglTY9RbphnfMG3CPuj+m
 gt6vksA8WhlPm6WCaY7ASVmU+5OwJDi/RMMpHSAqFq65aLKdifbZTM6oCd6TfqSFzDcIjy
 7wOK6UVlT8ToodiVCnk2T3Ug0H32PfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-isZ4bk4sOc-S1ndJSF0nHg-1; Fri, 29 May 2020 15:15:45 -0400
X-MC-Unique: isZ4bk4sOc-S1ndJSF0nHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FD51872FE4
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 19:15:44 +0000 (UTC)
Received: from work-vm (ovpn-113-111.ams2.redhat.com [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC7F610013C2;
 Fri, 29 May 2020 19:15:40 +0000 (UTC)
Date: Fri, 29 May 2020 20:15:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: remove symlink fallbacks
Message-ID: <20200529191538.GS2856@work-vm>
References: <20200514140736.20561-1-mszeredi@redhat.com>
 <20200515141057.GB235744@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200515141057.GB235744@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 15:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> On Thu, May 14, 2020 at 04:07:36PM +0200, Miklos Szeredi wrote:
> > Path lookup in the kernel has special rules for looking up magic symlinks
> > under /proc.  If a filesystem operation is instructed to follow symlinks
> > (e.g. via AT_SYMLINK_FOLLOW or lack of AT_SYMLINK_NOFOLLOW), and the final
> > component is such a proc symlink, then the target of the magic symlink is
> > used for the operation, even if the target itself is a symlink.  I.e. path
> > lookup is always terminated after following a final magic symlink.
> > 
> > I was erronously assuming that in the above case the target symlink would
> > also be followed, and so workarounds were added for a couple of operations
> > to handle the symlink case.  Since the symlink can be handled simply by
> > following the proc symlink, these workardouds are not needed.
> > 
> > Also remove the "norace" option, which disabled the workarounds.
> > 
> > Commit bdfd66788349 ("virtiofsd: Fix xattr operations") already dealt with
> > the same issue for xattr operations.
> > 
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> Good to have this cleanup.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Queued.

> Vivek
> 
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 175 ++-----------------------------
> >  1 file changed, 6 insertions(+), 169 deletions(-)
> > 
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> > index 3ba1d9098460..2ce7c96085bf 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -140,7 +140,6 @@ enum {
> >  struct lo_data {
> >      pthread_mutex_t mutex;
> >      int debug;
> > -    int norace;
> >      int writeback;
> >      int flock;
> >      int posix_lock;
> > @@ -176,7 +175,6 @@ static const struct fuse_opt lo_opts[] = {
> >      { "cache=none", offsetof(struct lo_data, cache), CACHE_NONE },
> >      { "cache=auto", offsetof(struct lo_data, cache), CACHE_AUTO },
> >      { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
> > -    { "norace", offsetof(struct lo_data, norace), 1 },
> >      { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
> >      { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
> >      FUSE_OPT_END
> > @@ -592,136 +590,6 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
> >      fuse_reply_attr(req, &buf, lo->timeout);
> >  }
> >  
> > -/*
> > - * Increments parent->nlookup and caller must release refcount using
> > - * lo_inode_put(&parent).
> > - */
> > -static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *inode,
> > -                              char path[PATH_MAX], struct lo_inode **parent)
> > -{
> > -    char procname[64];
> > -    char *last;
> > -    struct stat stat;
> > -    struct lo_inode *p;
> > -    int retries = 2;
> > -    int res;
> > -
> > -retry:
> > -    sprintf(procname, "%i", inode->fd);
> > -
> > -    res = readlinkat(lo->proc_self_fd, procname, path, PATH_MAX);
> > -    if (res < 0) {
> > -        fuse_log(FUSE_LOG_WARNING, "%s: readlink failed: %m\n", __func__);
> > -        goto fail_noretry;
> > -    }
> > -
> > -    if (res >= PATH_MAX) {
> > -        fuse_log(FUSE_LOG_WARNING, "%s: readlink overflowed\n", __func__);
> > -        goto fail_noretry;
> > -    }
> > -    path[res] = '\0';
> > -
> > -    last = strrchr(path, '/');
> > -    if (last == NULL) {
> > -        /* Shouldn't happen */
> > -        fuse_log(
> > -            FUSE_LOG_WARNING,
> > -            "%s: INTERNAL ERROR: bad path read from proc\n", __func__);
> > -        goto fail_noretry;
> > -    }
> > -    if (last == path) {
> > -        p = &lo->root;
> > -        pthread_mutex_lock(&lo->mutex);
> > -        p->nlookup++;
> > -        g_atomic_int_inc(&p->refcount);
> > -        pthread_mutex_unlock(&lo->mutex);
> > -    } else {
> > -        *last = '\0';
> > -        res = fstatat(AT_FDCWD, last == path ? "/" : path, &stat, 0);
> > -        if (res == -1) {
> > -            if (!retries) {
> > -                fuse_log(FUSE_LOG_WARNING,
> > -                         "%s: failed to stat parent: %m\n", __func__);
> > -            }
> > -            goto fail;
> > -        }
> > -        p = lo_find(lo, &stat);
> > -        if (p == NULL) {
> > -            if (!retries) {
> > -                fuse_log(FUSE_LOG_WARNING,
> > -                         "%s: failed to find parent\n", __func__);
> > -            }
> > -            goto fail;
> > -        }
> > -    }
> > -    last++;
> > -    res = fstatat(p->fd, last, &stat, AT_SYMLINK_NOFOLLOW);
> > -    if (res == -1) {
> > -        if (!retries) {
> > -            fuse_log(FUSE_LOG_WARNING,
> > -                     "%s: failed to stat last\n", __func__);
> > -        }
> > -        goto fail_unref;
> > -    }
> > -    if (stat.st_dev != inode->key.dev || stat.st_ino != inode->key.ino) {
> > -        if (!retries) {
> > -            fuse_log(FUSE_LOG_WARNING,
> > -                     "%s: failed to match last\n", __func__);
> > -        }
> > -        goto fail_unref;
> > -    }
> > -    *parent = p;
> > -    memmove(path, last, strlen(last) + 1);
> > -
> > -    return 0;
> > -
> > -fail_unref:
> > -    unref_inode_lolocked(lo, p, 1);
> > -    lo_inode_put(lo, &p);
> > -fail:
> > -    if (retries) {
> > -        retries--;
> > -        goto retry;
> > -    }
> > -fail_noretry:
> > -    errno = EIO;
> > -    return -1;
> > -}
> > -
> > -static int utimensat_empty(struct lo_data *lo, struct lo_inode *inode,
> > -                           const struct timespec *tv)
> > -{
> > -    int res;
> > -    struct lo_inode *parent;
> > -    char path[PATH_MAX];
> > -
> > -    if (S_ISLNK(inode->filetype)) {
> > -        res = utimensat(inode->fd, "", tv, AT_EMPTY_PATH);
> > -        if (res == -1 && errno == EINVAL) {
> > -            /* Sorry, no race free way to set times on symlink. */
> > -            if (lo->norace) {
> > -                errno = EPERM;
> > -            } else {
> > -                goto fallback;
> > -            }
> > -        }
> > -        return res;
> > -    }
> > -    sprintf(path, "%i", inode->fd);
> > -
> > -    return utimensat(lo->proc_self_fd, path, tv, 0);
> > -
> > -fallback:
> > -    res = lo_parent_and_name(lo, inode, path, &parent);
> > -    if (res != -1) {
> > -        res = utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
> > -        unref_inode_lolocked(lo, parent, 1);
> > -        lo_inode_put(lo, &parent);
> > -    }
> > -
> > -    return res;
> > -}
> > -
> >  static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
> >  {
> >      struct lo_data *lo = lo_data(req);
> > @@ -828,7 +696,8 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
> >          if (fi) {
> >              res = futimens(fd, tv);
> >          } else {
> > -            res = utimensat_empty(lo, inode, tv);
> > +            sprintf(procname, "%i", inode->fd);
> > +            res = utimensat(lo->proc_self_fd, procname, tv, 0);
> >          }
> >          if (res == -1) {
> >              goto out_err;
> > @@ -1129,41 +998,6 @@ static void lo_symlink(fuse_req_t req, const char *link, fuse_ino_t parent,
> >      lo_mknod_symlink(req, parent, name, S_IFLNK, 0, link);
> >  }
> >  
> > -static int linkat_empty_nofollow(struct lo_data *lo, struct lo_inode *inode,
> > -                                 int dfd, const char *name)
> > -{
> > -    int res;
> > -    struct lo_inode *parent;
> > -    char path[PATH_MAX];
> > -
> > -    if (S_ISLNK(inode->filetype)) {
> > -        res = linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
> > -        if (res == -1 && (errno == ENOENT || errno == EINVAL)) {
> > -            /* Sorry, no race free way to hard-link a symlink. */
> > -            if (lo->norace) {
> > -                errno = EPERM;
> > -            } else {
> > -                goto fallback;
> > -            }
> > -        }
> > -        return res;
> > -    }
> > -
> > -    sprintf(path, "%i", inode->fd);
> > -
> > -    return linkat(lo->proc_self_fd, path, dfd, name, AT_SYMLINK_FOLLOW);
> > -
> > -fallback:
> > -    res = lo_parent_and_name(lo, inode, path, &parent);
> > -    if (res != -1) {
> > -        res = linkat(parent->fd, path, dfd, name, 0);
> > -        unref_inode_lolocked(lo, parent, 1);
> > -        lo_inode_put(lo, &parent);
> > -    }
> > -
> > -    return res;
> > -}
> > -
> >  static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
> >                      const char *name)
> >  {
> > @@ -1172,6 +1006,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
> >      struct lo_inode *parent_inode;
> >      struct lo_inode *inode;
> >      struct fuse_entry_param e;
> > +    char procname[64];
> >      int saverr;
> >  
> >      if (!is_safe_path_component(name)) {
> > @@ -1190,7 +1025,9 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
> >      e.attr_timeout = lo->timeout;
> >      e.entry_timeout = lo->timeout;
> >  
> > -    res = linkat_empty_nofollow(lo, inode, parent_inode->fd, name);
> > +    sprintf(procname, "%i", inode->fd);
> > +    res = linkat(lo->proc_self_fd, procname, parent_inode->fd, name,
> > +                 AT_SYMLINK_FOLLOW);
> >      if (res == -1) {
> >          goto out_err;
> >      }
> > -- 
> > 2.21.1
> > 
> > _______________________________________________
> > Virtio-fs mailing list
> > Virtio-fs@redhat.com
> > https://www.redhat.com/mailman/listinfo/virtio-fs
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


