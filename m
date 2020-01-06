Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFBBC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397F2207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXMDtnFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397F2207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioY6H-0000go-8O
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sstabellini@kernel.org>) id 1ioY5S-0008TA-IA
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sstabellini@kernel.org>) id 1ioY5R-0004xO-9E
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sstabellini@kernel.org>)
 id 1ioY5R-0004vm-1C
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:30:49 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CF019207FD;
 Mon,  6 Jan 2020 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578339047;
 bh=Zr2a3QnGSlSg+5wUtJEvdPlP7eexDngZxc2J2B44KJs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=EXMDtnFKmsc1BY9hMxCRy6VPfDquO1UF6dTlebgQzMoyBiDf/DKNrvfTilBf8wQfZ
 LE6cQc+rWIbGv2ys8fkaRuyxBImeYrxm+BRafS2HziWIa575sUe1ifMgflzBJca1vz
 SqkimfKw76SMlmHvABwIPXXIJSr0YSYvY8MwPUuA=
Date: Mon, 6 Jan 2020 11:30:46 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9p: init_in_iov_from_pdu can truncate the size
In-Reply-To: <20200106183114.6b1a4de4@bahia.lan>
Message-ID: <alpine.DEB.2.21.2001061115110.732@sstabellini-ThinkPad-T480s>
References: <20191219004251.23763-1-sstabellini@kernel.org>
 <20200106144254.79920ae7@bahia.lan> <2163433.xPYm55Bgvh@silver>
 <20200106183114.6b1a4de4@bahia.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
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
Cc: anthony.perard@citrix.com, Stefano Stabellini <sstabellini@kernel.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Stefano Stabellini <stefano.stabellini@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020, Greg Kurz wrote:
> On Mon, 06 Jan 2020 16:24:18 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > On Montag, 6. Januar 2020 14:42:54 CET Greg Kurz wrote:
> > > > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > > > index 775e8ff766..68873c3f5f 100644
> > > > --- a/hw/9pfs/virtio-9p-device.c
> > > > +++ b/hw/9pfs/virtio-9p-device.c
> > > > @@ -145,19 +145,15 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu,
> > > > size_t offset,> 
> > > >  }
> > > >  
> > > >  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec
> > > >  **piov,
> > > > 
> > > > -                                        unsigned int *pniov, size_t size)
> > > > +                                        unsigned int *pniov, size_t
> > > > *size)
> > > > 
> > > >  {
> > > >  
> > > >      V9fsState *s = pdu->s;
> > > >      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
> > > >      VirtQueueElement *elem = v->elems[pdu->idx];
> > > >      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> > > > 
> > > > -    if (buf_size < size) {
> > > > -        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > > -
> > > > -        virtio_error(vdev,
> > > > -                     "VirtFS reply type %d needs %zu bytes, buffer has
> > > > %zu", -                     pdu->id + 1, size, buf_size);
> > > > +    if (buf_size < *size) {
> > > > +        *size = buf_size;
> > > > 
> > > >      }
> > > 
> > > As suggested by Christian in some other mail, it could still make sense to
> > > raise the error if there isn't even enough space to pack a 9p message
> > > header.
> > 
> > Another option: Instead of handling this as a hard error (which they probably 
> > try to avoid in their use case): putting the handler asleep for a while by 
> > calling qemu_co_sleep_ns_wakeable() in this case. Then a bit later transport 
> > would eventually have the required buffer size and handler could continue the 
> > request without an error.
> > 
> 
> Waiting for an arbitrary amount of time (how much?) and retrying doesn't give
> any guarantee either that things will go smoothly. If anything, I'd rather have
> the transport to wake up the request when more buffer space gets available.
> 
> > But this would require more care. For instance subsequent request handlers 
> > would need to check if there was already an event handler asleep, and if so it 
> > would either need to wake it up or put itself asleep as well to prevent the 
> > request order being processed by server being messed up.
> > 
> 
> And so on... ie. we would need to handle a queue of sleeping requests IIUC.
> Not really fan to go this way to address what looks like a corner case.

I agree with you that handling requests queuing is complex and overkill
for this. As I don't have a better suggestion, I am going to go with
retaining the error if the allocated buf_size is less than P9_IOHDRSZ.

