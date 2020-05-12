Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25AC2D0F8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 23:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFA020731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 23:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLfF131Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFA020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYeGn-00032c-4e
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 19:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jYeG8-0002dm-CG
 for qemu-devel@nongnu.org; Tue, 12 May 2020 19:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jYeG3-0004tz-76
 for qemu-devel@nongnu.org; Tue, 12 May 2020 19:24:23 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8F0020731;
 Tue, 12 May 2020 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589325857;
 bh=EbLEx7T5IHNXX+ZubYr3+gxJhjQ3YF1Iw46J3GtoBzg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=rLfF131YDaXGtqRggXxo+r+Kjxl+lqQTWnKrbgwqedo2m0bm2KRbJMBpGOuYUUOMo
 JAhkzAJx0sGXMUD3o1ISWGhKGJt5g7o3Fc8mcXmT1jBpk76rC3LiadTZfJvIbygRZg
 MSu2NO90KuAu++5U7gHb/O5yebv8ivSsDYpW83ww=
Date: Tue, 12 May 2020 16:24:16 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
In-Reply-To: <3732481.xNstV0F5bx@silver>
Message-ID: <alpine.DEB.2.21.2005121602520.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <54f3b9c9f05a77ccdd6103bd46c828fcb675cbac.1589132512.git.qemu_oss@crudebyte.com>
 <alpine.DEB.2.21.2005111454160.26167@sstabellini-ThinkPad-T480s>
 <3732481.xNstV0F5bx@silver>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 19:24:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony Perard <anthony.perard@citrix.com>, Greg Kurz <groug@kaod.org>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020, Christian Schoenebeck wrote:
> On Dienstag, 12. Mai 2020 00:09:46 CEST Stefano Stabellini wrote:
> > On Sun, 10 May 2020, Christian Schoenebeck wrote:
> > > Commit SHA-1 16724a173049ac29c7b5ade741da93a0f46edff7 introduced
> > > truncating the response to the currently available transport buffer
> > > size, which was supposed to fix an 9pfs error on Xen boot where
> > > transport buffer might still be smaller than required for response.
> > > 
> > > Unfortunately this change broke small reads (with less than 12
> > > bytes).
> > > 
> > > To address both concerns, check the actual response type and only
> > > truncate reply for Rreaddir responses,
> > 
> > I realize you mean "Rread" (not Rreaddir).
> 
> Yes, that's currently an unfortunate auto completion issue in my head due to 
> having spent too much time on readdir() code lately. I'm working on it. ;-)

ahahah


> > Are we sure that truncation
> > can only happen with Rread? I checked the spec it looks like Directories
> > are pretty much like files from the spec point of view. So it seems to
> > me that truncation might be possible there too.
> 
> That's the big question here: do we need to address this for other types than 
> Rread? So far I only addressed this for Rread because from what you described 
> you were encountering that Xen boot issue only with reads, right?

That's right


> What we cannot do is simply truncating any response arbitrarily without 
> looking at the precise response type. With Rread (9p2000.L) it's quite simple, 
> because it is Ok (i.e. from client & guest OS perspective) to return 
> *arbitrarily* less data than originally requested by client.
> 
> A problem with Rread would be protocol variant 9p2000.u, because such clients 
> would also use Rread on directories. In that case client would end up with 
> trash data -> undefined behaviour.
> 
> Likewise for Rreaddir (9p2000.L) it would be much more complicated, we could 
> truncate the response, but we may not truncate individual directory entries of 
> that response. So not only the Rreaddir header must be preserved, we also 
> would have to look at the individual entries (their sizes vary for each entry 
> individually) returned and only truncate at the boundaries of individual 
> entries inside the response, otherwise client would receive trash data -> 
> undefined behaviour.

Let me premise that this patch fixes an important bug, so I am not
asking you to do any more work to get this patch committed right now :-)

But I think it would be good to test what would happen if the client did
a read on a directory with hundreds of entries, such as a maildir
directory. There has to be point where the number of directory entries
is larger than the shared buffer. What happens then?

I am guessing that we'll have to implement the "truncate at the
boundaries of individual entries" to get it right in all cases.

Given that it doesn't look like truncation would work right with
Rreaddir anyway today, I think it would be OK to fix it in a separate
patch.


> And that's it, for all other 9P types we can't truncate response at all. For 
> those types we could probably just return EAGAIN, but would it help? Probably 
> would require changes on client side as well then to handle this correctly.

I think the critical ones are Rread and Rreaddir. I wonder if we could
even reproduce a bug with any of the other 9p types. Probably not. So
returning an error might be good enough. Returning an error is also way
better than calling virtio_error or xen_9pfs_disconnect, more on this
below.


