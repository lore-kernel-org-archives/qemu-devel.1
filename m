Received: from eggs.gnu.org ([2001:4830:134:3::10]:56801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXanJ-0003Sl-7g
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXanF-0001TZ-7v
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXanE-0001TE-Uj
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:16:37 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
	<96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
	<ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4c4f0fa-da73-9f65-3450-fd2b1f08f0a4@redhat.com>
Date: Tue, 18 Jul 2017 17:16:32 -0500
MIME-Version: 1.0
In-Reply-To: <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wdw8ik35IIOt6q6QpPx6h3RX9KJhuL8in"
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wdw8ik35IIOt6q6QpPx6h3RX9KJhuL8in
From: Eric Blake <eblake@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>
Message-ID: <c4c4f0fa-da73-9f65-3450-fd2b1f08f0a4@redhat.com>
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
 <96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
 <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
In-Reply-To: <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 04:22 PM, Cleber Rosa wrote:

> +++ 087.out.bad 2017-07-18 17:01:37.736038689 -0400
> @@ -27,7 +27,7 @@
>  Testing:
>  QMP_VERSION
>  {"return": {}}
> -{"error": {"class": "GenericError", "desc": "aio=3Dnative was specifie=
d,
> but it requires cache.direct=3Don, which was not specified."}}
> +{"error": {"class": "GenericError", "desc": "aio=3Dnative was specifie=
d,
> but is not supported in this build."}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
> "event": "SHUTDOWN", "data": {"guest": false}}
>=20
> Failures: 087
> Failed 1 of 1 tests
>=20
> When either "--disable-linux-aio" is given or when libaio headers are
> missing, which in the end means that CONFIG_LINUX_AIO won't be set in
> config-host.mak or config-host.h.

Or, instead of splitting the test, we could just add another post-test
filter that does sed 's/"aio=3Dnative[^"]*/"aio=3Dnative missing/' and
update the expected output accordingly.

> 2) Skip tests based on features more easily.  There's already support
> for skipping tests on various situations.  From 087:
>=20
> ...
> _supported_fmt qcow2
> _supported_proto file
> _supported_os Linux
> ...

There's also _notrun (for example, see test 183, which checks whether
'migrate -b' works before getting on to the rest of the test).

>=20
> It's trivial to also have access to other compile time settings.  I did=

> a quick experiment that would add a "_required_feature" function to
> "common.rc".  For 087 (or 190?) it would look like:
>=20
> ...
> _supported_fmt qcow2
> _supported_proto file
> _supported_os Linux
> _required_feature CONFIG_LINUX_AIO
> ...
>=20
> Does it make sense?  Would a patch series along those lines would be
> welcomed by reviews?

Seems reasonable, if it makes it easier to mark particular tests as
requiring certain subsets of configure options.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Wdw8ik35IIOt6q6QpPx6h3RX9KJhuL8in
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluiMAACgkQp6FrSiUn
Q2rYrAgAoSN72bAjP8kCoA2QKx07hXJVhMsPIcvT4eAuZkCUkQHsMGFwxxMHk10w
WgWeBmxZVU0ZDY+tEERYryP4Px7x8KHp4ZBvW3Cn+sBWBgLU6usqRdQUEcl+XWwV
TzmZB2X+0BaRHaUrHOWRvLp7sb03u9/e+Kh7/8JrekYblH4X6DB930Dx6T1otUet
mc0we6zZ5Z0ZGTlYbVniafXB3HQL/NUXjealLhUG5+MY1VcPEaM/Rp0JqN6oZSAK
vjzqxuSPbw8GQuKvpdxRxSeqruI1ZKYTBmAS35HRHua0Pt7ZrqA+cd4P7JqUYm2T
VoVwbtqqXRNDNdJik7tWaEiHoCoJYw==
=zjJL
-----END PGP SIGNATURE-----

--Wdw8ik35IIOt6q6QpPx6h3RX9KJhuL8in--
