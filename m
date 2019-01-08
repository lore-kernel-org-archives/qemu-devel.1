Received: from eggs.gnu.org ([209.51.188.92]:45604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ggfBw-00049F-Jv
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ggfBv-0004aJ-7i
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:24:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ggfBu-0004R1-UT
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:24:23 -0500
Date: Mon, 7 Jan 2019 17:24:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190107172415.2f723149@x1.home>
In-Reply-To: <20190107191044-mutt-send-email-mst@kernel.org>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-5-git-send-email-venu.busireddy@oracle.com>
	<20190107161717.4648aba2@x1.home>
	<20190107182115-mutt-send-email-mst@kernel.org>
	<20190107164115.6daffe19@x1.home>
	<20190107191044-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] vfio-pci: Add
 FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Mon, 7 Jan 2019 19:12:06 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jan 07, 2019 at 04:41:15PM -0700, Alex Williamson wrote:
> > On Mon, 7 Jan 2019 18:22:20 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Mon, Jan 07, 2019 at 04:17:17PM -0700, Alex Williamson wrote:  
> > > > On Mon,  7 Jan 2019 17:29:43 -0500
> > > > Venu Busireddy <venu.busireddy@oracle.com> wrote:
> > > >     
> > > > > From: Si-Wei Liu <si-wei.liu@oracle.com>
> > > > > 
> > > > > When a VF is hotplugged into the guest, datapath switching will be
> > > > > performed immediately, which is sub-optimal in terms of timing, and
> > > > > could end up with substantial network downtime. One of ways to shorten
> > > > > this downtime is to switch the datapath only after the VF is seen to get
> > > > > enabled by guest, indicated by the bus master bit in VF's PCI config
> > > > > space getting enabled. The FAILOVER_PRIMARY_CHANGED event is emitted
> > > > > at that time to indicate this condition. Then management stack can kick
> > > > > off datapath switching upon receiving the event.
> > > > > 
> > > > > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > > > > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> > > > > ---
> > > > >  hw/vfio/pci.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  qapi/net.json | 26 ++++++++++++++++++++++++++
> > > > >  2 files changed, 83 insertions(+)    
> > > > 
> > > > Why is this done at the vfio driver layer rather than the PCI core
> > > > layer?  We write everything through using pci_default_write_config(), I
> > > > don't see that anything here is particularly vfio specific.  Please copy
> > > > me on any changes in hw/vfio.  Thanks,
> > > > 
> > > > Alex    
> > > 
> > > Hmm so you are saying let's send events for each device?
> > > I don't have a problem with this but in this case
> > > I think I would like to see a per-device option "send events".
> > > We don't want a ton of events in the simple default config.  
> > 
> > In the below we're only sending events for PCIDevice.failover_primary,  
> 
> Well failover_primary in this patch is a vfio property, not a
> pci device property.

It's both and it's kind of a kludge (from 2/5):

--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3077,6 +3077,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
+    pdev->failover_primary = vdev->failover_primary;
 
     return;
 
