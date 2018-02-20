Received: from eggs.gnu.org ([2001:4830:134:3::10]:41594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eo7tV-0006f7-QQ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eo7tS-0004Gx-I2
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:23:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eo7tS-0004GV-BQ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:23:38 -0500
Date: Tue, 20 Feb 2018 14:23:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180220142319.2c959f83@redhat.com>
In-Reply-To: <2d4874be-fec4-39bb-9df5-bb53f17d1d74@redhat.com>
References: <20180216134516.6269-1-peter.maydell@linaro.org>
	<20180216134516.6269-2-peter.maydell@linaro.org>
	<20180216172841.2ec69b8a@redhat.com>
	<98a92185-d5e0-48fd-79a7-1c77260c9aca@amsat.org>
	<2d4874be-fec4-39bb-9df5-bb53f17d1d74@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On Tue, 20 Feb 2018 13:13:49 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 16/02/2018 18:40, Philippe Mathieu-Daud=C3=A9 wrote:
> > we can keep object_initialize() when no parent,
> > and add object_initialize_child(, const char *childname, Object *parent)
> > 'parent' last because all previous args are child-related.
> >  =20
> >> =20
> >>> +    qdev_set_parent_bus(DEVICE(child), sysbus_get_default()); =20
> >> and then assuming we don't create sysbus devices, nor should be able t=
o,
> >> which are not attached to sysbus_get_default() this one can go sysbus'=
 instance_init() =20
> > good idea.
> >  =20
[...]

> I'm not sure about moving qdev_set_parent_bus to instance_init().  It
> would be a bit different from other buses and possibly confusing.
That's what this series sort of does, i.e. creating a type/class
specific helper(s). Which becomes confusing as number of helpers
increases (frankly it's just 2 different approaches to code i.e.
functional vs OOM).

It could be better to keep single QOM API and let SYSBUS base class
instance_init() to do all implicit initialization that must be done
for inherited classes.
Yes, it will be different from other devices with buses but
users won't really care (there is no other buss to assign to),
for them it will look like a typical bus-less device and it
would be less error-prone to code.

=20
> Potentially there could be a "hierarchy" of *_initialize_child
> functions, adding or removing arguments as needed for the specific kind
> of bus:
>=20
> 	/* adds qdev_set_parent_bus */
> 	device_initialize_child(Object *parent, const char *childname,
> 				BusState *bus, void *data, size_t size,
> 				const char *typename);
> 	/* uses sysbus_get_default() */
> 	sysbus_initialize_child(Object *parent, const char *childname,
> 				void *data, size_t size,
> 				const char *typename);


> 	/* initializes "addr" property too */
> 	pci_initialize_child(Object *parent, const char *childname,
> 			     BusState *bus, int addr,
> 			     void *data, size_t size,
> 			     const char *typename);
PCI could also incorporate PCI specific bus setting/
verification logic inside of base class.

It could allow us to drop bus assigning magic in qdev_device_add(),
bringing it closer to simple QOM object handling, with specifics
abstracted by respective TYPE implementations.
Maybe we would be able to unify -device with -object in the end.


> Thanks,
>=20
> Paolo
> qdev_device_add
