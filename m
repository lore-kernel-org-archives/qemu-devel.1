Received: from eggs.gnu.org ([2001:4830:134:3::10]:59947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZGWV-00019V-LX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZGWU-0006mA-Ao
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eZGWU-0006l8-1K
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:34:30 -0500
Date: Wed, 10 Jan 2018 13:34:18 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110133418.GS3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1514453778-5363-1-git-send-email-den@openvz.org>
	<20180110123354.GI3205@redhat.com>
	<8dd96abc-474f-6ea6-f2fc-d712db4be3ab@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dd96abc-474f-6ea6-f2fc-d712db4be3ab@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] io/channel-websock: handle continuous
 reads without any data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org

On Wed, Jan 10, 2018 at 04:31:21PM +0300, Edgar Kaziakhmedov wrote:
> 
> 
> On 01/10/2018 03:33 PM, Daniel P. Berrange wrote:
> > On Thu, Dec 28, 2017 at 12:36:18PM +0300, Denis V. Lunev wrote:
> > > From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> > > 
> > > According to the current implementation of websocket protocol in QEMU,
> > > qio_channel_websock_handshake_io tries to read handshake from the
> > > channel to start communication over tcp socket. But this subroutine
> > > doesn't cover scenario when socket was closed while handshaking. Therefore,
> > > if G_IO_IN is caught and qio_channel_websock_handshake_read returns
> > > zero, error has to be set and connection has to be done.
> > > 
> > > Such behaviour causes 100% CPU load in main QEMU loop, because main loop
> > > poll continues to receive and handle G_IO_IN events from websocket.
> > > 
> > > Step to reproduce 100% CPU load:
> > > - start qemu with the simplest configuration
> > >      $ qemu -vnc [::1]:1,websocket=7500
> > > 2) open any vnc listener (which doesn't follow websocket protocol)
> > >      $ vncviewer :7500
> > > 3) kill listener
> > > 4) qemu main thread eats 100% CPU usage
> > > 
> > > Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > CC: Daniel P. Berrange <berrange@redhat.com>
> > > ---
> > >   io/channel-websock.c | 8 +++++---
> > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/io/channel-websock.c b/io/channel-websock.c
> > > index 87ebdeb..71f046a 100644
> > > --- a/io/channel-websock.c
> > > +++ b/io/channel-websock.c
> > > @@ -581,9 +581,11 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
> > >           return FALSE;
> > >       }
> > >       if (ret == 0) {
> > > -        trace_qio_channel_websock_handshake_pending(ioc, G_IO_IN);
> > > -        /* need more data still */
> > > -        return TRUE;
> > > +        /* If G_IN_IO happened and there is no data to read, close connection */
> > > +        error_setg(&err, "connection was closed");
> > > +        qio_task_set_error(task, err);
> > > +        qio_task_complete(task);
> > > +        return FALSE;
> > This is bogus - 'ret == 0' from  qio_channel_websock_handshake_read()
> > does *not* imply end of file.
> > 
> > It says we have read some data, but not yet seen the end of the HTTP
> > headers.
> Yes, good catch.
> > 
> > If you want to detect EOF, you need to check the qio_channel_read()
> > function return value directly in that method.
> Directly in qio_channel_websock_handshake_read method suppose called in
> qio_channel_websock_handshake_read routine.

In this code:


    if (!handshake_end) {
        if (ioc->encinput.offset >= 4096) {
            qio_channel_websock_handshake_send_res_err(
                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_TOO_LARGE);
            error_setg(errp,
                       "End of headers not found in first 4096 bytes");
            return 1;
        } else {
            return 0;
        }
    }


There needs to be an extra else if branch added

  } else if (ret == 0) {
        qio_channel_websock_handshake_send_res_err(
            ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_EOF);
        error_setg(errp,
                   "End of headers not found before connection closed");
        return -1;  
  }


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
