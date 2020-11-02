Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ADDC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3884322245
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6pItFBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3884322245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZef9-0000Dp-4z
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZedl-0007Lz-U6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:33:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZedk-0008RK-4j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604341991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPORZeg+S+HBTkehML7TmlQ3ZPMdeoacbN0FvN5HmHk=;
 b=Q6pItFBmhq1nMRQZgel1vftmrWmHYODmxMm0D6iMCLeI/5rY95TD4NKwmbxlDNuYQeLvBx
 45SvMxp64zlTQ/E3+XmDDKWqQJZ2Ut4T3z325c8/zGxmjPY4AenzLd+xIiubwhs4lN05XM
 7Eksl/EUYxjQj7zZLFdhWpakUycKMjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-HZaOJ9qUOQ6ZOp1w1QIIFw-1; Mon, 02 Nov 2020 13:33:08 -0500
X-MC-Unique: HZaOJ9qUOQ6ZOp1w1QIIFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D874809DCD;
 Mon,  2 Nov 2020 18:33:07 +0000 (UTC)
Received: from work-vm (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D735873673;
 Mon,  2 Nov 2020 18:33:02 +0000 (UTC)
Date: Mon, 2 Nov 2020 18:33:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v2] tools/virtiofsd: Check vu_init() return value
 (CID 1435958)
Message-ID: <20201102183300.GO3673@work-vm>
References: <20201102092339.2034297-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102092339.2034297-1-philmd@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> Since commit 6f5fd837889, vu_init() can fail if malloc() returns NULL.
> 
> This fixes the following Coverity warning:
> 
>   CID 1435958 (#1 of 1): Unchecked return value (CHECKED_RETURN)
> 
> Fixes: 6f5fd837889 ("libvhost-user: support many virtqueues")
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Queued.

> ---
> v2: Add fuse_log()

Thanks.

> ---
>  tools/virtiofsd/fuse_virtio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index 324936948d3..83ba07c6cd8 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -1013,8 +1013,11 @@ int virtio_session_mount(struct fuse_session *se)
>      se->vu_socketfd = data_sock;
>      se->virtio_dev->se = se;
>      pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
> -    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
> -            fv_set_watch, fv_remove_watch, &fv_iface);
> +    if (!vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
> +                 fv_set_watch, fv_remove_watch, &fv_iface)) {
> +        fuse_log(FUSE_LOG_ERR, "%s: vu_init failed\n", __func__);
> +        return -1;
> +    }
>  
>      return 0;
>  }
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


