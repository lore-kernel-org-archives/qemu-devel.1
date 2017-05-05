Received: from eggs.gnu.org ([2001:4830:134:3::10]:60978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6ezI-0007sO-Kd
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6ezF-0007Nu-Cr
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6ezF-0007NO-4d
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:17:41 -0400
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<20170505103822.20641-9-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d3cca3f-3a95-0beb-9342-428b96816173@redhat.com>
Date: Fri, 5 May 2017 17:17:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170505103822.20641-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v1 8/9] util/qemu-thread-*: add
 qemu_lock, locked and unlock trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org



On 05/05/2017 12:38, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Can you look at the patch I just sent a pull request for?  It only has
locked and unlocked trace events, you can add lock on top.

Paolo

> ---
>  include/qemu/thread.h    |  7 +++++--
>  util/qemu-thread-posix.c | 11 +++++++++--
>  util/trace-events        |  5 +++++
>  3 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 9910f49b3a..ddea4990c0 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -22,9 +22,12 @@ typedef struct QemuThread QemuThread;
> =20
>  void qemu_mutex_init(QemuMutex *mutex);
>  void qemu_mutex_destroy(QemuMutex *mutex);
> -void qemu_mutex_lock(QemuMutex *mutex);
>  int qemu_mutex_trylock(QemuMutex *mutex);
> -void qemu_mutex_unlock(QemuMutex *mutex);
> +void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const in=
t line);
> +void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const =
int line);
> +
> +#define qemu_mutex_lock(mutex) qemu_mutex_lock_impl(mutex, __FILE__, _=
_LINE__)
> +#define qemu_mutex_unlock(mutex) qemu_mutex_unlock_impl(mutex, __FILE_=
_, __LINE__)
> =20
>  /* Prototypes for other functions are in thread-posix.h/thread-win32.h=
.  */
>  void qemu_rec_mutex_init(QemuRecMutex *mutex);
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 73e3a0edf5..9da1c9e756 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -14,6 +14,7 @@
>  #include "qemu/thread.h"
>  #include "qemu/atomic.h"
>  #include "qemu/notify.h"
> +#include "trace.h"
> =20
>  static bool name_threads;
> =20
> @@ -53,13 +54,17 @@ void qemu_mutex_destroy(QemuMutex *mutex)
>          error_exit(err, __func__);
>  }
> =20
> -void qemu_mutex_lock(QemuMutex *mutex)
> +void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const in=
t line)
>  {
>      int err;
> =20
> +    trace_qemu_mutex_lock(mutex, file, line);
> +
>      err =3D pthread_mutex_lock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> +
> +    trace_qemu_mutex_locked(mutex, file, line);
>  }
> =20
>  int qemu_mutex_trylock(QemuMutex *mutex)
> @@ -67,13 +72,15 @@ int qemu_mutex_trylock(QemuMutex *mutex)
>      return pthread_mutex_trylock(&mutex->lock);
>  }
> =20
> -void qemu_mutex_unlock(QemuMutex *mutex)
> +void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const =
int line)
>  {
>      int err;
> =20
>      err =3D pthread_mutex_unlock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> +
> +    trace_qemu_mutex_unlock(mutex, file, line);
>  }
> =20
>  void qemu_rec_mutex_init(QemuRecMutex *mutex)
> diff --git a/util/trace-events b/util/trace-events
> index b44ef4f895..972d7e1786 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -34,6 +34,11 @@ qemu_co_mutex_lock_return(void *mutex, void *self) "=
mutex %p self %p"
>  qemu_co_mutex_unlock_entry(void *mutex, void *self) "mutex %p self %p"
>  qemu_co_mutex_unlock_return(void *mutex, void *self) "mutex %p self %p=
"
> =20
> +# util/qemu-thread.c
> +qemu_mutex_lock(void *mutex, const char *file, const int line) "waitin=
g on mutex %p (%s:%d)"
> +qemu_mutex_locked(void *mutex, const char *file, const int line) "take=
n mutex %p (%s:%d)"
> +qemu_mutex_unlock(void *mutex, const char *file, const int line) "rele=
ased mutex %p (%s:%d)"
> +
>  # util/oslib-win32.c
>  # util/oslib-posix.c
>  qemu_memalign(size_t alignment, size_t size, void *ptr) "alignment %zu=
 size %zu ptr %p"
>=20
