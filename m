Received: from eggs.gnu.org ([2001:4830:134:3::10]:53780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1yS3-0002my-Af
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1yRx-0002Gb-CA
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1yRx-0002FY-3n
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:36:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26524C04AC6F
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:36:12 +0000 (UTC)
Date: Tue, 10 Oct 2017 18:36:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171010173607.GC18266@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-5-berrange@redhat.com>
	<44b7c0ce-b6a7-87e0-0317-059cb84d57b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44b7c0ce-b6a7-87e0-0317-059cb84d57b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 4/7] io: pass a struct iovec into
 qio_channel_websock_encode
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

On Tue, Oct 10, 2017 at 12:18:26PM -0500, Eric Blake wrote:
> On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> > Instead of requiring use of another Buffer, pass a struct iovec
> > into qio_channel_websock_encode, which gives callers more
> > flexibility in how they process data.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  io/channel-websock.c | 69 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 42 insertions(+), 27 deletions(-)
> > 
> 
> > +static void qio_channel_websock_encode(QIOChannelWebsock *ioc,
> > +                                       uint8_t opcode,
> > +                                       const struct iovec *iov,
> > +                                       size_t niov,
> > +                                       size_t size)
> >  {
> 
> Is size redundant with iov_size(iov, niov)?  Or is a caller allowed to
> pass a smaller size (tail end of iov is not encoded) or larger size
> (encoding stops at end of iov, even if size is not exhausted)?  I'd lean
> towards the former (one less parameter), especially since all callers in
> this patch could have passed iov_size(&iov, 1) for the same effect.

You've already noticed the code in later patch which passes a smaller
size. This lets me avoid having to duplicate the iovec array and
set smaller iov_len

> 
> > -    trace_qio_channel_websock_encode(ioc, opcode, header_size, buffer->offset);
> > -    buffer_reserve(output, header_size + buffer->offset);
> > -    buffer_append(output, header.buf, header_size);
> > -    buffer_append(output, buffer->buffer, buffer->offset);
> > +    trace_qio_channel_websock_encode(ioc, opcode, header_size, size);
> > +    buffer_reserve(&ioc->encoutput, header_size + size);
> > +    buffer_append(&ioc->encoutput, header.buf, header_size);
> > +    for (i = 0; i < niov && size != 0; i++) {
> > +        size_t want = iov->iov_len;
> > +        if (want > size) {
> > +            want = size;
> > +        }
> > +        buffer_append(&ioc->encoutput, iov->iov_base, want);
> > +        size -= want;
> > +    }
> 
> Umm, where are you incrementing iov? It appears you only tested with
> niov == 1.

Opps. Yeah, we need to cope with niov > 0 to satisfy qio_channel_writev
API contract, but the VNC server only ever sends a single iov element
so I didn't hit the bug.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
