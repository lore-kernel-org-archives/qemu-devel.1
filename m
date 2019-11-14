Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C98DC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 01:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D7E206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 01:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNfcLudk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D7E206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV3d2-0006xE-0V
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 20:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1iV3bv-0006YL-HL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 20:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1iV3bt-0004H2-AS
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 20:07:47 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1iV3bt-0004Ez-0p
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 20:07:45 -0500
Received: by mail-ot1-x343.google.com with SMTP id w24so2931183otk.6
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 17:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=rxSzMiELlbhVjqJe9+KP93GDYnYU135WdctEEPZoRQs=;
 b=RNfcLudksSU2EJTiAgXkr8a4iPbxJaj7IyPeNvHrXjKds7j+4jGXbVGSEJ7YkcHbD7
 liy5YUTBhwZ/Y5/WatubBggjMsHcBnAzEZUbFHfoU0ZmQXNFEaojXSEty/pOOqN2TfDV
 XErAhFuwKWFUtYehjRs5yaBLkSbfVjJdFRW/xPB5wrkyavZENJhL+ww/Iqf9+wkw4q47
 +xfx1m8nz/a3gS/BQvJZGpFW8KxjMackGrkG/E0f2SZoVIPXg57Iu8pqKxsieAQz4Ub+
 11GJZ8u6g5bo0PVojYlM/RoJptuLZi0IXBbBIOEBaM+K74cWRZq9KZ0Ew4ky8BTlFAVS
 fz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=rxSzMiELlbhVjqJe9+KP93GDYnYU135WdctEEPZoRQs=;
 b=aDWtN3GBbgZvO/T6I0U1d7RNgRlAzETidrbGTvRbV9NlJn85GmVnxtWvTNYfizqcTg
 Zkji7mFnSCKyP4nVA1LU7hhFKcdmbjMAbvv/nl//Mh7CbDvXWhb90NyuNGWxxyrPEGLm
 lM7qy20CIbXB3PDIsVq2+zZ9QT8c6IVgAzo0mJ5nyYibJnU0anUfoz/Fk1LH37AppMIQ
 EVByI50yxihkUrjRnoSHbszMqaQRJCRSzW3UTyLcB53ZhyEd5TokgygzIKn6k2O1IB4S
 Nuu7kY7xx4ETHLAn5PkhRzqFVnBXA3wk/jezR46PIZ4Qx461S26Kqe2SZ9dk43jH+CMZ
 B8oQ==
X-Gm-Message-State: APjAAAWz4nKiv86B5uvzjtRVvOsyD4vinkwgRxx6E9SiZ5daiP8ARzkx
 wylIf9MUzBmMaiCGRrnsURI=
X-Google-Smtp-Source: APXvYqwVPil5MrUlKXkgKXU6X2t9qP21KngmYA/USW1eF6wvo4J9Zm1oNJfC6g82LO7yWkCMhby1uw==
X-Received: by 2002:a9d:568:: with SMTP id 95mr4917110otw.99.1573693663354;
 Wed, 13 Nov 2019 17:07:43 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id q3sm1282013oti.49.2019.11.13.17.07.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Nov 2019 17:07:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20191113050402-mutt-send-email-mst@kernel.org>
References: <20191113054301.31529-1-mdroth@linux.vnet.ibm.com>
 <20191113050402-mutt-send-email-mst@kernel.org>
Message-ID: <157369365636.3335.3099930975683371802@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH RFC] virtio-pci: disable vring processing when
 bus-mastering is disabled
Date: Wed, 13 Nov 2019 19:07:36 -0600
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

Quoting Michael S. Tsirkin (2019-11-13 04:09:02)
> On Tue, Nov 12, 2019 at 11:43:01PM -0600, Michael Roth wrote:
> > Currently the SLOF firmware for pseries guests will disable/re-enable
> > a PCI device multiple times via IO/MEM/MASTER bits of PCI_COMMAND
> > register after the initial probe/feature negotiation, as it tends to
> > work with a single device at a time at various stages like probing
> > and running block/network bootloaders without doing a full reset
> > in-between.
> > =

