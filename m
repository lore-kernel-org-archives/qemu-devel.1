Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4097BC54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD4E20675
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVXR71GA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD4E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSc1-0001dn-4F
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYSbP-0000uf-9m
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:57:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYSbO-0006K4-JR
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589281053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZwLu5VbpWacXUxZiwAIC96KKWd15Nuw7MLmsS4aqIg=;
 b=WVXR71GAFphjq3CST/FUHKCX3p5gjnvfT2HXNRwsjOx3SE/jPrMb9qREzGqJl+g5zdAnC6
 9JN4HO1jwuvup/dwU+VadiADOdt4f2VG7ayDI49y50BTv/gyhcv6qE4u5vi2vVVHS8s72y
 WMO/0iOBzC13DDuEvdVk8MDk+DJ3yEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-5OPy-nsnODiCBBSMf8RsVg-1; Tue, 12 May 2020 06:57:30 -0400
X-MC-Unique: 5OPy-nsnODiCBBSMf8RsVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8BFC1009618;
 Tue, 12 May 2020 10:57:28 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DFEE6C78B;
 Tue, 12 May 2020 10:57:21 +0000 (UTC)
Date: Tue, 12 May 2020 12:57:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Reiter <s.reiter@proxmox.com>
Subject: Re: [RFC] bdrv_flush: only use fast path when in owned AioContext
Message-ID: <20200512105719.GI5951@linux.fritz.box>
References: <20200511165032.11384-1-s.reiter@proxmox.com>
MIME-Version: 1.0
In-Reply-To: <20200511165032.11384-1-s.reiter@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.05.2020 um 18:50 hat Stefan Reiter geschrieben:
> Just because we're in a coroutine doesn't imply ownership of the context
> of the flushed drive. In such a case use the slow path which explicitly
> enters bdrv_flush_co_entry in the correct AioContext.
> 
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
> 
> We've experienced some lockups in this codepath when taking snapshots of VMs
> with drives that have IO-Threads enabled (we have an async 'savevm'
> implementation running from a coroutine).
> 
> Currently no reproducer for upstream versions I could find, but in testing this
> patch fixes all issues we're seeing and I think the logic checks out.
> 
> The fast path pattern is repeated a few times in this file, so if this change
> makes sense, it's probably worth evaluating the other occurences as well.

What do you mean by "owning" the context? If it's about taking the
AioContext lock, isn't the problem more with calling bdrv_flush() from
code that doesn't take the locks?

Though I think we have some code that doesn't only rely on holding the
AioContext locks, but that actually depends on running in the right
thread, so the change looks right anyway.

Kevin

>  block/io.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index aba67f66b9..ee7310fa13 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2895,8 +2895,9 @@ int bdrv_flush(BlockDriverState *bs)
>          .ret = NOT_DONE,
>      };
>  
> -    if (qemu_in_coroutine()) {
> -        /* Fast-path if already in coroutine context */
> +    if (qemu_in_coroutine() &&
> +        bdrv_get_aio_context(bs) == qemu_get_current_aio_context()) {
> +        /* Fast-path if already in coroutine and we own the drive's context */
>          bdrv_flush_co_entry(&flush_co);
>      } else {
>          co = qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
> -- 
> 2.20.1
> 
> 


