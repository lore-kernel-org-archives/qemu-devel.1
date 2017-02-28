Received: from eggs.gnu.org ([2001:4830:134:3::10]:60681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cieiZ-0003Fh-O4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cieiW-0007De-Iy
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:09:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cieiW-0007D1-Ce
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:09:12 -0500
Date: Tue, 28 Feb 2017 10:09:07 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170228100907.GD2762@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170227201456.31814-1-berrange@redhat.com>
	<739c3a03-fffe-46d0-0ba6-a328a9a18eb2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <739c3a03-fffe-46d0-0ba6-a328a9a18eb2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: ignore case when matching websockets
 HTTP headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

On Mon, Feb 27, 2017 at 03:20:37PM -0600, Eric Blake wrote:
> On 02/27/2017 02:14 PM, Daniel P. Berrange wrote:
> > According to RFC7230 Section 3.2, header field name is case-insensitive.
> > Convert the header data into all lowercase before doing string matching
> > on the headers.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  io/channel-websock.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> 
> > @@ -223,7 +223,7 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
> >  static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
> >                                                Error **errp)
> >  {
> > -    char *handshake_end;
> > +    char *handshake_end, *tmp;
> >      ssize_t ret;
> >      /* Typical HTTP headers from novnc are 512 bytes, so limiting
> >       * total header size to 4096 is easily enough. */
> 
> Drive-by grammar nit: s/easily/easy/
> 
> > @@ -249,9 +249,13 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
> >          }
> >      }
> >  
> > +    for (tmp = (char *)ioc->encinput.buffer; tmp < handshake_end; tmp++) {
> > +        *tmp = g_ascii_tolower(*tmp);
> > +    }
> > +
> >      if (qio_channel_websock_handshake_process(ioc,
> >                                                (char *)ioc->encinput.buffer,
> > -                                              ioc->encinput.offset,
> > +                                              handshake_end - (char *)ioc->encinput.buffer,
> 
> I'm not sure why this change is here; nothing else in the patch changed
> ioc->encinput.offset.

It is a related bug. The ioc->encinput buffer contains upto 4096
bytes, but that data may cover both the header & payload. The
handshake_end pointer refers to the end of the header region.
So if we just pass encinput.offset, then handshake_process()
will be searching part of the payload as well as the header.
This might cause it do match the wrong data. I guess I should
have made that clear in the commit, or even tput it in a
separate commit

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
