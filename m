Received: from eggs.gnu.org ([2001:4830:134:3::10]:54697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX3fY-0003Ah-O8
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX3fU-0006VN-Vv
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gX3fU-0006TX-Pq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:31:12 -0500
Date: Wed, 12 Dec 2018 12:30:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181212123059.GD31033@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181210173151.16629-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181210173151.16629-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] virtio-fs: shared file system for
 virtual machines3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, sweil@redhat.com, swhiteho@redhat.com, stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu

On Mon, Dec 10, 2018 at 05:31:44PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This is the first RFC for the QEMU side of 'virtio-fs';
> a new mechanism for mounting host directories into the guest
> in a fast, consistent and secure manner.  Our primary use
> case is kata containers, but it should be usable in other scenarios
> as well.
> 
> There are corresponding patches being posted to Linux kernel,
> libfuse and kata lists.
> 
> For a fuller design description, and benchmark numbers, please see
> Vivek's posting of the kernel set here:
> 
> https://marc.info/?l=linux-kernel&m=154446243024251&w=2
> 
> We've got a small website with instructions on how to use it, here:
> 
> https://virtio-fs.gitlab.io/
> 
> and all the code is available on gitlab at:
> 
> https://gitlab.com/virtio-fs
> 
> QEMU's changes
> --------------
> 
> The QEMU changes are pretty small; 
> 
> There's a new vhost-user device, which is used to carry a stream of
> FUSE messages to an external daemon that actually performs
> all the file IO.  The FUSE daemon is an external process in order to
> achieve better isolation for security and resource control (e.g. number
> of file descriptors) and also because it's cleaner than trying to
> integrate libfuse into QEMU.

Overall I like the virtio-fs architecture more than the virtio-vsock+NFS
approach, as virtio-fs feels simpler and closer to virtio-9p with the
latter's proxy backends.

I never really liked the idea of having to mess around with the host
NFS server to exposed filesystems to guests, as that's systemwide
service.  The ability to have an isolated virtio-fs backend process
per filesystem share per guest is simpler from a mgmt pov.

One think I would like to see though is a general purpose, production
quality backend impl that is shipped by the QEMU project.  It is fine
if projects like Kata want to write a custom impl tailored to their
specific needs, but I think QEMU should have something as standard that
isn't just demoware. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
