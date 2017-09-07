Received: from eggs.gnu.org ([2001:4830:134:3::10]:40576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dppvR-0006ki-Ub
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dppvM-00062s-4Y
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dppvL-00062c-Sr
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:04:24 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-8-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3f858041-2cc1-7beb-78bc-d43c3b42b6ab@redhat.com>
Date: Thu, 7 Sep 2017 08:04:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/19] s390x: move two function
 declarations to s390-virtio-ccw.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 04.09.2017 17:43, David Hildenbrand wrote:
> We can also drop the extern. Fix up includes.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/hw/s390x/s390-virtio-ccw.h | 3 +++
>  target/s390x/cpu.h                 | 2 --
>  target/s390x/diag.c                | 1 +
>  target/s390x/interrupt.c           | 3 +++
>  4 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390=
-virtio-ccw.h
> index 41a9d2862b..42f2ccdb43 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -56,4 +56,7 @@ bool gs_allowed(void);
>   */
>  bool css_migration_enabled(void);
> =20
> +S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
> +void subsystem_reset(void);
> +
>  #endif
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 2343f2f1f7..6c0abb9894 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -720,8 +720,6 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr,=
 uint8_t ar, void *hostbuf,
> =20
> =20
>  /* outside of target/s390x/ */
> -S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
> -extern void subsystem_reset(void);
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code=
);
> =20
>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index e6b5e6de37..82a623948d 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -20,6 +20,7 @@
>  #include "hw/watchdog/wdt_diag288.h"
>  #include "sysemu/cpus.h"
>  #include "hw/s390x/ipl.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> =20
>  static int modified_clear_reset(S390CPU *cpu)
>  {
> diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
> index 058e219fe5..9aa6b89301 100644
> --- a/target/s390x/interrupt.c
> +++ b/target/s390x/interrupt.c
> @@ -15,6 +15,9 @@
>  #include "exec/exec-all.h"
>  #include "sysemu/kvm.h"
>  #include "hw/s390x/ioinst.h"
> +#if !defined(CONFIG_USER_ONLY)
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#endif
> =20
>  /* Ensure to exit the TB after this call! */
>  void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t=
 ilen)
>=20

If I listen to my gut feeling, I still think we should rather move
s390_cpu_addr2state() to cpu.c instead. It does not sound as it's really
specific to the virtio-ccw machine... Just my 0.02 =E2=82=AC

 Thomas
