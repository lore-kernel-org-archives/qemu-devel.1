Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F4C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17C420717
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipjCrXdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17C420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLP8z-0000y6-Dy
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLP89-0000Vl-9g
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLP87-0002fO-Ab
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600945778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPRp3Q96TmPVU7JbVrAuQ8TD+AA0NNz4NrCcBTnnIpU=;
 b=ipjCrXdPGaWCkbTvPY8J55DRUpzbZGLsNVIfm977OFxemSvDqbqLVtcc5Dxn14irOO8AGN
 kFlHURbj2gAn+aRjHM1saIQNQnzGCY4c5B33h8UBFkFmtWWQzo3Ki/mqoaXKh90kW18prr
 8z6rcBDaySMgw2SUnvE9w+eU26FA1hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-XHToIbktNBC0gbmnErMf-g-1; Thu, 24 Sep 2020 07:09:36 -0400
X-MC-Unique: XHToIbktNBC0gbmnErMf-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92AAA802B4A;
 Thu, 24 Sep 2020 11:09:35 +0000 (UTC)
Received: from work-vm (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A52175C1C7;
 Thu, 24 Sep 2020 11:09:31 +0000 (UTC)
Date: Thu, 24 Sep 2020 12:09:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [PATCH v2] virtiofsd: Add -o allow_direct_io|no_allow_direct_io
 options
Message-ID: <20200924110928.GD2792@work-vm>
References: <20200824105957.61265-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20200824105957.61265-1-zhangjiachen.jaycee@bytedance.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yongji Xie <xieyongji@bytedance.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jiachen Zhang (zhangjiachen.jaycee@bytedance.com) wrote:
> Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRECT
> open flag of guest applications will be discarded by virtiofsd. While
> this behavior makes it consistent with the virtio-9p scheme when guest
> applications use direct I/O, we no longer have any chance to bypass the
> host page cache.
> 
> Therefore, we add a flag 'allow_direct_io' to lo_data. If '-o
>  no_allow_direct_io' option is added, or none of '-o allow_direct_io' or
>  '-o no_allow_direct_io' is added, the 'allow_direct_io' will be set to
>  0, and virtiofsd discards O_DIRECT as before. If '-o allow_direct_io'
> is added to the starting command-line, 'allow_direct_io' will be set to
> 1, so that the O_DIRECT flags will be retained and host page cache can
> be bypassed.
> 
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Queued

> ---
>  tools/virtiofsd/helper.c         |  4 ++++
>  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 3105b6c23a..45b310ff3c 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
>             "                               (0 leaves rlimit unchanged)\n"
>             "                               default: min(1000000, fs.file-max - 16384)\n"
>             "                                        if the current rlimit is lower\n"
> +           "    -o allow_direct_io|no_allow_direct_io\n"
> +           "                               retain/discard O_DIRECT flags passed down\n"
> +           "                               to virtiofsd from guest applications.\n"
> +           "                               default: no_allow_direct_io\n"
>             );
>  }
>  
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 94e0de2d2b..c1ae897b77 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -151,6 +151,7 @@ struct lo_data {
>      int timeout_set;
>      int readdirplus_set;
>      int readdirplus_clear;
> +    int allow_direct_io;
>      struct lo_inode root;
>      GHashTable *inodes; /* protected by lo->mutex */
>      struct lo_map ino_map; /* protected by lo->mutex */
> @@ -179,6 +180,8 @@ static const struct fuse_opt lo_opts[] = {
>      { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
>      { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
>      { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
> +    { "allow_direct_io", offsetof(struct lo_data, allow_direct_io), 1 },
> +    { "no_allow_direct_io", offsetof(struct lo_data, allow_direct_io), 0 },
>      FUSE_OPT_END
>  };
>  static bool use_syslog = false;
> @@ -1516,7 +1519,8 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
>      fuse_reply_err(req, 0);
>  }
>  
> -static void update_open_flags(int writeback, struct fuse_file_info *fi)
> +static void update_open_flags(int writeback, int allow_direct_io,
> +                              struct fuse_file_info *fi)
>  {
>      /*
>       * With writeback cache, kernel may send read requests even
> @@ -1541,10 +1545,13 @@ static void update_open_flags(int writeback, struct fuse_file_info *fi)
>  
>      /*
>       * O_DIRECT in guest should not necessarily mean bypassing page
> -     * cache on host as well. If somebody needs that behavior, it
> -     * probably should be a configuration knob in daemon.
> +     * cache on host as well. Therefore, we discard it by default
> +     * ('-o no_allow_direct_io'). If somebody needs that behavior,
> +     * the '-o allow_direct_io' option should be set.
>       */
> -    fi->flags &= ~O_DIRECT;
> +    if (!allow_direct_io) {
> +        fi->flags &= ~O_DIRECT;
> +    }
>  }
>  
>  static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
> @@ -1576,7 +1583,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
>          goto out;
>      }
>  
> -    update_open_flags(lo->writeback, fi);
> +    update_open_flags(lo->writeback, lo->allow_direct_io, fi);
>  
>      fd = openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOLLOW,
>                  mode);
> @@ -1786,7 +1793,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>      fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n", ino,
>               fi->flags);
>  
> -    update_open_flags(lo->writeback, fi);
> +    update_open_flags(lo->writeback, lo->allow_direct_io, fi);
>  
>      sprintf(buf, "%i", lo_fd(req, ino));
>      fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
> @@ -2824,6 +2831,7 @@ int main(int argc, char *argv[])
>          .debug = 0,
>          .writeback = 0,
>          .posix_lock = 1,
> +        .allow_direct_io = 0,
>          .proc_self_fd = -1,
>      };
>      struct lo_map_elem *root_elem;
> -- 
> 2.11.0
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


