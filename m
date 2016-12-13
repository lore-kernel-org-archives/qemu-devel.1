Received: from eggs.gnu.org ([2001:4830:134:3::10]:49792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cGucD-00060C-BP
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cGuc9-0003KR-KB
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:28:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cGuc9-0003K3-Bw
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:27:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBDLJCIt061937
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 16:27:55 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27akchy6u7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 16:27:55 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 13 Dec 2016 16:27:53 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1473773430-19616-1-git-send-email-maxime.coquelin@redhat.com>
References: <1473773430-19616-1-git-send-email-maxime.coquelin@redhat.com>
Date: Tue, 13 Dec 2016 15:27:45 -0600
Message-Id: <20161213212745.1976.91005@loki>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2] virtio-bus: Plug devices
 after features are negotiated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Cc: cornelia.huck@de.ibm.com, marcel@redhat.com, eblake@redhat.com, qemu-stable@nongnu.org, stefanha@redhat.com, dgilbert@redhat.com

Quoting Maxime Coquelin (2016-09-13 08:30:30)
> Currently, devices are plugged before features are negotiated.
> If the backend doesn't support VIRTIO_F_VERSION_1, the transport
> needs to rewind some settings.
> =

> This is the case for CCW, for which a post_plugged callback had
> been introduced, where max_rev field is just updated if
> VIRTIO_F_VERSION_1 is not supported by the backend.
> For PCI, implementing post_plugged would be much more
> complicated, so it needs to know whether the backend supports
> VIRTIO_F_VERSION_1 at plug time.
> =

> Currently, nothing is done for PCI. Modern capabilities get
> exposed to the guest even if VIRTIO_F_VERSION_1 is not supported
> by the backend, which confuses the guest.
> =

> This patch replaces existing post_plugged solution with an
> approach that fits with both transports.
> Features negotiation is performed before ->device_plugged() call.
> A pre_plugged callback is introduced so that the transports can
> set their supported features.
> =

> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: qemu-stable@nongnu.org
> Tested-by: Cornelia Huck <cornelia.huck@de.ibm.com> [ccw]
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>


It looks like this patch breaks migration under certain circumstances.
One such scenario is migrating 2.7 -> 2.8.0-rc3 as detailed below on a
host that doesn't have support for virtio-1 in vhost (which was
introduced via 41e3e42 in kernel 3.18. In my case, I'm using Ubuntu
14.04, kernel 3.13):

 source (2.7.0):
 =

   sudo build/v2.7.0/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -L
   build/v2.7.0-bios -M pc-i440fx-2.7 -m 512M -drive
   file=3D/home/mdroth/vm/win7_home_sp1_virtio_testing.qcow2,if=3Dvirtio -v=
ga
   cirrus -smp 4 -device virtio-net-pci,netdev=3Dnet0 -netdev
   tap,id=3Dnet0,vhost=3Don,script=3D/etc/qemu-ifup -monitor
   unix:/tmp/vm-hmp.sock,server,nowait -qmp
   unix:/tmp/vm-qmp.sock,server,nowait -vnc :200
  =

 target (2.8.0-rc3):
   =

   sudo build/v2.8.0-rc3/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
   -L build/v2.8.0-rc3-bios -M pc-i440fx-2.7 -m 512M -drive
   file=3D/home/mdroth/vm/win7_home_sp1_virtio_testing.qcow2,if=3Dvirtio -v=
ga
   cirrus -smp 4 -device virtio-net-pci,netdev=3Dnet0 -netdev
   tap,id=3Dnet0,vhost=3Don,script=3D/etc/qemu-ifup -monitor
   unix:/tmp/vm-hmp-incoming.sock,server,nowait -qmp
   unix:/tmp/vm-qmp-incoming.sock,server,nowait -vnc :201
   -incoming unix:/tmp/migrate.sock
    =

 error on target after migration:
     =

   qemu-system-x86_64: get_pci_config_device: Bad config data: i=3D0x34
   read: 98 device: 40 cmask: ff wmask: 0 w1cmask:0
   qemu-system-x86_64: Failed to load PCIDevice:config
   qemu-system-x86_64: Failed to load virtio-net:virtio
   qemu-system-x86_64: error while loading state for instance 0x0 of
   device '0000:00:03.0/virtio-net'
   qemu-system-x86_64: load of migration failed: Invalid argument


