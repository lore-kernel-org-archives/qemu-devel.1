Received: from eggs.gnu.org ([2001:4830:134:3::10]:45693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ePSOr-00043H-01
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ePSOm-0003qU-0j
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:14:04 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1ePSOl-0003oq-Rc
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:13:59 -0500
Received: by mail-ua0-f193.google.com with SMTP id t24so3752931uaa.13
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 04:13:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151299850672.4808.6299375638944179634.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
	<151299850672.4808.6299375638944179634.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 14 Dec 2017 13:13:56 +0100
Message-ID: <CABdb737KFsR_TbqHDFSjymC_B9BTrXd_3xw95yHSzfWMRvNH5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 05/46] windbg: added helper features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Mon, Dec 11, 2017 at 2:21 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Added some helper features for windbgstub.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |   31 +++++++++++++++++++++++++++++++
>  include/exec/windbgstub.h       |    6 ++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index 2390597f1f..4c747fa23e 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -13,7 +13,38 @@
>  #define WINDBGSTUB_UTILS_H
>
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "log.h"
> +#include "cpu.h"
>  #include "exec/windbgstub.h"
>  #include "exec/windbgkd.h"
>
> +#define WINDBG_DEBUG(...) do {             \
> +    if (WINDBG_DEBUG_ON) {                 \
> +        qemu_log(WINDBG ": " __VA_ARGS__); \
> +        qemu_log("\n");                    \
> +    }                                      \
> +} while (false)
> +
> +#define WINDBG_ERROR(...) error_report(WINDBG ": " __VA_ARGS__)
> +
> +#define FMT_ADDR "addr:0x" TARGET_FMT_lx
> +#define FMT_ERR  "Error:%d"
> +
> +#define UINT8_P(ptr) ((uint8_t *) (ptr))
> +#define PTR(var) UINT8_P(&var)
> +
> +#define sizeof_field(type, field) sizeof(((type *) NULL)->field)
> +
> +#define READ_VMEM(cpu, addr, type) ({                         \
> +    type _t;                                                  \
> +    cpu_memory_rw_debug(cpu, addr, PTR(_t), sizeof(type), 0); \
> +    _t;                                                       \
> +})
> +
> +typedef struct SizedBuf {
> +    uint8_t *data;
> +    size_t size;
> +} SizedBuf;
> +

Ah, I thought you'd remove it completely. I was thinking about
something like this (patch on top of your series):

diff --git a/include/exec/windbgstub-utils.h
b/include/exec/windbgstub-utils.h
index d3e737e031..ece1c8ce60 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -50,11 +50,6 @@
 # define ldtul_p(p) ldl_p(p)
 #endif

-typedef struct SizedBuf {
-    uint8_t *data;
-    size_t size;
-} SizedBuf;
-
 typedef struct InitedAddr {
     target_ulong addr;
     bool is_init;
@@ -97,8 +92,8 @@ void kd_api_query_memory(CPUState *cpu, PacketData
*pd);
 void kd_api_get_context_ex(CPUState *cpu, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cpu, PacketData *pd);

-SizedBuf kd_gen_exception_sc(CPUState *cpu);
-SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
+void kd_gen_exception_sc(CPUState *cpu, DBGKD_ANY_WAIT_STATE_CHANGE
*sc);
+void kd_gen_load_symbols_sc(CPUState *cpu,
DBGKD_ANY_WAIT_STATE_CHANGE *sc);

 bool windbg_on_load(void);

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index c38bfa7448..6c42b95fe9 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -1184,40 +1184,25 @@ static void kd_init_state_change(CPUState
*cpu,
     }
 }

