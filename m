Received: from eggs.gnu.org ([2001:4830:134:3::10]:40999)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dpDZv-0003Qk-NO
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dpDZq-00040x-PU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:07:43 -0400
References: <1504613972-15847-1-git-send-email-peter.maydell@linaro.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <9daeb0c9-b1b3-66d4-2b0c-77affb449efd@gmx.com>
Date: Tue, 5 Sep 2017 14:57:18 +0200
MIME-Version: 1.0
In-Reply-To: <1504613972-15847-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iTaeI2rF1bX5llqKJ40IrkEEUW83P4TL0"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] util/qemu-thread-posix.c:
 Replace OS ifdefs with CONFIG_HAVE_SEM_TIMEDWAIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iTaeI2rF1bX5llqKJ40IrkEEUW83P4TL0
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: patches@linaro.org
Message-ID: <9daeb0c9-b1b3-66d4-2b0c-77affb449efd@gmx.com>
Subject: Re: [Qemu-trivial] [PATCH] util/qemu-thread-posix.c: Replace OS
 ifdefs with CONFIG_HAVE_SEM_TIMEDWAIT
References: <1504613972-15847-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504613972-15847-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.09.2017 14:19, Peter Maydell wrote:
> In qemu-thread-posix.c we have two implementations of the
> various qemu_sem_* functions, one of which uses native POSIX
> sem_* and the other of which emulates them with pthread conditions.
> This is necessary because not all our host OSes support
> sem_timedwait().
>=20
> Instead of a hard-coded list of OSes which don't implement
> sem_timedwait(), which gets out of date, make configure
> test for the presence of the function and set a new
> CONFIG_HAVE_SEM_TIMEDWAIT appropriately.
>=20
> In particular, newer NetBSDs have sem_timedwait(), so this
> commit will switch them over to using it. OSX still does
> not have an implementation.
>=20

The NetBSD part looks fine. It builds fine on NetBSD/amd64 8.99.2. All
tests pass (with disabled PaX MPROTECT).

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Kamil Rytarowski <n54@gmx.com>

