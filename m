Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF4C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9320208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9320208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hstc5-0005hI-3I
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hstbh-0005HV-DS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hstbg-0004RD-Ip
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:45:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hstbg-0004Qo-DO
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:45:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1BB09308218D;
 Wed, 31 Jul 2019 18:45:47 +0000 (UTC)
Received: from work-vm (ovpn-116-252.ams2.redhat.com [10.36.116.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1D911001B28;
 Wed, 31 Jul 2019 18:45:41 +0000 (UTC)
Date: Wed, 31 Jul 2019 19:45:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190731184538.GO3203@work-vm>
References: <20190731161006.9447-1-stefanha@redhat.com>
 <20190731161006.9447-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731161006.9447-2-stefanha@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 31 Jul 2019 18:45:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/5] virtiofsd: take lo->mutex around
 lo_add_fd_mapping()
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
> The lo_add_fd_mapping() function assumes lo->mutex is held, so we should
> acquire it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied

Would it make sense for me to squash this into:
    virtiofsd: passthrough_ll: add fd_map to hide file descriptors 

?

Dave

> ---
>  contrib/virtiofsd/passthrough_ll.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index 65b7352c95..417a104218 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -1555,7 +1555,9 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
>  
>  		update_version(lo, lo_inode(req, parent));
>  
> +		pthread_mutex_lock(&lo->mutex);
>  		fh = lo_add_fd_mapping(req, fd);
> +		pthread_mutex_unlock(&lo->mutex);
>  		if (fh == -1) {
>  			close(fd);
>  			fuse_reply_err(req, ENOMEM);
> @@ -1760,7 +1762,9 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>  	if (fd == -1)
>  		return (void) fuse_reply_err(req, errno);
>  
> +	pthread_mutex_lock(&lo->mutex);
>  	fh = lo_add_fd_mapping(req, fd);
> +	pthread_mutex_unlock(&lo->mutex);
>  	if (fh == -1) {
>  		close(fd);
>  		fuse_reply_err(req, ENOMEM);
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

