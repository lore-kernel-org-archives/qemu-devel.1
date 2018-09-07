Received: from eggs.gnu.org ([2001:4830:134:3::10]:43439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyGwG-0004kf-6H
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyGwB-0001UC-GH
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:36:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyGwB-0001S8-5J
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:36:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1-v6so5949290wrt.3
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 06:36:39 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819517756.30857.1862569750260837574.stgit@pasha-ThinkPad-T60>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152819517756.30857.1862569750260837574.stgit@pasha-ThinkPad-T60>
Date: Fri, 07 Sep 2018 14:36:36 +0100
Message-ID: <87tvn1zaxn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/7] tcg: add instrumenting module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu, Richard Henderson <richard.henderson@linaro.org>


Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
>
> This is a samples of the instrumenting interface and implementation
> of some instruction tracing tasks.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  accel/tcg/translator.c    |    5 +++++
>  include/qemu/instrument.h |    7 +++++++
>  plugins/helper.h          |    1 +
>  plugins/plugins.c         |   41 +++++++++++++++++++++++++++++++++++++++=
++
>  4 files changed, 54 insertions(+)
>  create mode 100644 include/qemu/instrument.h
>  create mode 100644 plugins/helper.h
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 0f9dca9..48773ac 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -17,6 +17,7 @@
>  #include "exec/gen-icount.h"
>  #include "exec/log.h"
>  #include "exec/translator.h"
> +#include "qemu/instrument.h"
>
>  /* Pairs with tcg_clear_temp_count.
>     To be called by #TranslatorOps.{translate_insn,tb_stop} if
> @@ -89,6 +90,10 @@ void translator_loop(const TranslatorOps *ops, DisasCo=
ntextBase *db,
>              }
>          }
>
> +        if (plugins_need_before_insn(db->pc_next, cpu)) {
> +            plugins_instrument_before_insn(db->pc_next, cpu);
> +        }
> +

I don't really see the need for a plugin_need_foo call here. Can't we
just iterate over all plugins that provide a before_insn binding and
leave it at that?

If the plugin decides it doesn't want to do anything with this
particular instruction it can always bail early.

>          /* Disassemble one instruction.  The translate_insn hook should
>             update db->pc_next and db->is_jmp to indicate what should be
>             done next -- either exiting this loop or locate the start of
> diff --git a/include/qemu/instrument.h b/include/qemu/instrument.h
> new file mode 100644
> index 0000000..e8f279f
> --- /dev/null
> +++ b/include/qemu/instrument.h
> @@ -0,0 +1,7 @@
> +#ifndef INSTRUMENT_H
> +#define INSTRUMENT_H
> +
> +bool plugins_need_before_insn(target_ulong pc, CPUState *cpu);
> +void plugins_instrument_before_insn(target_ulong pc, CPUState *cpu);

Need empty inline cases for #ifndef CONFIG_PLUGINS

> +
> +#endif /* INSTRUMENT_H */
> diff --git a/plugins/helper.h b/plugins/helper.h
> new file mode 100644
> index 0000000..007b395
> --- /dev/null
> +++ b/plugins/helper.h
> @@ -0,0 +1 @@
> +DEF_HELPER_2(before_insn, void, tl, ptr)

I wonder if we should have an explicit DEF_HELPER_FLAGS_2. Looking at
the flags though:

  /* call flags */
  /* Helper does not read globals (either directly or through an exception)=
. It
     implies TCG_CALL_NO_WRITE_GLOBALS. */
  #define TCG_CALL_NO_READ_GLOBALS    0x0010
  /* Helper does not write globals */
  #define TCG_CALL_NO_WRITE_GLOBALS   0x0020
  /* Helper can be safely suppressed if the return value is not used. */
  #define TCG_CALL_NO_SIDE_EFFECTS    0x0040

  /* convenience version of most used call flags */
  #define TCG_CALL_NO_RWG         TCG_CALL_NO_READ_GLOBALS
  #define TCG_CALL_NO_WG          TCG_CALL_NO_WRITE_GLOBALS
  #define TCG_CALL_NO_SE          TCG_CALL_NO_SIDE_EFFECTS
  #define TCG_CALL_NO_RWG_SE      (TCG_CALL_NO_RWG | TCG_CALL_NO_SE)
  #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)

I guess no flags means machine state is fully consistent before we make
the helper call?

> diff --git a/plugins/plugins.c b/plugins/plugins.c
> index eabc931..5a08e71 100644
> --- a/plugins/plugins.c
> +++ b/plugins/plugins.c
> @@ -1,8 +1,13 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "cpu.h"
>  #include "qemu/error-report.h"
>  #include "qemu/plugins.h"
> +#include "qemu/instrument.h"
> +#include "tcg/tcg.h"
> +#include "tcg/tcg-op.h"
>  #include "qemu/queue.h"
> +#include "qemu/option.h"
>  #include <gmodule.h>
>
>  typedef bool (*PluginInitFunc)(const char *);
> @@ -80,6 +85,40 @@ void qemu_plugin_load(const char *filename, const char=
 *args)
>      return;
>  }
>
> +bool plugins_need_before_insn(target_ulong pc, CPUState *cpu)
> +{
> +    QemuPluginInfo *info;
> +    QLIST_FOREACH(info, &qemu_plugins, next) {
> +        if (info->needs_before_insn && info->needs_before_insn(pc, cpu))=
 {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +void plugins_instrument_before_insn(target_ulong pc, CPUState *cpu)
> +{
> +    TCGv t_pc =3D tcg_const_tl(pc);
> +    TCGv_ptr t_cpu =3D tcg_const_ptr(cpu);
> +    /* We will dispatch plugins' callbacks in our own helper below */
> +    gen_helper_before_insn(t_pc, t_cpu);
> +    tcg_temp_free(t_pc);
> +    tcg_temp_free_ptr(t_cpu);
> +}

OK I see what is happening here - but I worry about pushing off all
plugins into a single helper call with a fairly fixed amount of
information.

Would it be better to expose the generate helper API and maybe a few TCG
constants to the plugin function itself. It could then either emit
additional TCG operations or call to the helper - and deal with the
logic about if it should or shouldn't in a single call rather than doing
the need_foo call first.

Richard,

Will the TCG be smart enough to drop the pc/t_cpu variables if they are
ultimately not used by the instrument in this particular iteration?

> +
> +void helper_before_insn(target_ulong pc, void *cpu)
> +{
> +    QemuPluginInfo *info;
> +    QLIST_FOREACH(info, &qemu_plugins, next) {
> +        if (info->needs_before_insn && info->needs_before_insn(pc, cpu))=
 {
> +            if (info->before_insn) {
> +                info->before_insn(pc, cpu);
> +            }
> +        }
> +    }
> +}
> +
>  void qemu_plugins_init(void)
>  {
>      QemuPluginInfo *info;
> @@ -88,4 +127,6 @@ void qemu_plugins_init(void)
>              info->init(info->args);
>          }
>      }
> +
> +#include "exec/helper-register.h"
>  }


--
Alex Benn=C3=A9e
