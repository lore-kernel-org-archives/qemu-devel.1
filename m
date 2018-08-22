Received: from eggs.gnu.org ([2001:4830:134:3::10]:51055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsQwW-0004ru-VQ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsQkR-0003NA-Ou
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:52:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsQkR-0003LA-Am
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:52:23 -0400
Date: Wed, 22 Aug 2018 11:52:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822105216.GG12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] clean/simple Q35 support in libvirt+QEMU
 for guest OSes that don't support virtio-1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Laine Stump <laine@laine.org>, Libvirt <libvir-list@redhat.com>, qemu list <qemu-devel@nongnu.org>

On Wed, Aug 22, 2018 at 12:36:27PM +0200, Andrea Bolognani wrote:
> On Tue, 2018-08-21 at 14:21 -0400, Laine Stump wrote:
> > On 08/17/2018 06:35 AM, Andrea Bolognani wrote:
> > > If we decide we want to explicitly spell out the options instead
> > > of relying on QEMU changing behavior based on the slot type, which
> > > is probably a good idea anyway, I think we should have
> > > 
> > >   virtio-0.9 => disable-legacy=no,disable-modern=no
> > >   virtio-1.0 => disable-legacy=yes,disable-modern=no
> > > 
> > > There's basically no reason to have a device legacy-only rather
> > > than transitional, and spelling out both options instead of only
> > > one of them just seems more robust.
> > 
> > I agree with both of those, but the counter-argument is that "virtio"
> > already describes a transitional device like your proposal for
> > virtio-0.9 (at least today), and it makes the versioned models less
> > orthogonal. In the end, I could go either way...
> 
> Yeah, Dan already made that argument and convinced me that we
> should use virtio-0.9 for legacy only, virtio-1.0 for modern only
> and plain virtio for no enforced behavior / transitional.
> 
> > The problem I can see with the virtio-1.0 model name is that if
> > management applications start putting that into their XML (even though
> > "virtio" would yield a working guest), the guests will be unable to
> > migrate to another machine that has the same version of qemu, but an
> > older libvirt that doesn't understand the virtio-1.0 model number. If
> > that's acceptable, then management apps can being always specifying the
> > version for virtio whether it's old or new. If not, then they should
> > continue to use plain "virtio" unless they specifically need to force
> > virtio-0.9.
> 
> Well, even using virtio-0.9 could be considered problematic,
> because at least from the QEMU point of view there's nothing
> preventing the guest from working correctly as long as the version
> is recent enough that disable-legacy/disable-modern are available.
> 
> AFAIK management applications such as oVirt and OpenStack usually
> require specific, reasonably recent versions of QEMU and libvirt,
> so they could make sure virtio-0.9 and virtio-1.0 are understood
> by all nodes in the cluster that way.

Of course this is not a new scenario - any time an app makes use of a new
feature exposed in libvirt there's a chance that guests using that feature
will not be migratable to older libvirt. The apps and/or administrators
deploying them, have to decide on the cost/benefit tradeoff.

I think this will have an impact on ability of apps to adopt use of the
virtio-0.9/1.0 device model variants though. Both oVirt and OpenStack
do care about live migration to older versions, at least at certain
periods in time. For example, during a live upgrade scenario, 

This dovetails into Laine querying about the domain capabilities not
currently reporting info on the available device models. In the case
that migration to older verisons is needed, the dom capabilities info
won't be looked at anyway, as they don't wish to blindly use a feature
that just happens to exist in the current version.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
