Received: from eggs.gnu.org ([2001:4830:134:3::10]:35518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjqI0-0005fA-OV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjqHx-0006ez-03
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:42:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjqHw-0006da-Pi
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:42:40 -0500
Date: Fri, 3 Mar 2017 16:42:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170303164233.GH13631@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<20170303162128.GD13631@redhat.com>
	<e7d5aa7e-46a9-efba-bcf2-934b71e3bb74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7d5aa7e-46a9-efba-bcf2-934b71e3bb74@redhat.com>
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: G 3 <programmingkidx@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Fri, Mar 03, 2017 at 10:40:13AM -0600, Eric Blake wrote:
> On 03/03/2017 10:21 AM, Daniel P. Berrange wrote:
> 
> >>
> >> +#ifndef O_PATH
> >> +    #define O_PATH 0
> >> +#endif
> > 
> > Isn't the use of O_PATH required in order to fix the recent
> > security vulnerability in 9p ?  If so, then defining it to
> > 0 means the QEMU is silently becoming vulnerable once again
> > which I don't think is a good idea.
> 
> My understanding is that O_PATH is an optimization. It lets openat()
> succeed in some places where it would ordinarily fail (for example, it
> can be used to open a dir with mode 0000) - the resulting fd is
> limited-use (it cannot be used to read() or write(), but CAN be used as
> the relative fd for a subsequent openat(), for example).  If you define
> O_PATH to 0, then attempts to traverse paths will fail where the could
> have otherwise succeeded, but failure is okay (the CVE was that we were
> succeeding at opening through a guest-controlled symlink; whether we now
> fail or guarantee that we are not going through a symlink is a quality
> of implementation, but either way, we are at least immune from
> succeeding through a symlink).

So we're not vulnerable, but we are breaking some valid guest usage.
I don't much like the idea of doing that silently, but i guess there's
no better alternative.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
