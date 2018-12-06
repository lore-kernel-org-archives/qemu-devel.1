Received: from eggs.gnu.org ([2001:4830:134:3::10]:38196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUr4u-0003zM-L8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUqoN-00031J-1g
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:23:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gUqoL-0002tp-2t
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:23:14 -0500
Date: Thu, 6 Dec 2018 10:23:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206102306.GI29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Dec 05, 2018 at 10:01:00PM +0100, Kamil Rytarowski wrote:
> On 05.12.2018 21:43, Ed Maste wrote:
> > I'd very much like to have CI coverage for QEMU on FreeBSD, and as of
> > yesterday there's a hosted CI service that supports FreeBSD: Cirrus
> > CI. They also offer free service for OSS projects. I created a
> > .cirrus.yml (shown below) in a QEMU GitHub fork and successfully
> > executed a build test.
> > 
> > I can submit a patch to add the config file, but wanted to ask for
> > advice or comments from those who set up the existing Linux CI first.
> > Is there anything I should be aware of or should address? Although
> > this is a very basic build / test I believe it will prove quite
> > valuable in reducing the latency between a commit and finding an issue
> > on FreeBSD.
> > 
> > .cirrus.yml:
> > freebsd_instance:
> >   image: freebsd-12-0-rc3-amd64
> > 
> > env:
> >   CIRRUS_CLONE_DEPTH: 1
> > 
> > task:
> >   install_script: pkg install -y git glib gmake perl5 pixman pkgconf

I'd encourage you to loook at installing as many deps as possible to
maximise the coverage. eg gnutls, nettle, spice, and anything else that
is relevant

> >   script:
> >     - mkdir build
> >     - cd build
> >     - ../configure || { cat config.log; exit 1; }
> >     - gmake
> >     - gmake check

Are the Cirrus CI environments SMP ? If so adding a -j flag would
give much improved build times.

> > 
> 
> There are already FreeBSD, OpenBSD and NetBSD test scripts in the qemu
> project.
> 
> I'm not sure whether there is any integration with GitHub.

The trouble is that these are all VMs, and (AFAIK) none of the free CI
services let you spin up arbitrary VM images with KVM, only allow for
custom docker images.

So unless there's some way for us actually run the VM images on a public
CI that we already use, I think it is reasonable to use Cirrus CI for
FeeBSD testing.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
