Received: from eggs.gnu.org ([2001:4830:134:3::10]:57695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePJ6o-0004Zg-Q0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePJ6k-0005XX-5d
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:18:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePJ6j-0005WT-T7
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:18:46 -0500
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
	<20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de0c5647-ca81-f5be-db52-9f0d3b173dac@redhat.com>
Date: Wed, 13 Dec 2017 20:18:43 -0600
MIME-Version: 1.0
In-Reply-To: <20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kv9NPWPKcn3R0l1PFhXs3euFOhOp8gmSB"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] qmp.c: (re)implement qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kv9NPWPKcn3R0l1PFhXs3euFOhOp8gmSB
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com
Message-ID: <de0c5647-ca81-f5be-db52-9f0d3b173dac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] qmp.c: (re)implement qmp_cpu
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
 <20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
In-Reply-To: <20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/2017 12:15 PM, Daniel Henrique Barboza wrote:
> Commit 755f196898 ("qapi: Convert the cpu command") added the qmp_cpu
> function in qmp.c, leaving it blank. It the same commit, a working
> hmp_cpu was implemented. Since then, no further changes were made in
> qmp_cpu, resulting now in a working 'cpu' command that works in HMP
> and a 'cpu' command in QMP that does nothing.
>=20
> Regardless of what constraints were involved that time in not implemeti=
ng
> qmp_cpu, at this moment it is possible to have both. This patch brings
> the logic of hmp_cpu to qmp_cpu and converts the HMP function to use it=
s
> QMP counterpart.

I'm not sure I like this. HMP is stateful (you have to remember what
previous 'cpu' commands have been run to tell what the current command
will do).  That may be convenient (if not confusing) to humans, but is
lousy for machine interfaces.  QMP should be stateless as much as
possible - for any command that would behave differently according to
what CPU is selected, THAT command (and not a different 'cpu' command
executed previously) should have a cpu argument alongside all its other
parameters.

So unless you have a really strong use case for this, I don't think we
want it.


> +++ b/qapi-schema.json
> @@ -1048,11 +1048,19 @@
>  ##
>  # @cpu:
>  #
> -# This command is a nop that is only provided for the purposes of comp=
atibility.
> +# Set the default CPU.
>  #
> -# Since: 0.14.0
> +# @index: The index of the virtual CPU to be set as default
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.12.0
> +#
> +# Example:
> +#
> +# -> { "execute": "cpu", "arguments": { "index": 2 } }
> +# <- { "return": {} }
>  #
> -# Notes: Do not use this command.
>  ##
>  { 'command': 'cpu', 'data': {'index': 'int'} }
> =20
> diff --git a/qmp.c b/qmp.c
> index e8c303116a..c482225d5c 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -115,7 +115,9 @@ void qmp_system_powerdown(Error **erp)
> =20
>  void qmp_cpu(int64_t index, Error **errp)
>  {
> -    /* Just do nothing */
> +    if (monitor_set_cpu(index) < 0) {
> +        error_setg(errp, "Invalid CPU index");
> +    }
>  }
> =20
>  void qmp_cpu_add(int64_t id, Error **errp)
>=20

Better yet, let's document that 'cpu' is deprecated, so that we can
remove it from QMP altogether in a couple of releases.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kv9NPWPKcn3R0l1PFhXs3euFOhOp8gmSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlox34MACgkQp6FrSiUn
Q2qEKAf/dYzQTt9ssWpxCrkK5p9T0FwLHop3weRpMV0DjwQI/XByZWJjChVGzwws
vrfGcvvewQQJnfwnnJJ7x+C1T2qSR5pScm74Kp3jMhSyf5/4Wh0bryRdN/JXnlJZ
reMT6lcxzKX2V9F7WOG1rstrh4RqZFQs+102JhyIvXe3LW+fRV5OhcLG1CYwSnWf
GbbD0AHZW9zXa48Ttrz2HMemNp1a2RSzXu13MLxBg1By8Re3z4mLiMy25Dg7OUhR
e9APiB/uSaisqCiw/5FLd3qfOnRQXkBcHdNWXxxDIkx8O2izWYSIPZlb3PU1N0Ik
eJwxoMIgS8E0rJGcx33J9zYkjOFd8Q==
=L9eJ
-----END PGP SIGNATURE-----

--kv9NPWPKcn3R0l1PFhXs3euFOhOp8gmSB--
