Received: from eggs.gnu.org ([2001:4830:134:3::10]:35598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqKTA-0000OW-Nw
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqKT6-0005gE-Co
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:13:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eqKT6-0005g2-7U
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:13:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA4D8407519B
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 15:13:31 +0000 (UTC)
Date: Mon, 26 Feb 2018 15:13:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180226151328.GD2873@work-vm>
References: <20180226130452.21309-1-dgilbert@redhat.com>
	<70a6755d-22e4-3463-8ab0-6804c38af5b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70a6755d-22e4-3463-8ab0-6804c38af5b9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] serial: Open non-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 26/02/2018 14:04, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > On a real serial device, the open can block if the handshake
> > lines are in a particular state.  If a QEMU is passing the serial
> > device to the guest, the QEMU startup is blocked opening the device
> > (with a symptom seen as a timeout from libvirt).
> > 
> > Open the serial port with O_NONBLOCK.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Socket chardevs have "nowait" for that.  Should serial have something
> similar?

Hmm, maybe, although I think for real serial the nonblocking open should
be the default.
I've not got any more complex tests though for it.
stty -F uses the same trick of opening non-blocking.

Dave

> Thanks,
> 
> Paolo
> 
> > ---
> >  chardev/char-serial.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> > index feb52e559d..97be5d4a63 100644
> > --- a/chardev/char-serial.c
> > +++ b/chardev/char-serial.c
> > @@ -265,7 +265,8 @@ static void qmp_chardev_open_serial(Chardev *chr,
> >      ChardevHostdev *serial = backend->u.serial.data;
> >      int fd;
> >  
> > -    fd = qmp_chardev_open_file_source(serial->device, O_RDWR, errp);
> > +    fd = qmp_chardev_open_file_source(serial->device, O_RDWR | O_NONBLOCK,
> > +                                      errp);
> >      if (fd < 0) {
> >          return;
> >      }
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