Based on discussion on IRC (excerpts below), I think the new handling needs
to be controllable via a machine option that can be disabled by default
for older machine types. This is being considered a release blocker for
2.8 since there are still pre-3.18 LTS kernels in the wild.


root-cause:

14:35 < stefanha> v3.13 will not work
14:35 < stefanha>         VHOST_FEATURES =3D (1ULL << VIRTIO_F_NOTIFY_ON_EM=
PTY) |
14:35 < stefanha>                          (1ULL << VIRTIO_RING_F_INDIRECT_=
DESC) |
14:35 < stefanha>                          (1ULL << VIRTIO_RING_F_EVENT_IDX=
) |
14:35 < stefanha>                          (1ULL << VHOST_F_LOG_ALL),
14:35 < stefanha> The kernel side only knows about these guys
14:35 < davidgiluk> our downstream 3.10.0-524 seems to work - but that's pr=
obably got all the vhost stuff backported
14:35 < stefanha> plus these guys:
14:35 < stefanha> F        VHOST_NET_FEATURES =3D VHOST_FEATURES |
14:35 < stefanha>                          (1ULL << VHOST_NET_F_VIRTIO_NET_=
HDR) |
14:35 < stefanha>                          (1ULL << VIRTIO_NET_F_MRG_RXBUF),
14:36 < stefanha> mdroth: So QEMU is going to check a list of feature bits =
including VERSION_1
14:36 < stefanha> and it will see that vhost doesn't support them.
14:36 < stefanha> So we're kind of doing the right thing now.
14:36 < stefanha> Before userspace was overriding the fact that vhost canno=
t handle VERSION_1.
14:36 < stefanha> ...except we broke migration
14:36 < davidgiluk> stefanha: But shouldn't it refuse to startup ?
14:36 < stefanha> Everything is perfect*
14:36 < stefanha> * except we broke migration
14:36 < stefanha> :)

suggestions on how to fix this:

14:40 < stefanha> My understanding is this bug is vhost-specific.  If you h=
ave an old kernel that doesn't support VERSION_1 vhost then migration will =
break.
14:41 < stefanha> The actual bug is in QEMU though, not vhost
14:42 < stefanha> vhost is reporting the truth.  It's QEMU that has changed=
 behavior.
14:44 < stefanha> mdroth: I think a lame fix would be to make virtio_pci_de=
vice_plugged() dependent on a flag that says: use old broken behavior inste=
ad of reporting the truth to the guest.
14:44 < stefanha> The flag could be enabled for all old machine types
14:44 < stefanha> and new machine types will report the truth.
14:44 < stefanha> That way migration continues to work.
14:44 < stefanha> Not sure if anyone can think of a nicer solution.
14:45 < stefanha> But we're going to have to keep lying to the guest if we =
want to preserve migration compatibility
14:45 < stefanha> The key change in behavior with the patch you identified =
is:
14:46 < stefanha> if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VER=
SION_1)) {
14:46 < stefanha> virtio_pci_disable_modern(proxy);
14:46 < stefanha> Previously it didn't care about vdev->host_features.  It =
simply allowed VERSION_1 when proxy's disable_modern boolean was false.
14:47 < mdroth> stefanha: ok, that explains why it seems to work with disab=
le-modern=3Dtrue
14:48 < stefanha> mdroth: Your Ubuntu kernel old but 14.04 LTS is definitel=
y still around so I don't think we can ship QEMU 2.8 like this.
14:49 < stefanha> mdroth: Let's summarize it on the mailing list and see wh=
at Michael Tsirkin and Maxime Coquelin think.
14:49 < mdroth> stefanha: i suppose a potential workaround would be to tell=
 users to set disable-modern=3D to match their vhost capabilities, but it's=
 hard for them to apply that retroactively if they're looking to migrate
14:49 < stefanha> We can delay the release in the meantime.
14:50 < stefanha> mdroth: I don't think a workaround is going to be smooth =
in this case
14:50 < stefanha> People will only notice once migration fails,
14:50 < stefanha> and that's when you lose your VM state!


> ---
> =

> The patch applies on top of Michael's pci branch.
> =

> Changes from v1:
> ----------------
>  - Fix commit message typos (Cornelia, Eric)
> =

>  hw/s390x/virtio-ccw.c          | 30 +++++++++++++++---------------
>  hw/virtio/virtio-bus.c         |  9 +++++----
>  hw/virtio/virtio-pci.c         | 36 ++++++++++++++++++++++++++++++++----
>  hw/virtio/virtio-pci.h         |  5 +++++
>  include/hw/virtio/virtio-bus.h | 10 +++++-----
>  5 files changed, 62 insertions(+), 28 deletions(-)
> =

> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 9678956..9f3f386 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1261,6 +1261,16 @@ static int virtio_ccw_load_config(DeviceState *d, =
QEMUFile *f)
>      return 0;
>  }
> =

