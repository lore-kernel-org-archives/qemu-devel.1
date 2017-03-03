Received: from eggs.gnu.org ([2001:4830:134:3::10]:39552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjs8W-0003fe-QB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjs8S-0001wW-Fn
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:41:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjs8S-0001w2-6s
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:41:00 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A6C23B71E
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 18:41:00 +0000 (UTC)
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3776dbf-f2d3-b2ef-4454-9b9dc46d7f20@redhat.com>
Date: Fri, 3 Mar 2017 12:40:57 -0600
MIME-Version: 1.0
In-Reply-To: <1488544368-30622-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DJjLE9URvm7JQrxbH90Dcg3x3Qp8Jq3BI"
Subject: Re: [Qemu-devel] [PATCH v4 07/28] qmp: Clean up how we enforce
 capability negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DJjLE9URvm7JQrxbH90Dcg3x3Qp8Jq3BI
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e3776dbf-f2d3-b2ef-4454-9b9dc46d7f20@redhat.com>
Subject: Re: [PATCH v4 07/28] qmp: Clean up how we enforce capability
 negotiation
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 06:32 AM, Markus Armbruster wrote:
> To enforce capability negotiation before normal operation,
> handle_qmp_command() inspects every command before it's handed off to
> qmp_dispatch().  This is a bit of a layering violation, and results in
> duplicated code.
>=20
> Before capability negotiation (!cur_mon->in_command_mode), we fail
> commands other than "qmp_capabilities".  This is what enforces
> capability negotiation.
>=20
> Afterwards, we fail command "qmp_capabilities".
>=20
> Clean this up as follows.
>=20
> The obvious place to fail a command is the command itself, so move the
> "afterwards" check to qmp_qmp_capabilities().
>=20
> We do the "before" check in every other command, but that would be
> bothersome.  Instead, start with an alternate list of commant that

s/commant/commands/

> contains only "qmp_capabilities".  Switch to the full list in
> qmp_qmp_capabilities().
>=20
> Additionally, replace the generic human-readable error message for
> CommandNotFound by one that reminds the user to run qmp_capabilities.
> Without that, we'd regress commit 2d5a834.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor.c | 76 +++++++++++++++++++++++++++++++++++--------------------=
--------
>  1 file changed, 42 insertions(+), 34 deletions(-)
>=20

> @@ -3786,11 +3785,20 @@ static void handle_qmp_command(JSONMessageParse=
r *parser, GQueue *tokens)
>      cmd_name =3D qdict_get_str(qdict, "execute");
>      trace_handle_qmp_command(mon, cmd_name);
> =20
> -    if (invalid_qmp_mode(mon, cmd_name, &err)) {
> -        goto err_out;
> -    }
> +    rsp =3D qmp_dispatch(cur_mon->qmp.commands, req);
> =20
> -    rsp =3D qmp_dispatch(&qmp_commands, req);
> +    qdict =3D qdict_get_qdict(qobject_to_qdict(rsp), "error");
> +    if (qdict) {
> +        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands
> +            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
> +                    QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUN=
D])) {

Could join these two 'if' into one, for less {}, but that's cosmetic.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DJjLE9URvm7JQrxbH90Dcg3x3Qp8Jq3BI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubi5AAoJEKeha0olJ0NqBFUH/3QOvj+lqTGmnuv23qXXcVqQ
r8j5KY6RXN8kmaachsEo/zDJIIuL+z9TTMNrMzfK4/LSqMeB2QSyDEE2LRnpWBgG
dJ7A1CtPiPfsNm+z95gJO6fIcIiwZwofEAemqjJmQst81xxKY0ww/rkk10xocLl1
ZFKLejFjmGGe29LWsG+D3XESUabg8JQtn+QMIjy8hw+BkgTsLLLyP/K6r39+SWOl
TKiR2Da1SEuqJTZRItpBm/zBuYzS8I1oSLBi+aql+Fm4h6ZrXjV17oUKmauP89OJ
mk/hxfVBcKrkZEXeFHYmVbLY6PHl53aLDQBCF9SvYz/45TXZnPEc+WpD++Ihn9k=
=+Cth
-----END PGP SIGNATURE-----

--DJjLE9URvm7JQrxbH90Dcg3x3Qp8Jq3BI--
