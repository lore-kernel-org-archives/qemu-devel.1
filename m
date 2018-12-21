Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaJ4O-0005f0-Fh
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaJ4K-0002Xb-Eb
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:34:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gaJ4I-0002TU-EK
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:34:16 -0500
References: <20181220152030.28035-1-remy.noel@blade-group.com>
	<20181220163738.GA5662@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44649c49-6d9f-a839-32f1-1cce9766da17@redhat.com>
Date: Fri, 21 Dec 2018 12:34:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181220163738.GA5662@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0cvTm023tFifx4AMvnSpFfH5qwfqaAURh"
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v4 0/2] Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0cvTm023tFifx4AMvnSpFfH5qwfqaAURh
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Message-ID: <44649c49-6d9f-a839-32f1-1cce9766da17@redhat.com>
Subject: Re: [QEMU-devel][PATCH v4 0/2] Fix concurrent
 aio_poll/set_fd_handler.
References: <20181220152030.28035-1-remy.noel@blade-group.com>
 <20181220163738.GA5662@stefanha-x1.localdomain>
In-Reply-To: <20181220163738.GA5662@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/12/18 17:37, Stefan Hajnoczi wrote:
> On Thu, Dec 20, 2018 at 04:20:28PM +0100, remy.noel@blade-group.com wro=
te:
>> From: Remy Noel <remy.noel@blade-group.com>
>>
>> It is possible for an io_poll/read/write callback to be concurrently e=
xecuted along
>> with an aio_set_fd_handlers. This can cause all sorts of problems, lik=
e
>> a NULL callback or a bad opaque pointer.
>>
>> V2:
>>     * Do not use RCU anymore as it inccurs a performance loss
>> V3:
>>     * Don't drop revents when a handler is modified [Stefan]
>> V4:
>>     * Unregister fd from ctx epoll when removing fd_handler [Paolo]
>>
>> Remy Noel (2):
>>   aio-posix: Unregister fd from ctx epoll when removing fd_handler.
>>   aio-posix: Fix concurrent aio_poll/set_fd_handler.
>>
>>  util/aio-posix.c | 90 +++++++++++++++++++++++++++++------------------=
-
>>  util/aio-win32.c | 67 ++++++++++++++++-------------------
>>  2 files changed, 84 insertions(+), 73 deletions(-)
>>
>> --=20
>> 2.19.2
>>
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

FWIW, I had missed the early version that used RCU, but lockcnt is
already very RCU-like, so not using RCU is the right thing to do.  The
difference between lockcnt and RCU is that cleanup is done by the reader
instead of a separate thread.  Because we know that reader/writer
concurrency is very rare for AioContext handlers, the tradeoffs favor
lockcnt over RCU.

Paolo


--0cvTm023tFifx4AMvnSpFfH5qwfqaAURh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlwcz6sACgkQv/vSX3jH
roP+/ggAqizsNhLP6ApRp4F14jv28xpbDSgsv5RbCwcQPlrRx4cfwHDfUVtzXY/1
nd9hIGuTv/4RZWCfo0jGxq26rYwci6gFmyzf2AmtOH9VmoNovVAjCNRcuY+ILwNv
JlZDEi1+tjneLTF3BVt8w7HIJv2d302Y1npYZSiP/wWL160sYYvlGRseEI9MpyWC
q1hhrqvX6RB/LJelvXGwLiPBEO5uIJecvJfjKbDhtrI8ytVHOkqrUoft2XBoArfd
dySsnk4fdiTt9+DBGrvfb+SydF/QBeExdSHWjdkq3AxlSHkA5Gw5/1AL46RiIVB6
D5GUWCL4TtTo5lCP4IzP0DidNGaHJA==
=Oct8
-----END PGP SIGNATURE-----

--0cvTm023tFifx4AMvnSpFfH5qwfqaAURh--
