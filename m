Received: from eggs.gnu.org ([2001:4830:134:3::10]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e84LK-0000uC-MG
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e84LG-0005Ca-LZ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:06:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e84LG-0005CR-Cs
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:06:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DFCCC04AC60
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 13:06:29 +0000 (UTC)
Date: Fri, 27 Oct 2017 14:06:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171027130625.GB30686@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171027085548.3472-1-berrange@redhat.com>
	<20171027125920.GA2401@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171027125920.GA2401@work-vm>
Subject: Re: [Qemu-devel] [PATCH] net: detect errors from probing vnet hdr
 flag for TAP devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On Fri, Oct 27, 2017 at 01:59:22PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > When QEMU sets up a tap based network device backend, it mostly ignores errors
> > reported from various ioctl() calls it makes, assuming the TAP file descriptor
> > is valid. This assumption can easily be violated when the user is passing in a
> > pre-opened file descriptor. At best, the ioctls may fail with a -EBADF, but if
> > the user passes in a bogus FD number that happens to clash with a FD number that
> > QEMU has opened internally for another reason, a wide variety of errnos may
> > result, as the TUNGETIFF ioctl number may map to a completely different command
> > on a different type of file.
> > 
> > By ignoring all these errors, QEMU sets up a zombie network backend that will
> > never pass any data. Even worse, when QEMU shuts down, or that network backend
> > is hot-removed, it will close this bogus file descriptor, which could belong to
> > another QEMU device backend.
> > 
> > There's no obvious guaranteed reliable way to detect that a FD genuinely is a
> > TAP device, as opposed to a UNIX socket, or pipe, or something else. Checking
> > the errno from probing vnet hdr flag though, does catch the big common cases.
> > ie calling TUNGETIFF will return EBADF for an invalid FD, and ENOTTY when FD is
> > a UNIX socket, or pipe which catches accidental collisions with FDs used for
> > stdio, or monitor socket.
> > 
> > Previously the example below where bogus fd 9 collides with the FD used for the
> > chardev saw:
> > 
> > $ ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=hostnet0,fd=9 \
> >   -chardev socket,id=charchannel0,path=/tmp/qga,server,nowait \
> >   -monitor stdio -vnc :0
> > qemu-system-x86_64: -netdev tap,id=hostnet0,fd=9: TUNGETIFF ioctl() failed: Inappropriate ioctl for device
> > TUNSETOFFLOAD ioctl() failed: Bad address
> > QEMU 2.9.1 monitor - type 'help' for more information
> > (qemu) Warning: netdev hostnet0 has no peer
> > 
> > which gives a running QEMU with a zombie network backend.
> > 
> > With this change applied we get an error message and QEMU immediately exits
> > before carrying on and making a bigger disaster:
> 
> Right, that does make a better error so;
> 
> Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Is there anyway we could get that error before the -chardev goes and
> allocates the fd 9?

That is unfortunately determined by the order in which the QEMU command line
args are parsed, and chardevs are procssed before netdevs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
