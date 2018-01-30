Received: from eggs.gnu.org ([2001:4830:134:3::10]:59666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egY2a-0004qg-Mw
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egY2W-0000vD-PZ
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:41:44 -0500
References: <20180130133828.77336-1-borntraeger@de.ibm.com>
	<20180130133828.77336-2-borntraeger@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb70731d-b857-8adb-0dc7-cd072a2c50b1@redhat.com>
Date: Tue, 30 Jan 2018 09:41:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180130133828.77336-2-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kz7faaNn2AwG01bSoTvx9UIDDkzImNlhn"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] Fix configure for s390 qemu on
 alpine and other busybox environments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alice Frosi <alice@linux.vnet.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kz7faaNn2AwG01bSoTvx9UIDDkzImNlhn
From: Eric Blake <eblake@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alice Frosi <alice@linux.vnet.ibm.com>, qemu-s390x
 <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Message-ID: <fb70731d-b857-8adb-0dc7-cd072a2c50b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] Fix configure for s390 qemu on alpine
 and other busybox environments
References: <20180130133828.77336-1-borntraeger@de.ibm.com>
 <20180130133828.77336-2-borntraeger@de.ibm.com>
In-Reply-To: <20180130133828.77336-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 07:38 AM, Christian Borntraeger wrote:
> From: Alice Frosi <alice@linux.vnet.ibm.com>
>=20
> In alpine docker image the qemu-system-s390x build is broken and
> it throws this error:
> qemu-system-s390x: Initialization of device s390-ipl failed: could not
> load bootloader 's390-ccw.img'
>=20
> The grep command of busybox uses regex. This fails on binary data
> (e.g. stops on every \0), so it does not identify the string
> BiGeNdIaN in the test case big/little. Therefore, it assumes
> that the architecture is little endian.
>=20
> This fix solves the grep problem by printing the content of
> TMPO with strings
>=20
> Signed-off-by: Alice Frosi <alice@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [some changes to patch description, add -a option to strings]
> ---
> v1->v2:
> - Fix email address of Alice
> - Fix patch prefix

Oh, that reminds me I still have an old patch to qobject_from_jsonf that
probed $TMPO using strings [1].  It does look like 'strings -a' is
portable, so I'll have to update my patch when I dig it back out of stora=
ge.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07963.html

> +++ b/configure
> @@ -1906,9 +1906,9 @@ int main(int argc, char *argv[]) {
>  EOF
> =20
>  if compile_object ; then
> -    if grep -q BiGeNdIaN $TMPO ; then
> +    if strings -a $TMPO | grep -q BiGeNdIaN ; then
>          bigendian=3D"yes"
> -    elif grep -q LiTtLeEnDiAn $TMPO ; then
> +    elif strings -a $TMPO | grep -q LiTtLeEnDiAn ; then

Yes, this is indeed a more portable way to grep binary files (it's also
possible to do:

tr -d '\0' < $TMPO | grep -q ...

if we're worried about the availability of strings, but I don't see that
being a problem if no one reports it actually failing).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kz7faaNn2AwG01bSoTvx9UIDDkzImNlhn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwkjAACgkQp6FrSiUn
Q2pwowf/Wm8eezWfbbRkqsOgd/ugTHGR7CtZUdkmpmEpV2mcpCnODXGnPdR5zEOM
KFuRQkKWeYGa4hKWKrXaBtAqirL2/RSBRq3gqzmUKGeORy5bZfloM7haW6V/w/GA
WIiVcE5o6rvHIzn+uLZpKPvxIBTKkGtAJOiEc90iuCXQA3mwG9koBxAE7GVrIIf2
E6C3JgytV57Y15/bK0I9YqHZMUSht1BqAy4sNOTRyaRIGH5pitGj9Byvvh/nG3Wo
hyNQ2hB1uwoysOezhg5VOlqISl1BZjO4AjYoY8wR6cbEH76ebDfrj8p4yBgdY8rl
hIIDGB+UJQKI0WTpjXvDGEkWHjpWGA==
=iuSI
-----END PGP SIGNATURE-----

--kz7faaNn2AwG01bSoTvx9UIDDkzImNlhn--
