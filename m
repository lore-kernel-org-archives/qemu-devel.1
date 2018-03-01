Received: from eggs.gnu.org ([2001:4830:134:3::10]:60173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erQdM-0004Z2-7V
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erQdL-00049n-1S
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:00:40 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erQdK-00049J-RQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:00:38 -0500
Received: by mail-ot0-x241.google.com with SMTP id l5so5988028otf.9
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 08:00:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-6-peter.maydell@linaro.org>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-6-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 16:00:17 +0000
Message-ID: <CAFEAcA-8VnzF5CwJsbfYxUOX87zH_iLS6gM2r1e6PochemNVQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 05/19] armv7m: Forward idau
 property to CPU object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 20 February 2018 at 18:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> Create an "idau" property on the armv7m container object which
> we can forward to the CPU object. Annoyingly, we can't use
> object_property_add_alias() because the CPU object we want to
> forward to doesn't exist until the armv7m container is realized.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armv7m.h | 3 +++
>  hw/arm/armv7m.c         | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
> index 35ab757264..5c3f406ccc 100644
> --- a/include/hw/arm/armv7m.h
> +++ b/include/hw/arm/armv7m.h
> @@ -12,6 +12,7 @@
>
>  #include "hw/sysbus.h"
>  #include "hw/intc/armv7m_nvic.h"
> +#include "target/arm/idau.h"
>
>  #define TYPE_BITBAND "ARM,bitband-memory"
>  #define BITBAND(obj) OBJECT_CHECK(BitBandState, (obj), TYPE_BITBAND)
> @@ -40,6 +41,7 @@ typedef struct {
>   * + Property "memory": MemoryRegion defining the physical address space
>   *   that CPU accesses see. (The NVIC, bitbanding and other CPU-internal
>   *   devices will be automatically layered on top of this view.)
> + * + Property "idau": IDAU interface (forwarded to CPU object)
>   */
>  typedef struct ARMv7MState {
>      /*< private >*/
> @@ -58,6 +60,7 @@ typedef struct ARMv7MState {
>      char *cpu_type;
>      /* MemoryRegion the board provides to us (with its devices, RAM, etc) */
>      MemoryRegion *board_memory;
> +    Object *idau;
>  } ARMv7MState;
>
>  #endif
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index facc536b07..189066812c 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -19,6 +19,7 @@
>  #include "sysemu/qtest.h"
>  #include "qemu/error-report.h"
>  #include "exec/address-spaces.h"
> +#include "target/arm/idau.h"
>
>  /* Bitbanded IO.  Each word corresponds to a single bit.  */
>
> @@ -162,6 +163,11 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>
>      object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
>                               &error_abort);
> +    object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }

This turns out to not quite be right -- if the CPU doesn't have
the "idau" property (ie it is a v7M CPU like the cortex-m3) then
the object_property_set_link will fail. This causes 'make check'
to fail when it tries to run the M3/M4 boards with
"qemu-system-aarch64: Property '.init-svtor' not found"

The fix is to squash in this:

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 149aa07cd5..70871eb139 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -163,10 +163,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)

     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
-    object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
-        return;
+    if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
+        object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
     }
     object_property_set_uint(OBJECT(s->cpu), s->init_svtor,
"init-svtor", &err);
     if (err != NULL) {

which I propose to do in putting the patchset into target-arm.next.

Similarly for init-svtor in the patch later in this series which adds that.

thanks
-- PMM
