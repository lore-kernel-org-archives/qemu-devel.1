Received: from eggs.gnu.org ([2001:4830:134:3::10]:52554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7b7r-0007uy-Va
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 02:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7b7r-0000rP-1G
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 02:59:15 -0400
Date: Wed, 3 Oct 2018 16:29:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181003062949.GZ1886@umbus.fritz.box>
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YG0IFkGWIt6MbjRk"
Content-Disposition: inline
In-Reply-To: <20180926094219.20322-19-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 18/24] qdev: hotplug: provide do_unplug
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--YG0IFkGWIt6MbjRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 26, 2018 at 11:42:13AM +0200, David Hildenbrand wrote:
> The unplug and unplug_request handlers are special: They are not
> executed when unrealizing a device, but rather trigger the removal of a
> device from device_del() via object_unparent() - to effectively
> unrealize a device.
>=20
> If such a device has a child bus and another device attached to
> that bus (e.g. how virtio devices are created with their proxy device),
> we will not get a call to the unplug handler. As we want to support
> hotplug handlers (and especially also some unplug logic to undo resource
> assignment) for such devices, we cannot simply call the unplug handler
> when unrealizing - it has a different semantic ("trigger removal").
>=20
> To handle this scenario, we need a do_unplug handler, that will be
> executed for all devices with a hotplug handler.
>=20
> While at it, introduce hotplug_fn_nofail and fix a spelling mistake in
> a comment.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/core/hotplug.c    | 10 ++++++++++
>  hw/core/qdev.c       |  6 ++++++
>  include/hw/hotplug.h | 26 ++++++++++++++++++++++++--
>  3 files changed, 40 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
> index 2253072d0e..e7a68d5160 100644
> --- a/hw/core/hotplug.c
> +++ b/hw/core/hotplug.c
> @@ -45,6 +45,16 @@ void hotplug_handler_post_plug(HotplugHandler *plug_ha=
ndler,
>      }
>  }
> =20
> +void hotplug_handler_do_unplug(HotplugHandler *plug_handler,
> +                                 DeviceState *plugged_dev)

Hrm.  I really dislike things named "do_X".  The "do" rarely adds any
useful meaning.  And when there's also something called just plain
"X", it's *always* unclear how they relate to each other.

That's doubly true when it's a general interface like this, rather
than just some local functions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YG0IFkGWIt6MbjRk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0YdwACgkQbDjKyiDZ
s5Lx6Q//fg4PQ2r85/wafUdlxkDN3K2H4p0fsEA/ZtgFDqx268c8s7SfWXAINlhQ
l30nbNwuijnlrB66OIXZ+mD0pzraAnGdRe8C/q6gWXvBQXQLUT2WEz6nW4HxJTZD
3Os5R0PiIcmO8GxbeeJM2mE/x5zzRjtDFPvqi2UySe5bXINtfSu4NOkDoirSvE/Q
2FNf0NGPlnwpiX4Z3Pd1l3iiZNLjM5WAnlrrfTqO7Uet4ut+hX1Casqn2R3sihtG
dDqOzsBqyw/e5VQri6tPIMGA1wNdNFbOm1Fd9WHE7w0CKss5D91WOXoGtbeTDwCe
nQHXfPItsFzSMF80K3eaevjHAG3v2ZQsF71QVW3s7Mfioegta5AvrhhLvbbzqc1z
QC2BbEiSrxNqSZYVfA7a3aQ5hsHhOoi0VrNY1OniK8yCsZArXcrd2PUezLJGQ7Zp
2j0oM39G9sIof91/8bI9PEBwXWmWMqaVhuX3LIT8+a+Tj53AMAIVtk8hb9wFdwgq
78jdJlCciIGTTEhtuZroC7o0aR75ob2aBAKf+mMYv9aBDj/2iyq29unRR5sQRTOU
KRsitigseegtM4ai6s4uG0io6RAIzF7I0neXLDRNP3R2YXp20Nu0Udue05dal3zi
LIdDDDrbLF8OKqyP9t806bF8wDXo2K4/+iWYlIJ6moKDfHe6QaQ=
=Sphh
-----END PGP SIGNATURE-----

--YG0IFkGWIt6MbjRk--
