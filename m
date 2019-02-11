Received: from eggs.gnu.org ([209.51.188.92]:59463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt2ZQ-000344-T2
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt2ZN-0006df-7k
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:47:47 -0500
Date: Mon, 11 Feb 2019 11:42:31 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190211034231.GD18083@stefanha-x1.localdomain>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <20190208141122.53046-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] coroutines: generate
 wrapper code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 05:11:22PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> We have a very frequent pattern of wrapping a coroutine_fn function
> to be called from non-coroutine context:
>=20
>   - create structure to pack parameters
>   - create function to call original function taking parameters from
>     struct
>   - create wrapper, which in case of non-coroutine context will
>     create a coroutine, enter it and start poll-loop.
>
> Here is a draft of template code + example how it can be used to drop a
> lot of similar code.
>=20
> Hope someone like it except me)

My 2 cents.  Cons:

 * Synchronous poll loops are an anti-pattern.  They block all of QEMU
   with the big mutex held.  Making them easier to write is
   questionable because we should aim to have as few of these as
   possible.

 * Code generation makes the code easier to write but harder to read.
   Code is read more than written.  In this case I think open coding
   isn't too bad and I prefer it to reading a code generation script to
   understand how it works.

If we were planning to add lots more of these then I agree code
generation would help.  But in this case I'd rather not.

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYO8nAAoJEJykq7OBq3PIl5kH/3BLSvY7fH7RJ6B3r03WzNWB
hRTXd2Y5KnpnCSxEmYpvETyxRHhljoRZycuSVkhTMcCzKS1KHz/oTQWUhigZZSoH
zrJjqQIaLT1nxMBnk2xOSLGiOa+1rVNq7xKhNBLNZQBcFCH0NQf1VoQZ/epI7g2V
8K55MGMluQiOCFVs2axLIgGu7FxwLLLDvBwSkp0AOtJMonT+ks2FzX5fngOhInvi
us/axViMcrKfLSfhJHuRLi0AZjl0dYyeeYH4z3XW+rIMcDKhWEMEVf/x01TMUukF
4ASpYY292g4Gi2cJIA+5hsI2WlXN/VPrHjtEeqy6j23SO6cA9H2mtpq9ms8Ulfw=
=0X5o
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
