Received: from eggs.gnu.org ([2001:4830:134:3::10]:43861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gByPc-00029y-7q
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gByPb-0005cx-Cd
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:39:40 -0400
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
	<442bb618199daa309d3191a5ee848e659a46c0ce.1539528213.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5016919e-897c-1b64-ad9a-4721b5692455@redhat.com>
Date: Mon, 15 Oct 2018 10:39:12 +0200
MIME-Version: 1.0
In-Reply-To: <442bb618199daa309d3191a5ee848e659a46c0ce.1539528213.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] Introduce attributes to qemu timer
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 14/10/2018 16:55, Artem Pisarenko wrote:
> Attributes are simple flags, associated with individual timers for thei=
r whole lifetime.
> They intended to be used to mark individual timers for special handling=
 by various qemu features operating at qemu core level.
> Existing timer, aio and coroutine interface extended with attribute-ena=
bled variants of functions, which create/initialize timers.
>=20
> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> ---
>=20
> Notes:
>     Conversion and association between QEMUTimerAttrBit and accessor ma=
cro are dumb.
>     Maybe better alternatives exist (like QFlags in Qt framework) or ex=
isting qemu code may be reused, if any.
>     Attributes also may be better named as flags, but they looks like s=
omething volatile, whereas 'attribute' expresses constant nature better.
>=20
>  include/block/aio.h         |  50 +++++++++++++++++++-
>  include/qemu/coroutine.h    |   5 +-
>  include/qemu/timer.h        | 110 ++++++++++++++++++++++++++++++++++++=
++------
>  tests/ptimer-test-stubs.c   |   7 +--
>  util/qemu-coroutine-sleep.c |   6 ++-
>  util/qemu-timer.c           |  12 +++--
>  6 files changed, 165 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/block/aio.h b/include/block/aio.h
> index f08630c..a6be3fb 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -407,10 +407,35 @@ static inline QEMUTimer *aio_timer_new(AioContext=
 *ctx, QEMUClockType type,
>                                         int scale,
>                                         QEMUTimerCB *cb, void *opaque)
>  {
> -    return timer_new_tl(ctx->tlg.tl[type], scale, cb, opaque);
> +    return timer_new_a_tl(ctx->tlg.tl[type], scale, 0, cb, opaque);
>  }

The new function _a_tl is a bit ugly.

I would prefer to:

- only have a new timer_new_full that takes all of scale, attribute and
timerlist

- accept a NULL timerlist and default to main_loop_tlg.tl[type]

- add aio_timer_{new,init}_with_attrs

> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9801e7f..cffc2b2 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -276,7 +276,10 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
>  /**
>   * Yield the coroutine for a given duration
>   */
> -void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
> +#define qemu_co_sleep_ns(type, ns) \
> +    qemu_co_sleep_a_ns(type, 0, ns)
> +void coroutine_fn qemu_co_sleep_a_ns(QEMUClockType type, int attribute=
s,
> +                                     int64_t ns);

I wouldn't bother adding co_sleep_a_ns unless it's needed.

>  /**
>   * Yield until a file descriptor becomes readable
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 39ea907..031e3a1 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -52,6 +52,28 @@ typedef enum {
>      QEMU_CLOCK_MAX
>  } QEMUClockType;
> =20
> +/**
> + * QEMU Timer attributes:
> + *
> + * An individual timer may be assigned with one or multiple attributes=
 when
> + * initialized.
> + * Attribute is a static flag, meaning that timer has corresponding pr=
operty.
> + * Attributes are defined in QEMUTimerAttrBit enum and encoded to bit =
set,
> + * which used to initialize timer, stored to 'attributes' member and c=
an be
> + * retrieved externally with timer_get_attributes() call.
> + * Values of QEMUTimerAttrBit aren't used directly,
> + * instead each attribute in bit set accessed with QEMU_TIMER_ATTR(id)=
 macro,
> + * where 'id' is a unique part of attribute identifier.

I think QEMU_TIMER_ATTR is an unnecessary complication.  I would just
add a TIMER_ATTR_EXTERNAL constant.

Paolo
