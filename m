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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39800C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F802072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqzi/J7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F802072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isZSD-0007QY-Ug
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 16:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1isZRA-0006AU-Bw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1isZR8-0004QX-Dk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:45:52 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:36150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1isZR8-0004Q1-7T
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:45:50 -0500
Received: by mail-qk1-x741.google.com with SMTP id a203so24227271qkc.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 13:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cerdoMttWgpAAJPifMw/kxUQ9doqFtTlDHU/7VHj1Is=;
 b=jqzi/J7Vpeb7yQ4qim8bcU2W/h0GOZV9d/DkzwnP7va7P7v88h5/pp9v+n+JGDRAma
 +Jk3k6h4UM2HiPB3OG9mp9xknhF1OZqWKUfRX1ER/vnbznAPUFYs5ZhOoPAg4VCHbcbH
 rccZTGFhBxpbarN3XX0iD0yCCR7qf0oh+SNKqT3FjMdCDK7PWXmsbKdjoE2OPNBxl6ZX
 e2ZYfHzGJ4rjQmy0i7lhqIke/zUO/u4RQQQDbe0CWQrkgl0g+xZJqYXcWSRrgw+M4iMI
 egagpVCUkbmtzpAuaMNr/xWq/vbuaqz6/LTFjMbYCK/vxUc2yfibZmnyYz0DbZYqGXGN
 whvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cerdoMttWgpAAJPifMw/kxUQ9doqFtTlDHU/7VHj1Is=;
 b=EbdNNXZQ9ji/dsXBB5b5QcAYtC0ociu6eUCVhrtpgtDZVcjB1efPyRMRUQr504O0P6
 PkLpdvhtUOiT63rZjeK/oQF+3hjTFlWzKoFYC7U1iOqYZkH1Pq3KOs/UbBL68Q3mtreB
 PyA0ejLvTm15cHCOOQRbBO6MQHxtuVRJGdg3lA49Simb19sLRErut4eK2/tLHTcIcO8C
 5KsGuD2sScUqulgpbj9XljWpiC0KRqnLkhn9t7zR7XKdlGtLRMuVLrXdUjagH1XiYFRq
 2tQZ8HVXlUj5dMYt7gk+ysz41rmwdVK5oQyZqRxrQBh1dNHhRTV450Z2c7BPcT+wJl9J
 6PKA==
X-Gm-Message-State: APjAAAWH7Tct538Z5R9Np6/ID9WYouhaiTdsq0wZCcZTyX1wijKDB+8r
 GmX/fzDmTmyQAqqwfZ218w==
X-Google-Smtp-Source: APXvYqyRR/Kg4dq5BTmrHn7KhYFP0jtAeJFHECyJ1+E0VrJurhZcgqqwi2FWAmWns5vDhkXj6w9qdw==
X-Received: by 2002:a37:f514:: with SMTP id l20mr39273630qkk.421.1579297549268; 
 Fri, 17 Jan 2020 13:45:49 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id m10sm12270594qki.74.2020.01.17.13.45.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 13:45:48 -0800 (PST)
Date: Fri, 17 Jan 2020 16:45:43 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 034/104] virtiofsd: passthrough_ll: add ino_map to hide
 lo_inode pointers
Message-ID: <20200117214543.b7qxbn346nwuxly3@gabell>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-35-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212163904.159893-35-dgilbert@redhat.com>
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

