Received: from eggs.gnu.org ([2001:4830:134:3::10]:53143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1yQG-0001Sf-LB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1yQC-00018z-Ma
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:34:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1yQC-00018j-De
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:34:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76A717E448
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:34:23 +0000 (UTC)
Date: Tue, 10 Oct 2017 18:34:19 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171010173419.GA18266@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-3-berrange@redhat.com>
	<5622c2ab-caa8-3c46-0926-c46218a3d179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5622c2ab-caa8-3c46-0926-c46218a3d179@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/7] io: simplify websocket ping reply
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Oct 10, 2017 at 11:55:25AM -0500, Eric Blake wrote:
> On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> > We must ensure we don't get flooded with ping replies if the outbound
> > channel is slow. Currently we do this by keeping the ping reply in a
> > separate temporary buffer and only writing it if the encoutput buffer
> > is completely empty. This is overly pessimistic, as it is reasonable
> > to add a ping reply to the encoutput buffer even if it has previous
> > data in it, as long as that previous data doesn't include a ping
> > reply.
> > 
> > To track this better, put the ping reply directly into the encoutput
> > buffer, and then record the size of encoutput at this time in
> > ping_remain. As we write encoutput to the underlying channel, we
> > can decrement the ping_remain counter. Once it hits zero, we can
> > accept further ping replies for transmission.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  include/io/channel-websock.h |  2 +-
> >  io/channel-websock.c         | 28 +++++++++++++++-------------
> >  2 files changed, 16 insertions(+), 14 deletions(-)
> > 
> 
> > +++ b/io/channel-websock.c
> > @@ -825,11 +825,14 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
> >          }
> >          return -1;
> >      } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
> > -        /* ping frames produce an immediate reply */
> > -        buffer_reset(&ioc->ping_reply);
> > -        qio_channel_websock_encode_buffer(
> > -            ioc, &ioc->ping_reply, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,
> > -            &ioc->encinput);
> > +        /* ping frames produce an immediate reply, as long as we've not still
> > +         * got a previous ping queued, in which case we drop the new pong */
> 
> Wouldn't that be a 'previous pong queued'?

Indeed

> 
> > +        if (ioc->ping_remain == 0) {
> > +            qio_channel_websock_encode_buffer(
> > +                ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,
> > +                &ioc->encinput);
> > +            ioc->ping_remain = ioc->encoutput.offset;
> > +        }
> 
> But if you change the comment, then naming the variable pong_remain may
> make more sense.

Yeah, that's sensible.

> 
> But naming is a bikeshed issue, so either way,
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
