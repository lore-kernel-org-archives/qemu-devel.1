Received: from eggs.gnu.org ([2001:4830:134:3::10]:56089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ec76A-0002Dr-4k
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ec763-0001A9-UN
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:07:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ec763-00019S-K8
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:06:59 -0500
Date: Thu, 18 Jan 2018 10:06:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118100649.GD19695@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180110131832.16623-1-klim.kireev@virtuozzo.com>
	<71031eb9-06a0-21fe-dd89-4b49e23b97be@redhat.com>
	<fe310a84-9ffd-b167-0c42-5073e01afb04@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe310a84-9ffd-b167-0c42-5073e01afb04@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: klim <klim.kireev@virtuozzo.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, den@virtuozzo.com

On Thu, Jan 18, 2018 at 12:41:08PM +0300, klim wrote:
> On 01/16/2018 08:25 PM, Paolo Bonzini wrote:
> > On 10/01/2018 14:18, Klim Kireev wrote:
> > > The following behavior was observed for QEMU configured by libvirt
> > > to use guest agent as usual for the guests without virtio-serial
> > > driver (Windows or the guest remaining in BIOS stage).
> > > 
> > > In QEMU on first connect to listen character device socket
> > > the listen socket is removed from poll just after the accept().
> > > virtio_serial_guest_ready() returns 0 and the descriptor
> > > of the connected Unix socket is removed from poll and it will
> > > not be present in poll() until the guest will initialize the driver
> > > and change the state of the serial to "guest connected".
> > > 
> > > In libvirt connect() to guest agent is performed on restart and
> > > is run under VM state lock. Connect() is blocking and can
> > > wait forever.
> > > In this case libvirt can not perform ANY operation on that VM.
> > > 
> > > The bug can be easily reproduced this way:
> > > 
> > > Terminal 1:
> > > qemu-system-x86_64 -m 512 -device pci-serial,chardev=serial1 -chardev socket,id=serial1,path=/tmp/console.sock,server,nowait
> > > (virtio-serial and isa-serial also fit)
> > > 
> > > Terminal 2:
> > > minicom -D unix\#/tmp/console.sock
> > > (type something and pres enter)
> > > C-a x (to exit)
> > > 
> > > Do 3 times:
> > > minicom -D unix\#/tmp/console.sock
> > > C-a x
> > > 
> > > It needs 4 connections, because the first one is accepted by QEMU, then two are queued by
> > > the kernel, and the 4th blocks.
> > > 
> > > The problem is that QEMU doesn't add a read watcher after succesful read
> > > until the guest device wants to acquire recieved data, so
> > > I propose to install a separate pullhup watcher regardless of
> > > whether the device waits for data or not. After closing the connection,
> > > the guest has a capability to read the data within timeout.
> > I don't understand the timeout part.
> The timeout is important, because of following situation:
> client sends to the guest big bunch of data and closes his end of socket.
> if we just destroy the connection on the qemu's side, the guest can't read
> remaining data in channel.

Why is that a problem that needs solving ?  IMHO if the clients wants any
kind of assurance that the guest has read all the data, it should keep the
socket open and wait for a reply from the guest agent. It is totally
reasonable for the request to be dropped/partially sent if the client closes
the socket without waiting. The guest should be robust to seeing such
partial messages.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
