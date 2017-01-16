Received: from eggs.gnu.org ([2001:4830:134:3::10]:60500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT8jt-0000Df-Ny
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT8jr-00036Q-Su
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:58:29 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:35566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cT8jr-00036D-N1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:58:27 -0500
Received: by mail-vk0-x22c.google.com with SMTP id x75so74574541vke.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 06:58:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170105043430.3176-3-alastair@au1.ibm.com>
References: <20170105043430.3176-1-alastair@au1.ibm.com>
	<20170105043430.3176-3-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 14:58:06 +0000
Message-ID: <CAFEAcA-wDNpH3V50TaMWFUxY39oiRvHKtwgnu_7h0y+zfoPeWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 2/7] qtest: Support named interrupts
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

On 5 January 2017 at 04:34, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> The QTest framework cannot check the state of named interrupts. This patch
> adds support for them.
>
> Read actions are via callbacks, which allows for pulsed interrupts
> to be read (the polled method used for the unnamed interrupts
> cannot read pulsed interrupts as the value is reverted before the
> test sees the changes).
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  hw/core/irq.c    | 18 +++++++------
>  include/hw/irq.h | 13 +++++++---
>  qtest.c          | 57 +++++++++++++++++++++++++----------------
>  tests/libqtest.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  tests/libqtest.h | 30 ++++++++++++++++++++++
>  5 files changed, 159 insertions(+), 37 deletions(-)
>
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index 49ff2e6..75f915b 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -134,15 +134,17 @@ qemu_irq *qemu_irq_proxy(qemu_irq **target, int n)
>      return qemu_allocate_irqs(proxy_irq_handler, target, n);
>  }
>
> -void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
> +qemu_irq qemu_irq_dup(qemu_irq in)
>  {
> -    int i;
> -    qemu_irq *old_irqs = qemu_allocate_irqs(NULL, NULL, n);
> -    for (i = 0; i < n; i++) {
> -        *old_irqs[i] = *gpio_in[i];
> -        gpio_in[i]->handler = handler;
> -        gpio_in[i]->opaque = &old_irqs[i];
> -    }
> +    qemu_irq out = qemu_allocate_irq(in->handler, in->opaque, in->n);
> +    return out;
> +}
> +
> +void qemu_irq_intercept_in(qemu_irq gpio_in, qemu_irq_handler handler,
> +        void *opaque)
> +{
> +    gpio_in->handler = handler;
> +    gpio_in->opaque = opaque;
>  }
>
>  static const TypeInfo irq_type_info = {
> diff --git a/include/hw/irq.h b/include/hw/irq.h
> index 4c4c2ea..2583fd1 100644
> --- a/include/hw/irq.h
> +++ b/include/hw/irq.h
> @@ -58,8 +58,15 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
>   */
>  qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);
>
> -/* For internal use in qtest.  Similar to qemu_irq_split, but operating
> -   on an existing vector of qemu_irq.  */
> -void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
> +/**
> + * Duplicate an IRQ
> + * @param in the IRQ to deplicate
> + * @return a copy of the IRQ
> + */
> +qemu_irq qemu_irq_dup(qemu_irq in);
> +
> +/* For internal use in qtest. */
> +void qemu_irq_intercept_in(qemu_irq gpio_in, qemu_irq_handler handler,
> +        void *opaque);
>
>  #endif
> diff --git a/qtest.c b/qtest.c
> index 46b99ae..ad7e215 100644
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
> @@ -160,6 +159,8 @@ static bool qtest_opened;
>   *
>   *  IRQ raise NUM
>   *  IRQ lower NUM
> + *  IRQ_NAMED raise NAME NUM
> + *  IRQ_NAMED lower NAME NUM
>   *
>   * where NUM is an IRQ number.  For the PC, interrupts can be intercepted
>   * simply with "irq_intercept_in ioapic" (note that IRQ0 comes out with

You need to update the text here to explain what NAME is in the
same way that it describes NUM.

> @@ -243,17 +244,31 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
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

qemu_irq values aren't necessarily boolean: you can
send integers down them if you want. This will break
that by squashing the value down to 0/1.
The on-the-wire protocol with IRQ/IRQ_NAMED doesn't
support reporting an integer value, but the old code
did at least not break the device even if it wasn't able
to report the value back to the test code accurately.

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
> +            qtest_sendf(chr, "IRQ_NAMED %s %s %d\n",
> +                        level ? "raise" : "lower", data->name, n);
> +        } else {
> +            qtest_sendf(chr, "IRQ %s %d\n", level ? "raise" : "lower", n);
> +        }
> +
> +        data->last_level = level;
>      }
>  }
>
> @@ -303,23 +318,26 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          }
>
>          QLIST_FOREACH(ngl, &dev->gpios, node) {
> -            /* We don't support intercept of named GPIOs yet */
> -            if (ngl->name) {
> -                continue;
> -            }
>              if (words[0][14] == 'o') {
>                  int i;
>                  for (i = 0; i < ngl->num_out; ++i) {
> -                    qemu_irq *disconnected = g_new0(qemu_irq, 1);
> -                    qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler,
> -                                                      disconnected, i);
> +                    qtest_irq *data = g_new0(qtest_irq, 1);
> +                    data->name = ngl->name;
> +                    qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler, data,
> +                                                      i);
>
> -                    *disconnected = qdev_intercept_gpio_out(dev, icpt,
> +                    data->old_irq = qdev_intercept_gpio_out(dev, icpt,
>                                                              ngl->name, i);
>                  }
>              } else {
> -                qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
> -                                      ngl->num_in);
> +                int i;
> +                for (i = 0; i < ngl->num_in; ++i) {
> +                    qtest_irq *data = g_new0(qtest_irq, 1);
> +                    data->name = ngl->name;
> +                    data->old_irq = qemu_irq_dup(ngl->in[i]);
> +
> +                    qemu_irq_intercept_in(ngl->in[i], qtest_irq_handler, data);
> +                }
>              }
>          }
>          irq_intercept_dev = dev;
> @@ -622,8 +640,6 @@ static int qtest_can_read(void *opaque)
>
>  static void qtest_event(void *opaque, int event)
>  {
> -    int i;
> -
>      switch (event) {
>      case CHR_EVENT_OPENED:
>          /*
> @@ -632,9 +648,6 @@ static void qtest_event(void *opaque, int event)
>           * used.  Injects an extra reset even when it's not used, and
>           * that can mess up tests, e.g. -boot once.
>           */
> -        for (i = 0; i < ARRAY_SIZE(irq_levels); i++) {
> -            irq_levels[i] = 0;
> -        }
>          qemu_gettimeofday(&start_time);
>          qtest_opened = true;
>          if (qtest_log_fp) {
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 6f69752..a433c3b 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -27,6 +27,7 @@
>
>  #define MAX_IRQ 256
>  #define SOCKET_TIMEOUT 50
> +#define IRQ_KEY_LENGTH 64
>
>  QTestState *global_qtest;
>
> @@ -34,12 +35,22 @@ struct QTestState
>  {
>      int fd;
>      int qmp_fd;
> +    GHashTable *irq_handlers;
>      bool irq_level[MAX_IRQ];
>      GString *rx;
>      pid_t qemu_pid;  /* our child QEMU process */
>      bool big_endian;
>  };
>
> +typedef struct irq_action {
> +    void (*cb)(void *opaque, const char *name, int irq, bool level);

This function type gets used in several places, can we have
a typedef please? (Typedefs for functions should be of the
function type, not the function pointer, and CamelCase, eg
typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *opaque);
which you then use with "CPReadFn *readfn;".)

> +    void *opaque;
> +    const char *name;
> +    int n;
> +    bool level;

Should be int, see above; this then matches the int_levels[]
array it's replacing.

> +} irq_action;
> +
> +
>  static GHookList abrt_hooks;
>  static GList *qtest_instances;
>  static struct sigaction sigact_old;
> @@ -216,6 +227,9 @@ QTestState *qtest_init(const char *extra_args)
>
>      s->big_endian = qtest_query_target_endianness(s);
>
> +    s->irq_handlers = g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
> +            g_free);
> +
>      return s;
>  }
>
> @@ -224,6 +238,8 @@ void qtest_quit(QTestState *s)
>      qtest_instances = g_list_remove(qtest_instances, s);
>      g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE, s));
>
> +    g_hash_table_destroy(s->irq_handlers);
> +
>      /* Uninstall SIGABRT handler on last instance */
>      if (!qtest_instances) {
>          cleanup_sigabrt_handler();
> @@ -304,11 +320,35 @@ static GString *qtest_recv_line(QTestState *s)
>      return line;
>  }
>
> +void qtest_irq_attach(QTestState *s, const char *name, int irq,
> +        void (*irq_cb)(void *opaque, const char *name, int irq, bool level),
> +        void *opaque)
> +{
> +    char key[IRQ_KEY_LENGTH];
> +    irq_action *action = g_new0(irq_action, 1);
> +
> +    action->cb = irq_cb;
> +    action->name = name;
> +    action->n = irq;
> +    action->opaque = opaque;
> +    action->level = false;
> +
> +    g_assert_cmpint(snprintf(key, sizeof(key), "%s.%d",
> +            name, irq), <, sizeof(key));
> +
> +    g_hash_table_insert(s->irq_handlers, g_strdup(key), action);
> +}
> +
> +#define MAX_ACTIONS 256
>  static gchar **qtest_rsp(QTestState *s, int expected_args)
>  {
>      GString *line;
>      gchar **words;
>      int i;
> +    int action_index;
> +    int action_count = 0;
> +    bool action_raise[MAX_ACTIONS];
> +    irq_action *actions[MAX_ACTIONS];
>
>  redo:
>      line = qtest_recv_line(s);
> @@ -325,10 +365,29 @@ redo:
>          g_assert_cmpint(irq, >=, 0);
>          g_assert_cmpint(irq, <, MAX_IRQ);
>
> -        if (strcmp(words[1], "raise") == 0) {
> -            s->irq_level[irq] = true;
> -        } else {
> -            s->irq_level[irq] = false;
> +        s->irq_level[irq] = (strcmp(words[1], "raise") == 0);
> +
> +        g_strfreev(words);
> +        goto redo;
> +    } else if (strcmp(words[0], "IRQ_NAMED") == 0) {
> +        bool level;
> +        char key[IRQ_KEY_LENGTH];
> +        irq_action *action;
> +
> +        g_assert(words[1] != NULL);
> +        g_assert(words[2] != NULL);
> +        g_assert(words[3] != NULL);
> +
> +        level = (strcmp(words[1], "raise") == 0);
> +
> +        g_assert_cmpint(snprintf(key, sizeof(key), "%s.%s",
> +                        words[2], words[3]), <, sizeof(key));
> +
> +        action = g_hash_table_lookup(s->irq_handlers, key);
> +
> +        if (action) {
> +            action_raise[action_count] = level;
> +            actions[action_count++] = action;
>          }
>
>          g_strfreev(words);
> @@ -346,6 +405,17 @@ redo:
>          g_strfreev(words);
>      }
>
> +    /* Defer processing of IRQ actions until all communications have been
> +     * handled, otherwise, interrupt handler that cause further communication

"handlers"

> +     * can disrupt the communication stream
> +     */
> +    for (action_index = 0; action_index < action_count; action_index++) {
> +        irq_action *action = actions[action_index];
> +        action->cb(action->opaque, action->name, action->n,
> +                action_raise[action_index]);
> +        action->level = action_raise[action_index];
> +    }
> +
>      return words;
>  }

thanks
-- PMM
