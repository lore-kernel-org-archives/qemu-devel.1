Received: from eggs.gnu.org ([209.51.188.92]:56525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIh1R-0007z7-Qm
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIgvG-0003AD-Fe
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:56:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIgvG-00039e-9W
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:56:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so17377936wrx.10
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 14:56:21 -0700 (PDT)
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <edbaa0c1-d7ae-11a7-2ada-e3c5f4ca7c8a@redhat.com>
Date: Mon, 22 Apr 2019 23:56:18 +0200
MIME-Version: 1.0
In-Reply-To: <20190422210448.2488-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qtest: Move accel code to accel/qtest.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

Hi Eduardo,

On 4/22/19 11:04 PM, Eduardo Habkost wrote:
> QTest has two parts: the server (-qtest) and the accelerator
> (-machine accel=qtest).  The accelerator depends on CONFIG_POSIX
> due to its usage of sigwait(), but the server doesn't.
> 
> Move the accel code to accel/qtest.c.  Later we will disable
> compilation of accel/qtest.c on non-POSIX systems.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  accel/qtest.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  qtest.c             | 34 ----------------------------
>  accel/Makefile.objs |  1 +
>  3 files changed, 56 insertions(+), 34 deletions(-)
>  create mode 100644 accel/qtest.c
> 
> diff --git a/accel/qtest.c b/accel/qtest.c
> new file mode 100644
> index 0000000000..a02b3c26c7
> --- /dev/null
> +++ b/accel/qtest.c
> @@ -0,0 +1,55 @@
> +/*
> + * QTest accelerator code
> + *
> + * Copyright IBM, Corp. 2011
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"

Why include "qemu/module.h"?
I guess you don't need it.

> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
> +#include "sysemu/accel.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/cpus.h"
> +
> +static int qtest_init_accel(MachineState *ms)
> +{
> +    QemuOpts *opts = qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
> +                                      &error_abort);
> +    qemu_opt_set(opts, "shift", "0", &error_abort);
> +    configure_icount(opts, &error_abort);
> +    qemu_opts_del(opts);
> +    return 0;
> +}
> +
> +static void qtest_accel_class_init(ObjectClass *oc, void *data)
> +{
> +    AccelClass *ac = ACCEL_CLASS(oc);
> +    ac->name = "QTest";
> +    ac->available = qtest_available;
> +    ac->init_machine = qtest_init_accel;
> +    ac->allowed = &qtest_allowed;
> +}
> +
> +#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
> +
> +static const TypeInfo qtest_accel_type = {
> +    .name = TYPE_QTEST_ACCEL,
> +    .parent = TYPE_ACCEL,
> +    .class_init = qtest_accel_class_init,
> +};
> +
> +static void qtest_type_init(void)
> +{
> +    type_register_static(&qtest_accel_type);
> +}
> +
> +type_init(qtest_type_init);
> diff --git a/qtest.c b/qtest.c
> index 527141785f..f2e2f27778 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -749,16 +749,6 @@ static void qtest_event(void *opaque, int event)
>      }
>  }
>  
> -static int qtest_init_accel(MachineState *ms)
> -{
> -    QemuOpts *opts = qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
> -                                      &error_abort);
> -    qemu_opt_set(opts, "shift", "0", &error_abort);
> -    configure_icount(opts, &error_abort);
> -    qemu_opts_del(opts);
> -    return 0;
> -}
> -
>  void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp)
>  {
>      Chardev *chr;
> @@ -791,27 +781,3 @@ bool qtest_driver(void)
>  {
>      return qtest_chr.chr != NULL;
>  }
> -
> -static void qtest_accel_class_init(ObjectClass *oc, void *data)
> -{
> -    AccelClass *ac = ACCEL_CLASS(oc);
> -    ac->name = "QTest";
> -    ac->available = qtest_available;
> -    ac->init_machine = qtest_init_accel;
> -    ac->allowed = &qtest_allowed;
> -}
> -
> -#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
> -
> -static const TypeInfo qtest_accel_type = {
> -    .name = TYPE_QTEST_ACCEL,
> -    .parent = TYPE_ACCEL,
> -    .class_init = qtest_accel_class_init,
> -};
> -
> -static void qtest_type_init(void)
> -{
> -    type_register_static(&qtest_accel_type);
> -}
> -
> -type_init(qtest_type_init);
> diff --git a/accel/Makefile.objs b/accel/Makefile.objs
> index c3718a10c5..2a5ed46940 100644
> --- a/accel/Makefile.objs
> +++ b/accel/Makefile.objs
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_SOFTMMU) += accel.o
> +obj-$(CONFIG_SOFTMMU) += qtest.o
>  obj-$(CONFIG_KVM) += kvm/
>  obj-$(CONFIG_TCG) += tcg/
>  obj-y += stubs/
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
