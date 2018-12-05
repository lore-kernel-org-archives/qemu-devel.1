Received: from eggs.gnu.org ([2001:4830:134:3::10]:48487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUZt4-0000ZL-Ti
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUZsz-0005aa-Tt
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:18:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gUZsz-0005Y6-Ja
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:18:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5GIY9c147443
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 11:18:52 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p6ffp8ntx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 11:18:49 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 5 Dec 2018 16:18:40 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAKPgXcE1zoFiBgbEqn6VAdsQuR7GfCNTn+pHgekH1XwLAdq-ig@mail.gmail.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<CAKPgXcE1zoFiBgbEqn6VAdsQuR7GfCNTn+pHgekH1XwLAdq-ig@mail.gmail.com>
Date: Wed, 05 Dec 2018 10:18:29 -0600
Message-Id: <154402670926.16620.2184992513838364109@sif>
Subject: Re: [Qemu-devel] [RFC 0/2] Attempt to implement the standby feature
 for assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Sameeh Jubran <sameeh@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com

Quoting Sameeh Jubran (2018-10-25 13:01:10)
> On Thu, Oct 25, 2018 at 5:06 PM Sameeh Jubran <sameeh@daynix.com> wrote:
> >
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > Hi all,
> >
> > Background:
> >
> > There has been a few attempts to implement the standby feature for vfio
> > assigned devices which aims to enable the migration of such devices. Th=
is
> > is another attempt.
> >
> > The series implements an infrastructure for hiding devices from the bus
> > upon boot. What it does is the following:
> >
> > * In the first patch the infrastructure for hiding the device is added
> >   for the qbus and qdev APIs. A "hidden" boolean is added to the device
> >   state and it is set based on a callback to the standby device which
> >   registers itself for handling the assessment: "should the primary dev=
ice
> >   be hidden?" by cross validating the ids of the devices.
> >
> > * In the second patch the virtio-net uses the API to hide the vfio
> >   device and unhides it when the feature is acked.
> >
> > Disclaimers:
> >
> > * I have only scratch tested this and from qemu side, it seems to be
> >   working.
> > * This is an RFC so it lacks some proper error handling in few cases
> >   and proper resource freeing. I wanted to get some feedback first
> >   before it is finalized.
> >
> > Command line example:
> >
> > /home/sameeh/Builds/failover/qemu/x86_64-softmmu/qemu-system-x86_64 \
> > -netdev tap,id=3Dhostnet0,script=3Dworld_bridge_standalone.sh,downscrip=
t=3Dno,ifname=3Dcc1_71 \
> > -netdev tap,vhost=3Don,id=3Dhostnet1,script=3Dworld_bridge_standalone.s=
h,downscript=3Dno,ifname=3Dcc1_72,queues=3D4 \
> > -device virtio-net,host_mtu=3D1500,netdev=3Dhostnet1,id=3Dcc1_72,vector=
s=3D10,mq=3Don,primary=3Dcc1_71 \
> > -device e1000,netdev=3Dhostnet0,id=3Dcc1_71,standby=3Dcc1_72 \
> >
> > Migration support:
> >
> > Pre migration or during setup phase of the migration we should send an
> > unplug request to the guest to unplug the primary device. I haven't had
> > the chance to implement that part yet but should do soon. Do you know
> > what's the best approach to do so? I wanted to have a callback to the
> > virtio-net device which tries to send an unplug request to the guest and
> > if succeeds then the migration continues. It needs to handle the case w=
here
> > the migration fails and then it has to replug the primary device back.
> I think that the "add_migration_state_change_notifier" API call can be us=
ed
> from within the virtio-net device to achieve this, what do you think?

I think it would be good to hear from the libvirt folks (on Cc:) on this as
having QEMU unplug a device without libvirt's involvement seems like it
could cause issues. Personally I think it seems cleaner to just have QEMU
handle the 'hidden' aspects of the device and leave it to QMP/libvirt to do
the unplug beforehand. On the libvirt side I could imagine adding an option
like virsh migrate --switch-to-standby-networking or something along
that line to do it automatically (if we decide doing it automatically is
even needed on that end).

> >
> > The following terms are used as interchangeable:
> > standby - virtio-net
> > primary - vfio-device - physical device - assigned device
> >
> > Please share your thoughts and suggestions,
> > Thanks!
> >
> > Sameeh Jubran (2):
> >   qdev/qbus: Add hidden device support
> >   virtio-net: Implement VIRTIO_NET_F_STANDBY feature
> >
> >  hw/core/qdev.c                 | 48 +++++++++++++++++++++++++---
> >  hw/net/virtio-net.c            | 25 +++++++++++++++
> >  hw/pci/pci.c                   |  1 +
> >  include/hw/pci/pci.h           |  2 ++
> >  include/hw/qdev-core.h         | 11 ++++++-
> >  include/hw/virtio/virtio-net.h |  5 +++
> >  qdev-monitor.c                 | 58 ++++++++++++++++++++++++++++++++--
> >  7 files changed, 142 insertions(+), 8 deletions(-)
> >
> > --
> > 2.17.0
> >
> =

> =

> -- =

> Respectfully,
> Sameeh Jubran
> Linkedin
> Software Engineer @ Daynix.
>=20
