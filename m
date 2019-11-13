Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8DCC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA87620818
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQo1hw/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA87620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUpb2-0007wy-0X
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 05:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iUpaL-0007RZ-Di
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iUpaJ-0001Aa-BY
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:09:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iUpaJ-000195-66
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573639749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2pCBtBHHmOMc2NKla+4he9Lgx9niz9+qaboC2JBdEQ=;
 b=EQo1hw/BHx0d1rHgRnb36pgBqmPdqRZQbUtZgVppyQ2wl4vHGJHFjhd5OLrA+Cju+YQBln
 K7Z93gST2TOBblqcouYpkK5EfYm1r7J0iWBdU1NXoWcfLmaShjiRiii18TL+vHSP+aWL5d
 +3dG9AfF3INFr2HPWoBCSMvXUn1IKHw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-lJDZ29pTP8Cmu_hHELioFQ-1; Wed, 13 Nov 2019 05:09:08 -0500
Received: by mail-qt1-f200.google.com with SMTP id i1so976864qtj.19
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 02:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/wmfE/jeWUvmmlbPQU7s4gyOODIUbXqwffYYl7y+fsM=;
 b=aNghAI9HHvDnYlY+pGvnU+iZsO8/fpIIBn7k0sh/ObtJ8bFnQFg/Y4avaOwF5+C3Oy
 /bpI/2nUJPej6t7lgJxVJ3gtAIlo4qOpsGGuo6crO3MF0EDMjP8FZ9cQSMAjjmKVQxFL
 6523dZlMSXRx4DDpIGTj1VYWaz3o/mGf4AA093ydDVKDVBuJexLin10Ubflw8rA5x06R
 U8mQSxqUoAtZm/d+t0tpWYFH8hyvGXPRTZEoKl77RuGfDv8LHsrxc/N4dSkJXSV4aiSE
 S4UQVf2062U226SKNRxcbksldXehSR/rir0uXubishx2qfOHXzaYZb3W0q2WHN5AW9vw
 pNLw==
X-Gm-Message-State: APjAAAUEKY+1Pz/jqZc4sYD+USWjo5flyW8wpKpntGmX94sI9y98TqRo
 IQjn0hzSF3IdQOGq3zdBaqPtXcgG9dL/884stFpQGl5GmHdBtBOw5GNvSoj+ednjsV0E+qXFX74
 z0M5J0MVVrWTo3C8=
X-Received: by 2002:a05:6214:11f2:: with SMTP id
 e18mr2106975qvu.86.1573639747717; 
 Wed, 13 Nov 2019 02:09:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5fS/DNv5jEjjplQCSwM/oyJgGoEENs1MgrUEEm2eRrT72LSEFWqvW3C0DbJ+ybM/zq1R5ow==
X-Received: by 2002:a05:6214:11f2:: with SMTP id
 e18mr2106952qvu.86.1573639747339; 
 Wed, 13 Nov 2019 02:09:07 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id z7sm1098934qth.85.2019.11.13.02.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 02:09:06 -0800 (PST)
Date: Wed, 13 Nov 2019 05:09:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: disable vring processing when
 bus-mastering is disabled
