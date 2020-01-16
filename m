Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC82C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958EC207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958EC207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is46V-0005BJ-Od
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1is45j-0004EV-Gv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1is45f-000325-1E
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:17:38 -0500
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:49005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1is45e-0002yV-B6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:17:34 -0500
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by
 mgwkm02.jp.fujitsu.com with smtp
 id 11aa_1e22_ef0b02c8_72e1_49a6_954f_4dfbda4cf5b3;
 Thu, 16 Jan 2020 21:17:23 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 740CCAC0058
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 21:17:22 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 68F1FBD675A;
 Thu, 16 Jan 2020 21:17:21 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHKW14.g01.fujitsu.local (10.0.194.53) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 21:17:21 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 093/104] virtiofsd: introduce inode refcount to prevent
 use-after-free
Date: Thu, 16 Jan 2020 21:25:42 +0900
Message-ID: <20200116122542.20873-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-94-dgilbert@redhat.com>
References: <20191212163904.159893-94-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.219.69.169
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
Cc: misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> If thread A is using an inode it must not be deleted by thread B when
> processing a FUSE_FORGET request.
> 
> The FUSE protocol itself already has a counter called nlookup that is
> used in FUSE_FORGET messages.  We cannot trust this counter since the
> untrusted client can manipulate it via FUSE_FORGET messages.
> 
> Introduce a new refcount to keep inodes alive for the required lifespan.
> lo_inode_put() must be called to release a reference.  FUSE's nlookup
> counter holds exactly one reference so that the inode stays alive as
> long as the client still wants to remember it.
> 
> Note that the lo_inode->is_symlink field is moved to avoid creating a
> hole in the struct due to struct field alignment.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 168 ++++++++++++++++++++++++++-----
>  1 file changed, 145 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index b19c9ee328..8f4ab8351c 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -99,7 +99,13 @@ struct lo_key {
>  
>  struct lo_inode {
>      int fd;
> -    bool is_symlink;
> +
> +    /*
> +     * Atomic reference count for this object.  The nlookup field holds a
> +     * reference and release it when nlookup reaches 0.
> +     */
> +    gint refcount;
> +
>      struct lo_key key;
>  
>      /*
> @@ -118,6 +124,8 @@ struct lo_inode {
>      fuse_ino_t fuse_ino;
>      pthread_mutex_t plock_mutex;
>      GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
> +
> +    bool is_symlink;
>  };
>  
>  struct lo_cred {
> @@ -473,6 +481,23 @@ static ssize_t lo_add_inode_mapping(fuse_req_t req, struct lo_inode *inode)
>      return elem - lo_data(req)->ino_map.elems;
>  }
>  
> +static void lo_inode_put(struct lo_data *lo, struct lo_inode **inodep)
> +{
> +    struct lo_inode *inode = *inodep;
> +
> +    if (!inode) {
> +        return;
> +    }
> +
> +    *inodep = NULL;
> +
> +    if (g_atomic_int_dec_and_test(&inode->refcount)) {
> +        close(inode->fd);
> +        free(inode);
> +    }
> +}
> +
> +/* Caller must release refcount using lo_inode_put() */
>  static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
>  {
>      struct lo_data *lo = lo_data(req);
> @@ -480,6 +505,9 @@ static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
>  
>      pthread_mutex_lock(&lo->mutex);
>      elem = lo_map_get(&lo->ino_map, ino);
> +    if (elem) {
> +        g_atomic_int_inc(&elem->inode->refcount);
> +    }
>      pthread_mutex_unlock(&lo->mutex);
>  
>      if (!elem) {
> @@ -489,10 +517,23 @@ static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
>      return elem->inode;
>  }
>  
> +/*
> + * TODO Remove this helper and force callers to hold an inode refcount until
> + * they are done with the fd.  This will be done in a later patch to make
> + * review easier.
> + */
>  static int lo_fd(fuse_req_t req, fuse_ino_t ino)
>  {
>      struct lo_inode *inode = lo_inode(req, ino);
> -    return inode ? inode->fd : -1;
> +    int fd;
> +
> +    if (!inode) {
> +        return -1;
> +    }
> +
> +    fd = inode->fd;
> +    lo_inode_put(lo_data(req), &inode);
> +    return fd;
>  }
>  
>  static void lo_init(void *userdata, struct fuse_conn_info *conn)
> @@ -547,6 +588,10 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
>      fuse_reply_attr(req, &buf, lo->timeout);
>  }
>  
> +/*
> + * Increments parent->nlookup and caller must release refcount using
> + * lo_inode_put(&parent).
> + */
>  static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *inode,
>                                char path[PATH_MAX], struct lo_inode **parent)
>  {
> @@ -584,6 +629,7 @@ retry:
>          p = &lo->root;
>          pthread_mutex_lock(&lo->mutex);
>          p->nlookup++;
> +        g_atomic_int_inc(&p->refcount);
>          pthread_mutex_unlock(&lo->mutex);
>      } else {
>          *last = '\0';

We need lo_ionde_put() in error path, right?:
https://gitlab.com/virtio-fs/qemu/blob/virtio-fs-as-posted-2019-12-12/tools/virtiofsd/passthrough_ll.c#L680

nit: if yes, unref_inode_lolocked() is always paired with lo_inode_put().
So how about combine them in one function? As p->nloockup and p->refcount
are both incremented in one place (lo_find/lo_parent_and_name) in these case,
it seems natural for me to decrement them in one function as well.

Thanks,
Misono

