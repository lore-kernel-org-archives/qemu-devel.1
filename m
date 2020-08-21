Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D94C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A0D207C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjRXXBDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A0D207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98zH-0006fK-Pr
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k98yh-00065b-SL
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k98yg-00060i-4r
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598023753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+RDHVIFmuFBkF/mJ72xAnZiarBXaqBQcfxa9KUJcs0=;
 b=bjRXXBDbG6agxnZwVJqhN6733RNCUcwXBtWR7PlIaLEBeqQDrF8ByaxaIasiCs2/EiA2Lk
 /94q9ouZTW8RzpNv3NHRoGHft0feLlszgmwsg5rwcoZ8xmBPAy3KRpI12PlD3Kg6wgfu7a
 Oozc1eVFmD7JE8i8KBlnM9N/6LpGj3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-sgjqK8lAMcGoTQyrI3Hy0A-1; Fri, 21 Aug 2020 11:29:11 -0400
X-MC-Unique: sgjqK8lAMcGoTQyrI3Hy0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C3FB10ABDA2;
 Fri, 21 Aug 2020 15:29:10 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 596AB7E31B;
 Fri, 21 Aug 2020 15:29:09 +0000 (UTC)
Date: Fri, 21 Aug 2020 17:29:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 37/47] qemu-img: Use child access functions
Message-ID: <20200821152907.GF5153@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-38-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625152215.941773-38-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
> This changes iotest 204's output, because blkdebug on top of a COW node
> used to make qemu-img map disregard the rest of the backing chain (the
> backing chain was broken by the filter).  With this patch, the
> allocation in the base image is reported correctly.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> @@ -3437,6 +3441,7 @@ static int img_rebase(int argc, char **argv)
>      uint8_t *buf_old = NULL;
>      uint8_t *buf_new = NULL;
>      BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
> +    BlockDriverState *unfiltered_bs;
>      char *filename;
>      const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
>      int c, flags, src_flags, ret;
> @@ -3571,6 +3576,8 @@ static int img_rebase(int argc, char **argv)
>      }
>      bs = blk_bs(blk);
>  
> +    unfiltered_bs = bdrv_skip_filters(bs);
> +
>      if (out_basefmt != NULL) {
>          if (bdrv_find_format(out_basefmt) == NULL) {
>              error_report("Invalid format name: '%s'", out_basefmt);
> @@ -3582,7 +3589,7 @@ static int img_rebase(int argc, char **argv)
>      /* For safe rebasing we need to compare old and new backing file */
>      if (!unsafe) {
>          QDict *options = NULL;
> -        BlockDriverState *base_bs = backing_bs(bs);
> +        BlockDriverState *base_bs = bdrv_cow_bs(unfiltered_bs);
>  
>          if (base_bs) {
>              blk_old_backing = blk_new(qemu_get_aio_context(),
> @@ -3738,8 +3745,9 @@ static int img_rebase(int argc, char **argv)
>                   * If cluster wasn't changed since prefix_chain, we don't need
>                   * to take action
>                   */
> -                ret = bdrv_is_allocated_above(backing_bs(bs), prefix_chain_bs,
> -                                              false, offset, n, &n);
> +                ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
> +                                              prefix_chain_bs, false,
> +                                              offset, n, &n);
>                  if (ret < 0) {
>                      error_report("error while reading image metadata: %s",
>                                   strerror(-ret));

img_rebase() has these additional calls:

    /* If the cluster is allocated, we don't need to take action */
    ret = bdrv_is_allocated(bs, offset, n, &n);

And:

    if (out_baseimg && *out_baseimg) {
        ret = bdrv_change_backing_file(bs, out_baseimg, out_basefmt);
    } else {
        ret = bdrv_change_backing_file(bs, NULL, NULL);
    }

Shouldn't they use unfiltered_bs?

(Not that it's likely that anyone would use 'qemu-img rebase' with a
filter, but while you're touching it...)

Kevin


