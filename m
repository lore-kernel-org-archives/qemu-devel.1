Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQJYn-0005T8-Ih
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 17:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQJYk-0003m0-EV
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 17:32:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQJYk-0003lm-7g
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 17:32:06 -0400
Date: Wed, 6 Jun 2018 00:32:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180606002650-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<CADGSJ21Qf6KpLzr+og5DOFjMPqu69n6dWRLvvj1FGAR5kVRNew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ21Qf6KpLzr+og5DOFjMPqu69n6dWRLvvj1FGAR5kVRNew@mail.gmail.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Tue, Jun 05, 2018 at 02:16:44PM -0700, Siwei Liu wrote:
> Good to see this discussion going. I share the same feeling that the
> decision of plugging the primary (passthrough) should only be made
> until guest driver acknowledges DRIVER_OK and _F_STANDBY.
> Architecturally this intelligence should be baken to QEMU itself
> rather than moving up to management stack, such as libvirt.
> 
> A few questions in line below.
> 
> On Tue, Jun 5, 2018 at 5:33 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > I don't think this is sufficient.
> >
> > If both primary and standby devices are present, a legacy guest without
> > support for the feature might see two devices with same mac and get
> > confused.
> >
> > I think that we should only make primary visible after guest acked the
> > backup feature bit.
> >
> > And on reset or when backup is cleared in some other way, unplug the
> > primary.
> >
> > Something like the below will do the job:
> >
> > Primary device is added with a special "primary-failover" flag.
> 
> I wonder if you envision this flag as a user interface or some
> internal attribute/property to QEMU device?
> 
> Since QEMU needs to associate this particular primary-failover device
> with a virtio standby instance for checking DRIVER_OK as you indicate
> below, I wonder if the group ID thing will be helpful to set
> "primary-failover" flag internally without having to add another
> option in CLI?

I haven't thought about it but it's an option.

> > A virtual machine is then initialized with just a standby virtio
> > device. Primary is not yet added.
> >
> > Later QEMU detects that guest driver device set DRIVER_OK.
> > It then exposes the primary device to the guest, and triggers
> > a device addition event (hot-plug event) for it.
> 
> Sounds OK. While there might be a small window the guest already
> starts to use virtio interface before the passthrough gets plugged in,
> I think that should be fine.
> 
> Another option is to wait until the primary appears and gets
> registered in the guest, so it can bring up the upper failover
> interface.

We can't be sure this will ever happen, can we? We might be asked to
migrate at any time.

> >
> > If QEMU detects guest driver removal, it initiates a hot-unplug sequence
> > to remove the primary driver.  In particular, if QEMU detects guest
> > re-initialization (e.g. by detecting guest reset) it immediately removes
> > the primary device.
> 
> Agreed.
> 
> For legacy guest, user might prefer seeing a single passthrough device
> rather than a virtio device. I would hope there's an option to allow
> it to happen, instead of removing all passthrough devices.
> 
> Regards,
> -Siwei

I don't see a way to make it work since then you can't migrate, can you?

The way I see it, if you don't need migration, just use PT without
failover.  If you do, then you either use virtio or failover if guest
supports it.

> >
> > We can move some of this code to management as well, architecturally it
> > does not make too much sense but it might be easier implementation-wise.
> >
> > HTH
> >
> > On Mon, Jun 04, 2018 at 06:41:48PM -0700, Samudrala, Sridhar wrote:
> >> Ping on this patch now that the kernel patches are accepted into davem's net-next tree.
> >> https://patchwork.ozlabs.org/cover/920005/
> >>
> >>
> >> On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
> >> > This feature bit can be used by hypervisor to indicate virtio_net device to
> >> > act as a standby for another device with the same MAC address.
> >> >
> >> > I tested this with a small change to the patch to mark the STANDBY feature 'true'
> >> > by default as i am using libvirt to start the VMs.
> >> > Is there a way to pass the newly added feature bit 'standby' to qemu via libvirt
> >> > XML file?
> >> >
> >> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> > ---
> >> >   hw/net/virtio-net.c                         | 2 ++
> >> >   include/standard-headers/linux/virtio_net.h | 3 +++
> >> >   2 files changed, 5 insertions(+)
> >> >
> >> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> > index 90502fca7c..38b3140670 100644
> >> > --- a/hw/net/virtio-net.c
> >> > +++ b/hw/net/virtio-net.c
> >> > @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
> >> >                        true),
> >> >       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
> >> >       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> >> > +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
> >> > +                      false),
> >> >       DEFINE_PROP_END_OF_LIST(),
> >> >   };
> >> > diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> >> > index e9f255ea3f..01ec09684c 100644
> >> > --- a/include/standard-headers/linux/virtio_net.h
> >> > +++ b/include/standard-headers/linux/virtio_net.h
> >> > @@ -57,6 +57,9 @@
> >> >                                      * Steering */
> >> >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23     /* Set MAC address */
> >> > +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for another device
> >> > +                                         * with the same MAC.
> >> > +                                         */
> >> >   #define VIRTIO_NET_F_SPEED_DUPLEX 63      /* Device set linkspeed and duplex */
> >> >   #ifndef VIRTIO_NET_NO_LEGACY
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
