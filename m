Received: from eggs.gnu.org ([209.51.188.92]:52654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grS9K-0006oy-M8
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grS9I-0007Uq-Rd
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:42:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1grS9I-0007T2-IO
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:42:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A58B58592
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:42:14 +0000 (UTC)
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-17-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e7c814c-5d82-e9c0-3d53-bcc576019b65@redhat.com>
Date: Wed, 6 Feb 2019 12:42:05 -0600
MIME-Version: 1.0
In-Reply-To: <20190206181725.14337-17-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zj91kA0CSqdPbqyH4HPbYWTSynT5tZcUH"
Subject: Re: [Qemu-devel] [PATCH v3 16/17] qmp: Deprecate query-events in
 favor of query-qmp-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, libvirt-list@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zj91kA0CSqdPbqyH4HPbYWTSynT5tZcUH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, libvirt-list@redhat.com
Message-ID: <0e7c814c-5d82-e9c0-3d53-bcc576019b65@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 16/17] qmp: Deprecate query-events in
 favor of query-qmp-schema
References: <20190206181725.14337-1-armbru@redhat.com>
 <20190206181725.14337-17-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adding libvirt in cc

On 2/6/19 12:17 PM, Markus Armbruster wrote:
> query-events doesn't reflect compile-time configuration.  Instead of
> fixing that, deprecate the command in favor of query-qmp-schema.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor.c            | 5 +++++
>  qapi/misc.json       | 7 +++++--
>  qemu-deprecated.texi | 5 +++++
>  3 files changed, 15 insertions(+), 2 deletions(-)

Libvirt uses query-events; we'll need to patch libvirt to start relying
on query-qmp-schema before this deprecation cycle can complete (although
I'm in favor of making the change).

>=20
> diff --git a/monitor.c b/monitor.c
> index eeec289aae..9f27621ed1 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1099,6 +1099,11 @@ CommandInfoList *qmp_query_commands(Error **errp=
)
> =20
>  EventInfoList *qmp_query_events(Error **errp)
>  {
> +    /*
> +     * TODO This deprecated command is the only user of
> +     * QAPIEvent_str() and QAPIEvent_lookup[].  When the command goes,=

> +     * they should go, too.
> +     */
>      EventInfoList *info, *ev_list =3D NULL;
>      QAPIEvent e;
> =20
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 82f9147353..98f59f828a 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -318,12 +318,15 @@
>  ##
>  # @query-events:
>  #
> -# Return a list of supported QMP events by this server
> +# Return information on QMP events.
>  #
> -# Returns: A list of @EventInfo for all supported events
> +# Returns: A list of @EventInfo.
>  #
>  # Since: 1.2.0
>  #
> +# Note: This command is deprecated, because its output doesn't reflect=

> +# compile-time configuration.  Use query-qmp-schema instead.
> +#
>  # Example:
>  #
>  # -> { "execute": "query-events" }
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 9cc20b365c..3288e102d6 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -103,6 +103,11 @@ Use ``device_add'' for hotplugging vCPUs instead o=
f ``cpu-add''.  See
>  documentation of ``query-hotpluggable-cpus'' for additional
>  details.
> =20
> +@subsection query-events (since 4.0)
> +
> +The ``query-events'' command has been superseded by the more powerful
> +and accurate ``query-qmp-schema'' command.
> +
>  @section Human Monitor Protocol (HMP) commands
> =20
>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (=
since 3.1)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--zj91kA0CSqdPbqyH4HPbYWTSynT5tZcUH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbKn0ACgkQp6FrSiUn
Q2qdsAf/YY5+BiD0WUyz1/MesCOfEWBoar698+RiXro16zZQ0sa8tx2JLmwQ7QWb
1P9eTV7GF4sB6i+4dcNJc8Rj8miYyqqZXFF9bu1uS6239XjFGDVZ0LTBpRvlP+bX
hprtfLrzI/t50ltU509bhLu6ym5eNug9S+DdX1m8yUSlgiEEgGy/qATQqLGPhO+6
Yro0smHyWsewMqpErLwnXr9mSQ7RY1oS4zlR8jsC4PiP/S3xJngSLFrOWM3XfsMU
3Y7CA2uY3GQC9aAklBSLOyRcEUhlUTDvmiKSKaPM7vJSb2mOjWMHT9A5DpTk9s0R
DoywSihFG6ZxgZcggO+wNLyZbK4Ltg==
=K/21
-----END PGP SIGNATURE-----

--zj91kA0CSqdPbqyH4HPbYWTSynT5tZcUH--