> > In QEMU, when PCI_COMMAND_MASTER is disabled we disable the
> > corresponding IOMMU memory region, so DMA accesses (including to vring
> > fields like idx/flags) will no longer undergo the necessary
> > translation. Normally we wouldn't expect this to happen since it would
> > be misbehavior on the driver side to continue driving DMA requests.
> > =

> > However, in the case of pseries, with iommu_platform=3Don, we trigger t=
he
> > following sequence when tearing down the virtio-blk dataplane ioeventfd
> > in response to the guest unsetting PCI_COMMAND_MASTER:
> > =

> >   #2  0x0000555555922651 in virtqueue_map_desc (vdev=3Dvdev@entry=3D0x5=
55556dbcfb0, p_num_sg=3Dp_num_sg@entry=3D0x7fffe657e1a8, addr=3Daddr@entry=
=3D0x7fffe657e240, iov=3Diov@entry=3D0x7fffe6580240, max_num_sg=3Dmax_num_s=
g@entry=3D1024, is_write=3Dis_write@entry=3Dfalse, pa=3D0, sz=3D0)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:757
> >   #3  0x0000555555922a89 in virtqueue_pop (vq=3Dvq@entry=3D0x555556dc86=
60, sz=3Dsz@entry=3D184)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:950
> >   #4  0x00005555558d3eca in virtio_blk_get_request (vq=3D0x555556dc8660=
, s=3D0x555556dbcfb0)
> >       at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:255
> >   #5  0x00005555558d3eca in virtio_blk_handle_vq (s=3D0x555556dbcfb0, v=
q=3D0x555556dc8660)
> >       at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:776
> >   #6  0x000055555591dd66 in virtio_queue_notify_aio_vq (vq=3Dvq@entry=
=3D0x555556dc8660)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1550
> >   #7  0x000055555591ecef in virtio_queue_notify_aio_vq (vq=3D0x555556dc=
8660)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1546
> >   #8  0x000055555591ecef in virtio_queue_host_notifier_aio_poll (opaque=
=3D0x555556dc86c8)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:2527
> >   #9  0x0000555555d02164 in run_poll_handlers_once (ctx=3Dctx@entry=3D0=
x55555688bfc0, timeout=3Dtimeout@entry=3D0x7fffe65844a8)
> >       at /home/mdroth/w/qemu.git/util/aio-posix.c:520
> >   #10 0x0000555555d02d1b in try_poll_mode (timeout=3D0x7fffe65844a8, ct=
x=3D0x55555688bfc0)
> >       at /home/mdroth/w/qemu.git/util/aio-posix.c:607
> >   #11 0x0000555555d02d1b in aio_poll (ctx=3Dctx@entry=3D0x55555688bfc0,=
 blocking=3Dblocking@entry=3Dtrue)
> >       at /home/mdroth/w/qemu.git/util/aio-posix.c:639
> >   #12 0x0000555555d0004d in aio_wait_bh_oneshot (ctx=3D0x55555688bfc0, =
cb=3Dcb@entry=3D0x5555558d5130 <virtio_blk_data_plane_stop_bh>, opaque=3Dop=
aque@entry=3D0x555556de86f0)
> >       at /home/mdroth/w/qemu.git/util/aio-wait.c:71
> >   #13 0x00005555558d59bf in virtio_blk_data_plane_stop (vdev=3D<optimiz=
ed out>)
> >       at /home/mdroth/w/qemu.git/hw/block/dataplane/virtio-blk.c:288
> >   #14 0x0000555555b906a1 in virtio_bus_stop_ioeventfd (bus=3Dbus@entry=
=3D0x555556dbcf38)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:245
> >   #15 0x0000555555b90dbb in virtio_bus_stop_ioeventfd (bus=3Dbus@entry=
=3D0x555556dbcf38)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:237
> >   #16 0x0000555555b92a8e in virtio_pci_stop_ioeventfd (proxy=3D0x555556=
db4e40)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:292
> >   #17 0x0000555555b92a8e in virtio_write_config (pci_dev=3D0x555556db4e=
40, address=3D<optimized out>, val=3D1048832, len=3D<optimized out>)
> >       at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:613
> > =

> > I.e. the calling code is only scheduling a one-shot BH for
> > virtio_blk_data_plane_stop_bh, but somehow we end up trying to process
> > an additional virtqueue entry before we get there. This is likely due
> > to the following check in virtio_queue_host_notifier_aio_poll:
> > =

