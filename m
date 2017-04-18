Received: from eggs.gnu.org ([2001:4830:134:3::10]:39376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d0WkY-0007Td-50
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d0WkU-0000Yq-58
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:17:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1d0WkT-0000YX-V2
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:17:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3E629E61D
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 17:17:04 +0000 (UTC)
Date: Tue, 18 Apr 2017 18:17:03 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170418171703.GY30620@redhat.com>
References: <20170418152424.GX30620@redhat.com>
	<9ae9d913-2516-72dc-adaf-cdd0f082c486@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae9d913-2516-72dc-adaf-cdd0f082c486@redhat.com>
Subject: Re: [Qemu-devel] virtio-scsi limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Apr 18, 2017 at 05:30:52PM +0200, Paolo Bonzini wrote:
> > When I changed libguestfs to use LUNs instead of targets (target=0
> > unit=i), I got a peculiar bug.  It looks like there is some kind of
> > race when enumerating the device, where /sys is populated before the
> > device is actually available.
> 
> That's not _too_ surprising because devtmpfs processes creation/deletion
> requests asynchronously.

I had a bit of a look into this, and I don't think this can be right.
At this point we're running inside the initramfs environment, where
/dev is a rootfs (a special case of either ramfs or tmpfs).

Would it still be the case that a single process that does mknod
followed by mount could not see the effect of the mknod?

The mount error (EINVAL) should indicate an invalid superblock rather
than a missing inode (if you believe the documentation, so that may be
wrong).

The sequence of events (happening in a single init process) is as
described below:

> > https://github.com/libguestfs/supermin/blob/master/init/init.c#L176
> > 
> > * fp = fopen ("/sys/block/sdab/dev", "r") succeeds at line 181
> > 
> > * we read major:minor from fp at line 230
> > 
> > * we mknod ("/dev/root",...) at line 245
> > 
> > * we mount ("/dev/root", "/root", "ext2"...) at line 262, which fails with
> >   EINVAL
> > 
> > * shortly after that, kernel messages indicate that sdab has been
> >   attached.

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
