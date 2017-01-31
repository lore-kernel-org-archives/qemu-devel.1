Received: from eggs.gnu.org ([2001:4830:134:3::10]:41141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cYZ65-00022C-Cl
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cYZ62-0004OF-7N
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:07:49 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:57120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cYZ61-0004O9-Ur
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:07:46 -0500
Date: Tue, 31 Jan 2017 09:07:45 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <31961688.771677.1485871665864.JavaMail.zimbra@redhat.com>
In-Reply-To: <421566746.771522.1485871592528.JavaMail.zimbra@redhat.com>
References: <1485870329-79428-1-git-send-email-eswierk@skyportsystems.com>
	<421566746.771522.1485871592528.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char: drop data written to a disconnected
 pty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, berrange@redhat.com, pbonzini@redhat.com, marcandre lureau <marcandre.lureau@redhat.com>, eblake@redhat.com, ben@skyportsystems.com

Hi

----- Original Message -----
> Hi
> 
> ----- Original Message -----
> > When a serial port writes data to a pty that's disconnected, drop the
> > data and return the length dropped. This avoids triggering pointless
> > retries in callers like the 16550A serial_xmit(), and causes
> > qemu_chr_fe_write() to write all data to the log file, rather than
> > logging only while a pty client like virsh console happens to be
> > connected.
> > 
> > Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
> > ---
> >  qemu-char.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/qemu-char.c b/qemu-char.c
> > index 676944a..ccb6923 100644
> > --- a/qemu-char.c
> > +++ b/qemu-char.c
> > @@ -1528,7 +1528,7 @@ static int pty_chr_write(CharDriverState *chr, const
> > uint8_t *buf, int len)
> >          /* guest sends data, check for (re-)connect */
> >          pty_chr_update_read_handler_locked(chr);
> >          if (!s->connected) {
> > -            return 0;
> > +            return len;
> 
> I think this can be confusing if some backends silently drop the data (under
> disconnected state), while other don't. Perhaps we should have instead a new
> common chardev property "hup-drop" ? (suggestions for better name welcome)
> 

actually,tcp_chr_write() already drops data on disconnected state, so they would have different default value for backward compatibility...

> >          }
> >      }
> >      return io_channel_send(s->ioc, buf, len);
> > --
> > 1.9.1
> > 
> > 
> 
