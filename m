Received: from eggs.gnu.org ([2001:4830:134:3::10]:41423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f0RRB-0002ij-CX
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f0RR5-0005qb-Io
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:41:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f0RR5-0005p8-BY
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:41:15 -0400
Date: Mon, 26 Mar 2018 14:41:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180326144102.00c5f3a0@redhat.com>
In-Reply-To: <fadf8f9f-acd1-6a47-086d-01590400104e@amsat.org>
References: <20180216134516.6269-1-peter.maydell@linaro.org>
	<20180216134516.6269-2-peter.maydell@linaro.org>
	<20180216172841.2ec69b8a@redhat.com>
	<98a92185-d5e0-48fd-79a7-1c77260c9aca@amsat.org>
	<2d4874be-fec4-39bb-9df5-bb53f17d1d74@redhat.com>
	<20180220142319.2c959f83@redhat.com>
	<fadf8f9f-acd1-6a47-086d-01590400104e@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/sysbus.h: New sysbus_init_child()
 helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On Sat, 24 Mar 2018 12:35:22 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi,
>=20
> On 02/20/2018 10:23 AM, Igor Mammedov wrote:
> > On Tue, 20 Feb 2018 13:13:49 +0100
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >  =20
> >> On 16/02/2018 18:40, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> we can keep object_initialize() when no parent,
> >>> and add object_initialize_child(, const char *childname, Object *pare=
nt)
> >>> 'parent' last because all previous args are child-related.
> >>>    =20
> >>>>   =20
> >>>>> +    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());   =20
> >>>> and then assuming we don't create sysbus devices, nor should be able=
 to,
> >>>> which are not attached to sysbus_get_default() this one can go sysbu=
s' instance_init()   =20
> >>> good idea.
> >>>    =20
> > [...]
> >  =20
> >> I'm not sure about moving qdev_set_parent_bus to instance_init().  It
> >> would be a bit different from other buses and possibly confusing. =20
> > That's what this series sort of does, i.e. creating a type/class
> > specific helper(s). Which becomes confusing as number of helpers
> > increases (frankly it's just 2 different approaches to code i.e.
> > functional vs OOM).
> >=20
> > It could be better to keep single QOM API and let SYSBUS base class
> > instance_init() to do all implicit initialization that must be done
> > for inherited classes. =20
>=20
> What is the consensus on this series once 2.12 gets released?
At least we should add and make current code use it
  object_initialize_child()
It should save quite a bit of code in ARM target

As for
  qdev_set_parent_bus(DEVICE, sysbus_get_default())
it is a separate issue, but I'd still go with
TYPE_SYS_BUS_DEVICE setting bus in its instance_init so that
inherited types nor their users would have to deal with it.

> > Yes, it will be different from other devices with buses but
> > users won't really care (there is no other buss to assign to),
> > for them it will look like a typical bus-less device and it
> > would be less error-prone to code.
> >=20
> >   =20
> >> Potentially there could be a "hierarchy" of *_initialize_child
> >> functions, adding or removing arguments as needed for the specific kind
> >> of bus:
> >>
> >> 	/* adds qdev_set_parent_bus */
> >> 	device_initialize_child(Object *parent, const char *childname,
> >> 				BusState *bus, void *data, size_t size,
> >> 				const char *typename);
> >> 	/* uses sysbus_get_default() */
> >> 	sysbus_initialize_child(Object *parent, const char *childname,
> >> 				void *data, size_t size,
> >> 				const char *typename); =20
> >=20
> >  =20
> >> 	/* initializes "addr" property too */
> >> 	pci_initialize_child(Object *parent, const char *childname,
> >> 			     BusState *bus, int addr,
> >> 			     void *data, size_t size,
> >> 			     const char *typename); =20
> > PCI could also incorporate PCI specific bus setting/
> > verification logic inside of base class.
> >=20
> > It could allow us to drop bus assigning magic in qdev_device_add(),
> > bringing it closer to simple QOM object handling, with specifics
> > abstracted by respective TYPE implementations.
> > Maybe we would be able to unify -device with -object in the end. =20
>=20
> Thanks,
>=20
> Phil.
