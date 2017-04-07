Received: from eggs.gnu.org ([2001:4830:134:3::10]:47468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUPC-0006Po-5T
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUP8-0001Y5-5d
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:58:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cwUP7-0001Ws-S5
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:58:22 -0400
References: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
	<20170407111851.20680-2-cornelia.huck@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac949777-b259-f0b2-fc22-077dcbac8951@redhat.com>
Date: Fri, 7 Apr 2017 08:58:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170407111851.20680-2-cornelia.huck@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SDmM7m2HgdWVpjaU5KUCUOvLDWp76Lruf"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/8] chardev: Basic support for
 TN3270
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: Jing Liu <liujbjl@linux.vnet.ibm.com>, agraf@suse.de, borntraeger@de.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Yang Chen <bjcyang@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SDmM7m2HgdWVpjaU5KUCUOvLDWp76Lruf
From: Eric Blake <eblake@redhat.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: Jing Liu <liujbjl@linux.vnet.ibm.com>, agraf@suse.de,
 borntraeger@de.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 Yang Chen <bjcyang@linux.vnet.ibm.com>
Message-ID: <ac949777-b259-f0b2-fc22-077dcbac8951@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/8] chardev: Basic support for
 TN3270
References: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
 <20170407111851.20680-2-cornelia.huck@de.ibm.com>
In-Reply-To: <20170407111851.20680-2-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2017 06:18 AM, Cornelia Huck wrote:
> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
>=20
> This introduces basic support for TN3270, which needs to negotiate
> three Telnet options during handshake:
>   - End of Record
>   - Binary Transmission
>   - Terminal-Type
>=20
> As a basic implementation, this simply ignores NOP and Interrupt
> Process(IP) commands. More work should be done for them later.
>=20
> For more details, please refer to RFC 854 and 1576.
>=20
> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
> Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---

> +++ b/qapi-schema.json
> @@ -4874,6 +4874,8 @@
>  # @nodelay: set TCP_NODELAY socket option (default: false)
>  # @telnet: enable telnet protocol on server
>  #          sockets (default: false)
> +# @tn3270: enable tn3270 protocol on server
> +#          sockets (default: false) (Since: 2.10)
>  # @reconnect: For a client socket, if a socket is disconnected,
>  #          then attempt a reconnect after the given number of seconds.=

>  #          Setting this to zero disables this function. (default: 0)
> @@ -4887,6 +4889,7 @@
>                                       '*wait'      : 'bool',
>                                       '*nodelay'   : 'bool',
>                                       '*telnet'    : 'bool',
> +                                     '*tn3270'    : 'bool',
>                                       '*reconnect' : 'int' },
>    'base': 'ChardevCommon' }

I almost wonder if we should make this a flat union, so that members
that only make sense with the server side (such as tn3270) or with the
client side (reconnect) can only be present when that branch of the
union is taken.  But that may break back-compat if we have existing code
that silently ignores a member that makes no sense, and we start
forcefully warning about the member being present.  At any rate, making
such a change is not a prerequisite for this series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SDmM7m2HgdWVpjaU5KUCUOvLDWp76Lruf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY55r3AAoJEKeha0olJ0Nqm3cH/RbtQ7MisOZZTobX4sS4Sz/c
0OYX0vI3ro2Pv+vZOq1n55Q1rngTFPrP1I1DRL+8VOm4DELEaBO728ftagtKo03i
kG5izXhm6JVYfzPs3W8zJA0BuBnRgAtR7qsgLk40+EoKf+bxHT2SJy53X1qSixRx
3U9UsCSBbkW4uzPapnBrkuztNV4y52K9IxXsOCLopCkF3kSknTA0eOJrB2Nc3t5H
fyEQrVBm18H5hulPsHKSIzurFBa2Z+gGA0mXOXkzb3X5GnR/Sdd0UoohqBWFMF8W
2Mu1vNdyO4Jc35g4VOqlqJ8wL+5+GXLgu2T8L92Ta699VIGO6ybjP99n0S2m9r4=
=e6qH
-----END PGP SIGNATURE-----

--SDmM7m2HgdWVpjaU5KUCUOvLDWp76Lruf--
