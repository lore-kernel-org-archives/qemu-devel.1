Received: from eggs.gnu.org ([2001:4830:134:3::10]:53567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1Hpo-000522-JR
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 16:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1Hpn-0002QB-Kz
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 16:06:00 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:49030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1Hpn-0002PZ-DJ
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 16:05:59 -0400
Received: by mail-wm0-x233.google.com with SMTP id i124so17622176wmf.3
	for <qemu-devel@nongnu.org>; Sun, 08 Oct 2017 13:05:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150748304313.11627.11685667181516412731.stgit@bahia.lan>
References: <150748304313.11627.11685667181516412731.stgit@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Oct 2017 21:05:37 +0100
Message-ID: <CAFEAcA-HYzVowLcomUJRNfb+_DFKqOKuW+X5kZBg1S4o_9pbyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr: introduce
 SPAPR_MACHINE_NOASSERT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 8 October 2017 at 18:17, Greg Kurz <groug@kaod.org> wrote:
> A spapr-cpu-core device can only be plugged into a pseries machine. This
> is checked in spapr_cpu_core_realize() with object_dynamic_cast() instead
> of the usual SPAPR_MACHINE() macro because we don't want QEMU to abort.
>
> This patch moves the gory details to a SPAPR_MACHINE_NOASSERT() macro
> that acts like the SPAPR_MACHINE() one, except it returns NULL instead
> of aborting if its argument doesn't point to a pseries machine type.
>
> This is done for two reasons:
> - it makes the code nicer
> - it may be used by other pseries-specific devices like PHBs for example
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_cpu_core.c |    7 +++----
>  include/hw/ppc/spapr.h  |    3 +++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 37beb56e8b18..5fde07614218 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -199,7 +199,7 @@ error:
>
>  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>  {
> -    sPAPRMachineState *spapr;
> +    sPAPRMachineState *spapr = SPAPR_MACHINE_NOASSERT(qdev_get_machine());
>      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc = CPU_CORE(OBJECT(dev));
> @@ -209,9 +209,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>      void *obj;
>      int i, j;
>
> -    spapr = (sPAPRMachineState *) qdev_get_machine();
> -    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
> -        error_setg(errp, "spapr-cpu-core needs a pseries machine");
> +    if (!spapr) {
> +        error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine");
>          return;
>      }
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c1b365f56431..4933da8083df 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -43,6 +43,9 @@ typedef struct sPAPRMachineClass sPAPRMachineClass;
>  #define SPAPR_MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(sPAPRMachineClass, klass, TYPE_SPAPR_MACHINE)
>
> +#define SPAPR_MACHINE_NOASSERT(obj) \
> +    ((sPAPRMachineState *) object_dynamic_cast(obj, TYPE_SPAPR_MACHINE))
> +

I don't think this is a great idea. Doing things with pointers
that might not be of the right type should be obvious, not hidden
under macros. An opencoded call to object_dynamic_cast is how the
rest of the codebase does this; it's a bit of a weird way
to write "isinstance()" but there you go. If we want to
improve the way we write this sort of thing we should do
so as a general improvement to the QOM APIs and conventions,
not just a single thing in SPAPR code.

thanks
-- PMM
