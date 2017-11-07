Received: from eggs.gnu.org ([2001:4830:134:3::10]:46370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCPSh-0001Fh-KE
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCPSd-0006Xi-OO
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:28:07 -0500
Date: Tue, 7 Nov 2017 15:46:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171107154656.GB23535@stefanha-x1.localdomain>
References: <20171107150937.23188-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20171107150937.23188-1-slp@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] util/async: use atomic_mb_set in
 qemu_bh_cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 04:09:37PM +0100, Sergio Lopez wrote:
> Commit b7a745d added a qemu_bh_cancel call to the completion function
> as an optimization to prevent it from unnecessarily rescheduling itself.
>=20
> This completion function is scheduled from worker_thread, after setting
> the state of a ThreadPoolElement to THREAD_DONE.
>=20
> This was considered to be safe, as the completion function restarts the
> loop just after the call to qemu_bh_cancel. But, under certain access
> patterns and scheduling conditions, the loop may wrongly use a
> pre-fetched elem->state value, reading it as THREAD_QUEUED, and ending
> the completion function without having processed a pending TPE linked at
> pool->head.
>=20
> In some situations, if there are no other independent requests in the
> same aio context that could eventually trigger the scheduling of the
> completion function, the omitted TPE and all operations pending on it
> will get stuck forever.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  util/async.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAdVwAAoJEJykq7OBq3PIxbcH/ifV4fW2o0/pQKQA7nCV7zAL
8VvNAV+bzUUV63uAO+r7oo4Q2/WfNHGnHULHPyXpIOBlsuIDAG4DhsCkCXTPHIl6
FV6yboDU61qeSakpc98uQUZVC+74+P1E8p7LWlVdAFYnl474duL6cMboWpc9RkCZ
tpzzTK5SRdPHpGt7ka5F6ZuCKglm8WQakBbey15PdbIIl9gGQU1q1KMNVeHhIu6e
8Uc5E/KCgg5ciibglsKDkutcsIeDcdihcaA+WVrIKYlpYLCtzMmiCScr1Qk21wl0
d6FFYiR8djga5na1G/3gkICeqeOKY9YHX7DzykC8FrJqCsAnumB262TLXpspwg0=
=WzO3
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