-SizedBuf kd_gen_exception_sc(CPUState *cpu)
+void kd_gen_exception_sc(CPUState *cpu, DBGKD_ANY_WAIT_STATE_CHANGE
*sc)
 {
     CPUArchState *env = cpu->env_ptr;
-    DBGKD_ANY_WAIT_STATE_CHANGE *sc;
     DBGKM_EXCEPTION_RECORD64 *exc;
-    SizedBuf buf;

-    buf.size = sizeof(DBGKD_ANY_WAIT_STATE_CHANGE) + sizeof(int);
-    buf.data = g_malloc0(buf.size);
-    sc = (DBGKD_ANY_WAIT_STATE_CHANGE *) buf.data;
     exc = &sc->u.Exception.ExceptionRecord;
     kd_init_state_change(cpu, sc);

     stl_p(&sc->NewState, DbgKdExceptionStateChange);
     stl_p(&exc->ExceptionCode, 0x80000003);
     sttul_p(&exc->ExceptionAddress, env->eip);
-
-    return buf;
 }

-SizedBuf kd_gen_load_symbols_sc(CPUState *cpu)
+void kd_gen_load_symbols_sc(CPUState *cpu,
DBGKD_ANY_WAIT_STATE_CHANGE *sc)
 {
-    DBGKD_ANY_WAIT_STATE_CHANGE *sc;
-    SizedBuf buf;
-
-    buf.size = sizeof(DBGKD_ANY_WAIT_STATE_CHANGE);
-    buf.data = g_malloc0(buf.size);
-    sc = (DBGKD_ANY_WAIT_STATE_CHANGE *) buf.data;
     kd_init_state_change(cpu, sc);

     stl_p(&sc->NewState, DbgKdLoadSymbolsStateChange);
     stl_p(&sc->u.LoadSymbols.PathNameLength, 0);
-
-    return buf;
 }

 #endif
diff --git a/windbgstub.c b/windbgstub.c
index a458b962de..d8712af103 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -117,9 +117,15 @@ static void windbg_send_control_packet(uint16_t
type)

 static void windbg_bp_handler(CPUState *cpu)
 {
-    SizedBuf buf = kd_gen_exception_sc(cpu);
-    windbg_send_data_packet(buf.data, buf.size,
PACKET_TYPE_KD_STATE_CHANGE64);
-    g_free(buf.data);
+    struct {
+        DBGKD_ANY_WAIT_STATE_CHANGE sc;
+        int extra;
+    } sc_with_extra;
+
+    memset(&sc_with_extra, 0, sizeof(sc_with_extra));
+    kd_gen_exception_sc(cpu, &sc_with_extra.sc);
+    windbg_send_data_packet((uint8_t *)&sc_with_extra,
sizeof(sc_with_extra),
+                            PACKET_TYPE_KD_STATE_CHANGE64);
 }

 static void windbg_vm_stop(void)
@@ -264,6 +270,8 @@ static void
windbg_process_data_packet(ParsingContext *ctx)

 static void windbg_process_control_packet(ParsingContext *ctx)
 {
+    DBGKD_ANY_WAIT_STATE_CHANGE sc;
+
     switch (ctx->packet.PacketType) {
     case PACKET_TYPE_KD_ACKNOWLEDGE:
         break;
@@ -273,10 +281,10 @@ static void
windbg_process_control_packet(ParsingContext *ctx)
         windbg_send_control_packet(ctx->packet.PacketType);
         windbg_state->ctrl_packet_id = INITIAL_PACKET_ID;

-        SizedBuf buf = kd_gen_load_symbols_sc(qemu_get_cpu(0));
-        windbg_send_data_packet(buf.data, buf.size,
+        memset(&sc, 0, sizeof(sc));
+        kd_gen_load_symbols_sc(qemu_get_cpu(0), &sc);
+        windbg_send_data_packet((uint8_t *)&sc, sizeof(sc),
                                 PACKET_TYPE_KD_STATE_CHANGE64);
-        g_free(buf.data);
         break;
     }
     default:



>  #endif
> diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
> index 1a6e1cc6e5..21bc552e58 100755
> --- a/include/exec/windbgstub.h
> +++ b/include/exec/windbgstub.h
> @@ -12,6 +12,12 @@
>  #ifndef WINDBGSTUB_H
>  #define WINDBGSTUB_H
>
> +#define WINDBG "windbg"
> +
> +#ifndef WINDBG_DEBUG_ON
> +#define WINDBG_DEBUG_ON false
> +#endif
> +
>  int windbg_server_start(const char *device);
>
>  #endif
>
