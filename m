Received: from eggs.gnu.org ([2001:4830:134:3::10]:48178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgWbC-0006WL-LL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgWb8-0007rs-Cl
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:04:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgWb8-0007rc-6e
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:04:46 -0500
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-24-marcandre.lureau@redhat.com>
	<967ff11e-ed7c-85b9-2c67-b3fb5335769e@redhat.com>
	<CAJ+F1CLBs4tGRf2V3rvu7pYrW7h7jbHPBYkr26PPcDxYeF8T8w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34ad1672-392a-02ec-4aa0-55efba58aea0@redhat.com>
Date: Wed, 22 Feb 2017 14:04:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLBs4tGRf2V3rvu7pYrW7h7jbHPBYkr26PPcDxYeF8T8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 23/30] bus: do not unref hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org



On 22/02/2017 14:03, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Feb 22, 2017 at 3:39 PM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>=20
>=20
>     On 21/02/2017 15:14, Marc-Andr=C3=A9 Lureau wrote:
>     > Apparently, none of the bus owner give a reference to the hotplug
>     > handler property, do not unref it on bus release.
>     >
>     > Furthermore, a bus is allowed to be its own hotplug handler, whic=
h can
>     > be seen in qbus_set_bus_hotplug_handler() function. However, in t=
his
>     > case, the reference can't be given to the property, or this will
>     create
>     > a cyclic dependency and the bus will never be free.
>     >
>     > Each bus owner should manage the lifecycle of the hotplug handler=
.
>     >
>     > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m
>     <mailto:marcandre.lureau@redhat.com>>
>=20
>     Almost all qbus_set_hotplug_handler callers are using it to set the
>     parent device (that is, the "adapter" or "bridge", whatever you wan=
t to
>     call it) as the hotplug handler.
>=20
>     The exception is piix4_update_bus_hotplug.  This one is the only ca=
se
>     where OBJ_PROP_LINK_UNREF_ON_RELEASE would be right.  Luckily, ther=
e
>     _is_ a reference to that device somewhere else to keep it alive, na=
mely
>     in /machine's acpi-device prop.  So this case is a bit hacky (not y=
our
>     fault) but works as well.  In addition the PIIX4_PM device is not
>     hot(un)pluggable.
>=20
> I understand you agree with my change, correct?

Yes.

>     Can you please add a comment to piix4_update_bus_hotplug explaining=
 that
>     the PIIX4PMState cannot outlive the PCIBus, because /machine keeps
>     it alive?
>=20
>=20
>  Do you mean PCIBus cannot outlive PIIX4PMState? (ie the PIIX4PMState
> will always be there since it's linked from /machine)

Yes (or just because it's not unpluggable).

Paolo
