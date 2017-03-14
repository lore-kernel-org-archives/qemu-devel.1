Received: from eggs.gnu.org ([2001:4830:134:3::10]:42897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqji-0005ah-C9
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqjd-0000S9-Re
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnqjd-0000RQ-IT
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:59:49 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-18-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c90b20a4-8180-4f73-6a99-bf71e124ea77@redhat.com>
Date: Tue, 14 Mar 2017 12:59:45 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-18-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WCUnxlkx6TANBcn4cm4CHtARjfAQHi496"
Subject: Re: [Qemu-devel] [PATCH for-2.9 17/47] qapi: The #optional tag is
 redundant, drop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WCUnxlkx6TANBcn4cm4CHtARjfAQHi496
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <c90b20a4-8180-4f73-6a99-bf71e124ea77@redhat.com>
Subject: Re: [PATCH for-2.9 17/47] qapi: The #optional tag is redundant, drop
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-18-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> We traditionally mark optional members #optional in the doc comment.
> Before commit 3313b61, this was entirely manual.
>=20
> Commit 3313b61 added some automation because its qapi2texi.py relied
> on #optional to determine whether a member is optional.  This is no
> longer the case since the previous commit: the only thing qapi2texi.py
> still does with #optional is stripping it out.  We still reject bogus
> qapi-schema.json and six places for qga/qapi-schema.json.
>=20
> Thus, you can't actually rely on #optional to see whether something is
> optional.  Yet we still make people add it manually.  That's just
> busy-work.

Yay! Let the computer do the work for us!

>=20
> Drop the code to check, fix up and strip out #optional, along with all
> instances of #optional.  To keep it out, add code to reject it, to be
> dropped again once the dust settles.
>=20
> No change to generated documentation.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> @@ -150,10 +148,10 @@ For example:
>  #
>  # Statistics of a virtual block device or a block backing device.
>  #
> -# @device: #optional If the stats are for a virtual block device, the =
name
> -#          corresponding to the virtual block device.
> +# @device: If the stats are for a virtual block device, the name
> +# corresponding to the virtual block device.

This loses the hanging indentation in the example, but I don't see you
making that change in the actual .json files.  It shouldn't matter in
the long run, and is certainly easier if the way you generated this
patch was with sed scripts (where computing correct hanging indentation
after rewrapping is a lot harder than omitting it).  I don't have any
strong opinions about the change (less typing, but slightly harder to
visually see that the following lines belong to the same parameter doc,
if you don't have blank lines between distinct parameter docs).  I'm not
even sure if it you want to call it out in the commit message as an
intentional reformat, particularly since you didn't do it everywhere.

> +++ b/qapi-schema.json
> @@ -150,10 +150,10 @@
>  #
>  # @fdname: file descriptor name previously passed via 'getfd' command
>  #
> -# @skipauth: #optional whether to skip authentication. Only applies
> +# @skipauth: whether to skip authentication. Only applies
>  #            to "vnc" and "spice" protocols
>  #
> -# @tls: #optional whether to perform TLS. Only applies to the "spice"
> +# @tls: whether to perform TLS. Only applies to the "spice"
>  #       protocol

Again, whitespace changes shouldn't affect generated output, so
rewrapping lines like this would be more busy-work than necessary, even
though this particular example would now fit on one line.

> @@ -667,45 +667,45 @@
>  #
=2E..
>  #
> -# @setup-time: #optional amount of setup time in milliseconds _before_=
 the
> +# @setup-time: amount of setup time in milliseconds _before_ the
>  #        iterations begin but _after_ the QMP command is issued. This =
is designed
>  #        to provide an accounting of any activities (such as RDMA pinn=
ing) which
>  #        may be expensive, but do not actually occur during the iterat=
ive
>  #        migration rounds themselves. (since 1.6)

Here's another place where wrapping now looks odd (short, followed by
multiple longer lines).  Again, the effort of rewrapping lines is not
worth the churn (and it's actually easier to read diffs that _don't_
reflow text).  So I'll just overlook wrapping oddities in the rest of
the patch, as inconsequential to the end result.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WCUnxlkx6TANBcn4cm4CHtARjfAQHi496
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyC+RAAoJEKeha0olJ0NqtcgH/j+MAkWaSKb853R4LwVfH8tl
wk40dyZ/XZvMoYMZ3bWOqT0Vwtknc7xetcFCMNHkdc57SABQV6EgPdEYkbCmVeg/
ndpuIQOYLdL70e9dc+NVAlLLZ+z39xhShvkagE2SxpR61G05/gqUdqrJ3HE8N83W
HhEVfC/zPJmf/RWe39422KybgG9XPaTZ+YuXcblRcAbODUIozFKq6LcfhA2wM/km
//jHSE0lk0pJlvquLIne8nYXDwIcshSwOMw8cAug+PrUAZ56lpwGxYMbWWWrWpcA
5V3I3jiRIfCG7YluGINNYXqchqheKKRpj5PkDQIi/l536y8nGirqw1cMOrlGRwM=
=2XnE
-----END PGP SIGNATURE-----

--WCUnxlkx6TANBcn4cm4CHtARjfAQHi496--
