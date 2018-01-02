Received: from eggs.gnu.org ([2001:4830:134:3::10]:46608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWSmn-00030k-5N
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWSmj-0002VT-3O
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:03:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWSmi-0002TP-Qy
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:03:41 -0500
References: <20180102170645.5877-1-danielhb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ece03c18-76c3-294d-9c2a-778a23e8d9b4@redhat.com>
Date: Tue, 2 Jan 2018 14:03:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180102170645.5877-1-danielhb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ipNKFWb04KOJ0GzBAJP054TE3o9fnRsTA"
Subject: Re: [Qemu-devel] [PATCH RESEND 1/1] qmp.c: system_wakeup: adding
 RUN_STATE_SUSPENDED check before proceeding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ipNKFWb04KOJ0GzBAJP054TE3o9fnRsTA
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <ece03c18-76c3-294d-9c2a-778a23e8d9b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND 1/1] qmp.c: system_wakeup: adding
 RUN_STATE_SUSPENDED check before proceeding
References: <20180102170645.5877-1-danielhb@linux.vnet.ibm.com>
In-Reply-To: <20180102170645.5877-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2018 11:06 AM, Daniel Henrique Barboza wrote:
> The qmp/hmp command 'system_wakeup' is simply a direct call to
> 'qemu_system_wakeup_request' from vl.c. This function verifies if
> runstate is SUSPENDED and if the wake up reason is valid before
> proceeding. However, no error or warning is thrown if any of those
> pre-requirements isn't met.
>=20
> This leads to situations such as the one described in
> https://github.com/open-power-host-os/qemu/issues/31, where one
> can induce the OS to be suspended by using pm-suspend (via
> dompmsuspend, for example) but for some reason the machine failed to
> go to the SUSPENDED runstate, staying at runstate RUNNING. The user
> then tries to wake up the guest using system_wakeup (or dompmwakeup),
> no error is thrown but nothing happened either because the wake up
> wasn't fired at all. In the end, the user is left with a guest that
> is dormant and believing that system_wakeup isn't working.
>=20
> This patch changes qmp_system_wakeup to make the runstate verification
> before proceeding to call qemu_system_wakeup_request, firing up
> an error message if the user tries to wake up a machine that
> isn't in SUSPENDED state. The change isn't made inside
> qemu_system_wakeup_request because it is used in migration,
> ACPI and others where this usage might be valid. This patch
> by no means fixes the situation described above, but it can direct
> the user/management closer to the real problem.

Converting something that silently did nothing successfully into now
returning an error is somewhat backwards-incompatible.  Is this
something that needs to go through a deprecation cycle, to give people a
chance to fix QMP scripts that were relying on the previous no-op
behavior to now work with the new semantics?  Or should we add an
optional bool parameter to the command, where omitting the parameter
gives the old semantics, but new enough clients can pass the bool to
choose which behavior (no-op or error) they prefer?

> +++ b/qmp.c
> @@ -201,6 +201,11 @@ void qmp_cont(Error **errp)
> =20
>  void qmp_system_wakeup(Error **errp)
>  {
> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
> +        error_setg(errp,
> +                   "Unable to wake up: guest is not in suspended state=
");
> +        return;
> +    }
>      qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ipNKFWb04KOJ0GzBAJP054TE3o9fnRsTA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL5ZkACgkQp6FrSiUn
Q2pojQf+Ipk6PYjfI2NFl5yrsdR5p/ob8r9urRNy/JX/+m28g9tvEdC2F+pt1y5r
H/8+Wh90WGIT/fDY7T5MedQ5LqljMmUtbTpRb/6vJi9yBI9cg7RSaYtxkYS8tz9B
zsRhIgp44hurKt0ywYA3jWdA7sD51Q1F6zd9/fSpmyyRTnNB1q7ZMCY52QYMZwS8
N5VEHgi4ulSbYIKfEBltohO2+cx7oEurzS3KD52wiI23hZXdP6C8LlDxlznf6zo8
P66xxi3wyJq0dCtqfMhk5fDUFqJEr03aWLUmKRl0IV4oEuTW7G8JwQMdO5h1sTQC
NhDQxoUQu8EKg7qCwkuEwKR1ryCljQ==
=OC+b
-----END PGP SIGNATURE-----

--ipNKFWb04KOJ0GzBAJP054TE3o9fnRsTA--
