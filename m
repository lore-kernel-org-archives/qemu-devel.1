Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2B8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC63205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="dJU86NM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC63205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFK9-0007oI-Sr
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jZEnM-00084z-Hu
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:25:08 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:39597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jZEnJ-00071B-Vr
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=qb7MJ5r6JWTjjMsn01Tsw5Zx0rM6bq9F8oCzmQCCFj8=; b=dJU86NM6RSXnfPgNUXUx4W2GN7
 +RJUmjV04ysmYip/r5eYe5rT4njhs3Ctc4gmeWbBepJ7ajaXwOKGuGRyVF5WeY7HgElJM/cFBi590
 rP9VwjzflQZKG6cYmpK8vUhq3fp8+0foaLJDjvxaDYy8HfC323EQ1ZCMd6gqND9vaoO+55Bc7Z2CU
 RkOLprc0NLB8G4Ss/pA2DFb/75RiWNNzjLgpoZY3LwL+2tONePTzI8O9uk+MoktRRzzAquNXwmu7k
 vlNnbysEC07nF7AndzQbvIKGdB0x6Nqh+3vtfYwWY0yBjfXh3g01c06Znzl9zXREWMBq+a0GKJku3
 kSlNnphe+AZNBQEiHtoSmuZ+SayAmcgGMLdbzN0GCopv6EwsKFTYxuqA6AXiTlFF5HDKS7hjbXUB7
 SjOu+Y35XKcroQf8PEwte/KQLV9tQLaM6vXYFSyGyyT0RAFGsM/13AT77HX9ScAddABInAwVwGzyq
 7dFGGMCNl0EaLCfhxHlQJepQQuN6jaTA4yaRcRgGY3VzSNyjiQgaY/0Sg65V1GFfGbBXzknbSt9+b
 9Q/cc3NSINHFwyB3nTbGTacwz98V4i3GNIcCgWcMlFvM9XFAan4TCyJlywoc3WErOV29rNgNRGGdX
 k74+t45ZlsjCwJxzEC2gFzNYGEcUWdXa6xBmf34M8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
Date: Thu, 14 May 2020 16:24:59 +0200
Message-ID: <3966630.RI2PehbzW4@silver>
In-Reply-To: <alpine.DEB.2.21.2005131531400.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <6359442.q4qrkmKcdg@silver>
 <alpine.DEB.2.21.2005131531400.26167@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 10:25:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 14. Mai 2020 01:31:30 CEST Stefano Stabellini wrote:
> > If there is really no way with Xen to ensure there's always a buffer size
> > according to msize,
> 
> Thank you for the long writeup. Let's see if we can come up with a
> good plan.
> 
> The Xen transport
> (https://xenbits.xenproject.org/docs/4.13-testing/misc/9pfs.html) has a
> shared memory area with 64 pages, so 256KB. It is split in half: 128KB
> for requests and 128KB for responses.

That's very little. That also means you won't be able to ever achieve decent 
9pfs performance with Xen, because that requires a much larger msize of 
approximately msize >= 4MB, depending on the underlying I/O hardware, tendency 
growing (due to rising I/O hardware bandwidth).

> The original error message is the following:
> 
>   xen be: 9pfs-0: xen be: 9pfs-0: Xen 9pfs request type 116 needs 126987
> bytes, buffer has 126965 Xen 9pfs request type 116needs 126987 bytes,
> buffer has 126965
> 
> and msize was set to 131072 in the Linux client.
> 
> So transport_size == msize. However, there can be multiple requests and
> responses inflight at any given time. It means that even with
> transport_size=128KB and msize=4KB we could still have so many outstanding
> requests that the available memory is less then 4KB.
> 
> I admit that with transport_size=128KB and msize=4KB it would be so
> unlikely to happen that it would be close to impossible to reproduce the
> error. But theoretically it is possible.

Even though msize=4kiB is the default value with Linux clients, I would never 
use such a small value as it would cause an extremely poor 9pfs performance. 
My plan BTW is to log a performance warning soon if a client is using such a 
little msize.

> If we can't come up with any better ideas, we could simply limit the
> msize in the Linux client to something like transport_size/2 or
> transport_size/4, but it doesn't feel right.

That sounds like it would just reduce likeliness for the low buffer situation 
to happen with Xen, it would not prevent it though.

As far as I understand you now, the problem with Xen transport seems to be 
that clients can submit requests more quickly than the 9pfs server could 
process. That would change the overall situation completely, because my hack 
solution with delaying delivery (yield) suggested previously, was based on the 
assumption that this low transport buffer scenario only happens once on boot, 
but not possibly at any later point again and again.

> > As you can see it all boils down to one thing: better look for a solution
> > for Xen to deliver the required buffer size, or in worst case: yield the
> > coroutine, i.e. delay delivery of response until that can be assured by
> > Xen.
> That's might be the best option. But it would have to be
> xen_9pfs_init_in_iov_from_pdu to call qemu_coroutine_yield() in a loop?
> Like:
> 
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 18fe5b7c92..ef1db47d0c 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -197,18 +197,13 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU
> *pdu, g_free(ring->sg);
> 
>      ring->sg = g_new0(struct iovec, 2);
> -    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
> 
> +again:
> +    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
>      buf_size = iov_size(ring->sg, num);
> -    if (buf_size  < P9_IOHDRSZ) {
> -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> -                "needs %zu bytes, buffer has %zu, less than minimum\n",
> -                pdu->id, *size, buf_size);
> -        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> -    }
>      if (buf_size  < *size) {
> -        *size = buf_size;
> +        qemu_coroutine_yield();
> +        goto again;
>      }
> 
>      *piov = ring->sg;
> 
> 
> How is the coroutine going to get scheduled again? Is it automatic or do
> we need to call it again explicitly when we get the next notification
> from the client, which should arrive as soon as the client finishes
> reading the responses?

I "think" the coroutine would be resumed in the next main loop iteration. But 
I am still reading up on qemu's coroutine implementation details myself. So 
that might work, yes, even though in a hackish way.

And as explained above, if this situation not only happens on boot, then you 
might consider a different approach. There is also yield_until_fd_readable(int 
fd); BTW. However the obvious step would be increasing Xen transport capacity 
tremendously at first place.

Looks like this issue will still take quite some time to be fixed with Xen. If 
you don't mind I'll send out a patch to revert truncation on virtio side, so 
that at least this bug is fixed with virtio ASAP.

Best regards,
Christian Schoenebeck



