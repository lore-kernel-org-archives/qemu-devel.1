Received: from eggs.gnu.org ([2001:4830:134:3::10]:41804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpKa8-0005QX-7a
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpKa3-0000hK-DK
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpKa3-0000gU-3h
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:36:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C1596E797
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 20:36:17 +0000 (UTC)
References: <f9d56290959d378dfa65b3906bf0d822ab938ac9.1504617551.git.mprivozn@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0659c96-31c6-d193-19bb-438fe6aa2601@redhat.com>
Date: Tue, 5 Sep 2017 15:36:15 -0500
MIME-Version: 1.0
In-Reply-To: <f9d56290959d378dfa65b3906bf0d822ab938ac9.1504617551.git.mprivozn@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4J347B0f9BMThNgmWl7nPoIQa5PKde8Ti"
Subject: Re: [Qemu-devel] [PATCH v2] watchdog: Allow setting action on the
 fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4J347B0f9BMThNgmWl7nPoIQa5PKde8Ti
From: Eric Blake <eblake@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <a0659c96-31c6-d193-19bb-438fe6aa2601@redhat.com>
Subject: Re: [PATCH v2] watchdog: Allow setting action on the fly
References: <f9d56290959d378dfa65b3906bf0d822ab938ac9.1504617551.git.mprivozn@redhat.com>
In-Reply-To: <f9d56290959d378dfa65b3906bf0d822ab938ac9.1504617551.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 08:22 AM, Michal Privoznik wrote:
> Currently, the only time that users can set watchdog action is at
> the start as all we expose is this -watchdog-action command line
> argument. This is suboptimal when users want to plug the device
> later via monitor. Alternatively, they might want to change the
> action for already existing device on the fly.
>=20
> At the same time, drop local redefinition of the actions eum in

s/eum/enum/

> watchdog.h in favour of the ones defined in schema.
>=20
> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=3D1447169
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---

> @@ -77,27 +80,17 @@ int select_watchdog(const char *p)
> =20
>  int select_watchdog_action(const char *p)
>  {

> +    int action;
> =20
> +    action =3D qapi_enum_parse(WatchdogExpirationAction_lookup, p,
> +                             WATCHDOG_EXPIRATION_ACTION__MAX, -1, NULL=
);

Semantic conflict; you need to rebase now that the qapi enum lookup code
has landed (see commit ebf677c8 and parents)

> +
> +    case WATCHDOG_EXPIRATION_ACTION__MAX:
> +        /* keep gcc happy */
> +        break;

Could use g_assert_not_reached() here instead.

> +++ b/qapi-schema.json
> @@ -6539,3 +6539,12 @@
>  # Since 2.9
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> +
> +##
> +# @watchdog-set-action:
> +#
> +# Set watchdog action
> +#
> +# Since 2.11
> +##
> +{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogExpir=
ationAction'} }

Can a machine have more than one watchdog device, in which case you'd
want a device name to select which watchdog gets which action?  But the
command-line version that you are replacing seems to be global, so I
guess you're okay with this interface.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4J347B0f9BMThNgmWl7nPoIQa5PKde8Ti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmvCr8ACgkQp6FrSiUn
Q2pq4wf/Sq2Ug0Tk5W709sbiiBsLtJJYTfDgZRx0vhot6lGOuJPcbpsP2MxROqXv
Awwy67PkhM+y211DWwhQOM6bsBfBr6a30unX8SJ6Yj/EgLyPKoGGAosSCS8l5bEb
17kIr0Aq/OlmMcEF3XGuJWXhkSMoUn4+h7k/XxEJmQKRSFAXI2DuuRUJL9TlWUqt
ug6whzkirzUKYMIgWRkuxL0MgbYh3wRjiKbOj1LgldQ4YBD1tX1ACMYqtjO24djO
EzZQhtw+9OONU/XBJuPVACIVOMUT3Wem/PD4bPdinruEigBDDB7dlJuxf9ka1fuy
4Yw6nO/2EhSJjhswMQZ0Jds5DXUgdQ==
=ywTL
-----END PGP SIGNATURE-----

--4J347B0f9BMThNgmWl7nPoIQa5PKde8Ti--