> > > and only if truncated reply would at least return one payload byte to
> > > client. Use Rreaddir's precise header size (11) for this instead of
> > > P9_IOHDRSZ.
> > 
> > Ah! That's the underlying error isn't it? That P9_IOHDRSZ is not really
> > the size of the reply header, it is bigger. Hence the check:
> > 
> >   if (buf_size < P9_IOHDRSZ) {
> > 
> > can be wrong for very small sizes.
> 
> Exactly. We need to handle this according to the precise header size of the 
> respective response type. But unfortunately that's not enough, like described 
> above in detail.

OK got it


> > > Fixes: 16724a173049ac29c7b5ade741da93a0f46edff7
> > > Fixes: https://bugs.launchpad.net/bugs/1877688
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > > 
> > >  hw/9pfs/virtio-9p-device.c | 35 +++++++++++++++++++++++++++--------
> > >  hw/9pfs/xen-9p-backend.c   | 38 +++++++++++++++++++++++++++++---------
> > >  2 files changed, 56 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > > index 536447a355..57e4d92ecb 100644
> > > --- a/hw/9pfs/virtio-9p-device.c
> > > +++ b/hw/9pfs/virtio-9p-device.c
> > > @@ -154,15 +154,34 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU
> > > *pdu, struct iovec **piov,> 
> > >      VirtQueueElement *elem = v->elems[pdu->idx];
> > >      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> > > 
> > > -    if (buf_size < P9_IOHDRSZ) {
> > > -        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > +    if (pdu->id + 1 == P9_RREAD) {
> > > +        /* size[4] Rread tag[2] count[4] data[count] */
> > 
> > 4+2+4 = 10
> 
> That's 4+1+2+4 = 11
> 
> You were missing "Rread" here which identifies the (numeric) 9P response type 
> and which is always 1 byte in size.

I thought so. Could you please update the comment in the code? As is it
is a bit confusing.

 
> > > +        const size_t hdr_size = 11;
> > 
> > Are you adding 1 to account for "count"?
> 
> The idea was that from client perspective a successful read() call must at 
> least return 1 byte. We must not return 0 bytes, because that would indicate 
> EOF for POSIX systems. For that reason the minimum Rread response size would 
> be:
> 
> 	header_size + 1 payload_byte
> 
> and hence
> 
> 	11 + 1 = 12

Yes I think you are right


> > > +        /*
> > > +         * If current transport buffer size is smaller than actually
> > > required +         * for this Rreaddir response, then truncate the
> > > response to the +         * currently available transport buffer size,
> > > however only if it would +         * at least allow to return 1 payload
> > > byte to client.
> > > +         */
> > > +        if (buf_size < hdr_size + 1) {
> > 
> > If you have already added 1 before, why do we need to add 1 again here?
> 
> See desription above. Variable 'hdr_size' is the Rread header size (11 bytes) 
> and +1 is added here for the minimum payload data returned.

OK


> > > +            VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > 
> > > -        virtio_error(vdev,
> > > -                     "VirtFS reply type %d needs %zu bytes, buffer has
> > > %zu, less than minimum", -                     pdu->id + 1, *size,
> > > buf_size);
> > > -    }
> > > -    if (buf_size < *size) {
> > > -        *size = buf_size;
> > > +            virtio_error(vdev,
> > > +                         "VirtFS reply type %d needs %zu bytes, buffer
> > > has " +                         "%zu, less than minimum (%zu)",
> > > +                         pdu->id + 1, *size, buf_size, hdr_size + 1);
> > > +        }
> > 
> > I think we want to return here
> 
> I just preserved your structure as it was. If you tell me it should return 
> here, I will add a return. NP.

The point I was trying to make is that it doesn't make a lot of sense to
try to do any operations after calling virtio_error. I am not a virtio
expert but certainly in the case of Xen below we cannot continue after
calling xen_9pfs_disconnect. The whole connection gets closed, more on
this below.


> > 
> > > +        if (buf_size < *size) {
> > > +            *size = buf_size;
> > > +        }
> > > +    } else {
> > > +        if (buf_size < *size) {
> > > +            VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > +
> > > +            virtio_error(vdev,
> > > +                         "VirtFS reply type %d needs %zu bytes, buffer
> > > has %zu", +                         pdu->id + 1, *size, buf_size);
> > > +        }
> > > 
> > >      }
> > >      
> > >      *piov = elem->in_sg;
> > > 
> > > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > > index f04caabfe5..98f340d24b 100644
> > > --- a/hw/9pfs/xen-9p-backend.c
> > > +++ b/hw/9pfs/xen-9p-backend.c
> > > @@ -201,15 +201,35 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU
> > > *pdu,> 
> > >      xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
> > >      
> > >      buf_size = iov_size(ring->sg, num);
> > > 
> > > -    if (buf_size  < P9_IOHDRSZ) {
> > > -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs
> > > " -                      "%zu bytes, buffer has %zu, less than
> > > minimum\n", -                      pdu->id + 1, *size, buf_size);
> > > -        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> > > -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> > > -    }
> > > -    if (buf_size  < *size) {
> > > -        *size = buf_size;
> > > +    if (pdu->id + 1 == P9_RREAD) {
> > > +        /* size[4] Rread tag[2] count[4] data[count] */
> > > +        const size_t hdr_size = 11;
> > > +        /*
> > > +         * If current transport buffer size is smaller than actually
> > > required +         * for this Rreaddir response, then truncate the
> > > response to the +         * currently available transport buffer size,
> > > however only if it would +         * at least allow to return 1 payload
> > > byte to client.
> > > +         */
> > > +        if (buf_size < hdr_size + 1) {
> > > +            xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d "
> > > +                          "needs %zu bytes, buffer has %zu, less than "
> > > +                          "minimum (%zu)\n",
> > > +                          pdu->id + 1, *size, buf_size, hdr_size + 1);
> > > +            xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> > > +            xen_9pfs_disconnect(&xen_9pfs->xendev);
> > 
> > I htink we want to return here.
> 
> Same thing: if you want a return here, I will add it.

I think we have to return here because the connection gets closed by
xen_9pfs_disconnect. I wonder if we should return -EAGAIN like you
suggested instead of calling xen_9pfs_disconnect() which is
irrecoverable. But that could be done later in a separate patch.