> ---
> It would be nice to gradually reduce the number of places
> we do per-OS ifdeffery in favour of checking for the specific
> feature we care about in each case...
> Tested on Linux, NetBSD, OSX.
>=20
>  configure                   | 15 +++++++++++++++
>  include/qemu/thread-posix.h |  2 +-
>  util/qemu-thread-posix.c    | 10 +++++-----
>  3 files changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/configure b/configure
> index fb7e34a..aa8d4d9 100755
> --- a/configure
> +++ b/configure
> @@ -4448,6 +4448,18 @@ if compile_prog "" "" ; then
>  fi
> =20
>  ##########################################
> +# check if we have sem_timedwait
> +
> +sem_timedwait=3Dno
> +cat > $TMPC << EOF
> +#include <semaphore.h>
> +int main(void) { return sem_timedwait(0, 0); }
> +EOF
> +if compile_prog "" "" ; then
> +    sem_timedwait=3Dyes
> +fi
> +
> +##########################################
>  # check if trace backend exists
> =20
>  $python "$source_path/scripts/tracetool.py" "--backends=3D$trace_backe=
nds" --check-backends  > /dev/null 2> /dev/null
> @@ -5680,6 +5692,9 @@ fi
>  if test "$inotify1" =3D "yes" ; then
>    echo "CONFIG_INOTIFY1=3Dy" >> $config_host_mak
>  fi
> +if test "$sem_timedwait" =3D "yes" ; then
> +  echo "CONFIG_SEM_TIMEDWAIT=3Dy" >> $config_host_mak
> +fi
>  if test "$byteswap_h" =3D "yes" ; then
>    echo "CONFIG_BYTESWAP_H=3Dy" >> $config_host_mak
>  fi
> diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
> index e5e3a0f..f4296d3 100644
> --- a/include/qemu/thread-posix.h
> +++ b/include/qemu/thread-posix.h
> @@ -21,7 +21,7 @@ struct QemuCond {
>  };
> =20
>  struct QemuSemaphore {
> -#if defined(__APPLE__) || defined(__NetBSD__)
> +#ifndef CONFIG_SEM_TIMEDWAIT
>      pthread_mutex_t lock;
>      pthread_cond_t cond;
>      unsigned int count;
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 4e95d27..7306475 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -168,7 +168,7 @@ void qemu_sem_init(QemuSemaphore *sem, int init)
>  {
>      int rc;
> =20
> -#if defined(__APPLE__) || defined(__NetBSD__)
> +#ifndef CONFIG_SEM_TIMEDWAIT
>      rc =3D pthread_mutex_init(&sem->lock, NULL);
>      if (rc !=3D 0) {
>          error_exit(rc, __func__);
> @@ -196,7 +196,7 @@ void qemu_sem_destroy(QemuSemaphore *sem)
> =20
>      assert(sem->initialized);
>      sem->initialized =3D false;
> -#if defined(__APPLE__) || defined(__NetBSD__)
> +#ifndef CONFIG_SEM_TIMEDWAIT
>      rc =3D pthread_cond_destroy(&sem->cond);
>      if (rc < 0) {
>          error_exit(rc, __func__);
> @@ -218,7 +218,7 @@ void qemu_sem_post(QemuSemaphore *sem)
>      int rc;
> =20
>      assert(sem->initialized);
> -#if defined(__APPLE__) || defined(__NetBSD__)
> +#ifndef CONFIG_SEM_TIMEDWAIT
>      pthread_mutex_lock(&sem->lock);
>      if (sem->count =3D=3D UINT_MAX) {
>          rc =3D EINVAL;
> @@ -256,7 +256,7 @@ int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
>      struct timespec ts;
> =20
>      assert(sem->initialized);
> -#if defined(__APPLE__) || defined(__NetBSD__)
> +#ifndef CONFIG_SEM_TIMEDWAIT
>      rc =3D 0;
>      compute_abs_deadline(&ts, ms);
>      pthread_mutex_lock(&sem->lock);
> @@ -304,7 +304,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
>      int rc;
> =20
>      assert(sem->initialized);
> -#if defined(__APPLE__) || defined(__NetBSD__)
> +#ifndef CONFIG_SEM_TIMEDWAIT
>      pthread_mutex_lock(&sem->lock);
>      while (sem->count =3D=3D 0) {
>          rc =3D pthread_cond_wait(&sem->cond, &sem->lock);
>=20



--iTaeI2rF1bX5llqKJ40IrkEEUW83P4TL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrp81AAoJEEuzCOmwLnZs6q0QAI573EKu8J7jXS1CqfBK/gFv
y2AdD4lX13hS6z5gGjSewKq7QaSwUl9w04KPZyhpeUV8Dj2FkPQgXlQp+bS5E7eL
20j59Ripug1xsH0TxW6HQ9jxELhjz982JtgYP6M9vKE0AxPN35l4Nm4S6wQ0UDE/
r+RrHOI31lkRXcFfqYrCh8uZwTA/mJYjcXfETOykF+/hDOnHfMbbcUqFFS7rI1Wv
dRQX+2/60SXoxlQoAKkwl5qoPWXEIE1I9W3tjQc6pGA5kgKU7uHow9GqffoPpxrw
blIsJIjigD1C6Ft8FlA9FZYqK+cLHDBxusdB0PBb8TezbDzzKXWhPUDexMV+neKg
7KN53il5/1lYhiSfU9hnm+QPPzWZla2ZVqJVndvaro8F45pxmDN78v3Xhti+56OV
nJdlQvihOs0sI6AC+ukYdnSux3AEDJt9S+fGbOdS8CYevrHCMExB/mlscmwYihZV
bt/y/Je5wP1y032X0fPMJLjU/nRoUcex4R4YpTF68hq9hpVsB99opkkyFyqku8ew
mfPeGnBEtMz1b1aSGwfHAxpcwkEdhE9cRxRSPGpcM5uevUu7Kaf1REVGI4w9T3Ra
kc6ViMJuHQzG3l1j47IheimH1ccuCpD5jrFuuxiCweSEtgBZUssLX5sTvuejM9+9
cwxD61az1nz4qsezIfVW
=4oPD
-----END PGP SIGNATURE-----

--iTaeI2rF1bX5llqKJ40IrkEEUW83P4TL0--
