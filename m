Received: from eggs.gnu.org ([2001:4830:134:3::10]:36456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EbE-0004sl-Nj
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EbA-0007b8-Pz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:07:08 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6EbA-0007ax-Js
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:07:04 -0400
Received: by mail-wm0-x229.google.com with SMTP id u65so14742385wmu.1
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 04:07:04 -0700 (PDT)
Date: Thu, 4 May 2017 12:07:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504110700.GE32376@stefanha-x1.localdomain>
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
In-Reply-To: <20170419144219.20371-12-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/11] blockjob: use deferred_to_main_loop
 to indicate the coroutine has ended
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 04:42:19PM +0200, Paolo Bonzini wrote:
> All block jobs are using block_job_defer_to_main_loop as the final
> step just before the coroutine terminates.  At this point,
> block_job_enter should do nothing, but currently it restarts
> the freed coroutine.
>=20
> Now, the job->co states should probably be changed to an enum
> (e.g. BEFORE_START, STARTED, YIELDED, COMPLETED) subsuming
> block_job_started, job->deferred_to_main_loop and job->busy.
> For now, this patch eliminates the problematic reenter by
> removing the reset of job->deferred_to_main_loop (which served
> no purpose, as far as I could see) and checking the flag in
> block_job_enter.

The defer_to_main_loop API was originally written as a utility that
could be called multiple times, not just during the final phase of the
block job.  In practice we only use it to complete the block job.

I suggest integrating it more deeply into blockjob.c so that all jobs
automatically invoke it once and only once.  There should be a
BlockJobDriver.main_loop_finalize() callback and the defer_to_main_loop
shouldn't be callable outside blockjob.c to prevent misuse.

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCwtUAAoJEJykq7OBq3PIk0wH/2KmL1MdwrlalbEkRPhLqk8W
xsLBQB50C0vQvkEEkAxiv/DU78XOhDN/yEP1trjnUGm8UPOBVprKLhk3EcZZVni7
4DwZKmi6Eob0xZx2nA48fMDoMzpBkDebayNnjqLVFGi+loaZCmj1FUlQBhsbbled
TDW6nRYiNDh1L3IIBCQbbI80refJJJp24Z+xvmpkAm5YMfC+NkPnszFwhiUjpkAh
Amu/wXXoz7Ucp4VoRjIZvEdYREp0IN6GPjQZOaVHg9kpXpf9wOEReaBBF5LlGLWo
slUqWMqeSsJnJAOZ1L+RPX5xMrZNoLJceYDLosD4EDu8nmHCpM+QaCpvxBGmqTQ=
=DBrS
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
