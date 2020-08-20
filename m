Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA68C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D23C2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h08YhgDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D23C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8iOO-0000oF-HC
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 07:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8iNg-0000Ft-Hb
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:05:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8iNd-0007ll-5i
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597921511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NIkbhjgws7GFTBkHX2EEgAeAKK4kgdpuPWkqxIVuWQM=;
 b=h08YhgDa7yY29pV9grX7+fsq5YxaU282lJW4xEYZzlDK227yNwhF4ZAekiq2DNcwjQ2Vvb
 d90WuiL/PbBdyoAuEgfQVgpMPwJcgd5VjoNZ42bPqC7jRb1jzZzr/KB54PhFQd5K1TOss8
 cooBX0l9GnEEZMRF5PnAc7OztgYLzFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-P9fmYd1_MgSg5X__H52DoA-1; Thu, 20 Aug 2020 07:05:09 -0400
X-MC-Unique: P9fmYd1_MgSg5X__H52DoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D43C51009441;
 Thu, 20 Aug 2020 11:05:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 282AD1014186;
 Thu, 20 Aug 2020 11:05:02 +0000 (UTC)
Date: Thu, 20 Aug 2020 13:05:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 07/22] block/export: Remove magic from block-export-add
Message-ID: <20200820110501.GB99531@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-8-kwolf@redhat.com>
 <b2958a79-f7c6-7bc2-8895-50924f15afd9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b2958a79-f7c6-7bc2-8895-50924f15afd9@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.08.2020 um 21:50 hat Eric Blake geschrieben:
> cc: Peter Krempa
> 
> On 8/13/20 11:29 AM, Kevin Wolf wrote:
> > nbd-server-add tries to be convenient and adds two questionable
> > features that we don't want to share in block-export-add, even for NBD
> > exports:
> > 
> > 1. When requesting a writable export of a read-only device, the export
> >     is silently downgraded to read-only. This should be an error in the
> >     context of block-export-add.
> 
> I'd be happy for this to be an error even with nbd-export-add; I don't think
> it would harm any of libvirt's existing usage (either for storage migration,
> or for incremental backups).
> 
> Side note: In the past, I had a proposal to enhance the NBD Protocol to
> allow a client to advertise to the server its intent on being a read-only or
> read-write client.  Not relevant to this patch, but this part of the commit
> message reminds me that I should revisit that topic (Rich and I recently hit
> another case in nbdkit where such an extension would be nice, when it comes
> to using NBD's multi-conn for better performance on a read-only connection,
> but only if the server knows the client intends to be read-only)
> 
> > 
> > 2. When using a BlockBackend name, unplugging the device from the guest
> >     will automatically stop the NBD server, too. This may sometimes be
> >     what you want, but it could also be very surprising. Let's keep
> >     things explicit with block-export-add. If the user wants to stop the
> >     export, they should tell us so.
> 
> Here, keeping the nbd command different from the block-export command seems
> tolerable.  On the other hand, I wonder if Peter needs to change anything in
> libvirt's incremental backup code to handle this sudden disappearance of an
> NBD device during a disk hot-unplug (that is, either the presence of an
> ongoing pull-mode backup should block disk unplug, or libvirt needs a way to
> guarantee that an ongoing backup NBD device remains in spite of subsequent
> disk actions on the guest).  Depending on libvirt's needs, we may want to
> revisit the nbd command to have the same policy as block-export-add, plus an
> introspectible feature notation.

As long as we can keep the compatibility code local to qmp_nbd_*(), I
don't think it's too bad. In particular because it's already written.

Instead of adjusting libvirt to changes in the nbd-* commands, I'd
rather have it change over to block-export-*. I would like to see the
nbd-server-add/remove commands deprecated soon after we have the
replacements.

> > 
> > Move these things into the nbd-server-add QMP command handler so that
> > they apply only there.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   include/block/nbd.h   |  3 ++-
> 
> > +void qmp_block_export_add(BlockExportOptions *export, Error **errp)
> > +{
> > +    blk_exp_add(export, errp);
> >   }
> >   void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
> >   {
> > -    BlockExportOptions export = {
> > +    BlockExport *export;
> > +    BlockDriverState *bs;
> > +    BlockBackend *on_eject_blk;
> > +
> > +    BlockExportOptions export_opts = {
> >           .type = BLOCK_EXPORT_TYPE_NBD,
> >           .u.nbd = *arg,
> >       };
> > -    qmp_block_export_add(&export, errp);
> > +
> > +    /*
> > +     * nbd-server-add doesn't complain when a read-only device should be
> > +     * exported as writable, but simply downgrades it. This is an error with
> > +     * block-export-add.
> 
> I'd be happy with either marking this deprecated now (and fixing it in two
> releases), or declaring it a bug in nbd-server-add now (and fixing it
> outright).

How about deprecating nbd-server-add completely?

> > +     */
> > +    bs = bdrv_lookup_bs(arg->device, arg->device, NULL);
> > +    if (bs && bdrv_is_read_only(bs)) {
> > +        arg->writable = false;
> > +    }
> > +
> > +    export = blk_exp_add(&export_opts, errp);
> > +    if (!export) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * nbd-server-add removes the export when the named BlockBackend used for
> > +     * @device goes away.
> > +     */
> > +    on_eject_blk = blk_by_name(arg->device);
> > +    if (on_eject_blk) {
> > +        nbd_export_set_on_eject_blk(export, on_eject_blk);
> > +    }
> 
> Wait - is the magic export removal tied only to exporting a drive name, and
> not a node name?  So as long as libvirt is using only node names whwen
> adding exports, a drive being unplugged won't interfere?

Yes, seems so. It's the existing behaviour, I'm only moving the code
around.

> Overall, the change makes sense to me, although I'd love to see if we could
> go further on the writable vs. read-only issue.

If nbd-server-add will be going away relatively soon, it's probably not
worth the trouble. But if you have reasons to keep it, maybe we should
consider it.

Kevin


