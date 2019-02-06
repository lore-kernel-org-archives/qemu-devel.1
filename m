Received: from eggs.gnu.org ([209.51.188.92]:54127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grQtJ-0005yb-V0
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grQtB-0008ES-V7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:21:36 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1grQt7-00080O-L8
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:21:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id t200so3720191wmt.0
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 09:21:18 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-4-cota@braap.org>
Date: Wed, 06 Feb 2019 17:21:15 +0000
Message-ID: <8736p0omt0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/73] cpu: introduce
 cpu_mutex_lock/unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> The few direct users of &cpu->lock will be converted soon.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h   | 33 +++++++++++++++++++++++++++++++
>  cpus.c              | 48 +++++++++++++++++++++++++++++++++++++++++++--
>  stubs/cpu-lock.c    | 28 ++++++++++++++++++++++++++
>  stubs/Makefile.objs |  1 +
>  4 files changed, 108 insertions(+), 2 deletions(-)
>  create mode 100644 stubs/cpu-lock.c
<snip>
> diff --git a/cpus.c b/cpus.c
> index 9a3a1d8a6a..187aed2533 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -83,6 +83,47 @@ static unsigned int throttle_percentage;
>  #define CPU_THROTTLE_PCT_MAX 99
>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>
> +/* XXX: is this really the max number of CPUs? */
> +#define CPU_LOCK_BITMAP_SIZE 2048
> +
> +/*
> + * Note: we index the bitmap with cpu->cpu_index + 1 so that the logic
> + * also works during early CPU initialization, when cpu->cpu_index is se=
t to
> + * UNASSIGNED_CPU_INDEX =3D=3D -1.
> + */
> +static __thread DECLARE_BITMAP(cpu_lock_bitmap,
> CPU_LOCK_BITMAP_SIZE);

I'm a little confused by this __thread bitmap. So by being a __thread
this is a per thread record (like __thread bool iothread_locked) of the
lock. However the test bellow:

> +
> +bool no_cpu_mutex_locked(void)
> +{
> +    return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
> +}

which is used for asserts implies the only case we care about is
ensuring one thread doesn't take multiple cpu locks (which seems
reasonable). The only other test is used by cpu_mutex_locked to see if
the current thread has locked a given CPU index.

Given that a thread can only be in two conditions:

  - no lock held
  - holding lock for cpu->index

Why the bitmap? Surely it could simply be:

  static __thread int current_cpu_lock_held;

Where:

  bool no_cpu_mutex_locked(void)
  {
      return current_cpu_lock_held =3D=3D 0;
  }

  bool cpu_mutex_locked(const CPUState *cpu)
  {
      return current_cpu_lock_held =3D=3D cpu->cpu_index + 1;
  }

And then we scale to INT_MAX cpus ;-)

If I've missed something I think the doc comment needs to be a bit more
explicit about our locking rules.

<snip>
>
> +    /* prevent deadlock with CPU mutex */
> +    g_assert(no_cpu_mutex_locked());
> +

Technically asserts don't prevent this - they are just enforcing the
locking rules otherwise we would deadlock.

--
Alex Benn=C3=A9e