Message-ID: <20191113050402-mutt-send-email-mst@kernel.org>
References: <20191113054301.31529-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191113054301.31529-1-mdroth@linux.vnet.ibm.com>
X-MC-Unique: lJDZ29pTP8Cmu_hHELioFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 11:43:01PM -0600, Michael Roth wrote:
> Currently the SLOF firmware for pseries guests will disable/re-enable
> a PCI device multiple times via IO/MEM/MASTER bits of PCI_COMMAND
> register after the initial probe/feature negotiation, as it tends to
> work with a single device at a time at various stages like probing
> and running block/network bootloaders without doing a full reset
> in-between.
>=20
> In QEMU, when PCI_COMMAND_MASTER is disabled we disable the
> corresponding IOMMU memory region, so DMA accesses (including to vring
> fields like idx/flags) will no longer undergo the necessary
> translation. Normally we wouldn't expect this to happen since it would
> be misbehavior on the driver side to continue driving DMA requests.
>=20
> However, in the case of pseries, with iommu_platform=3Don, we trigger the
> following sequence when tearing down the virtio-blk dataplane ioeventfd
> in response to the guest unsetting PCI_COMMAND_MASTER:
>=20
>   #2  0x0000555555922651 in virtqueue_map_desc (vdev=3Dvdev@entry=3D0x555=
556dbcfb0, p_num_sg=3Dp_num_sg@entry=3D0x7fffe657e1a8, addr=3Daddr@entry=3D=
0x7fffe657e240, iov=3Diov@entry=3D0x7fffe6580240, max_num_sg=3Dmax_num_sg@e=
ntry=3D1024, is_write=3Dis_write@entry=3Dfalse, pa=3D0, sz=3D0)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:757
>   #3  0x0000555555922a89 in virtqueue_pop (vq=3Dvq@entry=3D0x555556dc8660=
, sz=3Dsz@entry=3D184)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:950
>   #4  0x00005555558d3eca in virtio_blk_get_request (vq=3D0x555556dc8660, =
s=3D0x555556dbcfb0)
>       at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:255
>   #5  0x00005555558d3eca in virtio_blk_handle_vq (s=3D0x555556dbcfb0, vq=
=3D0x555556dc8660)
>       at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:776
>   #6  0x000055555591dd66 in virtio_queue_notify_aio_vq (vq=3Dvq@entry=3D0=
x555556dc8660)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1550
>   #7  0x000055555591ecef in virtio_queue_notify_aio_vq (vq=3D0x555556dc86=
60)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1546
>   #8  0x000055555591ecef in virtio_queue_host_notifier_aio_poll (opaque=
=3D0x555556dc86c8)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:2527
>   #9  0x0000555555d02164 in run_poll_handlers_once (ctx=3Dctx@entry=3D0x5=
5555688bfc0, timeout=3Dtimeout@entry=3D0x7fffe65844a8)
>       at /home/mdroth/w/qemu.git/util/aio-posix.c:520
>   #10 0x0000555555d02d1b in try_poll_mode (timeout=3D0x7fffe65844a8, ctx=
=3D0x55555688bfc0)
>       at /home/mdroth/w/qemu.git/util/aio-posix.c:607
>   #11 0x0000555555d02d1b in aio_poll (ctx=3Dctx@entry=3D0x55555688bfc0, b=
locking=3Dblocking@entry=3Dtrue)
>       at /home/mdroth/w/qemu.git/util/aio-posix.c:639
>   #12 0x0000555555d0004d in aio_wait_bh_oneshot (ctx=3D0x55555688bfc0, cb=
=3Dcb@entry=3D0x5555558d5130 <virtio_blk_data_plane_stop_bh>, opaque=3Dopaq=
ue@entry=3D0x555556de86f0)
>       at /home/mdroth/w/qemu.git/util/aio-wait.c:71
>   #13 0x00005555558d59bf in virtio_blk_data_plane_stop (vdev=3D<optimized=
 out>)
