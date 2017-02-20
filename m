Received: from eggs.gnu.org ([2001:4830:134:3::10]:49248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfoqd-0007pr-LA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfoqZ-0007cD-Kx
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:21:51 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cfoqZ-0007bv-F1
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:21:47 -0500
Received: by mail-wr0-x244.google.com with SMTP id s27so2987060wrb.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 06:21:47 -0800 (PST)
Date: Mon, 20 Feb 2017 14:21:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170220142143.GI21255@stefanha-x1.localdomain>
References: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Content-Disposition: inline
In-Reply-To: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v9 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, rakesh.ranjan@veritas.com, venkatesha.mg@veritas.com, Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com


--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 19, 2017 at 02:30:53PM -0800, Ashish Mittal wrote:
> v9 changelog:
> (1) Fixes for all the review comments from v8. I have left the definition
>     of VXHS_UUID_DEF unchanged pending a better suggestion.

If I understand correctly libvxhs has a global instance ID for choosing
the SSL client certificate.

I would get rid of iio_init()/iio_fini() or at least avoid passing in
anything besides int32_t version.  Let iio_open() take an instance ID
and iio_cb_t callback.

This gives applications more flexibility.  For example, you can write a
utility that copies data from instance A disk#1 to instance B disk#2.
Or an application with special requirements can process callbacks for
different disks in different iio_cb_t functions if it wishes.  Today
both of these things are not possible due to iio_init().

QEMU block drivers must keep in mind:

1. There may be more than one BlockDriverState (i.e. multiple disks for
   a VM).

2. Each BlockDriverState may be access from a different thread (i.e.
   it's best if the library avoids global state so thread-safety is
   easy).

So avoid the global iio_init() call.  Pass parameters into iio_open()
=66rom the QEMU command-line instead of using globals.

If the library wants to pool global resources like SSL/TCP connections
it can do that internally in a thread-safe way.  There's no need to make
configuration global via iio_init().

Stefan

--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYqvt3AAoJEJykq7OBq3PIaIcH/0y1AbEcYMKQSlw3Di5Q4SNM
GBrG5wSZH9ZkzVzhOPC9WJzk6kyH62FZo6luPng3Sg0f3NJiMDr49K5EqwlDdWbQ
8KPHQpfxx1gtyCquSj2LuvkxmVzh2ut5BDy3u9B2KbI8ouUOyILwf2jXyo0a7ZlC
T/0iooZOZUpGzGQfUlmUwxlwgydEdpJzEFe7PQPbkx62+afAxFOd6XoJQu3adWjf
MaqR8oWlcrdjHEfHB/4lpXOUsw0ZTYPqce/Lnb9dsQ58zu74oNjAlaqC3Jpz88qJ
WYXsJVCB2ib3kDA44Ye3XjQZycKlpuVwmXg+O+QIINB3AbCZxxpOszTdLaM4CFY=
=XTRk
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--
