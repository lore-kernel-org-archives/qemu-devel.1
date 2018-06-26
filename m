Received: from eggs.gnu.org ([2001:4830:134:3::10]:52259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXlJ9-0000oq-Q4
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXlJ5-0002Yp-N2
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:34:47 -0400
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-6-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <70637e9f-6fd6-a92e-0d2e-878f23460ac3@redhat.com>
Date: Tue, 26 Jun 2018 12:34:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180625115352.6889-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 5/9] s390x/tcg: properly
 implement the TOD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 25.06.2018 13:53, David Hildenbrand wrote:
> Right now, each CPU has its own TOD. Especially, the TOD will differ
> based on creation time of a CPU - e.g. when hotplugging a CPU the times
> will differ quite a lot, resulting in stall warnings in the guest.
>=20
> Let's use a single TOD by implementing our new TOD device. Prepare it
> for TOD-clock epoch extension.
>=20
> Most importantly, whenever we set the TOD, we have to update the CKC
> timer.
>=20
> Introduce "tcg_s390x.h" just like "kvm_s390x.h" for tcg specific
> function declarations that should not go into cpu.h.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/tod-qemu.c        | 46 ++++++++++++++++++++++++++++++++++----
>  hw/s390x/tod.c             | 11 +++++++++
>  include/hw/s390x/tod.h     | 19 ++++++++++++++++
>  target/s390x/cpu.c         |  7 ------
>  target/s390x/cpu.h         |  1 -
>  target/s390x/internal.h    | 16 -------------
>  target/s390x/misc_helper.c | 30 ++++++++++++++++++++-----
>  target/s390x/tcg_s390x.h   | 18 +++++++++++++++
>  8 files changed, 114 insertions(+), 34 deletions(-)
>  create mode 100644 target/s390x/tcg_s390x.h
>=20
> diff --git a/hw/s390x/tod-qemu.c b/hw/s390x/tod-qemu.c
> index 03ea1ce4e8..941e84693e 100644
> --- a/hw/s390x/tod-qemu.c
> +++ b/hw/s390x/tod-qemu.c
> @@ -11,19 +11,43 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/s390x/tod.h"
> +#include "qemu/timer.h"
> +#include "qemu/cutils.h"
> +#include "cpu.h"
> +#include "tcg_s390x.h"
> =20
>  static void qemu_s390_tod_get(const S390TODState *td, S390TOD *tod,
>                                Error **errp)
>  {
> -    /* FIXME */
> -    tod->high =3D 0;
> -    tod->low =3D 0;
> +    *tod =3D td->base;
> +
> +    tod->low +=3D time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +    if (tod->low < td->base.low) {
> +        tod->high++;
> +    }
>  }
> =20
>  static void qemu_s390_tod_set(S390TODState *td, const S390TOD *tod,
>                                Error **errp)
>  {
> -    /* FIXME */
> +    CPUState *cpu;
> +
> +    td->base =3D *tod;
> +
> +    td->base.low -=3D time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +    if (tod->low < td->base.low) {

Just a matter of taste, but I'd rather use "td->base.low > tod->low"
here instead (since the operations before and after the if-statement are
related to td->base).

> +        td->base.high--;
> +    }
> +
> +    /*
> +     * The TOD has been changed and we have to recalculate the CKC val=
ues
> +     * for all CPUs. We do this asynchronously, as "SET CLOCK should b=
e
> +     * issued only while all other activity on all CPUs .. has been
> +     * suspended".
> +     */
> +    CPU_FOREACH(cpu) {
> +        async_run_on_cpu(cpu, tcg_s390_tod_updated, RUN_ON_CPU_NULL);
> +    }
>  }
> =20
>  static void qemu_s390_tod_class_init(ObjectClass *oc, void *data)
> @@ -34,10 +58,24 @@ static void qemu_s390_tod_class_init(ObjectClass *o=
c, void *data)
>      tdc->set =3D qemu_s390_tod_set;
>  }
> =20
> +static void qemu_s390_tod_init(Object *obj)
> +{
> +    S390TODState *td =3D S390_TOD(obj);
> +    struct tm tm;
> +
> +    qemu_get_timedate(&tm, 0);
> +    td->base.high =3D 0;
> +    td->base.low =3D TOD_UNIX_EPOCH + (time2tod(mktimegm(&tm)) * 10000=
00000ULL);
> +    if (td->base.low < TOD_UNIX_EPOCH) {
> +        td->base.high +=3D 1;
> +    }
> +}

Nit: It would be sufficient to do this in the realize() function instead.

>  static TypeInfo qemu_s390_tod_info =3D {
>      .name =3D TYPE_QEMU_S390_TOD,
>      .parent =3D TYPE_S390_TOD,
>      .instance_size =3D sizeof(S390TODState),
> +    .instance_init =3D qemu_s390_tod_init,
>      .class_init =3D qemu_s390_tod_class_init,
>      .class_size =3D sizeof(S390TODClass),
>  };
[...]
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index dd5273949b..be341b5295 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -28,6 +28,8 @@
>  #include "qemu/timer.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> +#include "qapi/error.h"
> +#include "tcg_s390x.h"
> =20
>  #if !defined(CONFIG_USER_ONLY)
>  #include "sysemu/cpus.h"
> @@ -39,6 +41,7 @@
>  #include "hw/s390x/ioinst.h"
>  #include "hw/s390x/s390-pci-inst.h"
>  #include "hw/boards.h"
> +#include "hw/s390x/tod.h"
>  #endif
> =20
>  /* #define DEBUG_HELPER */
> @@ -138,25 +141,32 @@ void HELPER(spx)(CPUS390XState *env, uint64_t a1)
>  /* Store Clock */
>  uint64_t HELPER(stck)(CPUS390XState *env)
>  {
> -    uint64_t time;
> +    S390TODState *td =3D s390_get_todstate();
> +    S390TODClass *tdc =3D S390_TOD_GET_CLASS(td);
> +    S390TOD tod;
> =20
> -    time =3D env->tod_offset +
> -        time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> -
> -    return time;
> +    tdc->get(td, &tod, &error_abort);
> +    return tod.low;
>  }
> =20
>  /* Set Clock Comparator */
>  void HELPER(sckc)(CPUS390XState *env, uint64_t time)
>  {
> +    S390TODState *td =3D s390_get_todstate();
> +    S390TODClass *tdc =3D S390_TOD_GET_CLASS(td);
> +    S390TOD tod_base;
> +
>      if (time =3D=3D -1ULL) {
>          return;
>      }
> =20
>      env->ckc =3D time;
> =20
> +    tdc->get(td, &tod_base, &error_abort);
> +    tod_base.low -=3D time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));

So the tdc->get first adds the time2tod, and then you subtract it here
again? Can't you simply use td->base.low directly instead?

>      /* difference between origins */
> -    time -=3D env->tod_offset;
> +    time -=3D tod_base.low;
> =20
>      /* nanoseconds */
>      time =3D tod2time(time);
> @@ -164,6 +174,14 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t tim=
e)
>      timer_mod(env->tod_timer, time);
>  }

... I found only nits, so with or without my suggested modifications:

Reviewed-by: Thomas Huth <thuth@redhat.com>
