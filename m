Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5EAC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BEA2133F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BEA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2h3-0001dX-2r
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 03:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hg2e2-0007Ob-PD
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hg2e0-0003hT-2P
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:47:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hg2dz-0003gk-GQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:47:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so996372wms.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 00:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=SLz00dESU2JyNIgPI+hXOsLmHF/vZNlHW+9HIENpF7o=;
 b=OS+G7sBzxhopNRdfOJ5ZvEkofq+yYdOCmzTVYvYzU2rErIcwcSSSYYIZYtjo3WKDk9
 XPtw3dUKYgcWpTh/vwINFwUZqd5stzj7syasn2vto88Pb4weqqSWT+d5KhUpn6S3E1oC
 SDJIG0QYWKokkqSyYbHxFXxfCciN+3KbJvS0vAOAdmJz1+huU/IfkYo0cWFC0Qjh6RjQ
 e9WqR6awZlSfBujuyUll+CgJktwYPZi4h01YO7iueqqCEKBtFc6qcNc7p2ku6homlYjl
 qtvIDqY/0rpQ7K/0SeORpmrVoSsD1tLd1eCQA+u+7tKqcRHHmfXN7iMnLljhvAkV4k7I
 taqg==
X-Gm-Message-State: APjAAAWanyFOXs15Qa/T4eKf0w8vwrHuRFHgU0Z3sV1QCRGia850ApIe
 N/xMJNyKv89kdcFPhlur6L61mA==
X-Google-Smtp-Source: APXvYqwdtQ24lCYe6gLTooNkVjmeE9nFIKVV/htp5XYZElPEqF4heSy2ucpz3Xu98ZCgWLL+59ryPg==
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr1525316wmb.37.1561535222415; 
 Wed, 26 Jun 2019 00:47:02 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
 (host21-207-dynamic.52-79-r.retail.telecomitalia.it. [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id h90sm22373116wrh.15.2019.06.26.00.47.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 00:47:01 -0700 (PDT)
Date: Wed, 26 Jun 2019 09:46:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190626074659.fmxtr44okpk46fit@steredhat.homenet.telecomitalia.it>
References: <20190506122322.90035-1-sgarzare@redhat.com>
 <90af513d-7051-45f7-2953-55e0c8460be5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90af513d-7051-45f7-2953-55e0c8460be5@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2] block/rbd: add preallocation support
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Jason Dillaman <jdillama@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 06:06:02PM +0200, Max Reitz wrote:
> On 06.05.19 14:23, Stefano Garzarella wrote:
> > This patch adds the support of preallocation (off/full) for the RBD
> > block driver.
> > If available, we use rbd_writesame() to quickly fill the image when
> > full preallocation is required.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v2:
> > - Use 4 KiB buffer for rbd_writesame() [Jason]
> > - Use "rbd_concurrent_management_ops" and "stripe_unit" to limit
> >   concurrent ops to the backing cluster [Jason]
> > ---
> >  block/rbd.c          | 188 +++++++++++++++++++++++++++++++++++++++----
> >  qapi/block-core.json |   4 +-
> >  2 files changed, 175 insertions(+), 17 deletions(-)
> 
> This patch conflicts a bit with the rbd file growth patch, so that would
> need to be resolved in a v3.

Sure, I'll rebase this patch in a v3!

> 
> But still, that doesn’t prevent me from reviewing it as it is:
> 
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..bc54395e1c 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> 
> [...]
> 
> > @@ -331,6 +333,147 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
> 
> [...]
> 
> > +static int qemu_rbd_do_truncate(rados_t cluster, rbd_image_t image,
> > +                                int64_t offset, PreallocMode prealloc,
> > +                                Error **errp)
> > +{
> 
> [...]
> 
> > +#ifdef LIBRBD_SUPPORTS_WRITESAME
> > +        uint64_t stripe_unit, writesame_max_size;
> > +        int max_concurrent_ops;
> > +
> > +        max_concurrent_ops = qemu_rbd_get_max_concurrent_ops(cluster);
> > +        ret = rbd_get_stripe_unit(image, &stripe_unit);
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, -ret, "Failed to get stripe unit");
> > +            goto out;
> > +        }
> > +
> > +        /*
> > +         * We limit the rbd_writesame() size to avoid to spawn more then
> 
> s/then/than/

Ooo, I'll fix it!

> 
> > +         * 'rbd_concurrent_management_ops' concurrent operations.
> > +         */
> > +        writesame_max_size = MIN(stripe_unit * max_concurrent_ops, INT_MAX);
> > +#endif /* LIBRBD_SUPPORTS_WRITESAME */
> > +
> > +        buf = g_malloc(buf_size);
> > +        /*
> > +         * Some versions of rbd_writesame() discards writes of buffers with
> > +         * all zeroes. In order to avoid this behaviour, we set the first byte
> > +         * to one.
> > +         */
> > +        buf[0] = 1;
> 
> But I guess you’ll need to rewrite it as zero later, or the
> “bdrv_rbd.bdrv_has_zero_init = bdrv_has_zero_init_1” is no longer quite
> true.

Yes, and I should use g_malloc0. I'll check if the next rewrites is too
slow, in this case I'll use rbd_writesame() only for ceph version where
zeroed buffer is supported.

> 
> [...]
> 
> > @@ -449,6 +603,16 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
> >                                                     BLOCK_OPT_CLUSTER_SIZE, 0);
> >      rbd_opts->has_cluster_size = (rbd_opts->cluster_size != 0);
> >  
> > +    prealloc = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> > +    rbd_opts->preallocation = qapi_enum_parse(&PreallocMode_lookup, prealloc,
> > +                                              PREALLOC_MODE_OFF, &local_err);
> 
> You also need to set rbd_opts->has_preallocation to true.

I'll fix.

> 
> > +    g_free(prealloc);
> > +    if (local_err) {
> > +        ret = -EINVAL;
> > +        error_propagate(errp, local_err);
> > +        goto exit;
> > +    }
> > +
> >      options = qdict_new();
> >      qemu_rbd_parse_filename(filename, options, &local_err);
> >      if (local_err) {
> 
> [...]
> 
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7ccbfff9d0..db25a4065b 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4277,13 +4277,15 @@
> >  #                   point to a snapshot.
> >  # @size             Size of the virtual disk in bytes
> >  # @cluster-size     RBD object size
> > +# @preallocation    Preallocation mode (allowed values: off, full)
> 
> There should be a "(Since: 4.1)" note here.

I'll add the note!

Thanks for the review,
Stefano

