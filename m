Received: from eggs.gnu.org ([2001:4830:134:3::10]:59535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciNW5-0001Ae-0X
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciNW1-0007Cd-Db
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:47:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciNW1-0007CT-51
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:47:09 -0500
Date: Mon, 27 Feb 2017 15:47:02 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170227154702.GQ18219@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CGME20170213171108eucas1p147999fc8b6980ff89a67626b78b12e44@eucas1p1.samsung.com>
	<20170213171058.GA4246@aperevalov-ubuntu>
	<20170213181601.GG3086@work-vm>
	<20170214162155.GB6645@aperevalov-ubuntu>
	<20170214193425.GF11561@work-vm>
	<20170221073115.GA5046@aperevalov-ubuntu>
	<20170221100313.GB2377@work-vm>
	<20170227110520.GA27506@aperevalov-R560>
	<20170227112657.GE2350@work-vm> <20170227150015.GB5816@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170227150015.GB5816@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org

On Mon, Feb 27, 2017 at 04:00:15PM +0100, Andrea Arcangeli wrote:
> Hello,
> 
> On Mon, Feb 27, 2017 at 11:26:58AM +0000, Dr. David Alan Gilbert wrote:
> > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > Also if I'm not wrong, commands and pages are transferred over the same
> > > socket. Why not to use OOB TCP in this case for commands?
> > 
> > My understanding was that OOB was limited to quite small transfers
> > I think the right way is to use a separate FD for the requests, so I'll
> > do it after Juan's multifd series.
> 
> OOB would do the trick and we considered it some time ago, but we need
> this to work over any network pipe including TLS (out of control of
> qemu but setup by libvirt), and OOB being a protocol level TCP
> specific feature in the kernel, I don't think there's any way to
> access it through TLS APIs abstractions. Plus like David said there
> are issues with the size of the transfer.

Correct, there's no facility for handling OOB data when a socket is
using TLS. Also note that QEMU might not even have a TCP socket,
as when libvirt is tunnelling migration over the libvirtd connection,
QEMU will just be given a UNIX socket or even a anoymous pipe. So any
use of OOB data is pretty much out of the question. 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
