Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F65C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A398820674
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hg/NfVWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A398820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8lMu-0008TY-UV
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8lLk-0007vW-HL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:15:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8lLh-0007wU-Dd
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597932921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PaVB4l8qh968froKiExnji4R7K/eFW9mRp7Bvquepc0=;
 b=hg/NfVWa89OIKQt1KsGy9OBgJhsXMbGEU2zW39YuFH3MCos2KSEdQ1fXBPaii6b/uWr5G6
 3voicgflaOabxG4fdehEgeU3zM5D/e1nXXA9NCruujuY0n3IwqzMHf4/BgaOxawrV+rAIo
 2i87vgiuU/JRn7quPH9PkcjtI1quELg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-xDuLzFiqNJO9-k_t9mDcag-1; Thu, 20 Aug 2020 10:15:19 -0400
X-MC-Unique: xDuLzFiqNJO9-k_t9mDcag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7372318A2241;
 Thu, 20 Aug 2020 14:15:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ED2968865;
 Thu, 20 Aug 2020 14:15:15 +0000 (UTC)
Date: Thu, 20 Aug 2020 16:15:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 13/22] block/export: Move refcount from NBDExport to
 BlockExport
Message-ID: <20200820141514.GF99531@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-14-kwolf@redhat.com>
 <0ff82c83-16eb-c544-553a-9a58c9453133@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0ff82c83-16eb-c544-553a-9a58c9453133@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.08.2020 um 22:58 hat Eric Blake geschrieben:
> On 8/13/20 11:29 AM, Kevin Wolf wrote:
> > Having a refcount makes sense for all types of block exports. It is also
> > a prerequisite for keeping a list of all exports at the BlockExport
> > level.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> 
> > +++ b/include/block/export.h
> > @@ -21,14 +21,24 @@ typedef struct BlockExport BlockExport;
> >   typedef struct BlockExportDriver {
> >       BlockExportType type;
> >       BlockExport *(*create)(BlockExportOptions *, Error **);
> > +    void (*delete)(BlockExport *);
> >   } BlockExportDriver;
> >   struct BlockExport {
> >       const BlockExportDriver *drv;
> > +
> > +    /*
> > +     * Reference count for this block export. This includes strong references
> > +     * both from the owner (qemu-nbd or the monitor) and clients connected to
> > +     * the export.
> 
> I guess 'the monitor' includes qemu-storage-daemon.

Yes, qemu-storage-daemon has a QMP monitor, so I would count it there.
Even the --export command line option only calls the QMP command
internally.

> > +     */
> > +    int refcount;
> >   };
> >   extern const BlockExportDriver blk_exp_nbd;
> >   BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
> > +void blk_exp_ref(BlockExport *exp);
> > +void blk_exp_unref(BlockExport *exp);
> 
> Yay, I think this naming is more consistent with the rest of qemu...
> 
> >   #endif
> > diff --git a/include/block/nbd.h b/include/block/nbd.h
> > index 23030db3f1..af8509ab70 100644
> > --- a/include/block/nbd.h
> > +++ b/include/block/nbd.h
> > @@ -336,8 +336,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
> >   void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
> >   void nbd_export_close(NBDExport *exp);
> >   void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
> > -void nbd_export_get(NBDExport *exp);
> > -void nbd_export_put(NBDExport *exp);
> 
> ...as opposed to this which is common in kernel but less so in this project.
> No hard feelings from me :)
> 
> > +++ b/blockdev-nbd.c
> > @@ -232,7 +232,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
> >       /* The list of named exports has a strong reference to this export now and
> >        * our only way of accessing it is through nbd_export_find(), so we can drop
> >        * the strong reference that is @exp. */
> > -    nbd_export_put(exp);
> > +    blk_exp_unref((BlockExport*) exp);
> 
> Even a helper function that converts NBDBlockExport* to BlockExport* rather
> than a cast might be nicer, but then again, I see from Max's review that
> this may be a temporary state of things.
> (The QAPI contains such type-safe container casts, such as
> qapi_DriveBackup_base(), if that helps...)

Yes, this goes away before the end of the series.

> > @@ -1537,7 +1536,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
> >       exp = g_new0(NBDExport, 1);
> >       exp->common = (BlockExport) {
> > -        .drv = &blk_exp_nbd,
> > +        .drv        = &blk_exp_nbd,
> > +        .refcount   = 1,
> 
> I'm not sure whether trying to align the '=' is good, because the moment you
> add a longer field name, every other line has to be touched.  I'm fine with
> just one space on both side of =, even if it is more ragged to read.  But
> you're the author, so you get to pick.

I generally prefer aligned '=' because the code is read much more often
than it is written or modified, so being friendly for readers is
important.

> > @@ -1626,8 +1625,9 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
> >       exp->ctx = ctx;
> >       blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
> > +    blk_exp_ref(&exp->common);
> >       QTAILQ_INSERT_TAIL(&exports, exp, next);
> > -    nbd_export_get(exp);
> > +
> 
> Is there any consequence to this changed ordering in grabbing the reference
> vs. updating the list?

No intended consequences, but if Max is right that the code (before and
after this series) lacks some locking, it might make a theoretical
difference. If it does, the new code is safer than the old one. If it
doesn't, it's just more consistent with the order I'm used to see in
other places: First take the reference, then use it.

Kevin