> +static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> +{
> +   VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
> +   VirtIODevice *vdev =3D virtio_bus_get_device(&dev->bus);
> +
> +    if (dev->max_rev >=3D 1) {
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
> +    }
> +}
> +
>  /* This is called by virtio-bus just after the device is plugged. */
>  static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
>  {
> @@ -1270,6 +1280,10 @@ static void virtio_ccw_device_plugged(DeviceState =
*d, Error **errp)
>      SubchDev *sch =3D ccw_dev->sch;
>      int n =3D virtio_get_num_queues(vdev);
> =

> +    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
> +        dev->max_rev =3D 0;
> +    }
> +
>      if (virtio_get_num_queues(vdev) > VIRTIO_CCW_QUEUE_MAX) {
>          error_setg(errp, "The number of virtqueues %d "
>                     "exceeds ccw limit %d", n,
> @@ -1283,25 +1297,11 @@ static void virtio_ccw_device_plugged(DeviceState=
 *d, Error **errp)
> =

>      sch->id.cu_model =3D virtio_bus_get_vdev_id(&dev->bus);
> =

> -    if (dev->max_rev >=3D 1) {
> -        virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
> -    }
> =

>      css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
>                            d->hotplugged, 1);
>  }
> =

> -static void virtio_ccw_post_plugged(DeviceState *d, Error **errp)
> -{
> -   VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
> -   VirtIODevice *vdev =3D virtio_bus_get_device(&dev->bus);
> -
> -   if (!virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -        /* A backend didn't support modern virtio. */
> -       dev->max_rev =3D 0;
> -   }
> -}
> -
>  static void virtio_ccw_device_unplugged(DeviceState *d)
>  {
>      VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
> @@ -1593,8 +1593,8 @@ static void virtio_ccw_bus_class_init(ObjectClass *=
klass, void *data)
>      k->load_queue =3D virtio_ccw_load_queue;
>      k->save_config =3D virtio_ccw_save_config;
>      k->load_config =3D virtio_ccw_load_config;
> +    k->pre_plugged =3D virtio_ccw_pre_plugged;
>      k->device_plugged =3D virtio_ccw_device_plugged;
> -    k->post_plugged =3D virtio_ccw_post_plugged;
>      k->device_unplugged =3D virtio_ccw_device_unplugged;
>      k->ioeventfd_started =3D virtio_ccw_ioeventfd_started;
>      k->ioeventfd_set_started =3D virtio_ccw_ioeventfd_set_started;
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 1492793..11f65bd 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -49,16 +49,17 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Er=
ror **errp)
> =

>      DPRINTF("%s: plug device.\n", qbus->name);
> =

> -    if (klass->device_plugged !=3D NULL) {
> -        klass->device_plugged(qbus->parent, errp);
> +    if (klass->pre_plugged !=3D NULL) {
> +        klass->pre_plugged(qbus->parent, errp);
>      }
> =

>      /* Get the features of the plugged device. */
>      assert(vdc->get_features !=3D NULL);
>      vdev->host_features =3D vdc->get_features(vdev, vdev->host_features,
>                                              errp);
> -    if (klass->post_plugged !=3D NULL) {
> -        klass->post_plugged(qbus->parent, errp);
> +
> +    if (klass->device_plugged !=3D NULL) {
> +        klass->device_plugged(qbus->parent, errp);
>      }
>  }
> =

> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index dde71a5..2d60a00 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1576,18 +1576,48 @@ static void virtio_pci_modern_io_region_unmap(Vir=
tIOPCIProxy *proxy,
>                                  &region->mr);
>  }
> =

