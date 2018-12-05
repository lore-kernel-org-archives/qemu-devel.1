Received: from eggs.gnu.org ([2001:4830:134:3::10]:54485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUbDM-0000O2-Nn
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUbDJ-0007iT-Dx
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:44:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gUbDJ-0007h0-5P
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:43:57 -0500
Date: Wed, 5 Dec 2018 17:43:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181205174344.GG22100@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<CAKPgXcE1zoFiBgbEqn6VAdsQuR7GfCNTn+pHgekH1XwLAdq-ig@mail.gmail.com>
	<154402670926.16620.2184992513838364109@sif>
	<20181205170916.GK799@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205170916.GK799@angien.pipo.sk>
Subject: Re: [Qemu-devel] [libvirt] [RFC 0/2] Attempt to implement the
 standby feature for assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Sameeh Jubran <sameeh@daynix.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

On Wed, Dec 05, 2018 at 06:09:16PM +0100, Peter Krempa wrote:
> On Wed, Dec 05, 2018 at 10:18:29 -0600, Michael Roth wrote:
> > Quoting Sameeh Jubran (2018-10-25 13:01:10)
> > > On Thu, Oct 25, 2018 at 5:06 PM Sameeh Jubran <sameeh@daynix.com> wrote:
> > > > From: Sameeh Jubran <sjubran@redhat.com>
> > > > Migration support:
> > > >
> > > > Pre migration or during setup phase of the migration we should send an
> > > > unplug request to the guest to unplug the primary device. I haven't had
> > > > the chance to implement that part yet but should do soon. Do you know
> > > > what's the best approach to do so? I wanted to have a callback to the
> > > > virtio-net device which tries to send an unplug request to the guest and
> > > > if succeeds then the migration continues. It needs to handle the case where
> > > > the migration fails and then it has to replug the primary device back.
> > > I think that the "add_migration_state_change_notifier" API call can be used
> > > from within the virtio-net device to achieve this, what do you think?
> > 
> > I think it would be good to hear from the libvirt folks (on Cc:) on this as
> > having QEMU unplug a device without libvirt's involvement seems like it
> > could cause issues. Personally I think it seems cleaner to just have QEMU
> > handle the 'hidden' aspects of the device and leave it to QMP/libvirt to do
> > the unplug beforehand. On the libvirt side I could imagine adding an option
> > like virsh migrate --switch-to-standby-networking or something along
> > that line to do it automatically (if we decide doing it automatically is
> > even needed on that end).
> 
> I remember talking about this approach some time ago.
> 
> In general the migration itself is a very complex process which has too
> many places where it can fail. The same applies to device hotunplug.
> This series proposes to merge those two together into an even more
> complex behemoth.
> 
> Few scenarios which don't have clear solution come into my mind:
> - Since unplug request time is actually unbounded. The guest OS may
>   arbitrarily reject it or execute it at any later time, migration may get
>   stuck in a halfway state without any clear rollback or failure scenario.

IMHO this is the really big deal. Doing this inside QEMU can arbitrarily
delay the start of migration, but this is opaque to mgmt apps because it
all becomes hidden behind the migrate command. It is common for mgmt apps
to serialize migration operations, otherwise they compete for limited
network bandwidth making it less likely that any will complete. If we're
waiting for a guest OS to do the unplug though, we don't want to be
stopping other migrations from being started in the mean time. Having
the unplugs done from the mgmt app explicitly gives it the flexibility
to decide how to order and serialize things to suit its needs.

> - After migration, device hotplug may fail for whatever reason, leaving
>   networking crippled and again no clear single-case rollback scenario.

I'd say s/crippled/degraded/. Anyway depending on the the reason that
triggered the migration, you may not even want to rollback to the source
host, despite the VFIO hotplug failing on the target.

If the original host was being evacuated in order to upgrade it to the latest
security patches, or due to hardware problems, it can be preferrable to just
let the VM start running on the target host with just emulated NICs only and
worry about getting working VFIO later.

> Then there's stuff which requires libvirt/management cooperation
> - picking of the network device on destination
> - making sure that the device is present etc.
> 
> From managements point of view, bundling all this together is really not
> a good idea since it creates a very big matrix of failure scenarios. In
> general even libvirt will prefer that upper layer management drives this
> externally, since any rolback scenario will result in a policy decision
> of what to do in certain cases, and what timeouts to pick.

Indeed, leaving these policies decisions to the mgmt app has been a
better approach in general over time, as the view of what's the best
way to approach a problem has changed over time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