> >   static bool virtio_queue_host_notifier_aio_poll(void *opaque)
> >   {
> >       EventNotifier *n =3D opaque;
> >       VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> >       bool progress;
> > =

> >       if (!vq->vring.desc || virtio_queue_empty(vq)) {
> >           return false;
> >       }
> > =

> >       progress =3D virtio_queue_notify_aio_vq(vq);
> > =

> > namely the call to virtio_queue_empty(). In this case, since no new
> > requests have actually been issued, shadow_avail_idx =3D=3D last_avail_=
idx,
> > so we actually try to access the vring via vring_avail_idx() to get
> > the latest non-shadowed idx:
> > =

> >   int virtio_queue_empty(VirtQueue *vq)
> >   {
> >       bool empty;
> >       ...
> > =

> >       if (vq->shadow_avail_idx !=3D vq->last_avail_idx) {
> >           return 0;
> >       }
> > =

> >       rcu_read_lock();
> >       empty =3D vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
> >       rcu_read_unlock();
> >       return empty;
> > =

> > but since the IOMMU region has been disabled we get a bogus value (0
> > usually), which causes virtio_queue_empty() to falsely report that
> > there are entries to be processed, which causes errors such as:
> > =

> >   "virtio: zero sized buffers are not allowed"
> > =

> > or
> > =

> >   "virtio-blk missing headers"
> > =

> > and puts the device in an error state.
> > =

> > This patch works around the issue by introducing virtio_set_disabled(),
> > which piggy-backs off the vdev->broken flag we already use to bypass
> > checks like virtio_queue_empty(), and sets/unsets it in response to
> > enabling/disabling bus-mastering.
> > =

> > NOTES:
> > =

> >  - It's possible we could also work around this in SLOF by doing a
> >    full reset instead of relying on PCI_COMMAND to enable/disable, but
> >    in any case the QEMU behavior seems wrong.
> >  - This leaves some other oddities in play, like the fact that
> >    DRIVER_OK also gets unset in response to bus-mastering being
> >    disabled, but not restored (however the device seems to continue
> >    working)
> >  - Similarly, we disable the host notifier via
> >    virtio_bus_stop_ioeventfd(), which seems to move the handling out
> >    of virtio-blk dataplane and back into the main IO thread, and it
> >    ends up staying there till a reset (but otherwise continues working
> >    normally)
> > =

> > Cc: David Gibson <david@gibson.dropbear.id.au>,
> > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  hw/virtio/virtio-pci.c     | 12 ++++++++----
> >  hw/virtio/virtio.c         |  7 ++++++-
> >  include/hw/virtio/virtio.h |  1 +
> >  3 files changed, 15 insertions(+), 5 deletions(-)
> > =

> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index c6b47a9c73..394d409fb9 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -608,10 +608,14 @@ static void virtio_write_config(PCIDevice *pci_de=
v, uint32_t address,
> >          pcie_cap_flr_write_config(pci_dev, address, val, len);
> >      }
> >  =

> > -    if (range_covers_byte(address, len, PCI_COMMAND) &&
> > -        !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> > -        virtio_pci_stop_ioeventfd(proxy);
> > -        virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIVER=
_OK);
> > +    if (range_covers_byte(address, len, PCI_COMMAND)) {
> > +        if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> > +            virtio_set_disabled(vdev, true);
> > +            virtio_pci_stop_ioeventfd(proxy);
> > +            virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DR=
IVER_OK);
> > +        } else {
> > +            virtio_set_disabled(vdev, false);
> > +        }
> >      }
> >  =

> >      if (proxy->config_cap &&
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 527df03bfd..46580c357d 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2575,6 +2575,11 @@ void virtio_device_set_child_bus_name(VirtIODevi=
ce *vdev, char *bus_name)
> >      vdev->bus_name =3D g_strdup(bus_name);
> >  }
> >  =

