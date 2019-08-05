Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D7DC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F755216F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F755216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huekn-0004EU-Mw
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49570)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hueji-0003Wg-77
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1huejf-0001nP-HE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:17:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1huejd-0001mQ-Sf
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2F41B368DA;
 Mon,  5 Aug 2019 15:17:17 +0000 (UTC)
Received: from work-vm (ovpn-117-168.ams2.redhat.com [10.36.117.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2704E10016EA;
 Mon,  5 Aug 2019 15:17:10 +0000 (UTC)
Date: Mon, 5 Aug 2019 16:17:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190805151708.GN13734@work-vm>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190801165409.20121-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801165409.20121-4-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 05 Aug 2019 15:17:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] virtiofsd: fix lo_destroy() resource
 leaks
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
Cc: virtio-fs@redhat.com, Liu Bo <bo.liu@linux.alibaba.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> Now that lo_destroy() is serialized we can call unref_inode() so that
> all inode resources are freed.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  contrib/virtiofsd/passthrough_ll.c | 43 ++++++++++++++----------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index a81c01d0d1..02a5e97326 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -1340,28 +1340,6 @@ static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64_t n)
>  	}
>  }
>  
> -static int unref_all_inodes_cb(gpointer key, gpointer value,
> -			       gpointer user_data)
> -{
> -	struct lo_inode *inode  = value;
> -	struct lo_data *lo = user_data;
> -
> -	inode->nlookup = 0;
> -	lo_map_remove(&lo->ino_map, inode->fuse_ino);
> -	close(inode->fd);
> -	lo_inode_put(lo, &inode); /* Drop our refcount from lo_do_lookup() */
> -
> -	return TRUE;
> -}
> -
> -static void unref_all_inodes(struct lo_data *lo)
> -{
> -	pthread_mutex_lock(&lo->mutex);
> -	g_hash_table_foreach_remove(lo->inodes, unref_all_inodes_cb, lo);
> -	pthread_mutex_unlock(&lo->mutex);
> -
> -}
> -
>  static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
>  {
>  	struct lo_data *lo = lo_data(req);
> @@ -2462,6 +2440,18 @@ static void lo_removemapping(fuse_req_t req, struct fuse_session *se,
>  	fuse_reply_err(req, ret);
>  }
>  
> +static int destroy_inode_cb(gpointer key, gpointer value, gpointer user_data)
> +{
> +        struct lo_inode *inode = value;
> +        struct lo_data *lo = user_data;
> +
> +        /* inode->nlookup is normally protected by lo->mutex but see the
> +         * comment in lo_destroy().
> +         */
> +        unref_inode(lo, inode, inode->nlookup);
> +        return TRUE;
> +}
> +
>  static void lo_destroy(void *userdata, struct fuse_session *se)
>  {
>  	struct lo_data *lo = (struct lo_data*) userdata;
> @@ -2475,7 +2465,14 @@ static void lo_destroy(void *userdata, struct fuse_session *se)
>                          fuse_err("%s: unmap during destroy failed\n", __func__);
>                  }
>          }
> -	unref_all_inodes(lo);
> +
> +        /* Normally lo->mutex must be taken when traversing lo->inodes but
> +         * lo_destroy() is a serialized request so no races are possible here.
> +         *
> +         * In addition, we cannot acquire lo->mutex since destroy_inode_cb() takes it
> +         * too and this would result in a recursive lock.
> +         */
> +        g_hash_table_foreach_remove(lo->inodes, destroy_inode_cb, lo);
>  }
>  
>  static struct fuse_lowlevel_ops lo_oper = {
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

