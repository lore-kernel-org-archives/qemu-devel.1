Received: from eggs.gnu.org ([2001:4830:134:3::10]:34794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1ePNbb-0000F4-Mp
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 02:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1ePNbW-0003Ne-Ly
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 02:06:55 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1ePNbW-0003LV-2x
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 02:06:50 -0500
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
From: Ilya Maximets <i.maximets@samsung.com>
Message-id: <0e3648df-6aa2-f3e1-5ae6-14fb01d7b476@samsung.com>
Date: Thu, 14 Dec 2017 10:06:43 +0300
In-reply-to: <20171213214749-mutt-send-email-mst@kernel.org>
Content-language: en-GB
References: <CGME20171206130624eucas1p1f73fd4cf613eaf3ce4ce6918c807f8e1@eucas1p1.samsung.com>
	<1512565578-12078-1-git-send-email-i.maximets@samsung.com>
	<20171206184432-mutt-send-email-mst@kernel.org>
	<249c9e25-0bdb-7a44-6821-59474d25baa5@samsung.com>
	<20171207192456-mutt-send-email-mst@kernel.org>
	<a725504a-957e-d18c-d495-bf4a7c5adc55@samsung.com>
	<20171211062301-mutt-send-email-mst@kernel.org>
	<4ac23512-210b-0543-7ce7-82c9639f321c@samsung.com>
	<20171213214749-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: fix crash on virtio_error while
 device stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Heetae Ahn <heetae82.ahn@samsung.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On 13.12.2017 22:48, Michael S. Tsirkin wrote:
> On Wed, Dec 13, 2017 at 04:45:20PM +0300, Ilya Maximets wrote:
>>>> That
>>>> looks very strange. Some of the functions gets 'old_status', others
>>>> the 'new_status'. I'm a bit confused.
>>>
>>> OK, fair enough. Fixed - let's pass old status everywhere,
>>> users that need the new one can get it from the vdev.
>>>
>>>> And it's not functional in current state:
>>>>
>>>> hw/net/virtio-net.c:264:28: error: =E2=80=98status=E2=80=99 undeclar=
ed
>>>
>>> Fixed too. new version below.
>>
>> This doesn't fix the segmentation fault.
>=20
> Hmm you are right. Looking into it.
>=20
>> I have exactly same crash stacktrace:
>>
>> #0  vhost_memory_unmap hw/virtio/vhost.c:446
>> #1  vhost_virtqueue_stop hw/virtio/vhost.c:1155
>> #2  vhost_dev_stop hw/virtio/vhost.c:1594
>> #3  vhost_net_stop_one hw/net/vhost_net.c:289
>> #4  vhost_net_stop hw/net/vhost_net.c:368
>> #5  virtio_net_vhost_status (old_status=3D15 '\017', n=3D0x5625f390110=
0) at hw/net/virtio-net.c:180
>> #6  virtio_net_set_status (vdev=3D0x5625f3901100, old_status=3D<optimi=
zed out>) at hw/net/virtio-net.c:254
>> #7  virtio_set_status (vdev=3Dvdev@entry=3D0x5625f3901100, val=3D<opti=
mized out>) at hw/virtio/virtio.c:1152
>> #8  virtio_error (vdev=3D0x5625f3901100, fmt=3Dfmt@entry=3D0x5625f014f=
688 "Guest says index %u is available") at hw/virtio/virtio.c:2460
>=20
> BTW what is causing this? Why is guest avail index corrupted?

My testing environment for the issue:

* QEMU 2.10.1
* testpmd from a bit outdated DPDK 16.07.0 in guest with uio_pci_generic
* OVS 2.8 with DPDK 17.05.2 on the host.
* 2 vhost-user ports in VM in server mode.
* Testpmd just forwards packets from one port to another with --forward-m=
ode=3Dmac

testpmd with virtio-net driver sometimes crashes after killing the OVS if=
 some
heavy traffic flows. After restarting of the OVS and stopping it again QE=
MU
crashes on vhost disconnect and virtqueue_get_head() failure.

