Received: from eggs.gnu.org ([2001:4830:134:3::10]:42690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFni8-0001QO-2Z
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFni3-0006Uo-0m
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:30:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFni2-0006UP-Q4
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:30:14 -0400
Date: Mon, 7 May 2018 18:30:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507213011.GL13350@localhost.localdomain>
References: <20180419212727.26095-1-f4bug@amsat.org>
	<20180419212727.26095-4-f4bug@amsat.org>
	<b79057ab-d36e-21f9-236c-33c45051b273@amsat.org>
	<87bmee2vg0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87bmee2vg0.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qdev: Simplify the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Fri, Apr 20, 2018 at 09:22:55AM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
>=20
> > On 04/19/2018 06:27 PM, Philippe Mathieu-Daud=E9 wrote:
> >> The SysBusDevice is the last DeviceClass::init user.
> >>=20
> >> Instead of using
> >>   SysBusDeviceClass::realize
> >>    -> DeviceClass::realize
> >>        -> DeviceClass::init
> >>            -> sysbus_device_init
> >>               -> SysBusDeviceClass::init
> >>=20
> >> Simplify the path by directly calling SysBusDeviceClass::init
> >> in SysBusDeviceClass::realize:
> >>=20
> >>   SysBusDeviceClass::realize
> >>    -> SysBusDeviceClass::init
> >>=20
> >> Finally, remove the DeviceClass::init, there are no more users.
> >>=20
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> ---
> >>  include/hw/qdev-core.h |  2 --
> >>  hw/core/qdev.c         | 14 --------------
> >>  hw/core/sysbus.c       | 15 ++++++++++-----
> >>  3 files changed, 10 insertions(+), 21 deletions(-)
> >>=20
> >> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> >> index 9453588160..6f60748043 100644
> >> --- a/include/hw/qdev-core.h
> >> +++ b/include/hw/qdev-core.h
> >> @@ -29,7 +29,6 @@ typedef enum DeviceCategory {
> >>      DEVICE_CATEGORY_MAX
> >>  } DeviceCategory;
> >> =20
> >> -typedef int (*qdev_initfn)(DeviceState *dev);
> >>  typedef int (*qdev_event)(DeviceState *dev);
> >>  typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
> >>  typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
> >> @@ -124,7 +123,6 @@ typedef struct DeviceClass {
> >>      const struct VMStateDescription *vmsd;
> >> =20
> >>      /* Private to qdev / bus.  */
> >> -    qdev_initfn init; /* TODO remove, once users are converted to r=
ealize */
> >
> > The DeviceClass documentation (top of this file) is now out of date :=
(
> >
> > If the maintainer taking this series prefer a respin, I plan to only
> > remove the 'init' references in the big comment.
>=20
> I'd move the actual removal into the next and final patch.  Lets us fix
> up the comment in one go.

I'd prefer a respin, so we can ensure the documentation is
updated and the removal of DeviceClass::init and
DeviceClass::exit are done in the same patch.

(Sorry for taking so long to reply.)

--=20
Eduardo
