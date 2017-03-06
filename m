Received: from eggs.gnu.org ([2001:4830:134:3::10]:57853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckx6U-00037u-Ao
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckx6R-0003uV-5c
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:11:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckx6Q-0003uI-SY
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:11:23 -0500
References: <20170306071721.26708-1-ppandit@redhat.com>
	<20170306071721.26708-3-ppandit@redhat.com>
	<988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
	<alpine.LFD.2.20.1703062325370.6862@wniryva>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ba0840f-43cf-601d-f0ea-3094b935c4b0@redhat.com>
Date: Mon, 6 Mar 2017 12:11:20 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1703062325370.6862@wniryva>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hf81qaccu4e5LuihwxPhbAR64jHNM6Jki"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: allocate heap memory
 for execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hf81qaccu4e5LuihwxPhbAR64jHNM6Jki
From: Eric Blake <eblake@redhat.com>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio
 <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <8ba0840f-43cf-601d-f0ea-3094b935c4b0@redhat.com>
Subject: Re: [PATCH v2 2/2] linux-user: allocate heap memory for execve
 arguments
References: <20170306071721.26708-1-ppandit@redhat.com>
 <20170306071721.26708-3-ppandit@redhat.com>
 <988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
 <alpine.LFD.2.20.1703062325370.6862@wniryva>
In-Reply-To: <alpine.LFD.2.20.1703062325370.6862@wniryva>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 12:06 PM, P J P wrote:
> +-- On Mon, 6 Mar 2017, Eric Blake wrote --+
> | On 03/06/2017 01:17 AM, P J P wrote:
> | > Arguments passed to execve(2) call from user program could
> | > be large, allocating stack memory for them via alloca(3) call
> | > would lead to bad behaviour. Use 'g_malloc0' to allocate memory
> | > for such arguments.
> | >=20
> | > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> | > ---
> | >  linux-user/syscall.c | 7 +++++--
> | >  1 file changed, 5 insertions(+), 2 deletions(-)
> |=20
> | Is this patch alone (without 1/2) sufficient to solve the problem?  I=
f
> | so, then drop 1/2.
>=20
>   Yes, it seems to fix the issue. Still I think having ARG_MAX limit wo=
uld be=20
> good, as system exec(3) routines too impose _SC_ARG_MAX limit. I'll sen=
d a=20
> revised patch with 'g_try_new' call instead of g_malloc0.

If you impose any limit smaller than _SC_ARG_MAX, you are needlessly
limiting things.  Furthermore, _SC_ARG_MAX may not always be the same
value, depending on how the kernel was compiled.  So it's probably
asiest to just let execve() impose its own limits (and correctly report
errors to the caller when execve() fails), rather than trying to impose
limits yourself.

In short, the bug that you are fixing is not caused by the guest
requesting something beyond execve() limits, but caused by poor use of
alloca() leading to a stack overrun.  You only need to fix the bug (by
switching alloca() to heap allocation), not introduce additional ones
(by imposing arbitrary, and probably wrong, limits).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hf81qaccu4e5LuihwxPhbAR64jHNM6Jki
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvaZIAAoJEKeha0olJ0Nq0V4IAK0B6a6//L/QKoh+nialbpfQ
ha4RYc9o28Pm0QGDEmhBTUgMlaNoyxgTn2UYedF/DjH5KGfYg0dkz0Ufv0C5SEGF
FcMXzd2uuq3xHkNbVeDIW6LeLhMXejAIKLCb9yXIaf29IUm4kIwTBcd+LdcZf6ao
E9b9ARsVTe/p9TBOUyskdXVK3rURvjY7MPP9sRPUKrPW6lN0w5kjL8gjoCBHRsFM
j+rArF2Xj3iDbWPETSb1w+ycODFYGIWz9ropptSIxxRQqJgV2gvmNuoEkBI4efmC
3e8Shd5Cfuqq3NBdjyXA4Bdp/mTTwDeBgLqnxO8Y/Y4ZKNGE6eSQnA/Urf5xrHQ=
=hUmN
-----END PGP SIGNATURE-----

--hf81qaccu4e5LuihwxPhbAR64jHNM6Jki--
