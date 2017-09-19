Received: from eggs.gnu.org ([2001:4830:134:3::10]:55620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duICO-0007qL-9f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duICK-0004TS-HO
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:04:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duICK-0004Sn-8e
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:04:20 -0400
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6b1668e-b646-186b-8036-193100f15d54@redhat.com>
Date: Tue, 19 Sep 2017 08:04:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170919074314.10350-1-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PfgfnRo9SBCC3hrcOeLVQAx7rIqXm30eR"
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PfgfnRo9SBCC3hrcOeLVQAx7rIqXm30eR
From: Eric Blake <eblake@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>
Message-ID: <a6b1668e-b646-186b-8036-193100f15d54@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
In-Reply-To: <20170919074314.10350-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 02:43 AM, Christian Borntraeger wrote:
> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
>=20
> This patch is the s390 implementation of guest crash information, simil=
ar
> to commit d187e08dc4 ("i386/cpu: add crash-information QOM property") a=
nd
> the related commits. We will detect several crash reasons, with the
> "disabled wait" being the most important one, since this is used by all=

> s390 guests as a "panic like" notification.
>=20
> Demonstrate the these ways with examples as follows.
>=20

>=20
> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [minor fixes due to upstream feedback]
> ---
> V1->V2:
> 	- rename kvm-s390 to s390 in all places
> 	- add "loop" to the crash reasons where appropriate
> 	- use "-" instead of "_" for qapi
>=20
>  qapi/run-state.json | 19 ++++++++++++++++--
>  target/s390x/cpu.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  target/s390x/cpu.h  |  6 ++++++
>  target/s390x/kvm.c  | 29 +++++++++++++++++++++------
>  vl.c                |  6 ++++++
>  5 files changed, 109 insertions(+), 8 deletions(-)
>=20
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index d36ff49..4567510 100644
> --- a/qapi/run-state.json

> +
> +##
> +# @GuestPanicInformationS390:
> +#
> +# S390 specific guest panic information (PSW)
> +#
> +# Since: 2.11
> +##
> +{'struct': 'GuestPanicInformationS390',
> + 'data': { 'psw-mask': 'uint64',
> +           'psw-addr': 'uint64',
> +           'reason': 'str' } }

Missing documentation of the three fields; in particular, whether
'reason' is for human consumption only (presumably the case) rather than
for machine parsing.


> +    cpu_synchronize_state(cs);
> +    panic_info =3D g_malloc0(sizeof(GuestPanicInformation));
> +
> +    panic_info->type =3D GUEST_PANIC_INFORMATION_TYPE_S390;
> +    panic_info->u.s390.psw_mask =3D cpu->env.psw.mask;
> +    panic_info->u.s390.psw_addr =3D cpu->env.psw.addr;
> +
> +    switch (cs->exception_index) {
> +    case EXCP_CRASH_PGM:
> +        panic_info->u.s390.reason =3D g_strdup("program interrupt loop=
");
> +        break;
> +    case EXCP_CRASH_EXT:
> +        panic_info->u.s390.reason =3D g_strdup("external interrupt loo=
p");
> +        break;
> +    case EXCP_CRASH_WAITPSW:
> +        panic_info->u.s390.reason =3D g_strdup("disabled wait");
> +        break;
> +    case EXCP_CRASH_OPEREXC:
> +        panic_info->u.s390.reason =3D g_strdup("operation exception lo=
op");
> +        break;
> +    default:
> +        panic_info->u.s390.reason =3D g_strdup("unknown crash reason")=
;
> +        break;

Is it worth a QAPI enum type to expose the reason as one of a finite set
of known strings, or is that information not needed beyond the
human-only string that you are setting here?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PfgfnRo9SBCC3hrcOeLVQAx7rIqXm30eR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBFc4ACgkQp6FrSiUn
Q2pBDgf+NFtIcszbgSW/ZjqC4CSfj3gWKmDF93vjJSUzFZ6N0AlfrxcQx3Alh3rj
/RRAnnyHHsojZP2Q7lIQTcXdGplnhQv7WXiqActsn7c3SZHBazuImBgvSn22gj4q
R2apU5cxsimbFvdWLREEWTTfyv30yctPo09w3pMWSWqoSptKhCMykMZ8eNH0/Pt8
0jzxGTlkEVpsjbyuvNsyQz0tSmpdoy//Gd6+3+uZEl5Erqs9BKUuPE6IyeCb1l+8
caIsxIgibUX7NP+/UZW4COSdunp3LoqJqg2SUzdPWExS/N9B4GT7u5GvZHWEKtOI
8UsU+2x/AhO9ovkoPIrWuvaZyS1tFA==
=5BqL
-----END PGP SIGNATURE-----

--PfgfnRo9SBCC3hrcOeLVQAx7rIqXm30eR--
