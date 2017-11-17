Received: from eggs.gnu.org ([2001:4830:134:3::10]:36826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eFjdZ-0000DC-PN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eFjdU-0001uh-Oz
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:37:05 -0500
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:35002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eFjdU-0001t4-Ed
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:37:00 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C3B3E120609
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 17:36:57 +0100 (CET)
Date: Fri, 17 Nov 2017 17:36:43 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171117173643.59814f7a@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <48df4371-5966-a428-f5df-37c014c1ab94@linux.vnet.ibm.com>
References: <151092340873.11818.16813698420232981002.stgit@bahia>
	<48df4371-5966-a428-f5df-37c014c1ab94@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.11] spapr: reset DRCs
 after devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 17 Nov 2017 14:21:27 -0200
Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:

> On 11/17/2017 10:56 AM, Greg Kurz wrote:
> > A DRC with a pending unplug request releases its associated device at
> > machine reset time.
> >
> > In the case of LMB, when all DRCs for a DIMM device have been reset,
> > the DIMM gets unplugged, causing guest memory to disappear. This may
> > be very confusing for anything still using this memory.
> >
> > This is exactly what happens with vhost backends, and QEMU aborts
> > with:
> >
> > qemu-system-ppc64: used ring relocated for ring 2
> > qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assertion
> >   `r >= 0' failed.
> >
> > The issue is that each DRC registers a QEMU reset handler, and we
> > don't control the order in which these handlers are called (ie,
> > a LMB DRC will unplug a DIMM before the virtio device using the
> > memory on this DIMM could stop its vhost backend).
> >
> > To avoid such situations, let's reset DRCs after all devices
> > have been reset.
> >
> > Reported-by: Mallesh N. Koti <mallesh@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---  
> I believe this has to do with the problem discussed at the memory
> unplug reboot with vhost=on, right?
> 
> I don't see any problem with this patch and it's probably the best solution
> short-term for the problem (and potentially other related LMB release
> problems), but that said, how hard it is to forbid LMB unplug at all if the
> memory is being used in vhost?
> 

I don't know yet but I'll dig some more.

> The way I see it, the root problem is that a device unplug failed at the 
> guest
> side and we don't know about it, leaving drc->unplug_requested flags set
> around the code when it shouldn't. Reading that thread I see a comment from
> Michael S. Tsirkin saying that this bug is somewhat expected, that vhost 
> backend will
> not behave well if memory is going away. Unlike other LMB unplug 
> failures from
> the guest side that might happen for any other reason, this one sees 
> predicable
> and we can avoid it.
> 
> I think this is something worth considering. But for now,
> 
> 
> Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> 

Thanks!

> >   hw/ppc/spapr.c     |   21 +++++++++++++++++++++
> >   hw/ppc/spapr_drc.c |    7 -------
> >   2 files changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 6841bd294b3c..6285f7211f9a 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1411,6 +1411,19 @@ static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
> >       }
> >   }
> >
> > +static int spapr_reset_drcs(Object *child, void *opaque)
> > +{
> > +    sPAPRDRConnector *drc =
> > +        (sPAPRDRConnector *) object_dynamic_cast(child,
> > +                                                 TYPE_SPAPR_DR_CONNECTOR);
> > +
> > +    if (drc) {
> > +        spapr_drc_reset(drc);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >   static void ppc_spapr_reset(void)
> >   {
> >       MachineState *machine = MACHINE(qdev_get_machine());
> > @@ -1434,6 +1447,14 @@ static void ppc_spapr_reset(void)
> >       }
> >
> >       qemu_devices_reset();
> > +
> > +    /* DRC reset may cause a device to be unplugged. This will cause troubles
> > +     * if this device is used by another device (eg, a running vhost backend
> > +     * will crash QEMU if the DIMM holding the vring goes away). To avoid such
> > +     * situations, we reset DRCs after all devices have been reset.
> > +     */
> > +    object_child_foreach_recursive(object_get_root(), spapr_reset_drcs, NULL);
> > +
> >       spapr_clear_pending_events(spapr);
> >
> >       /*
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index 915e9b51c40c..e3b122968e89 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -455,11 +455,6 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
> >       }
> >   }
> >
> > -static void drc_reset(void *opaque)
> > -{
> > -    spapr_drc_reset(SPAPR_DR_CONNECTOR(opaque));
> > -}
> > -
> >   bool spapr_drc_needed(void *opaque)
> >   {
> >       sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
> > @@ -518,7 +513,6 @@ static void realize(DeviceState *d, Error **errp)
> >       }
> >       vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_drc,
> >                        drc);
> > -    qemu_register_reset(drc_reset, drc);
> >       trace_spapr_drc_realize_complete(spapr_drc_index(drc));
> >   }
> >
> > @@ -529,7 +523,6 @@ static void unrealize(DeviceState *d, Error **errp)
> >       gchar *name;
> >
> >       trace_spapr_drc_unrealize(spapr_drc_index(drc));
> > -    qemu_unregister_reset(drc_reset, drc);
> >       vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
> >       root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
> >       name = g_strdup_printf("%x", spapr_drc_index(drc));
> >
> >  
> 