On Thu, Dec 12, 2019 at 04:37:54PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Do not expose lo_inode pointers to clients.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 144 ++++++++++++++++++++++++-------
>  1 file changed, 114 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 0a94c3e1f2..fd1d88bddf 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -57,8 +57,8 @@
>  
>  #define HAVE_POSIX_FALLOCATE 1
>  /*
> - * We are re-using pointers to our `struct lo_inode` and `struct
> - * lo_dirp` elements as inodes. This means that we must be able to
> + * We are re-using pointers to our `struct lo_inode`
> + * elements as inodes. This means that we must be able to
>   * store uintptr_t values in a fuse_ino_t variable. The following
>   * incantation checks this condition at compile time.
>   */
> @@ -76,7 +76,7 @@ struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct {
>  
>  struct lo_map_elem {
>      union {
> -        /* Element values will go here... */
> +        struct lo_inode *inode;
>          ssize_t freelist;
>      };
>      bool in_use;
> @@ -97,6 +97,7 @@ struct lo_inode {
>      ino_t ino;
>      dev_t dev;
>      uint64_t refcount; /* protected by lo->mutex */
> +    fuse_ino_t fuse_ino;
>  };
>  
>  struct lo_cred {
> @@ -121,6 +122,7 @@ struct lo_data {
>      int cache;
>      int timeout_set;
>      struct lo_inode root; /* protected by lo->mutex */
> +    struct lo_map ino_map; /* protected by lo->mutex */
>  };
>  
>  static const struct fuse_opt lo_opts[] = {
> @@ -145,14 +147,14 @@ static struct lo_data *lo_data(fuse_req_t req)
>      return (struct lo_data *)fuse_req_userdata(req);
>  }
>  
> -__attribute__((unused)) static void lo_map_init(struct lo_map *map)
> +static void lo_map_init(struct lo_map *map)
>  {
>      map->elems = NULL;
>      map->nelems = 0;
>      map->freelist = -1;
>  }
>  
> -__attribute__((unused)) static void lo_map_destroy(struct lo_map *map)
> +static void lo_map_destroy(struct lo_map *map)
>  {
>      free(map->elems);
>  }
> @@ -183,8 +185,7 @@ static int lo_map_grow(struct lo_map *map, size_t new_nelems)
>      return 1;
>  }
>  
> -__attribute__((unused)) static struct lo_map_elem *
> -lo_map_alloc_elem(struct lo_map *map)
> +static struct lo_map_elem *lo_map_alloc_elem(struct lo_map *map)
>  {
>      struct lo_map_elem *elem;
>  
> @@ -200,8 +201,7 @@ lo_map_alloc_elem(struct lo_map *map)
>      return elem;
>  }
>  
> -__attribute__((unused)) static struct lo_map_elem *
> -lo_map_reserve(struct lo_map *map, size_t key)
> +static struct lo_map_elem *lo_map_reserve(struct lo_map *map, size_t key)
>  {
>      ssize_t *prev;
>  
> @@ -222,8 +222,7 @@ lo_map_reserve(struct lo_map *map, size_t key)
>      return NULL;
>  }
>  
> -__attribute__((unused)) static struct lo_map_elem *
> -lo_map_get(struct lo_map *map, size_t key)
> +static struct lo_map_elem *lo_map_get(struct lo_map *map, size_t key)
>  {
>      if (key >= map->nelems) {
>          return NULL;
> @@ -234,8 +233,7 @@ lo_map_get(struct lo_map *map, size_t key)
>      return &map->elems[key];
>  }
>  
> -__attribute__((unused)) static void lo_map_remove(struct lo_map *map,
> -                                                  size_t key)
> +static void lo_map_remove(struct lo_map *map, size_t key)
>  {
>      struct lo_map_elem *elem;
>  
> @@ -254,18 +252,40 @@ __attribute__((unused)) static void lo_map_remove(struct lo_map *map,
>      map->freelist = key;
>  }
>  
> +/* Assumes lo->mutex is held */
> +static ssize_t lo_add_inode_mapping(fuse_req_t req, struct lo_inode *inode)
> +{
> +    struct lo_map_elem *elem;
> +
> +    elem = lo_map_alloc_elem(&lo_data(req)->ino_map);
> +    if (!elem) {
> +        return -1;
> +    }
> +
> +    elem->inode = inode;
> +    return elem - lo_data(req)->ino_map.elems;
> +}
> +
>  static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
>  {
> -    if (ino == FUSE_ROOT_ID) {
> -        return &lo_data(req)->root;
> -    } else {
> -        return (struct lo_inode *)(uintptr_t)ino;
> +    struct lo_data *lo = lo_data(req);
> +    struct lo_map_elem *elem;
> +
> +    pthread_mutex_lock(&lo->mutex);
> +    elem = lo_map_get(&lo->ino_map, ino);
> +    pthread_mutex_unlock(&lo->mutex);
> +
> +    if (!elem) {
> +        return NULL;
>      }
> +
> +    return elem->inode;
>  }
>  
>  static int lo_fd(fuse_req_t req, fuse_ino_t ino)
>  {
> -    return lo_inode(req, ino)->fd;
> +    struct lo_inode *inode = lo_inode(req, ino);
> +    return inode ? inode->fd : -1;
>  }
>  
>  static bool lo_debug(fuse_req_t req)
> @@ -337,10 +357,18 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>  {
>      int saverr;
>      char procname[64];
> -    struct lo_inode *inode = lo_inode(req, ino);
> -    int ifd = inode->fd;
> +    struct lo_inode *inode;
> +    int ifd;
>      int res;
>  
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
> +    ifd = inode->fd;
> +
>      if (valid & FUSE_SET_ATTR_MODE) {
>          if (fi) {
>              res = fchmod(fi->fh, attr->st_mode);
> @@ -470,6 +498,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>          inode->dev = e->attr.st_dev;
>  
>          pthread_mutex_lock(&lo->mutex);
> +        inode->fuse_ino = lo_add_inode_mapping(req, inode);
>          prev = &lo->root;
>          next = prev->next;
>          next->prev = inode;
> @@ -478,7 +507,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>          prev->next = inode;
>          pthread_mutex_unlock(&lo->mutex);
>      }
> -    e->ino = (uintptr_t)inode;
> +    e->ino = inode->fuse_ino;
>  
>      if (lo_debug(req)) {
>          fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
> @@ -565,10 +594,16 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_t parent,
>  {
>      int res;
>      int saverr;
> -    struct lo_inode *dir = lo_inode(req, parent);
> +    struct lo_inode *dir;
>      struct fuse_entry_param e;
>      struct lo_cred old = {};
>  
> +    dir = lo_inode(req, parent);
> +    if (!dir) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
>      saverr = ENOMEM;
>  
>      saverr = lo_change_cred(req, &old);
> @@ -646,10 +681,16 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
>  {
>      int res;
>      struct lo_data *lo = lo_data(req);
> -    struct lo_inode *inode = lo_inode(req, ino);
> +    struct lo_inode *inode;
>      struct fuse_entry_param e;
>      int saverr;
>  
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
>      memset(&e, 0, sizeof(struct fuse_entry_param));
>      e.attr_timeout = lo->timeout;
>      e.entry_timeout = lo->timeout;
> @@ -667,7 +708,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
>      pthread_mutex_lock(&lo->mutex);
>      inode->refcount++;
>      pthread_mutex_unlock(&lo->mutex);
> -    e.ino = (uintptr_t)inode;
> +    e.ino = inode->fuse_ino;
>  
>      if (lo_debug(req)) {
>          fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
> @@ -733,10 +774,10 @@ static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64_t n)
>          next->prev = prev;
>          prev->next = next;
>  
> +        lo_map_remove(&lo->ino_map, inode->fuse_ino);
>          pthread_mutex_unlock(&lo->mutex);
>          close(inode->fd);
>          free(inode);
> -
>      } else {
>          pthread_mutex_unlock(&lo->mutex);
>      }
> @@ -745,7 +786,12 @@ static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64_t n)
>  static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
>  {
>      struct lo_data *lo = lo_data(req);
> -    struct lo_inode *inode = lo_inode(req, ino);
> +    struct lo_inode *inode;
> +
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        return;
> +    }
>  
>      if (lo_debug(req)) {
>          fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
> @@ -1227,10 +1273,16 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
>  {
>      char *value = NULL;
>      char procname[64];
> -    struct lo_inode *inode = lo_inode(req, ino);
> +    struct lo_inode *inode;
>      ssize_t ret;
>      int saverr;
>  
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
>      saverr = ENOSYS;
>      if (!lo_data(req)->xattr) {
>          goto out;
> @@ -1289,10 +1341,16 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
>  {
>      char *value = NULL;
>      char procname[64];
> -    struct lo_inode *inode = lo_inode(req, ino);
> +    struct lo_inode *inode;
>      ssize_t ret;
>      int saverr;
>  
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
>      saverr = ENOSYS;
>      if (!lo_data(req)->xattr) {
>          goto out;
> @@ -1350,10 +1408,16 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
>                          const char *value, size_t size, int flags)
>  {
>      char procname[64];
> -    struct lo_inode *inode = lo_inode(req, ino);
> +    struct lo_inode *inode;
>      ssize_t ret;
>      int saverr;
>  
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
>      saverr = ENOSYS;
>      if (!lo_data(req)->xattr) {
>          goto out;
> @@ -1383,10 +1447,16 @@ out:
>  static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *name)
>  {
>      char procname[64];
> -    struct lo_inode *inode = lo_inode(req, ino);
> +    struct lo_inode *inode;
>      ssize_t ret;
>      int saverr;
>  
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
>      saverr = ENOSYS;
>      if (!lo_data(req)->xattr) {
>          goto out;
> @@ -1505,6 +1575,7 @@ int main(int argc, char *argv[])
>      struct fuse_session *se;
>      struct fuse_cmdline_opts opts;
>      struct lo_data lo = { .debug = 0, .writeback = 0 };
> +    struct lo_map_elem *root_elem;
>      int ret = -1;
>  
>      /* Don't mask creation mode, kernel already did that */
> @@ -1513,8 +1584,19 @@ int main(int argc, char *argv[])
>      pthread_mutex_init(&lo.mutex, NULL);
>      lo.root.next = lo.root.prev = &lo.root;
>      lo.root.fd = -1;
> +    lo.root.fuse_ino = FUSE_ROOT_ID;
>      lo.cache = CACHE_NORMAL;
>  
> +    /*
> +     * Set up the ino map like this:
> +     * [0] Reserved (will not be used)
> +     * [1] Root inode
> +     */
> +    lo_map_init(&lo.ino_map);
> +    lo_map_reserve(&lo.ino_map, 0)->in_use = false;
> +    root_elem = lo_map_reserve(&lo.ino_map, lo.root.fuse_ino);
> +    root_elem->inode = &lo.root;
> +
>      if (fuse_parse_cmdline(&args, &opts) != 0) {
>          return 1;
>      }
> @@ -1611,6 +1693,8 @@ err_out2:
>  err_out1:
>      fuse_opt_free_args(&args);
>  
> +    lo_map_destroy(&lo.ino_map);
> +
>      if (lo.root.fd >= 0) {
>          close(lo.root.fd);
>      }

Looks good to me.

Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

