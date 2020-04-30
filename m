Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE5C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A1C2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="tjM4II46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A1C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8hM-0007gt-OD
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jU8gC-0005fy-GJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jU8eO-00070P-7H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:52:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:49489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jU8eN-0006yi-0v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ds1lrRqmSx903DpdqZMJVhfBBA+/t3UoZ/Qn/oYL7cM=; b=tjM4II46SuAzRBxTgRjaiEiUS7
 2ya04B2EHtETAunCdGAC8LfK1vDld++a+0JJ3fTXlbQYvLq19EbATwvtv6SbVUIQVmhyzmZTylbUR
 pAdOEM/r2P4X6pTgXYAFWl6KraePSHbtI0RoFY88pXxqIUgzaPQFRecYtYxCJ0ygON/purkd/EZXp
 czg6FQfrg3xhTJ5KWMs4xP1TTMcukXXhMP1L6CI1//PkPqlod/I0KI8iCNCR1Xl9nvx+wUNL26hcS
 UEHZsyg//pIpym197e7vu72slKk9FgJ7XbONBw4tEFPOGhcTQ9vF94YghFf6URz3hcdpF4UO60z2/
 4vDyQqQXkt72jMxmqJBL7OoPeOV5bP5voSJ92/J+HvMSSxSMO7uj75MqxkCK5ejh9sog9NmB/Kti0
 B3l4Vrnh1XmwI88O+cFQO5K+TNmpLeHnJA7WvtE8BB8OIntSedOmzC5h7QNd1/TQNlmYldDL+lhB0
 l5bumT7PTfNliuGvNGkzTbxPEA/kcmy3pvUNrHT55m+NsnSl53AIvg6CSoUgdFpJ6I+KkAJO9R/Y6
 gnRSUjJQzN4xMMHV+mCmUopKucUyMQ4qGjt7yYDtRlix+S6JY9yNwZg/GZjUlr/MfRfRPh9PWDFRW
 oABKYJWMkdc2IIi8BZ7PD+DW6XBbYT/11resSBPz4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 3/5] 9pfs: add new function v9fs_co_readdir_many()
Date: Thu, 30 Apr 2020 14:50:31 +0200
Message-ID: <5059845.6LZZmIoT5M@silver>
In-Reply-To: <20200430134235.524df46e@bahia.lan>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <fdb0e29a86d1df6005021a08078d7e69ed0de1a2.1587309014.git.qemu_oss@crudebyte.com>
 <20200430134235.524df46e@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:50:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 30. April 2020 13:42:35 CEST Greg Kurz wrote:
> > +/*
> > + * This is solely executed on a background IO thread.
> > + *
> > + * See v9fs_co_readdir_many() (as its only user) below for details.
> > + */
> > +static int do_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
> > +                             struct V9fsDirEnt **entries,
> > +                             int32_t maxsize, bool dostat)
> > +{
> > +    V9fsState *s = pdu->s;
> > +    V9fsString name;
> > +    int len, err = 0;
> > +    int32_t size = 0;
> > +    off_t saved_dir_pos;
> > +    struct dirent *dent;
> > +    struct V9fsDirEnt *e = NULL;
> > +    V9fsPath path;
> > +    struct stat stbuf;
> > 
> > -            errno = 0;
> > -            entry = s->ops->readdir(&s->ctx, &fidp->fs);
> > -            if (!entry && errno) {
> > +    *entries = NULL;
> > +    v9fs_path_init(&path);
> > +
> > +    /*
> > +     * TODO: Here should be a warn_report_once() if lock failed.
> > +     *
> > +     * With a good 9p client we should not get into concurrency here,
> > +     * because a good client would not use the same fid for concurrent
> > +     * requests. We do the lock here for safety reasons though. However
> > +     * the client would then suffer performance issues, so better log
> > that
> > +     * issue here.
> > +     */
> > +    v9fs_readdir_lock(&fidp->fs.dir);
> 
> I agree that a client that issues concurrent readdir requests on the
> same fid is probably asking for troubles, but this permitted by the
> spec. Whether we should detect such conditions and warn or even fail
> is discussion for another thread.
> 
> The locking is only needed to avoid concurrent accesses to the dirent
> structure returned by readdir(), otherwise we could return partially
> overwritten file names to the client. It must be done for each individual
> call to readdir(), but certainly not for multiple calls.

Yeah, that would resolve this issue more appropriately for 9p2000.L, since 
Treaddir specifies an offset, but for 9p2000.u the result of a concurrent read 
on a directory (9p2000.u) would still be undefined.

> As discussed privately, I'm working on a patch to better address the
> locking and I'd really prefer to merge this before your series. Sorry
> for the delay again. I'll try to post ASAP.
> 
> Anyway, I have some more remarks.
> 
> > +
> > +    /* save the directory position */
> > +    saved_dir_pos = s->ops->telldir(&s->ctx, &fidp->fs);
> > +    if (saved_dir_pos < 0) {
> > +        err = saved_dir_pos;
> > +        goto out;
> > +    }
> > +
> > +    while (true) {
> > +        /* get directory entry from fs driver */
> > +        err = do_readdir(pdu, fidp, &dent);
> > +        if (err || !dent) {
> > +            break;
> > +        }
> > +
> > +        /*
> > +         * stop this loop as soon as it would exceed the allowed maximum
> > +         * response message size for the directory entries collected so
> > far, +         * because anything beyond that size would need to be
> > discarded by +         * 9p controller (main thread / top half) anyway
> > +         */
> > +        v9fs_string_init(&name);
> > +        v9fs_string_sprintf(&name, "%s", dent->d_name);
> > +        len = v9fs_readdir_response_size(&name);
> > +        v9fs_string_free(&name);
> > +        if (size + len > maxsize) {
> > +            /* this is not an error case actually */
> > +            break;
> > +        }
> > +
> > +        /* append next node to result chain */
> > +        if (!e) {
> > +            *entries = e = g_malloc0(sizeof(V9fsDirEnt));
> > +        } else {
> > +            e = e->next = g_malloc0(sizeof(V9fsDirEnt));
> > +        }
> > +        e->dent = g_malloc0(sizeof(struct dirent));
> 
> So we're allocating a bunch of stuff here...
> 
> > +        memcpy(e->dent, dent, sizeof(struct dirent));
> > +
> > +        /* perform a full stat() for directory entry if requested by
> > caller */ +        if (dostat) {
> > +            err = s->ops->name_to_path(
> > +                &s->ctx, &fidp->path, dent->d_name, &path
> > +            );
> > +            if (err < 0) {
> > 
> >                  err = -errno;
> > 
> > -            } else {
> > -                *dent = entry;
> > -                err = 0;
> > +                break;
> 
> ... but we're erroring out there and it seems that we're leaking
> all the entries that have been allocated so far.

No, they are not leaking actually.

You are right that they are not deallocated in do_readdir_many(), but that's 
intentional: in the new implementation of v9fs_do_readdir() you see that 
v9fs_free_dirents(entries) is *always* called at the very end of the function, 
no matter if success or any error. That's one of the measures to simplify 
overall code as much as possible.

As you might have noticed, the previous/current v9fs_do_readdir() 
implementation had quite a bunch of individual error pathes, which is quite 
error prone or at least makes it difficult to maintain. So I think it makes 
sense to strip unnecessary branches as much as possible.

> Also I have the impression that all the if (dostat) { } block could
> be done before chaining a new entry.

Yes, you could move it forward, but what would you buy from that?

I think you mean the case when there's an error inside the if (dostat) {} 
block: The comments on struct V9fsDirEnt already suggest that the "st" member 
is optional and may be NULL. So if there's an error inside if (dostat) {}
then caller still has a valid "dent" field at least and it's up to caller 
whether or not it's a problem for its purpose that "st" is empty. For that 
reason I would not move the block forward.

Best regards,
Christian Schoenebeck



