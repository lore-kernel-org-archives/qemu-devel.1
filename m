Received: from eggs.gnu.org ([2001:4830:134:3::10]:43459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNJc8-0006pd-5v
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNJc4-0003BY-7w
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:26:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eNJc4-0003B2-18
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:26:52 -0500
Date: Fri, 8 Dec 2017 14:26:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171208142644.GA8998@stefanha-x1.localdomain>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20171208105553.12249-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-timer: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 11:55:51AM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-timer.c | 84 +++++++++++++++++++++++++++----------------------=
------
>  1 file changed, 42 insertions(+), 42 deletions(-)
>=20
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index 82d56507a2..7a99e0e336 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -192,14 +192,11 @@ bool timerlist_expired(QEMUTimerList *timer_list)
>          return false;
>      }
> =20
> -    qemu_mutex_lock(&timer_list->active_timers_lock);
> +    QEMU_LOCK_GUARD(QemuMutex, timers_guard, &timer_list->active_timers_=
lock);

It's not obvious to me that calling qemu_lock_get_ns() below with
active_timers_lock held is a good idea.  Using QEMU_WITH_LOCK() seems
like the clearer and safer option than QEMU_LOCK_GUARD().

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKqEkAAoJEJykq7OBq3PI7DIIAL6CK1DA4ew9JQboRfQ8tK92
GwmR8Nmsj3YoaGEyUG90S7BTC/fIXWmhKeFa28vaktoRmSJFXJzRSBH9GPbKctok
WRAN0FSJhm5VHwDc/rCgvWnCS6Rq75BzW2VUKDUwCzeMjUdnwoX76x6uqiIGcps7
+l0bZJeVSJXT2D49W3+DNiWc3WNV3mA50OK0F8BoWj5/I/LyMCyFH2Xoe8OgeFoq
nOgVYegQi7l1dhpKSFbS877SJUfPTV9HF7fxhmtXLRzldUeHeKnEzj6p7mrtkQ2+
ivEfAKbP0lFNsiF804RVbKTKh/XqQBzIkOoxUPyqu+eCumvfRIwRFxdrXqHxTbc=
=oPwW
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
