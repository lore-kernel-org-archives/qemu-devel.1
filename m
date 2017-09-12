Received: from eggs.gnu.org ([2001:4830:134:3::10]:37939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drh4E-0005gv-8V
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drh48-0002Ye-Mg
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drh48-0002Xv-H4
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:01:08 -0400
Date: Tue, 12 Sep 2017 10:01:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912090104.GB17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-7-brandon.carpenter@cypherpath.com>
	<20170911173743.GV21444@redhat.com>
	<1505151801.1214.2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505151801.1214.2@smtp.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] io: Reply to ping frames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: qemu-devel@nongnu.org

On Mon, Sep 11, 2017 at 10:43:21AM -0700, Brandon Carpenter wrote:
> On Mon, Sep 11, 2017 at 10:37 AM, Daniel P. Berrange <berrange@redhat.com>
> wrote:
> > At the time qio_channel_websock_decode_header is run, 'encinput' is only
> > guaranteed to contain enough data to decode the header.
> 
> Because the PING opcode is a control frame, this bit of code earlier in the
> function will ensure the entire frame has been read before the PING
> processing occurs:
> 
> >       if (ioc->encinput.offset < ioc->payload_remain) {
> >             /* Wait for the entire payload before processing control
> > frames
> >              * because the payload will most likely be echoed back. */
> >             if (ioc->opcode & QIO_CHANNEL_WEBSOCK_CONTROL_OPCODE_MASK) {
> >                 return QIO_CHANNEL_ERR_BLOCK;
> >             }
> >             payload_len = ioc->encinput.offset - (ioc->encinput.offset %
> > 4);

The problem is in the qio_channel_websock_read_wire method we refuse
to read more than 4k into encinput. So if the ping payload is greater
than 4k this will just loop forever.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