So, the sequence is follows:

1. Start OVS, Start QEMU, start testpmd, start external packet generator.
2. pkill -11 ovs-vswitchd
3. If testpmd not crashed in guest goto step #1.
4. Start OVS (testpmd with virtio driver still in down state)
5. pkill -11 ovs-vswitchd
6. Observe QEMU crash

I suspect that virtio-net driver from DPDK 16.07.0 corrupts vrings
just before crash at step #2.

I didn't tried actually to investigate virtio driver crash because it's a=
 bit
out of my scope and I have no enough time and a driver slightly outdated.
But the stability of QEMU itself is really important thing.

One interesting thing is that I can not reproduce virtio driver crash wit=
h
"virtio: rework set_status callbacks" applied. I had to break vrings manu=
ally
to reproduce original nested call of vhost_net_stop().

>=20
>> #9  virtqueue_get_head at hw/virtio/virtio.c:543
>> #10 virtqueue_drop_all hw/virtio/virtio.c:984
>> #11 virtio_net_drop_tx_queue_data hw/net/virtio-net.c:240
>> #12 virtio_bus_set_host_notifier at hw/virtio/virtio-bus.c:297
>> #13 vhost_dev_disable_notifiers at hw/virtio/vhost.c:1431
>> #14 vhost_net_stop_one at hw/net/vhost_net.c:290
>> #15 vhost_net_stop at hw/net/vhost_net.c:368
>> #16 virtio_net_vhost_status (old_status=3D15 '\017', n=3D0x5625f390110=
0) at hw/net/virtio-net.c:180
>> #17 virtio_net_set_status (vdev=3D0x5625f3901100, old_status=3D<optimi=
zed out>) at hw/net/virtio-net.c:254
>> #18 qmp_set_link at net/net.c:1430
>> #19 chr_closed_bh at net/vhost-user.c:214
>> #20 aio_bh_call at util/async.c:90
>> #21 aio_bh_poll at util/async.c:118
>> #22 aio_dispatch at util/aio-posix.c:429
>> #23 aio_ctx_dispatch at util/async.c:261
>> #24 g_main_context_dispatch () from /lib64/libglib-2.0.so.0
>> #25 glib_pollfds_poll () at util/main-loop.c:213
>> #26 os_host_main_loop_wait at util/main-loop.c:261
>> #27 main_loop_wait at util/main-loop.c:515
>> #28 main_loop () at vl.c:1917
>> #29 main
>>
>>
>> Actually the logic doesn't change. In function  virtio_net_vhost_statu=
s():
>>
>> -    if ((virtio_net_started(n, status) && !nc->peer->link_down) =3D=3D
>> +    if ((virtio_net_started(n, vdev->status) && !nc->peer->link_down)=
 =3D=3D
>>          !!n->vhost_started) {
>>          return;
>>      }
>>
>> previously new 'status' was checked and the new 'vdev->status' checked=
 now.
>> It's the same condition that doesn't work because vhost_started flag i=
s still
>> set to 1.
>> Anyway, nc->peer->link_down is true in our case, so there is no differ=
ence if
>> we'll change the vdev->status.
>>
>>>>>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> Still completely untested, sorry about that - hope you can help here.
>>>
>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>> index 098bdaa..f5d0ee1 100644
>>> --- a/include/hw/virtio/virtio.h
>>> +++ b/include/hw/virtio/virtio.h
>>> @@ -115,7 +115,7 @@ typedef struct VirtioDeviceClass {
>>>      void (*get_config)(VirtIODevice *vdev, uint8_t *config);
>>>      void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>>>      void (*reset)(VirtIODevice *vdev);
>>> -    void (*set_status)(VirtIODevice *vdev, uint8_t val);
>>> +    void (*set_status)(VirtIODevice *vdev, uint8_t old_status);
>>>      /* For transitional devices, this is a bitmap of features
>>>       * that are only exposed on the legacy interface but not
>>>       * the modern one.
>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>> index 05d1440..b8b07ba 100644
>>> --- a/hw/block/virtio-blk.c
>>> +++ b/hw/block/virtio-blk.c
>>> @@ -814,15 +814,15 @@ static uint64_t virtio_blk_get_features(VirtIOD=
evice *vdev, uint64_t features,
>>>      return features;
>>>  }
>>> =20
>>> -static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status=
)
>>> +static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t old_st=
atus)
>>>  {
>>>      VirtIOBlock *s =3D VIRTIO_BLK(vdev);
>>> =20
>>> -    if (!(status & (VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_=
OK))) {
>>> +    if (!(vdev->status & (VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_D=
RIVER_OK))) {
>>>          assert(!s->dataplane_started);
>>>      }
>>> =20
>>> -    if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>> +    if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>>          return;
>>>      }
>>> =20
>>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.=
c
>>> index 9470bd7..881b1ff 100644
>>> --- a/hw/char/virtio-serial-bus.c
>>> +++ b/hw/char/virtio-serial-bus.c
>>> @@ -616,7 +616,7 @@ static void guest_reset(VirtIOSerial *vser)
>>>      }
>>>  }
>>> =20
>>> -static void set_status(VirtIODevice *vdev, uint8_t status)
>>> +static void set_status(VirtIODevice *vdev, uint8_t old_status)
>>>  {
>>>      VirtIOSerial *vser;
>>>      VirtIOSerialPort *port;
>>> @@ -625,7 +625,7 @@ static void set_status(VirtIODevice *vdev, uint8_=
t status)
>>>      port =3D find_port_by_id(vser, 0);
>>> =20
>>>      if (port && !use_multiport(port->vser)
>>> -        && (status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>> +        && (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>>          /*
>>>           * Non-multiport guests won't be able to tell us guest
>>>           * open/close status.  Such guests can only have a port at i=
d
>>> @@ -634,7 +634,7 @@ static void set_status(VirtIODevice *vdev, uint8_=
t status)
>>>           */
>>>          port->guest_connected =3D true;
>>>      }
>>> -    if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>> +    if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>>          guest_reset(vser);
>>>      }
>>> =20
>>> diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
>>> index 0e42f0d..abb817b 100644
>>> --- a/hw/input/virtio-input.c
>>> +++ b/hw/input/virtio-input.c
>>> @@ -188,12 +188,12 @@ static uint64_t virtio_input_get_features(VirtI=
ODevice *vdev, uint64_t f,
>>>      return f;
>>>  }
>>> =20
>>> -static void virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
>>> +static void virtio_input_set_status(VirtIODevice *vdev, uint8_t old_=
val)
>>>  {
>>>      VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(vdev);
>>>      VirtIOInput *vinput =3D VIRTIO_INPUT(vdev);
>>> =20
>>> -    if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
>>> +    if (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
>>>          if (!vinput->active) {
>>>              vinput->active =3D true;
>>>              if (vic->change_active) {
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 38674b0..7851968 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -124,7 +124,7 @@ static void virtio_net_announce_timer(void *opaqu=
e)
>>>      virtio_notify_config(vdev);
>>>  }
>>> =20
>>> -static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
>>> +static void virtio_net_vhost_status(VirtIONet *n, uint8_t old_status=
)
>>>  {
>>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>>>      NetClientState *nc =3D qemu_get_queue(n->nic);
>>> @@ -134,7 +134,7 @@ static void virtio_net_vhost_status(VirtIONet *n,=
 uint8_t status)
>>>          return;
>>>      }
>>> =20
>>> -    if ((virtio_net_started(n, status) && !nc->peer->link_down) =3D=3D
>>> +    if ((virtio_net_started(n, vdev->status) && !nc->peer->link_down=
) =3D=3D
>>>          !!n->vhost_started) {
>>>          return;
>>>      }
>>> @@ -212,12 +212,12 @@ static bool virtio_net_set_vnet_endian(VirtIODe=
vice *vdev, NetClientState *ncs,
>>>      return false;
>>>  }
>>> =20
>>> -static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t stat=
us)
>>> +static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t old_=
status)
>>>  {
>>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>>>      int queues =3D n->multiqueue ? n->max_queues : 1;
>>> =20
>>> -    if (virtio_net_started(n, status)) {
>>> +    if (virtio_net_started(n, vdev->status)) {
>>>          /* Before using the device, we tell the network backend abou=
t the
>>>           * endianness to use when parsing vnet headers. If the backe=
nd
>>>           * can't do it, we fallback onto fixing the headers in the c=
ore
>>> @@ -225,7 +225,7 @@ static void virtio_net_vnet_endian_status(VirtION=
et *n, uint8_t status)
>>>           */
>>>          n->needs_vnet_hdr_swap =3D virtio_net_set_vnet_endian(vdev, =
n->nic->ncs,
>>>                                                              queues, =
true);
>>> -    } else if (virtio_net_started(n, vdev->status)) {
>>> +    } else if (virtio_net_started(n, old_status)) {
>>>          /* After using the device, we need to reset the network back=
end to
>>>           * the default (guest native endianness), otherwise the gues=
t may
>>>           * lose network connectivity if it is rebooted into a differ=
ent
>>> @@ -243,15 +243,15 @@ static void virtio_net_drop_tx_queue_data(VirtI=
ODevice *vdev, VirtQueue *vq)
>>>      }
>>>  }
>>> =20
>>> -static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t=
 status)
>>> +static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t=
 old_status)
>>>  {
>>>      VirtIONet *n =3D VIRTIO_NET(vdev);
>>>      VirtIONetQueue *q;
>>>      int i;
>>>      uint8_t queue_status;
>>> =20
>>> -    virtio_net_vnet_endian_status(n, status);
>>> -    virtio_net_vhost_status(n, status);
>>> +    virtio_net_vnet_endian_status(n, old_status);
>>> +    virtio_net_vhost_status(n, old_status);
>>> =20
>>>      for (i =3D 0; i < n->max_queues; i++) {
>>>          NetClientState *ncs =3D qemu_get_subqueue(n->nic, i);
>>> @@ -261,7 +261,7 @@ static void virtio_net_set_status(struct VirtIODe=
vice *vdev, uint8_t status)
>>>          if ((!n->multiqueue && i !=3D 0) || i >=3D n->curr_queues) {
>>>              queue_status =3D 0;
>>>          } else {
>>> -            queue_status =3D status;
>>> +            queue_status =3D vdev->status;
>>>          }
>>>          queue_started =3D
>>>              virtio_net_started(n, queue_status) && !n->vhost_started=
;
>>> @@ -2048,9 +2048,11 @@ static void virtio_net_device_unrealize(Device=
State *dev, Error **errp)
>>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>>>      VirtIONet *n =3D VIRTIO_NET(dev);
>>>      int i, max_queues;
>>> +    uint8_t old_status =3D vdev->status;
>>> =20
>>>      /* This will stop vhost backend if appropriate. */
>>> -    virtio_net_set_status(vdev, 0);
>>> +    vdev->status =3D 0;
>>> +    virtio_net_set_status(vdev, old_status);
>>> =20
>>>      g_free(n->netclient_name);
>>>      n->netclient_name =3D NULL;
>>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>>> index 9c1bea8..5a561e4 100644
>>> --- a/hw/scsi/vhost-scsi.c
>>> +++ b/hw/scsi/vhost-scsi.c
>>> @@ -108,11 +108,11 @@ static void vhost_scsi_stop(VHostSCSI *s)
>>>      vhost_scsi_common_stop(vsc);
>>>  }
>>> =20
>>> -static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
>>> +static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t old_va=
l)
>>>  {
>>>      VHostSCSI *s =3D VHOST_SCSI(vdev);
>>>      VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>> -    bool start =3D (val & VIRTIO_CONFIG_S_DRIVER_OK);
>>> +    bool start =3D vdev->status & VIRTIO_CONFIG_S_DRIVER_OK;
>>> =20
>>>      if (vsc->dev.started =3D=3D start) {
>>>          return;
>>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>>> index f7561e2..289a27e 100644
>>> --- a/hw/scsi/vhost-user-scsi.c
>>> +++ b/hw/scsi/vhost-user-scsi.c
>>> @@ -38,11 +38,11 @@ static const int user_feature_bits[] =3D {
>>>      VHOST_INVALID_FEATURE_BIT
>>>  };
>>> =20
>>> -static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t s=
tatus)
>>> +static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t o=
ld_status)
>>>  {
>>>      VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>>>      VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>> -    bool start =3D (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_=
running;
>>> +    bool start =3D (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) && vde=
v->vm_running;
>>> =20
>>>      if (vsc->dev.started =3D=3D start) {
>>>          return;
>>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>>> index 5ec1c6a..d3f445b 100644
>>> --- a/hw/virtio/vhost-vsock.c
>>> +++ b/hw/virtio/vhost-vsock.c
>>> @@ -154,10 +154,10 @@ static void vhost_vsock_stop(VirtIODevice *vdev=
)
>>>      vhost_dev_disable_notifiers(&vsock->vhost_dev, vdev);
>>>  }
>>> =20
>>> -static void vhost_vsock_set_status(VirtIODevice *vdev, uint8_t statu=
s)
>>> +static void vhost_vsock_set_status(VirtIODevice *vdev, uint8_t old_s=
tatus)
>>>  {
>>>      VHostVSock *vsock =3D VHOST_VSOCK(vdev);
>>> -    bool should_start =3D status & VIRTIO_CONFIG_S_DRIVER_OK;
>>> +    bool should_start =3D vdev->status & VIRTIO_CONFIG_S_DRIVER_OK;
>>> =20
>>>      if (!vdev->vm_running) {
>>>          should_start =3D false;
>>> @@ -370,11 +370,14 @@ static void vhost_vsock_device_unrealize(Device=
State *dev, Error **errp)
>>>  {
>>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>>>      VHostVSock *vsock =3D VHOST_VSOCK(dev);
>>> +    uint8_t old_status;
>>> =20
>>>      vhost_vsock_post_load_timer_cleanup(vsock);
>>> =20
>>>      /* This will stop vhost backend if appropriate. */
>>> -    vhost_vsock_set_status(vdev, 0);
>>> +    old_status =3D vdev->status;
>>> +    vdev->status =3D 0;
>>> +    vhost_vsock_set_status(vdev, old_status);
>>> =20
>>>      vhost_dev_cleanup(&vsock->vhost_dev);
>>>      virtio_cleanup(vdev);
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index 37cde38..84e897a 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -468,12 +468,12 @@ static void virtio_balloon_device_reset(VirtIOD=
evice *vdev)
>>>      }
>>>  }
>>> =20
>>> -static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t st=
atus)
>>> +static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t ol=
d_status)
>>>  {
>>>      VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
>>> =20
>>>      if (!s->stats_vq_elem && vdev->vm_running &&
>>> -        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->=
svq, 1)) {
>>> +        (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewi=
nd(s->svq, 1)) {
>>>          /* poll stats queue for the element we have discarded when t=
he VM
>>>           * was stopped */
>>>          virtio_balloon_receive_stats(vdev, s->svq);
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index ad564b0..4981858 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -1128,6 +1128,8 @@ static int virtio_validate_features(VirtIODevic=
e *vdev)
>>>  int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>>>  {
>>>      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>>> +    uint8_t old_status;
>>> +
>>>      trace_virtio_set_status(vdev, val);
>>> =20
>>>      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>>> @@ -1140,10 +1142,13 @@ int virtio_set_status(VirtIODevice *vdev, uin=
t8_t val)
>>>              }
>>>          }
>>>      }
>>> +
>>> +    old_status =3D vdev->status;
>>> +    vdev->status =3D val;
>>> +
>>>      if (k->set_status) {
>>> -        k->set_status(vdev, val);
>>> +        k->set_status(vdev, old_status);
>>>      }
>>> -    vdev->status =3D val;
>>>      return 0;
>>>  }
>>> =20
>>>
>>>
>>>
>=20
>=20
>=20
