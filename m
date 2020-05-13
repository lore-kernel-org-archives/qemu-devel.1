Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79400C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617C1205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="00jzpV5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617C1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ0rX-000201-Ar
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZ0qf-0001Z8-Jw
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZ0qc-0005uj-UK
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:31:37 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0543D205ED;
 Wed, 13 May 2020 23:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589412691;
 bh=ar21ty5LSENLSjCiFBp2poJI4AR2+QysXgKL7s3wjcg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=00jzpV5M/YbyHa/ejfZuaMpsOYSt5oio1coqIsxNBMsLEkrvRdh7EZpsMKIOvXxlp
 VNRfmd58PrBFH7Gam4f29Bo20Fhl/3p6J89fN41PC6axFZtmgh9bIRXj6xcBWrzv8i
 nAqn4JzI/OJqohbh1/cwQE/OUvp5buE5cu30C26s=
Date: Wed, 13 May 2020 16:31:30 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
In-Reply-To: <6359442.q4qrkmKcdg@silver>
Message-ID: <alpine.DEB.2.21.2005131531400.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <3732481.xNstV0F5bx@silver>
 <alpine.DEB.2.21.2005121602520.26167@sstabellini-ThinkPad-T480s>
 <6359442.q4qrkmKcdg@silver>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 19:31:31
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020, Christian Schoenebeck wrote:
> On Mittwoch, 13. Mai 2020 01:24:16 CEST Stefano Stabellini wrote:
> > Let me premise that this patch fixes an important bug, so I am not
> > asking you to do any more work to get this patch committed right now :-)
> 
> Actually, I realized that this overall issue is much more delicate to handle 
> than I thought. My patch would still miss other important things, like e.g. it 
> does not roll back the read / readdir streaming positions of the respective 
> FID on 9P server side. -> data loss / undefined behaviour on subsequent read / 
> readdir
> 
> Also the 'count' parameter in the Rread response would need to be updated as 
> well. -> undefined behaviour
> 
> For these and other reasons already described, I start to think that it is 
> actually not a good idea to truncate the response at all, at least not at that 
> final transport stage (as my or your patch do).
> 
> Question: is there really no way to handle this overall issue exlusively on 
> Xen side, i.e. delaying response delivery until large enough transport buffer 
> would be available or acquiring on-demand the required buffer size? Or by 
> looking ahead at msize in advance (see below)?
> 
> >From what I see now, I would recommend completely reverting response 
> truncation on virtio transport side at least. Because so far I have not seen a 
> single case with virtio where the transport buffer was too small for 
> delivering any response. And as you can see, response truncation at late 
> transport level opens all kinds of severe issues on other ends. It is not easy 
> to do and requires a lot of code!
> 
> > But I think it would be good to test what would happen if the client did
> > a read on a directory with hundreds of entries, such as a maildir
> > directory. There has to be point where the number of directory entries
> > is larger than the shared buffer. What happens then?
> 
> I'm talking about virtio only now: that scenario does not happen. When client 
> opens a 9P session, client transmits 'msize' as parameter for the 9P sesssion 
> which is the "maximum message size" ever to be assumed on both sides for  
> client requests and server responses. By default msize is 4 kiB (4096 bytes) 
> with Linux clients, and our server would immediately error out if any client 
> tries to open a session with 'msize' < 4 kiB (for similar reasons discussed; 
> because some 9P response types cannot be truncated at all):
> 
> https://github.com/qemu/qemu/commit/
> e16453a31a00c1c0a199cab0617e8aa888f6419a#diff-f3e98ed0a65e27743b14785fa85b7d79
> 
> The Rread and Rreaddir responses are already truncated (in a sane and correct 
> way) in 9p.c by server's request handler in case the response would exceed 
> 'msize'. For that reason it is actually unexpected that transport would not be 
> able to provide the required transport buffer size for any response.
>
> > I am guessing that we'll have to implement the "truncate at the
> > boundaries of individual entries" to get it right in all cases.
> > 
> > Given that it doesn't look like truncation would work right with
> > Rreaddir anyway today, I think it would be OK to fix it in a separate
> > patch.
> 
> If there is really no way with Xen to ensure there's always a buffer size 
> according to msize, 

Thank you for the long writeup. Let's see if we can come up with a
good plan.

The Xen transport
(https://xenbits.xenproject.org/docs/4.13-testing/misc/9pfs.html) has a
shared memory area with 64 pages, so 256KB. It is split in half: 128KB
for requests and 128KB for responses. 

The original error message is the following:

  xen be: 9pfs-0: xen be: 9pfs-0: Xen 9pfs request type 116 needs 126987 bytes, buffer has 126965
  Xen 9pfs request type 116needs 126987 bytes, buffer has 126965

and msize was set to 131072 in the Linux client.


So transport_size == msize. However, there can be multiple requests and
responses inflight at any given time. It means that even with
transport_size=128KB and msize=4KB we could still have so many outstanding
requests that the available memory is less then 4KB.

I admit that with transport_size=128KB and msize=4KB it would be so
unlikely to happen that it would be close to impossible to reproduce the
error. But theoretically it is possible.

If we can't come up with any better ideas, we could simply limit the
msize in the Linux client to something like transport_size/2 or
transport_size/4, but it doesn't feel right.


> > I think we have to return here because the connection gets closed by
> > xen_9pfs_disconnect. I wonder if we should return -EAGAIN like you
> > suggested instead of calling xen_9pfs_disconnect() which is
> > irrecoverable. But that could be done later in a separate patch.
> 
> Even -EAGAIN would require a bunch of code, since the precise error response 
> type depends a) on the protocol dialect (9p2000.L vs. 9p2000.u) and b) even 
> depending on the precise request type. For some 9P request types it is not 
> even allowed to return an error response at all.
> 
> As you can see it all boils down to one thing: better look for a solution for 
> Xen to deliver the required buffer size, or in worst case: yield the 
> coroutine, i.e. delay delivery of response until that can be assured by Xen.

That's might be the best option. But it would have to be
xen_9pfs_init_in_iov_from_pdu to call qemu_coroutine_yield() in a loop?
Like:


diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 18fe5b7c92..ef1db47d0c 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -197,18 +197,13 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     g_free(ring->sg);
 
     ring->sg = g_new0(struct iovec, 2);
-    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
 
+again:
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
     buf_size = iov_size(ring->sg, num);
-    if (buf_size  < P9_IOHDRSZ) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
-                "needs %zu bytes, buffer has %zu, less than minimum\n",
-                pdu->id, *size, buf_size);
-        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
-        xen_9pfs_disconnect(&xen_9pfs->xendev);
-    }
     if (buf_size  < *size) {
-        *size = buf_size;
+        qemu_coroutine_yield();
+        goto again;
     }
 
     *piov = ring->sg;


How is the coroutine going to get scheduled again? Is it automatic or do
we need to call it again explicitly when we get the next notification
from the client, which should arrive as soon as the client finishes
reading the responses?

