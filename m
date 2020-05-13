Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D8C2D0FC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838922124A
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="lV+kRiV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838922124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYrBl-0003WH-PL
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 09:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jYrB8-000373-2m
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:12:06 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:47935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jYrB6-0006JM-Hq
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ppXfdfqmV2KaY3iTJLetCQIO+IFebWsreEWjiSPqrbQ=; b=lV+kRiV4cg5Eh3Jc0h1Vc+1SFQ
 L94lk9ebKczfhZKie2+oY7d9JP5oa6SLiyA+5v+SiHSI3QnPlv3fB4U4eOqpQS46uNgYdZvVHDw3e
 a+RUxseXvQmuKh90AhkvsGk9bla9XnFP59LWoQKeP/hTIRGbE/OCq/ziqQBiVEpw0HzwsRQ9FANQP
 VJqU6+K6GL/wYWxXoBPul6372noBtstVFmhy8N21OoSXmrlvryFRBF88UOzkkoCX/rg2mrde4lltI
 ot9MMtkN0T4x1GcufCWq2cLcqq5be6JfDk1Rca+1soxnBqPZnCWVSrLpwDVlJZBjEniUE3cyaeKTC
 q5DJmkrb6sxl1h50htz3muM5VlNYv/l8DzaGXV9NT8GRSXjZ0xl8ykrkUJrHhnM3fLb3n3hoC0eA9
 /S1S6WTueALpJg9ACIRKjWS/g3MzEXUFAFV90dY8wvbtwKE4rUDzMS1GKuX3+n53vi4YpGAbY0w+h
 D0zmM6HIkM0c/vW/N2xONi9HrY3KtHe96DsJTlCxDnJf14KehzuQaMhaSg4wxki/pToJKchqN3r7l
 2bxuEGOlz6jZcclmJHSqFVYFw6TiNtCpgoavf+tpSwxb3FH4lnsLSz6PUqNmRKzLRaG4q58wtT1vs
 WJKBHPBQeB9J9TWUGWel6n3RBbZ0RmxMZvsFeI27k=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Greg Kurz <groug@kaod.org>,
 Paul Durrant <paul@xen.org>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
Date: Wed, 13 May 2020 15:11:52 +0200
Message-ID: <6359442.q4qrkmKcdg@silver>
In-Reply-To: <alpine.DEB.2.21.2005121602520.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <3732481.xNstV0F5bx@silver>
 <alpine.DEB.2.21.2005121602520.26167@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 09:12:01
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

On Mittwoch, 13. Mai 2020 01:24:16 CEST Stefano Stabellini wrote:
> Let me premise that this patch fixes an important bug, so I am not
> asking you to do any more work to get this patch committed right now :-)

Actually, I realized that this overall issue is much more delicate to handle 
than I thought. My patch would still miss other important things, like e.g. it 
does not roll back the read / readdir streaming positions of the respective 
FID on 9P server side. -> data loss / undefined behaviour on subsequent read / 
readdir

Also the 'count' parameter in the Rread response would need to be updated as 
well. -> undefined behaviour

For these and other reasons already described, I start to think that it is 
actually not a good idea to truncate the response at all, at least not at that 
final transport stage (as my or your patch do).

Question: is there really no way to handle this overall issue exlusively on 
Xen side, i.e. delaying response delivery until large enough transport buffer 
would be available or acquiring on-demand the required buffer size? Or by 
looking ahead at msize in advance (see below)?

From what I see now, I would recommend completely reverting response 
truncation on virtio transport side at least. Because so far I have not seen a 
single case with virtio where the transport buffer was too small for 
delivering any response. And as you can see, response truncation at late 
transport level opens all kinds of severe issues on other ends. It is not easy 
to do and requires a lot of code!

> But I think it would be good to test what would happen if the client did
> a read on a directory with hundreds of entries, such as a maildir
> directory. There has to be point where the number of directory entries
> is larger than the shared buffer. What happens then?

I'm talking about virtio only now: that scenario does not happen. When client 
opens a 9P session, client transmits 'msize' as parameter for the 9P sesssion 
which is the "maximum message size" ever to be assumed on both sides for  
client requests and server responses. By default msize is 4 kiB (4096 bytes) 
with Linux clients, and our server would immediately error out if any client 
tries to open a session with 'msize' < 4 kiB (for similar reasons discussed; 
because some 9P response types cannot be truncated at all):

