Received: from eggs.gnu.org ([2001:4830:134:3::10]:50593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dc1kC-0001ea-NA
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 23:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dc1k9-0000WQ-Jn
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 23:51:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52860
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dc1k9-0000WB-D1
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 23:51:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6V3n1F7067570
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 23:51:44 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c1c24mbqf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 23:51:44 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 30 Jul 2017 23:51:43 -0400
Date: Mon, 31 Jul 2017 11:51:37 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170727135910.27d9e42e@gondolin>
Message-Id: <20170731035137.GB21572@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

* Cornelia Huck <cohuck@redhat.com> [2017-07-27 13:59:10 +0200]:

> On Thu, 27 Jul 2017 03:54:18 +0200
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > When a channel path is hot plugged into a CSS, we should generate
> > a channel path initialized CRW (channel report word). The current
> > code does not do that, instead it puts a stub function with a TODO
> > reminder there.
> > 
> > This implements the css_generate_chp_crws() function by:
> > 1. refactor the existing code.
> > 2. add an @add parameter to provide future callers with the
> >    capability of generating channel path permanent error with
> >    facility not initialized CRW.
> > 3. add a @hotplugged parameter, so to opt out generating initialized
> >    CRWs for predefined channel paths.
> 
> I'm not 100% sure whether the logic is correct here. Let me elaborate:
> 
> The current code flow when hotplugging a device is:
> - Generate the schib.
> - Check if any of the chpids refers to a not yet existing channel path;
>   generate it if that is the case.
> - Post a crw for the subchannel.
> 
> The second step is where the current code seems to be not quite correct
> already. It is fine for coldplugged devices, but I really think we need
> to make sure that all referenced channel paths are in place before we
> hotplug a new device. It was not really relevant when we just had one
> very virtual channel path, and 3270 is experimental so it is not a
> problem in practice.
vfio-ccw hotplug could also live with the current mechanism - just
generate the chp according to its CHPIDs information. What the problem
in practice for it then? Channel path status change could be synchronize
by adding more MMIO regions and eventfd irq for vfio-ccw.

> 
> This, of course, implies we need deeper changes. We need to create the
> channel paths before the subchannel is created and refuse hotplug of a
> device if not all channel paths it needs are defined. This means we
> need some things before we can claim real channel path support:
> - Have a way to specify channel paths on the command line resp. when
>   hotplugging. This implies they need to be real objects.
> - Have a way to specify which channel paths belong to a subchannel in
>   the same context. Keep existing device types working with the current
>   method.
If we want to adopt the unified modelling for all kinds of devices, then
we require the user to define chps before define devices.

We could defaulty always have a virtio reserved chp 0 defined on each
css, so we do not need to touch the current virtio devices command line.
Defining more chps or changing chpid for virtio devices does not provide
added values.

For emulated device, we can define chpids for use. E.g.:
-device chp,cssid=fe,chpid=11 \
-device chp,cssid=fe,chpid=22 \
-chardev socket,id=terminal0,host=0.0.0.0,port=23,nowait,server,tn3270 \
-device x-terminal3270,chardev=terminal0,id=terminal3270_0,devno=fe.0.000a,chpids=1122000000000000

Or, I think, we could let Qemu automatically find a free chp for them.
Sine, the same as the virtio devices, defining more chps or changing
chpid for emulated devices does provide added values either. In this
case, we do not need to touch the emualted device command line too.

When defining a vfio-ccw device, since the real subchannel implicitly
indicates the chps it bound to, we grasp the CHPIDs from sysfs (or, with
my current work, we could even retrieve these information from a new
added MMIO region). In this case, defining some channel path devices
separately does not make sense to me.

After thinking quite a while, if we do want to add a real device object
for a channel path, the most intractable problem (but not the only one)
for me is to find a good way to map the real path with the virtual one.
How would we retrieve the information from the real one? We'd need the
host kernel to provide totally new interfaces for channel path
information synchronization and notification machenism. I don't think in
this case sysfs is the choice. Ioctls, vfio MMIO regions and eventfd
could be a better choice. I think, this is like we are trying to
passthru a channel path. So we'd need to have a new vfio device physical
driver (e.g. vfio-chp) to handle this...

And, if we finnaly find a way to solve the above problem, we may have
some commandline as the follows, and there is still other problems. E.g.:

lscss:
MDEV                                  Subchan.  PIM PAM POM  CHPIDs
------------------------------------------------------------------------------
6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920  0.0.013f  f0  f0  ff   42434445 00000000

lschp:
CHPID  Vary  Cfg.  Type  Cmg  Shared  PCHID
============================================
0.42   1     1     1b    2    1       0158 
0.43   1     1     1b    2    1       0159 
0.44   1     1     1b    2    1       01a0 
0.45   1     1     1b    2    1       01a1

Suppose we want to pass through the above mdev ($MDEV_CCW013f), we could
have the following command line:
-device vfio-chp,sysfsdev=$MDEV_CHP42,cssid=0,chpid=42 \
-device vfio-chp,sysfsdev=$MDEV_CHP43,cssid=0,chpid=43 \
-device vfio-chp,sysfsdev=$MDEV_CHP44,cssid=0,chpid=44 \
-device vfio-chp,sysfsdev=$MDEV_CHP45,cssid=0,chpid=45 \
-device vfio-ccw,sysfsdev=$MDEV_CCW013f,devno=0.0.1234,chpids=4243444500000000

The above vfio-ccw devices can not use any other CHP besides the above
4. Defining only some of the 4 CHPs for the vfio-ccw device does not
sounds reasonable. So isn't it redundant to explicitly define all of the
4 chps in command line for the vfio-ccw device? Since, itself already
provides the CHPIDs information...

> - Give channel paths states: Defined, configured. The right time for a
>   CRW is the transition between those states.
Sounds reasonable.

> - Only queue a 'device come' CRW for a subchannel if at least one of
>   its channel paths is in the configured state. Detach or make not
>   operational a subchannel if all of its paths are deconfigured.
Sounds reasonable too.

> 
> Something along those lines also matches better what I've seen on z/VM
> or LPAR. I realize that it's not easy :(
Yes... I don't find out a way that can satisfy all of the above
requirements for now...

> 
> tl;dr: I don't think we want chp crws until after we have a good chp
> model.
I have to agree.

> 
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  hw/s390x/3270-ccw.c       |  3 ++-
> >  hw/s390x/css.c            | 55 ++++++++++++++++++++++++++++++++++++-----------
> >  hw/s390x/s390-ccw.c       |  2 +-
> >  hw/s390x/virtio-ccw.c     |  3 ++-
> >  include/hw/s390x/css.h    |  8 ++++---
> >  include/hw/s390x/ioinst.h |  1 +
> >  6 files changed, 53 insertions(+), 19 deletions(-)
> 

-- 
Dong Jia Shi
