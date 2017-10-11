Received: from eggs.gnu.org ([2001:4830:134:3::10]:41629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2GAx-0001af-UN
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2GAt-0008QL-Ov
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:31:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2GAt-0008Q2-Ic
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:31:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D56A3DBC0
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 12:31:46 +0000 (UTC)
Date: Wed, 11 Oct 2017 13:31:43 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171011123143.GH20372@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171011100959.29326-1-berrange@redhat.com>
	<20171011100959.29326-5-berrange@redhat.com>
	<731291c2-90f9-e83a-73d7-ebe42da13d0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <731291c2-90f9-e83a-73d7-ebe42da13d0c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/7] io: pass a struct iovec into
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

On Wed, Oct 11, 2017 at 07:30:45AM -0500, Eric Blake wrote:
> On 10/11/2017 05:09 AM, Daniel P. Berrange wrote:
> > Instead of requiring use of another Buffer, pass a struct iovec
> > into qio_channel_websock_encode, which gives callers more
> > flexibility in how they process data.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> > +static void qio_channel_websock_encode(QIOChannelWebsock *ioc,
> > +                                       uint8_t opcode,
> > +                                       const struct iovec *iov,
> > +                                       size_t niov,
> > +                                       size_t size)
> >  {
> >      size_t header_size;
> > +    size_t i;
> >      union {
> >          char buf[QIO_CHANNEL_WEBSOCK_HEADER_LEN_64_BIT];
> >          QIOChannelWebsockHeader ws;
> 
> Is it worth adding assert(size <= iov_size(iov, niov)) near the top,
> 
> > +    trace_qio_channel_websock_encode(ioc, opcode, header_size, size);
> > +    buffer_reserve(&ioc->encoutput, header_size + size);
> > +    buffer_append(&ioc->encoutput, header.buf, header_size);
> > +    for (i = 0; i < niov && size != 0; i++) {
> > +        size_t want = iov[i].iov_len;
> > +        if (want > size) {
> > +            want = size;
> > +        }
> > +        buffer_append(&ioc->encoutput, iov[i].iov_base, want);
> > +        size -= want;
> > +    }
> 
> so we don't have to worry about a huge size causing us to buffer_reserve
> far too much space?

Sure, I can add that.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
