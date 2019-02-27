Received: from eggs.gnu.org ([209.51.188.92]:50938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz15z-0004bN-Tb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz15y-00011s-PE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:26:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gz15y-0000cM-FH
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:26:06 -0500
Date: Wed, 27 Feb 2019 15:25:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227152525.GK31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225092846.GA4757@angien.pipo.sk>
	<20190225174001.GI379@stefanha-x1.localdomain>
	<87a7iincg0.fsf@dusky.pond.sub.org>
	<20190227151535.GE22539@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227151535.GE22539@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Feb 27, 2019 at 03:15:35PM +0000, Stefan Hajnoczi wrote:
> On Tue, Feb 26, 2019 at 10:09:19AM +0100, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> > > On Mon, Feb 25, 2019 at 10:28:46AM +0100, Peter Krempa wrote:
> > >> On Mon, Feb 25, 2019 at 09:50:26 +0100, Markus Armbruster wrote:
> > >> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> > >> Other than the above, this is a welcome improvement as I've personally
> > >> ran into scenarios where a feature in qemu was fixed but it was
> > >> impossible to detect whether given qemu version contains the fix as it
> > >> did not have any influence on the QMP schema.
> > >
> > > I'd like to make things as simpler as possible, but no simpler :).
> > >
> > > The simplest option is that the advertised features are set in stone at
> > > build time (e.g. selected with #ifdef if necessary).  But then we have
> > > no way of selecting features at runtime (e.g. based on kernel features).
> > >
> > > What do you think?
> > 
> > I think we should map the problem space, identify cases with actual
> > uses, then design a solution that covers them and can plausibly grow to
> > cover cases we anticipate.
> > 
> > The migrate-with-cache-direct-off-on-linux case is compile-time static.
> > 
> > Do we have or have we had a case that is not compile-time static?
> 
> I can't think of something that both requires query-qemu-features and
> isn't compile-time static.  But that could be because not many things
> require query-qemu-features :).
> 
> The philosophy on Linux seems to be: distros compile QEMU against
> headers that accurately reflect the system features that are available.
> Therefore there isn't a lot of runtime fallback logic in case a new QEMU
> is running on an old host.  This means we can get by with compile-time
> static features only.

This assumption is probably going to be more troublesome in future. It
is increasingly common to deploy libvirt & QEMU inside docker containers,
and there's not a strict requirement that the docker container image
is the same distro / version as the docker host. ie a Fedora docker
image could be run on a RHEL host & vica-verca. IOW we could see an older
kernel than what we compiled on. I don't know how common such mismatches
will be in practice, but at the Docker level there's nothing preventing
such mismatches, which means some people will inevitably end up running
in such scenarios whether we like it or not. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