> +static void virtio_pci_pre_plugged(DeviceState *d, Error **errp)
> +{
> +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(d);
> +    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> +
> +    if (virtio_pci_modern(proxy)) {
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
> +    }
> +
> +    virtio_add_feature(&vdev->host_features, VIRTIO_F_BAD_FEATURE);
> +}
> +
>  /* This is called by virtio-bus just after the device is plugged. */
>  static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>  {
>      VirtIOPCIProxy *proxy =3D VIRTIO_PCI(d);
>      VirtioBusState *bus =3D &proxy->bus;
>      bool legacy =3D virtio_pci_legacy(proxy);
> -    bool modern =3D virtio_pci_modern(proxy);
> +    bool modern;
>      bool modern_pio =3D proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
>      uint8_t *config;
>      uint32_t size;
>      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> =

> +    /*
> +     * Virtio capabilities present without
> +     * VIRTIO_F_VERSION_1 confuses guests
> +     */
> +    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
> +        virtio_pci_disable_modern(proxy);
> +
> +        if (!legacy) {
> +            error_setg(errp, "Device doesn't support modern mode, and le=
gacy"
> +                             " mode is disabled");
> +            error_append_hint(errp, "Set disable-legacy to off\n");
> +
> +            return;
> +        }
> +    }
> +
> +    modern =3D virtio_pci_modern(proxy);
> +
>      config =3D proxy->pci_dev.config;
>      if (proxy->class_code) {
>          pci_config_set_class(config, proxy->class_code);
> @@ -1629,7 +1659,6 @@ static void virtio_pci_device_plugged(DeviceState *=
d, Error **errp)
> =

>          struct virtio_pci_cfg_cap *cfg_mask;
> =

> -        virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
>          virtio_pci_modern_regions_init(proxy);
> =

>          virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
> @@ -1694,8 +1723,6 @@ static void virtio_pci_device_plugged(DeviceState *=
d, Error **errp)
>      if (!kvm_has_many_ioeventfds()) {
>          proxy->flags &=3D ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
>      }
> -
> -    virtio_add_feature(&vdev->host_features, VIRTIO_F_BAD_FEATURE);
>  }
> =

>  static void virtio_pci_device_unplugged(DeviceState *d)
> @@ -2508,6 +2535,7 @@ static void virtio_pci_bus_class_init(ObjectClass *=
klass, void *data)
>      k->query_guest_notifiers =3D virtio_pci_query_guest_notifiers;
>      k->set_guest_notifiers =3D virtio_pci_set_guest_notifiers;
>      k->vmstate_change =3D virtio_pci_vmstate_change;
> +    k->pre_plugged =3D virtio_pci_pre_plugged;
>      k->device_plugged =3D virtio_pci_device_plugged;
>      k->device_unplugged =3D virtio_pci_device_unplugged;
>      k->query_nvectors =3D virtio_pci_query_nvectors;
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 0698157..541cbdb 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -181,6 +181,11 @@ static inline void virtio_pci_force_virtio_1(VirtIOP=
CIProxy *proxy)
>      proxy->disable_legacy =3D ON_OFF_AUTO_ON;
>  }
> =

> +static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
> +{
> +    proxy->disable_modern =3D true;
> +}
> +
>  /*
>   * virtio-scsi-pci: This extends VirtioPCIProxy.
>   */
> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bu=
s.h
> index f3e5ef3..24caa0a 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -54,16 +54,16 @@ typedef struct VirtioBusClass {
>      int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
>      void (*vmstate_change)(DeviceState *d, bool running);
>      /*
> +     * Expose the features the transport layer supports before
> +     * the negotiation takes place.
> +     */
> +    void (*pre_plugged)(DeviceState *d, Error **errp);
> +    /*
>       * transport independent init function.
>       * This is called by virtio-bus just after the device is plugged.
>       */
>      void (*device_plugged)(DeviceState *d, Error **errp);
>      /*
> -     * Re-evaluate setup after feature bits have been validated
> -     * by the device backend.
> -     */
> -    void (*post_plugged)(DeviceState *d, Error **errp);
> -    /*
>       * transport independent exit function.
>       * This is called by virtio-bus just before the device is unplugged.
>       */
> -- =

> 2.7.4
> =

>=20
