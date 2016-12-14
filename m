Received: from eggs.gnu.org ([2001:4830:134:3::10]:55084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHEK9-0007AR-Vd
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHEK5-0007o5-IZ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:30:41 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHEK5-0007nb-Bh
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:30:37 -0500
Received: by mail-vk0-f43.google.com with SMTP id p9so40933500vkd.3
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:30:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161202054617.6749-5-alastair@au1.ibm.com>
References: <20161202054617.6749-1-alastair@au1.ibm.com>
	<20161202054617.6749-5-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 18:29:11 +0000
Message-ID: <CAFEAcA8__YWN9f2=GDeX5ddFnV_WWknpdrUeVud9-YLu9cE0Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 4/7] qtest: Support named interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

On 2 December 2016 at 05:46, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> The QTest framework cannot work with named interrupts. This patch
> adds support for them, as well as the ability to manipulate them
> from within a test.
>
> Read actions are via callbacks, which allows for pulsed interrupts
> to be read (the polled method used for the unnamed interrupts
> cannot read pulsed interrupts as the value is reverted before the
> test sees the changes).
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

> --- a/qtest.c
> +++ b/qtest.c
> @@ -40,7 +40,6 @@ static DeviceState *irq_intercept_dev;
>  static FILE *qtest_log_fp;
>  static CharBackend qtest_chr;
>  static GString *inbuf;
> -static int irq_levels[MAX_IRQ];
>  static qemu_timeval start_time;
>  static bool qtest_opened;
>
> @@ -160,10 +159,16 @@ static bool qtest_opened;
>   *
>   *  IRQ raise NUM
>   *  IRQ lower NUM
> + *  IRQ_NAMED NAME NUM LEVEL

I think we should be consistent about the protocol here:
unnamed IRQs get 'raise' and 'lower' messages, so we should
do the same for named IRQs.

>   *
>   * where NUM is an IRQ number.  For the PC, interrupts can be intercepted
>   * simply with "irq_intercept_in ioapic" (note that IRQ0 comes out with
>   * NUM=0 even though it is remapped to GSI 2).
> + *
> + *  > irq_set NAME NUM LEVEL
> + *  < OK
> + *
> + *  Set the named input IRQ to the level (0/1)

I think adding support for raising and lowering device IRQs
should be a separate patch, as it's a different feature.
(I'm also not sure we should need it -- devices will be
wired into the system, and qtest is testing the whole
system from the point of view of the CPU. The CPU can't
arbitrarily reach in and assert a device's outgoing
interrupt line, so I'm not sure the tests should be able
to do it either.)

(Everything else below here is trivial fixes.)

>   */
>
>  static int hex2nib(char ch)
> @@ -243,17 +248,31 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
>      va_end(ap);
>  }
>
> +typedef struct qtest_irq {
> +    qemu_irq old_irq;
> +    char *name;
> +    bool last_level;
> +} qtest_irq;
> +
>  static void qtest_irq_handler(void *opaque, int n, int level)
>  {
> -    qemu_irq old_irq = *(qemu_irq *)opaque;
> -    qemu_set_irq(old_irq, level);
> +    qtest_irq *data = (qtest_irq *)opaque;
> +    level = !!level;
> +
> +    qemu_set_irq(data->old_irq, level);
>
> -    if (irq_levels[n] != level) {
> +    if (level != data->last_level) {
>          CharBackend *chr = &qtest_chr;
> -        irq_levels[n] = level;
>          qtest_send_prefix(chr);
> -        qtest_sendf(chr, "IRQ %s %d\n",
> -                    level ? "raise" : "lower", n);
> +
> +        if (data->name) {
> +            qtest_sendf(chr, "IRQ_NAMED %s %d %d\n",
> +                    data->name, n, level);
> +        } else {
> +            qtest_sendf(chr, "IRQ %s %d\n", level ? "raise" : "lower", n);
> +        }
> +
> +        data->last_level = level;
>      }
>  }
>
> @@ -289,7 +308,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          if (!dev) {
>              qtest_send_prefix(chr);
>              qtest_send(chr, "FAIL Unknown device\n");
> -           return;
> +            return;
>          }
>
>          if (irq_intercept_dev) {
> @@ -299,33 +318,73 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>              } else {
>                  qtest_send(chr, "OK\n");
>              }
> -           return;
> +            return;
>          }

Fixing whitespace issues is generally best done in a separate patch.


> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 6f69752..36b3960 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -21,12 +21,16 @@
>  #include <sys/wait.h>
>  #include <sys/un.h>
>
> +#include <glib.h>
> +

osdep.h pulls in glib for you.

>  #include "qapi/qmp/json-parser.h"
>  #include "qapi/qmp/json-streamer.h"
>  #include "qapi/qmp/qjson.h"
>
> +

Stray whitespace change.

>  #define MAX_IRQ 256
>  #define SOCKET_TIMEOUT 50
> +#define IRQ_KEY_LENGTH 64
>
>  QTestState *global_qtest;


> @@ -346,6 +408,17 @@ redo:
>          g_strfreev(words);
>      }
>
> +/* Defer processing of IRQ actions until all communications have been handled,
> + * otherwise, interrupt handler that cause further communication can disrupt
> + * the communication stream
> + */

Bad indent on this comment.

> +    for (action_index = 0; action_index < action_count; action_index++) {
> +        irq_action *action = actions[action_index];
> +        action->cb(action->opaque, action->name, action->n,
> +                action_raise[action_index]);
> +        action->level = action_raise[action_index];
> +    }
> +
>      return words;
>  }
>

>  /**
> + * irq_attach:
> + * @name: the name of the gpio list containing the IRQ
> + * @irq: The IRQ to attach to
> + * @irq_cb: The callback to execute when the interrupt changes
> + * @opaque: opaque info to pass to the callback
> + *
> + * Attach a callback to an intecepted interrupt
> + */
> +static inline void irq_attach(const char *name, int irq,
> +        void (*irq_cb)(void *opaque, const char *name, int irq, bool level),
> +        void *opaque)
> +{
> +    qtest_irq_attach(global_qtest, name, irq, irq_cb, opaque);
> +}
> +
> +/**
> + * qtest_irq_set

Comment doesn't match function name (and missing ':').

> + * Set an interrupt level
> + * @id: the device to inject interrupts for
> + * @gpiolist: the GPIO list containing the line to seh
> + * @n: the line to set within the list
> + * @level: the IRQ level
> + */
> +static inline void irq_set(const char *id, const char *gpiolist, int n,
> +        bool level)
> +{
> +    qtest_irq_set(global_qtest, id, gpiolist, n, level);
> +}
> +
> +
> +/**
>   * outb:
>   * @addr: I/O port to write to.
>   * @value: Value being written.
> --
> 2.9.3

thanks
-- PMM
