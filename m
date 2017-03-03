Received: from eggs.gnu.org ([2001:4830:134:3::10]:33834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrsJ-0001gO-7w
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrsE-0003ff-VY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:24:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjrsE-0003eP-MA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:24:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CE7580F7B
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 18:24:14 +0000 (UTC)
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <96e019e3-7fe9-7ce6-ea57-28dd77d0f7cb@redhat.com>
Date: Fri, 3 Mar 2017 12:24:12 -0600
MIME-Version: 1.0
In-Reply-To: <1488544368-30622-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uRO5HVMR8LSXlwthTI1JCJQ2Cd46pMSIW"
Subject: Re: [Qemu-devel] [PATCH v4 05/28] qapi: Support multiple command
 registries per program
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
--uRO5HVMR8LSXlwthTI1JCJQ2Cd46pMSIW
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <96e019e3-7fe9-7ce6-ea57-28dd77d0f7cb@redhat.com>
Subject: Re: [PATCH v4 05/28] qapi: Support multiple command registries per
 program
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 06:32 AM, Markus Armbruster wrote:
> The command registry encapsulates a single command list.  Give the
> functions using it a parameter instead.  Define suitable command lists
> in monitor, guest agent and test-qmp-commands.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h | 22 ++++++++++++++--------
>  monitor.c                   | 31 +++++++++++++++++--------------
>  qapi/qmp-dispatch.c         | 17 +++++++++++++----
>  qapi/qmp-registry.c         | 37 ++++++++++++++++++-------------------=

>  qga/commands.c              |  2 +-
>  qga/guest-agent-core.h      |  2 ++
>  qga/main.c                  | 19 ++++++++++---------
>  scripts/qapi-commands.py    | 16 ++++++++++------
>  tests/test-qmp-commands.c   | 12 +++++++-----
>  9 files changed, 92 insertions(+), 66 deletions(-)
>=20

> +++ b/qapi/qmp-dispatch.c
> @@ -67,7 +67,11 @@ static QDict *qmp_dispatch_check_obj(const QObject *=
request, Error **errp)
>      return dict;
>  }
> =20
> -static QObject *do_qmp_dispatch(QObject *request, Error **errp)
> +volatile QmpCommand *save_cmd;

A comment why volatile is necessary would be nice...

> +QmpCommand cmd2;
> +
> +static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request=
,
> +                                Error **errp)
>  {
>      Error *local_err =3D NULL;
>      const char *command;
> @@ -81,7 +85,7 @@ static QObject *do_qmp_dispatch(QObject *request, Err=
or **errp)
>      }
> =20
>      command =3D qdict_get_str(dict, "execute");
> -    cmd =3D qmp_find_command(command);
> +    cmd =3D qmp_find_command(cmds, command);
>      if (cmd =3D=3D NULL) {
>          error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
>                    "The command %s has not been found", command);
> @@ -93,6 +97,9 @@ static QObject *do_qmp_dispatch(QObject *request, Err=
or **errp)
>          return NULL;
>      }
> =20
> +    assert(!cmd->options & QCO_NO_SUCCESS_RESP);
> +    save_cmd =3D cmd;
> +    cmd2 =3D *cmd;
>      if (!qdict_haskey(dict, "arguments")) {
>          args =3D qdict_new();
>      } else {
> @@ -111,6 +118,8 @@ static QObject *do_qmp_dispatch(QObject *request, E=
rror **errp)
> =20
>      QDECREF(args);
> =20
> +    assert(!cmd->options & QCO_NO_SUCCESS_RESP);
> +    assert(ret || local_err);

=2E..or is this leftovers from your debugging?

The rest of the patch looks fine; it is converting a global variable
into a per-instance variable.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--uRO5HVMR8LSXlwthTI1JCJQ2Cd46pMSIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubTMAAoJEKeha0olJ0NqJj4H/1ytl27ixf4D+CNbMucxH2z0
Rwhzl0303Clo7LjFYAHtScJGwR0O0tJDV9QThkaUw29nrxIP+EtCBMhMpU+H8pPo
haOepxbLLlQBfr5sP7LHC4BDiA+aFT8wcQ3ZED8HYCgT58JLPUCgIUxoSQfN3pnS
qb4Tbybv1MiBecIBBiSJrCK4Nu7+pcVjQvug1vvZTXhmvn2Uq60lPjCi7B/DzLCq
CcSoHP8RojJMpSLdNh/cjtD1KGdt3ptaHnyWxaz9flxj4nxskeinSCPIKIOzstCp
WlmNYgpNI+me0ujKu6kCQCDUWkiLtoPsirGorMuwjTADP+plyxhH/ZLpEaWkP40=
=DkTK
-----END PGP SIGNATURE-----

--uRO5HVMR8LSXlwthTI1JCJQ2Cd46pMSIW--