> > +void virtio_set_disabled(VirtIODevice *vdev, bool disable)
> > +{
> > +    vdev->broken =3D disable;
> > +}
> > +
> >  void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *f=
mt, ...)
> >  {
> >      va_list ap;
> =

> Hmm. I think just clear and immediate set of bus master while device was
> not doing any DMA actually should be fine and should not require a
> reset.  Now it's true that right now guests reset first thing which will
> clear the broken flag, but I'd say it's wrong to require this specific
> order.
> I think the easiest thing is to add a "disabled" flag.

Agreed. Some comments on that below.

> =

> =

> > @@ -2588,7 +2593,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice=
 *vdev, const char *fmt, ...)
> >          virtio_notify_config(vdev);
> >      }
> >  =

> > -    vdev->broken =3D true;
> > +    virtio_set_disabled(vdev, true);
> >  }
> >  =

> >  static void virtio_memory_listener_commit(MemoryListener *listener)
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 48e8d04ff6..921945b7e8 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -168,6 +168,7 @@ void virtio_init(VirtIODevice *vdev, const char *na=
me,
> >                           uint16_t device_id, size_t config_size);
> >  void virtio_cleanup(VirtIODevice *vdev);
> >  =

> > +void virtio_set_disabled(VirtIODevice *vdev, bool disable);
> >  void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_AT=
TR(2, 3);
> >  =

> >  /* Set the child bus name. */
> =

> =

> One open question here is cross version migration.
> What exactly happens if we migrate to an old qemu?
> from an old qemu?

Currently vdev->broken is already migrated via a subsection if it is set.

So, with the current proposed patch I would expect the following:

 old -> new:
   dev->broken set due to proposed virtio_set_disabled():
     - N/A
   dev->broken set due to other/existing reasons:
     - value is migrated, migration succeeds
     - device continues not working until a reset, or bus-mastering
       enabled/re-enabled. (which is good, but also makes me realize
       that a device that was put into broken state for reasons
       other than virtio_set_disabled() should not get 'unbroken'
       simply because bus-master bit was cycled. a separate flag
       is probably needed)
     - PASS
   dev->broken not set:
     - not migrated
     - PASS
 new -> old:
   dev->broken set due to proposed virtio_set_disabled():
     - migration succeeds to any QEMU that already has handling for
       dev->broken.
     - migration fails for any QEMU that doesn't have handling for
       dev->broken as it does now, but will a higher chance of
       triggering
     - device won't work until it is reset. for most guests we will
       probably get a reset before the device is used again anyway. for
       the SLOF case the device will stay broken after bus-mastering
       re-enabled, but that's the case for existing QEMU now anyway
     - PASS, but with increased chance of migration breakage for
       QEMU's that don't have handling for dev->broken.
   dev->broken set due to other/existing reasons:
     - migration succeeds to any QEMU that already has handling for
       dev->broken. device will require a reset as it does now.
     - migration fails for any QEMU that doesn't have handling for
       dev->broken as it does now
     - PASS
   dev->broken not set:
     - not migrated
     - PASS

With a new dev->disabled flag, which we'd likely send using a subsection
like with dev->broken, I would expect the following:

 old -> new:
   dev->disabled set:
     - N/A
   dev->disabled not set:
     - not migrated
     - if source disables BM just before migration we will likely go
       into an error state that either sets dev->broken or puts the
       device in some other possibly bad state. either case would require
       subsequent reset, just as they would without migration
     - PASS
 new -> old:
   dev->disabled set:
     - migration stream fails
     - FAIL, but as expected, and doesn't seem common currently outside
       of SLOF early-boot else we'd probably have more reports of
       breakage from vring access while BM isn't set.
   dev->broken not set:
     - not migrated
     - PASS

So re-using 'broken' is slightly better from a migration standpoint, but
as noted above it is probably wrong to unset 'broken' just because BM bit
gets cycled, so a new 'disabled' flag is probably needed.

We could probably get by with just adding a check for dev->disabled in =

virtio_queue_empty(), or even earlier in
virtio_queue_host_notifier_aio_poll(), but it seems more proper to also
add it in most of the same places we currently check for dev->broken.

That seems somewhat redundant though, so I think maybe the best approach
is to:

 - replace most dev->broken checks with checks for dev->disabled
 - set dev->disabled whenever dev->broken gets set
 - add a check in virtio_set_disabled() that only allows us to re-enable if
   dev->broken hasn't also been set.

I'll work on a follow-up using that approach if it seems reasonable to
you.

Thanks!

> =

> > -- =

> > 2.17.1
>=20

