Received: from eggs.gnu.org ([2001:4830:134:3::10]:53774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e0ctj-0001ih-6V
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e0ctf-0002rm-W1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:23:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41788
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e0ctf-0002rY-Ps
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:23:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v970JDN6145541
	for <qemu-devel@nongnu.org>; Fri, 6 Oct 2017 20:23:11 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2deex8m23q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 20:23:10 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 6 Oct 2017 18:23:09 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <e916c286-8e4b-32b7-41f2-8114db651a82@redhat.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1501119055-4060-4-git-send-email-mdroth@linux.vnet.ibm.com>
	<e916c286-8e4b-32b7-41f2-8114db651a82@redhat.com>
Date: Fri, 06 Oct 2017 19:03:57 -0500
Message-Id: <150733463701.11829.11130703335826126909@sif>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] qdev: defer DEVICE_DEL event
 until instance_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

Quoting Auger Eric (2017-08-09 09:04:54)
> Hi Michael,
> =

> On 27/07/2017 03:30, Michael Roth wrote:
> > DEVICE_DEL is currently emitted when a Device is unparented, as
> > opposed to when it is finalized. The main design motivation for this
> > seems to be that after unparent()/unrealize(), the Device is no
> > longer visible to the guest, and thus the operation is complete
> > from the perspective of management.
> > =

> > However, there are cases where remaining host-side cleanup is also
> > pertinent to management. The is generally handled by treating these
> > resources as aspects of the "backend", which can be managed via
> > separate interfaces/events, such as blockdev_add/del, netdev_add/del,
> > object_add/del, etc, but some devices do not have this level of
> > compartmentalization, namely vfio-pci, and possibly to lend themselves
> > well to it.
> > =

> > In the case of vfio-pci, the "backend" cleanup happens as part of
> > the finalization of the vfio-pci device itself, in particular the
> > cleanup of the VFIO group FD. Failing to wait for this cleanup can
> > result in tools like libvirt attempting to rebind the device to
> > the host while it's still being used by VFIO, which can result in
> > host crashes or other misbehavior depending on the host driver.
> > =

> > Deferring DEVICE_DEL still affords us the ability to manage backends
> > explicitly, while also addressing cases like vfio-pci's, so we
> > implement that approach here.
> > =

> > An alternative proposal involving having VFIO emit a separate event
> > to denote completion of host-side cleanup was discussed, but the
> > prevailing opinion seems to be that it is not worth the added
> > complexity, and leaves the issue open for other Device implementations
> > solve in the future.
> > =

> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  hw/core/qdev.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> > =

> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 08c4061..d14acba 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -1067,7 +1067,6 @@ static void device_finalize(Object *obj)
> >      NamedGPIOList *ngl, *next;
> >  =

> >      DeviceState *dev =3D DEVICE(obj);
> > -    qemu_opts_del(dev->opts);
> >  =

> >      QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
> >          QLIST_REMOVE(ngl, node);
> > @@ -1078,6 +1077,18 @@ static void device_finalize(Object *obj)
> >           * here
> >           */
> >      }
> > +
> > +    /* Only send event if the device had been completely realized */
> > +    if (dev->pending_deleted_event) {
> > +        g_assert(dev->canonical_path);
> > +
> > +        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canoni=
cal_path,
> > +                                       &error_abort);
> > +        g_free(dev->canonical_path);
> > +        dev->canonical_path =3D NULL;
> > +    }
> > +
> > +    qemu_opts_del(dev->opts);
> >  }
> >  =

> >  static void device_class_base_init(ObjectClass *class, void *data)
> > @@ -1107,16 +1118,6 @@ static void device_unparent(Object *obj)
> >          object_unref(OBJECT(dev->parent_bus));
> >          dev->parent_bus =3D NULL;
> >      }
> > -
> > -    /* Only send event if the device had been completely realized */
> > -    if (dev->pending_deleted_event) {
> > -        g_assert(dev->canonical_path);
> > -
> > -        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canoni=
cal_path,
> > -                                       &error_abort);
> > -        g_free(dev->canonical_path);
> > -        dev->canonical_path =3D NULL;
> > -    }
> is the code below, introduced in patch 1/device_set_realized() still
> relevant?
>         /* always re-initialize since we clean up in device_unparent()
> instead
>          * of unrealize()
>          */
>         g_free(dev->canonical_path);

Hi Eric,

Sorry for missing your reply previously. That comment does indeed need
some adjusting after patch 3. Will fix it up for v2.

> =

> Thanks
> =

> Eric
> >  }
> >  =

> >  static void device_class_init(ObjectClass *class, void *data)
> > =

>=20
