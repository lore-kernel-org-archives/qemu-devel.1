Received: from eggs.gnu.org ([2001:4830:134:3::10]:54472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPmna-00010r-IQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPmnV-0001fx-Gw
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:33:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fPmnV-0001fk-Bw
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:33:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDBD0BD9E
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 10:33:08 +0000 (UTC)
References: <20180604102752.32260-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
Date: Mon, 4 Jun 2018 12:33:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180604102752.32260-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n8EUeQ7K7DE5pA9HKB01BJqLmx4RaiRov"
Subject: Re: [Qemu-devel] [PATCH] vl: don't use RUN_STATE_PRECONFIG unless
 --preconfig is given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n8EUeQ7K7DE5pA9HKB01BJqLmx4RaiRov
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>
Message-ID: <8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
Subject: Re: [PATCH] vl: don't use RUN_STATE_PRECONFIG unless --preconfig is
 given
References: <20180604102752.32260-1-berrange@redhat.com>
In-Reply-To: <20180604102752.32260-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-04 12:27, Daniel P. Berrang=C3=A9 wrote:
> The RUN_STATE_PRECONFIG state is not supposed to be reachable unless th=
e
> --preconfig argument is given to QEMU, but when it was introduced in:
>=20
>   commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
>   Author: Igor Mammedov <imammedo@redhat.com>
>   Date:   Fri May 11 19:24:43 2018 +0200
>=20
>     cli: add --preconfig option
>=20
> The global 'current_run_state' variable was changed to have an initial
> value of RUN_STATE_PRECONFIG regardless of whether --preconfig is given=
=2E
>=20
> It then relies on the main loop to toggle it back to RUN_STATE_PRELAUNC=
H
> when --preconfig is not given. This is racy because it means that there=

> is a window where QEMU is in RUN_STATE_PRECONFIG despite --preconfig no=
t
> being given. This can be seen with the failure:
>=20
>   $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
>   QEMU 2.12.50 monitor - type 'help' for more information
>   (qemu)
>   HMP not available in preconfig state, use QMP instead
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  vl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This indeed fixes the issue that the preconfig state is reachable
without --preconfig, but it still keeps the main loop being invoked
twice (which means that e.g. HMP will process a single character before
the main loop is actually really invoked:

$ echo quit | x86_64-softmmu/qemu-system-x86_64 \
    -drive file=3D/dev/null,if=3Dide,readonly=3Don -monitor stdio
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) qqemu-system-x86_64: Initialization of device ide-hd failed:
Block node is read-only

(Note the "q" before "qemu-system-x86_64"))

(Naively,) I agree with Michal that the main loop should only be invoked
twice if --preconfig has been given, which is implemented by his patch:

http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html

Max


--n8EUeQ7K7DE5pA9HKB01BJqLmx4RaiRov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsVFWAACgkQ9AfbAGHV
z0BNBgf+IozzOERtBvhilajqgDzbHKkMZMzeuiUahQi1C/SRQFVIQa634xC9Ir9p
FaVOV2D1gwUXcu57roEjk2n9W1BP3qB80cOsKybNkiFYhjYKo9clLh/gOtAHabgl
OIzKXb48yXtn0MO4+KMkJ5hocBGSIQXTL1FVAfvkKhWToi9vWEwlJErgsM6i7685
Jzrmrf+rReyjBbtU1At7jhtm6IyRKTjoF9iWbCypAOSpbPaxqpU3VKesFk/q0+0l
GcqVBR3D1kIQmKnnjeKocUutGlCeWSKQhg8QAzi6oSdLTTqWTNUrt15mHPRhIb8i
2seQhh822kM6Cjq5au/op8ERd5ZgHw==
=KFEe
-----END PGP SIGNATURE-----

--n8EUeQ7K7DE5pA9HKB01BJqLmx4RaiRov--