https://github.com/qemu/qemu/commit/
e16453a31a00c1c0a199cab0617e8aa888f6419a#diff-f3e98ed0a65e27743b14785fa85b7d79

The Rread and Rreaddir responses are already truncated (in a sane and correct 
way) in 9p.c by server's request handler in case the response would exceed 
'msize'. For that reason it is actually unexpected that transport would not be 
able to provide the required transport buffer size for any response.

> I am guessing that we'll have to implement the "truncate at the
> boundaries of individual entries" to get it right in all cases.
> 
> Given that it doesn't look like truncation would work right with
> Rreaddir anyway today, I think it would be OK to fix it in a separate
> patch.

If there is really no way with Xen to ensure there's always a buffer size 
according to msize, then I fear this would need to be addressed in a 
completely different way: by changing the transport interface, early asking 
transport what the biggest buffer size would be, and then passing that info 
already early over to the 9P request handler (9p.c), such that it would 
already be able to assemble the individual responses *correctly* by using

	max_response_size = MIN(msize, client_requested_size, transport_size)

> > And that's it, for all other 9P types we can't truncate response at all.
> > For those types we could probably just return EAGAIN, but would it help?
> > Probably would require changes on client side as well then to handle this
> > correctly.
> I think the critical ones are Rread and Rreaddir. I wonder if we could
> even reproduce a bug with any of the other 9p types. Probably not. So
> returning an error might be good enough. Returning an error is also way
> better than calling virtio_error or xen_9pfs_disconnect, more on this
> below.

Xen *MUST* ensure to always deliver a transport buffer at least 4kiB in size 
for 9P responses. See my commit log message in the commit link provided above 
for detailed explanation why.

And IMO Xen should always be able to provide a transport buffer that's at 
least msize large. If that's the case, then we don't have to worry about 
anything else and can drop this transport truncation code.

> > > > Fixes: 16724a173049ac29c7b5ade741da93a0f46edff7
> > > > Fixes: https://bugs.launchpad.net/bugs/1877688
> > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > > ---
> > > > 
> > > >  hw/9pfs/virtio-9p-device.c | 35 +++++++++++++++++++++++++++--------
> > > >  hw/9pfs/xen-9p-backend.c   | 38
> > > >  +++++++++++++++++++++++++++++---------
> > > >  2 files changed, 56 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > > > index 536447a355..57e4d92ecb 100644
> > > > --- a/hw/9pfs/virtio-9p-device.c
> > > > +++ b/hw/9pfs/virtio-9p-device.c
> > > > @@ -154,15 +154,34 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU
> > > > *pdu, struct iovec **piov,>
> > > > 
> > > >      VirtQueueElement *elem = v->elems[pdu->idx];
> > > >      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> > > > 
> > > > -    if (buf_size < P9_IOHDRSZ) {
> > > > -        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > > +    if (pdu->id + 1 == P9_RREAD) {
> > > > +        /* size[4] Rread tag[2] count[4] data[count] */
> > > 
> > > 4+2+4 = 10
> > 
> > That's 4+1+2+4 = 11
> > 
> > You were missing "Rread" here which identifies the (numeric) 9P response
> > type and which is always 1 byte in size.
> 
> I thought so. Could you please update the comment in the code? As is it
> is a bit confusing.

I just copy pasted the 9P specs here, but NP, that's the smallest issue to 
address.

> I think we have to return here because the connection gets closed by
> xen_9pfs_disconnect. I wonder if we should return -EAGAIN like you
> suggested instead of calling xen_9pfs_disconnect() which is
> irrecoverable. But that could be done later in a separate patch.

Even -EAGAIN would require a bunch of code, since the precise error response 
type depends a) on the protocol dialect (9p2000.L vs. 9p2000.u) and b) even 
depending on the precise request type. For some 9P request types it is not 
even allowed to return an error response at all.

As you can see it all boils down to one thing: better look for a solution for 
Xen to deliver the required buffer size, or in worst case: yield the 
coroutine, i.e. delay delivery of response until that can be assured by Xen.

Best regards,
Christian Schoenebeck



