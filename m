Received: from eggs.gnu.org ([2001:4830:134:3::10]:32843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhx9o-0007jh-8I
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhx9j-0004Sx-IH
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:10:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhx9j-0004R5-72
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:10:39 -0400
References: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
	<1502881586-25044-2-git-send-email-vadim.galitsyn@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aaedc8e6-1d06-dbf6-532d-082b74034627@redhat.com>
Date: Wed, 16 Aug 2017 07:10:29 -0500
MIME-Version: 1.0
In-Reply-To: <1502881586-25044-2-git-send-email-vadim.galitsyn@profitbricks.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6UrJ1X9tBwPkBX2jBwCNJH0hKRAMPdPBf"
Subject: Re: [Qemu-devel] [PATCH v6 2/3] qmp: introduce
 query-memory-size-summary command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6UrJ1X9tBwPkBX2jBwCNJH0hKRAMPdPBf
From: Eric Blake <eblake@redhat.com>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>,
 Mohammed Gamal <mohammed.gamal@profitbricks.com>,
 Eduardo Otubo <eduardo.otubo@profitbricks.com>
Message-ID: <aaedc8e6-1d06-dbf6-532d-082b74034627@redhat.com>
Subject: Re: [PATCH v6 2/3] qmp: introduce query-memory-size-summary command
References: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
 <1502881586-25044-2-git-send-email-vadim.galitsyn@profitbricks.com>
In-Reply-To: <1502881586-25044-2-git-send-email-vadim.galitsyn@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 06:06 AM, Vadim Galitsyn wrote:
> Command above provides the following memory information in bytes:

My general preference for reading a commit message is to treat the
subject line as a one-line summary (the what), and then the commit
message body as something that can be read independently, starting with
an implicit "Apply this patch to...".  Your sentence reads awkwardly in
that light ("Apply this patch to command above provides...").  Better
might be:

Add a new query-memory-size-summary command which provides...

Yes, it repeats some of the subject line, but remember, not all mail
clients display the subject line immediately adjacent and in the same
font as the body, so making the reader refer back to the subject to get
context can be a distraction.

>=20
>   * base-memory - size of "base" memory specified with command line opt=
ion -m.
>=20
>   * plugged-memory - amount of memory that was hot-plugged.
>     If target does not have CONFIG_MEM_HOTPLUG enabled, no
>     value is reported.
>=20

> ---
>  hw/mem/pc-dimm.c                |  5 +++++
>  include/hw/mem/pc-dimm.h        |  1 +
>  qapi-schema.json                | 25 +++++++++++++++++++++++++
>  qmp.c                           | 13 +++++++++++++
>  stubs/Makefile.objs             |  2 +-
>  stubs/qmp_pc_dimm.c             | 13 +++++++++++++
>  stubs/qmp_pc_dimm_device_list.c |  8 --------
>  7 files changed, 58 insertions(+), 9 deletions(-)

You may want to look at using scripts/git.orderfile, to rearrange your
patch so that interface changes (.json, .h) occur before implementation
(.c).  For now, I'm just focusing on the interface:

> +++ b/qapi-schema.json
> @@ -4408,6 +4408,31 @@
>              '*unavailable-features': [ 'str' ], 'typename': 'str' } }
> =20
>  ##
> +# @MemoryInfo:
> +#
> +# Actual memory information in bytes.
> +#
> +# @base-memory: size of "base" memory specified with command line
> +#               option -m.
> +#
> +# @plugged-memory: size memory that can be hot-unplugged.

Please also document when this field will be omitted.

> +#
> +# Since: 2.10.0

You missed 2.10.  This must be 2.11.

> +##
> +{ 'struct': 'MemoryInfo',
> +  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
> +
> +##
> +# @query-memory-size-summary:
> +#
> +# Return the amount of initially allocated and hot-plugged (if
> +# enabled) memory in bytes.
> +#
> +# Since: 2.10.0

2.11

Also, consider including an example usage (there are efforts underway to
add automatic testing based on the examples, and a query-* command
should be easy to test in that manner).

> +##
> +{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
> +
> +##
>  # @query-cpu-definitions:
>  #


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6UrJ1X9tBwPkBX2jBwCNJH0hKRAMPdPBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUNjUACgkQp6FrSiUn
Q2pfWQf+PPsKiesInWzaLT4CKcHgWABOPgb6/GoyW2m5ld0S2H7DeogJOn+7Cjxu
p8RNEXFO4CNvV3LAWCnAzZZxdFV0/er1EbfSnyhfgkFK7kbM5Kumo7+CYTviIjgK
1dEBTVj1Ba0MOeFbIt4UmpPMyGPCG/0b7fTcMEel9vYxXJ8zp7Iz/0IdyFScRj3p
dy5sFdVYxneFpcCmq8yy0JCBUNW4EpsHvuV0pVzlg1P3j6PCOL3dyCidBpwv8WKj
CJWsjCzOJaNWFYmJ1dEMyI9t/0qfnyJmT72kqVbFgcU0OupxsV4kok+MZeofT9Zb
HKHRSQq2ouU4lNVC/dD0t7kh9cOEIg==
=ux2O
-----END PGP SIGNATURE-----

--6UrJ1X9tBwPkBX2jBwCNJH0hKRAMPdPBf--
