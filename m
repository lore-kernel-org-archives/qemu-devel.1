Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F94C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396B1206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBGp7bkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396B1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGgH-0004qa-B5
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZGfN-00040i-PE
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZGfM-0007n8-AC
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:25:01 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCA0220671;
 Thu, 14 May 2020 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589473499;
 bh=B9b/n1FYmXifToMzdkpqpkAgQqqdYGGv1CMFaePMk/g=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=HBGp7bkngfnbTGDe8KStUuv9hZEghIwB4Kfn0HksnkH4jmApsVHeOtHFF0UVVUxQv
 y8CxIfZDs0CQ12x3URkRr9otbZBl001bEr9+v+UiCTrNnWxV5LgLNv3LtiPr/TagKG
 JXuTsBiuHWftQwlul6Sr8yQ6/NyQx8tGIi+Pc2mk=
Date: Thu, 14 May 2020 09:24:58 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
In-Reply-To: <3966630.RI2PehbzW4@silver>
Message-ID: <alpine.DEB.2.21.2005140853310.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <6359442.q4qrkmKcdg@silver>
 <alpine.DEB.2.21.2005131531400.26167@sstabellini-ThinkPad-T480s>
 <3966630.RI2PehbzW4@silver>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:51:28
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

On Thu, 14 May 2020, Christian Schoenebeck wrote:
> On Donnerstag, 14. Mai 2020 01:31:30 CEST Stefano Stabellini wrote:
> > > If there is really no way with Xen to ensure there's always a buffer size
> > > according to msize,
> > 
> > Thank you for the long writeup. Let's see if we can come up with a
> > good plan.
> > 
> > The Xen transport
> > (https://xenbits.xenproject.org/docs/4.13-testing/misc/9pfs.html) has a
> > shared memory area with 64 pages, so 256KB. It is split in half: 128KB
> > for requests and 128KB for responses.
> 
> That's very little. That also means you won't be able to ever achieve decent 
> 9pfs performance with Xen, because that requires a much larger msize of 
> approximately msize >= 4MB, depending on the underlying I/O hardware, tendency 
> growing (due to rising I/O hardware bandwidth).

That's great feedback. Fortunately the size of the transport is
configurable so it is one liner away from becoming much bigger (well,
two oneliners, see net/9p/trans_xen.c:XEN_9PFS_RING_ORDER in Linux, and
hw/9pfs/xen-9p-backend.c:MAX_RING_ORDER in QEMU.)

Would you recommend 4MB each way, so a total of 8MB?


> > The original error message is the following:
> > 
> >   xen be: 9pfs-0: xen be: 9pfs-0: Xen 9pfs request type 116 needs 126987
> > bytes, buffer has 126965 Xen 9pfs request type 116needs 126987 bytes,
> > buffer has 126965
> > 
> > and msize was set to 131072 in the Linux client.
> > 
> > So transport_size == msize. However, there can be multiple requests and
> > responses inflight at any given time. It means that even with
> > transport_size=128KB and msize=4KB we could still have so many outstanding
> > requests that the available memory is less then 4KB.
> > 
> > I admit that with transport_size=128KB and msize=4KB it would be so
> > unlikely to happen that it would be close to impossible to reproduce the
> > error. But theoretically it is possible.
> 
> Even though msize=4kiB is the default value with Linux clients, I would never 
> use such a small value as it would cause an extremely poor 9pfs performance. 
> My plan BTW is to log a performance warning soon if a client is using such a 
> little msize.

Sounds good to me too


> > If we can't come up with any better ideas, we could simply limit the
> > msize in the Linux client to something like transport_size/2 or
> > transport_size/4, but it doesn't feel right.
> 
> That sounds like it would just reduce likeliness for the low buffer situation 
> to happen with Xen, it would not prevent it though.

Right


> As far as I understand you now, the problem with Xen transport seems to be 
> that clients can submit requests more quickly than the 9pfs server could 
> process. That would change the overall situation completely, because my hack 
> solution with delaying delivery (yield) suggested previously, was based on the 
> assumption that this low transport buffer scenario only happens once on boot, 
> but not possibly at any later point again and again.

Yes I think it could happen at any time, not just at boot.

From my understanding, I don't think it is necessarily due to QEMU being
slow. In fact, if QEMU was slow and the client fast, the reply ring
would be empty because the client would be up to speed, therefore msize
== transport_available_size, and there is no problem.

I think it happens when the client submits a bunch of requests but then
it is slow in reading back the replies. Hence, replies accumulate on the
ring, and transport_available_size < msize.

Given that currently the total ring size for replies is equal to msize,
we just need 2 inflight requests to potentially cause the situation.
For instance, a read of 10 bytes and a read of 128KB (max msize): if
issued together they lead to QEMU writing 10 bytes on the reply ring,
and then not having enough room to write 128KB anymore. This example is
a bit of an oversimplification because it doesn't account of the size of
the headers, but I hope you got my point.

So maybe it is OK to delaying delivery because it seems to me that is
the issue.

Also I am thinking that if we are going to increase the ring size to
4MB, maybe we should take the opportunity to set msize=transport_size/2
just to reduce the likelihood of this kind of issue, in addition to a
proper fix.

So maybe transport=8MB and msize=4MB or transport=4MB and msize=2MB.


> > > As you can see it all boils down to one thing: better look for a solution
> > > for Xen to deliver the required buffer size, or in worst case: yield the
> > > coroutine, i.e. delay delivery of response until that can be assured by
> > > Xen.
> > That's might be the best option. But it would have to be
> > xen_9pfs_init_in_iov_from_pdu to call qemu_coroutine_yield() in a loop?
> > Like:
> > 
> > 
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > index 18fe5b7c92..ef1db47d0c 100644
> > --- a/hw/9pfs/xen-9p-backend.c
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -197,18 +197,13 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU
> > *pdu, g_free(ring->sg);
> > 
> >      ring->sg = g_new0(struct iovec, 2);
> > -    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
> > 
> > +again:
> > +    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
> >      buf_size = iov_size(ring->sg, num);
> > -    if (buf_size  < P9_IOHDRSZ) {
> > -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> > -                "needs %zu bytes, buffer has %zu, less than minimum\n",
> > -                pdu->id, *size, buf_size);
> > -        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> > -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> > -    }
> >      if (buf_size  < *size) {
> > -        *size = buf_size;
> > +        qemu_coroutine_yield();
> > +        goto again;
> >      }
> > 
> >      *piov = ring->sg;
> > 
> > 
> > How is the coroutine going to get scheduled again? Is it automatic or do
> > we need to call it again explicitly when we get the next notification
> > from the client, which should arrive as soon as the client finishes
> > reading the responses?
> 
> I "think" the coroutine would be resumed in the next main loop iteration. But 
> I am still reading up on qemu's coroutine implementation details myself. So 
> that might work, yes, even though in a hackish way.
> 
> And as explained above, if this situation not only happens on boot, then you 
> might consider a different approach. There is also yield_until_fd_readable(int 
> fd); BTW. However the obvious step would be increasing Xen transport capacity 
> tremendously at first place.

Yes, I think we want to do three things:
- increase the transport size for performance
- set msize=transport_size/2 to decrease the likehood of this kind of
  issues
- introduce a slow but safe fix when the issue happens, and
  qemu_coroutine_yield() or yield_until_fd_readable() could be OK if it
  is very rare