>       at /home/mdroth/w/qemu.git/hw/block/dataplane/virtio-blk.c:288
>   #14 0x0000555555b906a1 in virtio_bus_stop_ioeventfd (bus=3Dbus@entry=3D=
0x555556dbcf38)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:245
>   #15 0x0000555555b90dbb in virtio_bus_stop_ioeventfd (bus=3Dbus@entry=3D=
0x555556dbcf38)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:237
>   #16 0x0000555555b92a8e in virtio_pci_stop_ioeventfd (proxy=3D0x555556db=
4e40)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:292
>   #17 0x0000555555b92a8e in virtio_write_config (pci_dev=3D0x555556db4e40=
, address=3D<optimized out>, val=3D1048832, len=3D<optimized out>)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:613
>=20
> I.e. the calling code is only scheduling a one-shot BH for
> virtio_blk_data_plane_stop_bh, but somehow we end up trying to process
> an additional virtqueue entry before we get there. This is likely due
> to the following check in virtio_queue_host_notifier_aio_poll:
>=20
>   static bool virtio_queue_host_notifier_aio_poll(void *opaque)
>   {
>       EventNotifier *n =3D opaque;
>       VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
>       bool progress;
>=20
>       if (!vq->vring.desc || virtio_queue_empty(vq)) {
>           return false;
>       }
>=20
>       progress =3D virtio_queue_notify_aio_vq(vq);
>=20
> namely the call to virtio_queue_empty(). In this case, since no new
> requests have actually been issued, shadow_avail_idx =3D=3D last_avail_id=
x,
> so we actually try to access the vring via vring_avail_idx() to get
> the latest non-shadowed idx:
>=20
>   int virtio_queue_empty(VirtQueue *vq)
>   {
>       bool empty;
>       ...
>=20
>       if (vq->shadow_avail_idx !=3D vq->last_avail_idx) {
>           return 0;
>       }
>=20
>       rcu_read_lock();
>       empty =3D vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
>       rcu_read_unlock();
>       return empty;
>=20
> but since the IOMMU region has been disabled we get a bogus value (0
> usually), which causes virtio_queue_empty() to falsely report that
> there are entries to be processed, which causes errors such as:
>=20
>   "virtio: zero sized buffers are not allowed"
>=20
> or
>=20
>   "virtio-blk missing headers"
>=20
> and puts the device in an error state.
>=20
> This patch works around the issue by introducing virtio_set_disabled(),
> which piggy-backs off the vdev->broken flag we already use to bypass
> checks like virtio_queue_empty(), and sets/unsets it in response to
> enabling/disabling bus-mastering.
>=20
> NOTES:
>=20
>  - It's possible we could also work around this in SLOF by doing a
>    full reset instead of relying on PCI_COMMAND to enable/disable, but
>    in any case the QEMU behavior seems wrong.
>  - This leaves some other oddities in play, like the fact that
>    DRIVER_OK also gets unset in response to bus-mastering being
>    disabled, but not restored (however the device seems to continue
>    working)
>  - Similarly, we disable the host notifier via
>    virtio_bus_stop_ioeventfd(), which seems to move the handling out
>    of virtio-blk dataplane and back into the main IO thread, and it
>    ends up staying there till a reset (but otherwise continues working
>    normally)
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>,
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  hw/virtio/virtio-pci.c     | 12 ++++++++----
>  hw/virtio/virtio.c         |  7 ++++++-
>  include/hw/virtio/virtio.h |  1 +
>  3 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c6b47a9c73..394d409fb9 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -608,10 +608,14 @@ static void virtio_write_config(PCIDevice *pci_dev,=
 uint32_t address,
>          pcie_cap_flr_write_config(pci_dev, address, val, len);
>      }
> =20
> -    if (range_covers_byte(address, len, PCI_COMMAND) &&
> -        !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> -        virtio_pci_stop_ioeventfd(proxy);
> -        virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIVER_O=
K);
> +    if (range_covers_byte(address, len, PCI_COMMAND)) {
> +        if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> +            virtio_set_disabled(vdev, true);
> +            virtio_pci_stop_ioeventfd(proxy);
> +            virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIV=
ER_OK);
> +        } else {
> +            virtio_set_disabled(vdev, false);
> +        }
>      }
> =20
>      if (proxy->config_cap &&
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 527df03bfd..46580c357d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2575,6 +2575,11 @@ void virtio_device_set_child_bus_name(VirtIODevice=
 *vdev, char *bus_name)
>      vdev->bus_name =3D g_strdup(bus_name);
>  }
> =20
> +void virtio_set_disabled(VirtIODevice *vdev, bool disable)
> +{
> +    vdev->broken =3D disable;
> +}
> +
>  void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt=
, ...)
>  {
>      va_list ap;

Hmm. I think just clear and immediate set of bus master while device was
not doing any DMA actually should be fine and should not require a
reset.  Now it's true that right now guests reset first thing which will
clear the broken flag, but I'd say it's wrong to require this specific
order.
I think the easiest thing is to add a "disabled" flag.


> @@ -2588,7 +2593,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *=
vdev, const char *fmt, ...)
>          virtio_notify_config(vdev);
>      }
> =20
> -    vdev->broken =3D true;
> +    virtio_set_disabled(vdev, true);
>  }
> =20
>  static void virtio_memory_listener_commit(MemoryListener *listener)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 48e8d04ff6..921945b7e8 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -168,6 +168,7 @@ void virtio_init(VirtIODevice *vdev, const char *name=
,
>                           uint16_t device_id, size_t config_size);
>  void virtio_cleanup(VirtIODevice *vdev);
> =20
> +void virtio_set_disabled(VirtIODevice *vdev, bool disable);
>  void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_ATTR=
(2, 3);
> =20
>  /* Set the child bus name. */


One open question here is cross version migration.
What exactly happens if we migrate to an old qemu?
from an old qemu?

> --=20
> 2.17.1


