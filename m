Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDBFC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E442206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUyHqT8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E442206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJd2-0006TB-43
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOJVt-0007qU-SD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOJVp-0000EU-Js
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601639166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FE068GphyT3N3wRrBI2NNYfUgehWHgiVKdwZiJbQi78=;
 b=dUyHqT8t4sM4E1pgmDD5F2Rj5n+94juwQjns2RLSZHINsBmDiBx2lXhVK3RWJpRL7yO/aJ
 XPDvgWZe7G0pmrhNrS34/8Y/gIIveg3zzhI1H8cpttHn+tq35OukjZEemhCr5SgZ2XxZfG
 qLWt7mPp1ZonXBU4jrRAFw6arADwlWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-RrPovBd6P1aOFQgplJyFoA-1; Fri, 02 Oct 2020 07:46:05 -0400
X-MC-Unique: RrPovBd6P1aOFQgplJyFoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9675F1018F84;
 Fri,  2 Oct 2020 11:46:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-139.ams2.redhat.com [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B5A119C66;
 Fri,  2 Oct 2020 11:46:01 +0000 (UTC)
Date: Fri, 2 Oct 2020 13:46:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: mingwei <gongwilliam@163.com>
Subject: Re: [PATCH v1 1/1] sheepdog driver patch: fixs the problem of qemu
 process become crashed when the sheepdog gateway break the IO and then
 recover
Message-ID: <20201002114600.GC4996@linux.fritz.box>
References: <20201001022127.7315-1-gongwilliam@163.com>
MIME-Version: 1.0
In-Reply-To: <20201001022127.7315-1-gongwilliam@163.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: namei.unix@gmail.com, sheepdog@lists.wpkg.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.10.2020 um 04:21 hat mingwei geschrieben:
> this patch fixs the problem of qemu process become crashed when the sheepdog gateway break the IO for a few seconds and then recover.
> 
> problem reproduce:
> 1.start a fio process in qemu to produce IOs to sheepdog gateway, whatever IO type you like.
> 2.kill the sheepdog gateway.
> 3.wait for a few seconds.
> 4.restart the sheepdog gateway.
> 5.qemu process crashed with segfault error 6.

Can you post a stack trace?

Signal 6 is not a segfault, but SIGABRT.

> problem cause:
> the last io coroutine will be destroyed after reconnect to sheepdog gateway, but the coroutine still be scheduled and the s->co_recv is still the last io coroutine pointer which had been destroyed, so when this coroutine go to coroutine context switch, it will make qemu process crashed.
> 
> problem fix:
> just make s->co_recv = NULL when the last io coroutine reconnect to sheepdog gateway.
> 
> Signed-off-by: mingwei <gongwilliam@163.com>
> ---
>  block/sheepdog.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 2f5c0eb376..3a00f0c1e1 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -727,6 +727,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
>                         NULL, NULL, NULL);
>      close(s->fd);
>      s->fd = -1;
> +    s->co_recv = NULL;

If s->co_revc != NULL before this, there is still a coroutine running
that hasn't terminated yet. Don't we need to make sure that the
coroutine actually terminates instead of just overwriting the pointer to
it?

Otherwise, we either leak the coroutine and the memory used for its
stack, or the coroutine continues to run at some point and might
interfer with the operation of the new instance.

>      /* Wait for outstanding write requests to be completed. */
>      while (s->co_send != NULL) {
           co_write_request(opaque);
       }

This existing code after your change is wrong, too, by the way. It
potentially calls aio_co_wake() multiple times in a row, which will
crash if it ends up only scheduling the coroutine instead of directly
entering it.

Kevin