@@ -3219,6 +3220,8 @@ static Property vfio_pci_dev_properties[] = {
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTOPCIBAR_OFF),
+    DEFINE_PROP_BOOL("failover-primary", VFIOPCIDevice, failover_primary,
+                     false),
     /*
      * TODO - support passed fds... is this necessary?
      * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),

The property could have set VFIOPCIDevice.pdev.failover_primary
directly.  I'm not thrilled about that name either, it's a very NIC
centric property whereas vfio-pci supports plenty of non-networking
devices, as of course does PCIDevice.  Maybe the concept needs to be
more general or the name needs to be more NIC specific and fail for
devices that don't have the correct class code.  Thanks,

Alex

> > seems like that would filter out the rest of the non-NIC PCI devices as
> > well as it does for non-NIC VFIO PCI devices.  The only thing remotely
> > vfio specific below is that it might notify based on the vfio device
> > name, but it's a fallback to PCIDevice.qdev.id.  A real ID could just
> > be a requirement to make use of this.  
> 
> 
> Right and in fact I don't see why we can't make reporting
> bus master status a capability of all devices.
> 
> 
> >  Thanks,
> > 
> > Alex
> >   
> > > > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > > > index bd83b58..adcc95a 100644
> > > > > --- a/hw/vfio/pci.c
> > > > > +++ b/hw/vfio/pci.c
> > > > > @@ -34,6 +34,7 @@
> > > > >  #include "pci.h"
> > > > >  #include "trace.h"
> > > > >  #include "qapi/error.h"
> > > > > +#include "qapi/qapi-events-net.h"
> > > > >  
> > > > >  #define MSIX_CAP_LENGTH 12
> > > > >  
> > > > > @@ -42,6 +43,7 @@
> > > > >  
> > > > >  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
> > > > >  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> > > > > +static void vfio_failover_notify(VFIOPCIDevice *vdev, bool status);
> > > > >  
> > > > >  /*
> > > > >   * Disabling BAR mmaping can be slow, but toggling it around INTx can
> > > > > @@ -1170,6 +1172,8 @@ void vfio_pci_write_config(PCIDevice *pdev,
> > > > >  {
> > > > >      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> > > > >      uint32_t val_le = cpu_to_le32(val);
> > > > > +    bool may_notify = false;
> > > > > +    bool master_was = false;
> > > > >  
> > > > >      trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
> > > > >  
> > > > > @@ -1180,6 +1184,14 @@ void vfio_pci_write_config(PCIDevice *pdev,
> > > > >                       __func__, vdev->vbasedev.name, addr, val, len);
> > > > >      }
> > > > >  
> > > > > +    /* Bus Master Enabling/Disabling */
> > > > > +    if (pdev->failover_primary && current_cpu &&
> > > > > +        range_covers_byte(addr, len, PCI_COMMAND)) {
> > > > > +        master_was = !!(pci_get_word(pdev->config + PCI_COMMAND) &
> > > > > +                        PCI_COMMAND_MASTER);
> > > > > +        may_notify = true;
> > > > > +    }
> > > > > +
> > > > >      /* MSI/MSI-X Enabling/Disabling */
> > > > >      if (pdev->cap_present & QEMU_PCI_CAP_MSI &&
> > > > >          ranges_overlap(addr, len, pdev->msi_cap, vdev->msi_cap_size)) {
> > > > > @@ -1235,6 +1247,14 @@ void vfio_pci_write_config(PCIDevice *pdev,
> > > > >          /* Write everything to QEMU to keep emulated bits correct */
> > > > >          pci_default_write_config(pdev, addr, val, len);
> > > > >      }
> > > > > +
> > > > > +    if (may_notify) {
> > > > > +        bool master_now = !!(pci_get_word(pdev->config + PCI_COMMAND) &
> > > > > +                             PCI_COMMAND_MASTER);
> > > > > +        if (master_was != master_now) {
> > > > > +            vfio_failover_notify(vdev, master_now);
> > > > > +        }
> > > > > +    }
> > > > >  }
> > > > >  
> > > > >  /*
> > > > > @@ -2801,6 +2821,17 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
> > > > >      vdev->req_enabled = false;
> > > > >  }
> > > > >  
> > > > > +static void vfio_failover_notify(VFIOPCIDevice *vdev, bool status)
> > > > > +{
> > > > > +    PCIDevice *pdev = &vdev->pdev;
> > > > > +    const char *n;
> > > > > +    gchar *path;
> > > > > +
> > > > > +    n = pdev->qdev.id ? pdev->qdev.id : vdev->vbasedev.name;
> > > > > +    path = object_get_canonical_path(OBJECT(vdev));
> > > > > +    qapi_event_send_failover_primary_changed(!!n, n, path, status);
> > > > > +}
> > > > > +
> > > > >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> > > > >  {
> > > > >      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> > > > > @@ -3109,10 +3140,36 @@ static void vfio_instance_finalize(Object *obj)
> > > > >      vfio_put_group(group);
> > > > >  }
> > > > >  
> > > > > +static void vfio_exit_failover_notify(VFIOPCIDevice *vdev)
> > > > > +{
> > > > > +    PCIDevice *pdev = &vdev->pdev;
> > > > > +
> > > > > +    /*
> > > > > +     * Guest driver may not get the chance to disable bus mastering
> > > > > +     * before the device object gets to be unrealized. In that event,
> > > > > +     * send out a "disabled" notification on behalf of guest driver.
> > > > > +     */
> > > > > +    if (pdev->failover_primary &&
> > > > > +        pdev->bus_master_enable_region.enabled) {
> > > > > +        vfio_failover_notify(vdev, false);
> > > > > +    }
> > > > > +}
> > > > > +
> > > > >  static void vfio_exitfn(PCIDevice *pdev)
> > > > >  {
> > > > >      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> > > > >  
> > > > > +    /*
> > > > > +     * During the guest reboot sequence, it is sometimes possible that
> > > > > +     * the guest may not get sufficient time to complete the entire driver
> > > > > +     * removal sequence, near the end of which a PCI config space write to
> > > > > +     * disable bus mastering can be intercepted by device. In such cases,
> > > > > +     * the FAILOVER_PRIMARY_CHANGED "disable" event will not be emitted. It
> > > > > +     * is imperative to generate the event on the guest's behalf if the
> > > > > +     * guest fails to make it.
> > > > > +     */
> > > > > +    vfio_exit_failover_notify(vdev);
> > > > > +
> > > > >      vfio_unregister_req_notifier(vdev);
> > > > >      vfio_unregister_err_notifier(vdev);
> > > > >      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> > > > > diff --git a/qapi/net.json b/qapi/net.json
> > > > > index 633ac87..a5b8d70 100644
> > > > > --- a/qapi/net.json
> > > > > +++ b/qapi/net.json
> > > > > @@ -757,3 +757,29 @@
> > > > >  ##
> > > > >  { 'command': 'query-standby-status', 'data': { '*device': 'str' },
> > > > >    'returns': ['StandbyStatusInfo'] }
> > > > > +
> > > > > +##
> > > > > +# @FAILOVER_PRIMARY_CHANGED:
> > > > > +#
> > > > > +# Emitted whenever the driver of failover primary is loaded or unloaded
> > > > > +# by the guest.
> > > > > +#
> > > > > +# @device: device name
> > > > > +#
> > > > > +# @path: device path
> > > > > +#
> > > > > +# @enabled: true if driver is loaded thus device is enabled in guest
> > > > > +#
> > > > > +# Since: 3.0
> > > > > +#
> > > > > +# Example:
> > > > > +#
> > > > > +# <- { "event": "FAILOVER_PRIMARY_CHANGED",
> > > > > +#      "data": { "device": "vfio-0",
> > > > > +#                "path": "/machine/peripheral/vfio-0" },
> > > > > +#                "enabled": "true" },
> > > > > +#      "timestamp": { "seconds": 1539935213, "microseconds": 753529 } }
> > > > > +#
> > > > > +##
> > > > > +{ 'event': 'FAILOVER_PRIMARY_CHANGED',
> > > > > +  'data': { '*device': 'str', 'path': 'str', 'enabled': 'bool' } }
> > > > >     
