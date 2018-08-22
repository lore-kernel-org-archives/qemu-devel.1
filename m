Received: from eggs.gnu.org ([2001:4830:134:3::10]:51055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsVae-0003BI-2g
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsVaa-0005u0-3Z
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:02:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsVaY-0005sh-40
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:02:31 -0400
Date: Wed, 22 Aug 2018 17:02:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822160222.GP12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
	<20180822120135.GN18995@localhost.localdomain>
	<20180822122601.GI12750@redhat.com>
	<20180822125455.GP18995@localhost.localdomain>
	<20180822134440.GK12750@redhat.com>
	<20180822141828.GQ18995@localhost.localdomain>
	<20180822145720.GL12750@redhat.com>
	<20180822154948.GR18995@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822154948.GR18995@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Libvirt <libvir-list@redhat.com>, qemu list <qemu-devel@nongnu.org>, Laine Stump <laine@laine.org>

On Wed, Aug 22, 2018 at 12:49:48PM -0300, Eduardo Habkost wrote:

> > The thing that has really tipped my mind this way is that even
> > if we provide new device models, mgmt apps will be loathe to
> > actually use them because it will prevent live migration of
> > those guests to hosts with older libvirt.
> 
> This might be an issue for some apps, but is it going to happen
> in practice?  Don't they all need mechanisms to flip a switch and
> enable features that require newer host software, already?

That is true, but most features that get added to virt these days
are things which are opt-in for specific use cases. eg when we
added mdev support if a guest gets given an mdev VGPU it obviously
won't be migratable to older libvirt lacking mdev support. The
mitigation is that only $TINY % of guests will be using mdev, so
the compat problem won't widely affect things.

With the alternative virtio models we're discussing here, the idea
is that they'd be used by default for all new guest deployments,
so the impact will be felt on every guest.

> > So my feeling is we should do the work to enable use of Q35
> > by default in mgmt apps, for guest OS where it is known to
> > work correctly today. Every other OS should just stick with
> > i440fx as we already know that works for them today and Q35
> > doesn't offer legacy OS compelling enough benefits to switch.
> 
> I'd still prefer if libvirt provided a saner configuration
> mechanism, and let libosinfo and management apps decide what
> works best for them.
> 
> If it helps, I can send QEMU patches to make
> virtio-0.9/virtio-1.0-non-transitional/virtio-1.0-transitional
> appear as different device types.  libvirt would then be able to
> check if the device type implements "pci-express-device" or
> "conventional-pci-device", instead of adding device-specific
> placement logic.

I don't think it makes a big difference from pov of the libvirt
impl, as its just the difference between "-device virtio-net,modern=off"
and "-device virtio-net-0.9".  It still has the same amount of extra
work and complexity rippling out from libvirt to mgmt apps, to address
a problem (make old RHEL6 use Q35 instad of i440fx) that shouldn't
really need to exist.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
