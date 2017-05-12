Received: from eggs.gnu.org ([2001:4830:134:3::10]:38677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Eh8-0003sf-Kl
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Eh4-0004x3-Di
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d9Eh4-0004wj-4L
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:49:34 -0400
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-2-f4bug@amsat.org>
	<alpine.DEB.2.20.1705121139030.2981@hadrien>
	<7d1b12cd-80dc-7fc8-935d-bec7fb08e256@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e548b97-c39a-4ba0-1eca-40b9e2b40137@redhat.com>
Date: Fri, 12 May 2017 12:49:23 -0500
MIME-Version: 1.0
In-Reply-To: <7d1b12cd-80dc-7fc8-935d-bec7fb08e256@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sdDsL9XLkxeTjkSgnrFSAsk1AOVHom5Hn"
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/5] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Julia Lawall <julia.lawall@lip6.fr>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Elfring <elfring@users.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sdDsL9XLkxeTjkSgnrFSAsk1AOVHom5Hn
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Julia Lawall <julia.lawall@lip6.fr>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>,
 Nicolas Palix <nicolas.palix@imag.fr>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <3e548b97-c39a-4ba0-1eca-40b9e2b40137@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] coccinelle: add a script to optimize tcg op
 using tcg_gen_extract()
References: <20170512033543.6789-1-f4bug@amsat.org>
 <20170512033543.6789-2-f4bug@amsat.org>
 <alpine.DEB.2.20.1705121139030.2981@hadrien>
 <7d1b12cd-80dc-7fc8-935d-bec7fb08e256@amsat.org>
In-Reply-To: <7d1b12cd-80dc-7fc8-935d-bec7fb08e256@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 12:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:

> In this patch
> http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01466.html
> Aurelien does:
>=20
> -    tcg_gen_shri_i32(cpu_sr_q, src, SR_Q);
> -    tcg_gen_andi_i32(cpu_sr_q, cpu_sr_q, 1);
> +    tcg_gen_extract_i32(cpu_sr_q, src, SR_Q, 1);
>=20
> having:
>=20
> #define SR_Q  8
>=20
> I wanted to write a Coccinelle script to check for this pattern.
> My first version was wrong, as Richard Henderson reminded me this
> pattern can be applied as long as the len argument (here "1") is a
> Mersenne prime (all least significant bits as "1").

Side note: while you are correct that a Mersenne prime is one less than
a power of 2, your use of the term here is incorrect. You are looking
for ALL instances of numbers that are one less than a power of two, and
not just the Mersenne primes.  (For instance, 0xf is NOT a Mersenne
prime, but IS a candidate for an optimization using a length of 4.)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sdDsL9XLkxeTjkSgnrFSAsk1AOVHom5Hn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFfWjAAoJEKeha0olJ0Nq6n0H+gJOY1TMW4numYt4VJKxZ9lb
7lYAJ6FZzahBPSoKEA4vp2IgAI4vSJbk5ro1bnIQFUdfOqKGI4Y4tTviehjBdLKh
E4e99GQtbEm6HxkL8bCYvkT33A9faen7KS8ZDNEkIBXhGoFpTXRENPWpaVZcSaN1
MLWDd/uJbJZqodOgCC6uLTivD4ZF9WBwV2bXS2hBlVtpLr4osR7+9QgqGVGh6da2
DERMrpTVXpsbNyC8T6AaRT3v2OfiA5u76QGkOv1PFk9bui6KWCm8TP8bqmOxvn/M
Gi+/R+09RU0j1I6JQKuU6fhedxh1g8aJV4uIJIzX173P0Ot1a7YnwK1LJh2VI1U=
=zF2V
-----END PGP SIGNATURE-----

--sdDsL9XLkxeTjkSgnrFSAsk1AOVHom5Hn--
