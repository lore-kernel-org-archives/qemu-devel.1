Received: from eggs.gnu.org ([2001:4830:134:3::10]:57571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUaIF-0002Nr-BB
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUaIC-0004gz-8M
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:44:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gUaIB-0004ae-TJ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:44:56 -0500
Date: Wed, 5 Dec 2018 09:44:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181205094421.26f66aee@x1.home>
In-Reply-To: <87d0qgrrd0.fsf@dusky.pond.sub.org>
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394077749.28192.1229512133780284321.stgit@gimli.home>
	<83c490a2-7565-b95c-563f-fb73476e874f@redhat.com>
	<87d0qgrrd0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 3/9] qapi: Define PCIe link
 speed and width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>

On Wed, 05 Dec 2018 15:16:27 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Auger Eric <eric.auger@redhat.com> writes:
>=20
> > Hi Alex,
> >
> > On 12/4/18 5:26 PM, Alex Williamson wrote: =20
> >> Create properties to be able to define speeds and widths for PCIe
> >> links.  The only tricky bit here is that our get and set callbacks
> >> translate from the fixed QAPI automagic enums to those we define
> >> in PCI code to represent the actual register segment value.
> >>=20
> >> Cc: Eric Blake <eblake@redhat.com>
> >> Cc: Markus Armbruster <armbru@redhat.com>
> >> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>  hw/core/qdev-properties.c    |  178 +++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/hw/qdev-properties.h |    8 ++
> >>  qapi/common.json             |   42 ++++++++++
> >>  3 files changed, 228 insertions(+)
> >>=20
> >> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> >> index 35072dec1ecf..f5ca5b821a79 100644
> >> --- a/hw/core/qdev-properties.c
> >> +++ b/hw/core/qdev-properties.c
> >> @@ -1327,3 +1327,181 @@ const PropertyInfo qdev_prop_off_auto_pcibar =
=3D {
> >>      .set =3D set_enum,
> >>      .set_default_value =3D set_default_value_enum,
> >>  };
> >> +
> >> +/* --- PCIELinkSpeed 2_5/5/8/16 -- */
> >> +
> >> +static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const cha=
r *name,
> >> +                                   void *opaque, Error **errp)
> >> +{
> >> +    DeviceState *dev =3D DEVICE(obj);
> >> +    Property *prop =3D opaque;
> >> +    PCIExpLinkSpeed *p =3D qdev_get_prop_ptr(dev, prop);
> >> +    PCIELinkSpeed speed;
> >> +
> >> +    switch (*p) {
> >> +    case QEMU_PCI_EXP_LNK_2_5GT:
> >> +        speed =3D PCIE_LINK_SPEED_2_5;
> >> +        break;
> >> +    case QEMU_PCI_EXP_LNK_5GT:
> >> +        speed =3D PCIE_LINK_SPEED_5;
> >> +        break;
> >> +    case QEMU_PCI_EXP_LNK_8GT:
> >> +        speed =3D PCIE_LINK_SPEED_8;
> >> +        break;
> >> +    case QEMU_PCI_EXP_LNK_16GT:
> >> +        speed =3D PCIE_LINK_SPEED_16;
> >> +        break;
> >> +    default:
> >> +        /* Unreachable */
> >> +        abort(); =20
> > nit: g_assert_not_reached() here and below. =20
>=20
> In my opinion, g_assert_not_reached() & friends are an overly ornate
> reinvention of an old and perfectly adequate wheel.
>=20
> A long time ago for reasons since forgotten, the maintainers in charge
> back then demanded abort() instead of assert(0).  Either is fine with
> me.
>=20
> I tolerate g_assert_not_reached() in files that already use g_assert().
> This one doesn't.
>=20
> In any case, I'd drop the comment.

I added the comment because as a casual QAPI contributor it's otherwise
not obvious that bogus user input can't reach that case.  Comments are
free.
=20
> Note that I'm not this file's maintainer.

get_maintainer.pl says there is no maintainer here and references:

"Michael S. Tsirkin" <mst@redhat.com> (commit_signer:3/4=3D75%)
"Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com> (commit_signer:2/4=
=3D50%)
Markus Armbruster <armbru@redhat.com> (commit_signer:1/4=3D25%)
"Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (commit_signer:1/4=3D25%)
Paolo Bonzini <pbonzini@redhat.com> (commit_signer:1/4=3D25%)

CC'ing those folks.  Unless anyone expresses a strong opinion or trend
towards using g_assert_not_reached(), I'll stick with Markus' style to
only use it in files where g_assert() is already present... or at least
claim that's why I didn't use it ;)  Thanks,

Alex
