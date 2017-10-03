Received: from eggs.gnu.org ([2001:4830:134:3::10]:37325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzLpo-0006JD-1k
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzLpj-0008JU-70
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:58:00 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:54687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dzLpj-0008Iy-2c
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:57:55 -0400
Received: by mail-ua0-f172.google.com with SMTP id l94so5023374ual.11
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 04:57:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642389121.3900.12320775067244184010.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642389121.3900.12320775067244184010.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 3 Oct 2017 13:57:31 +0200
Message-ID: <CABdb7345MdDY1J4gX2nh=GiSdA3Dn+-eLWXDXZ2_a9NzMJt2MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/43] windbg: hook to wrmsr operation
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

On Tue, Sep 26, 2017 at 1:04 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Inserted hook to wrmsr operation. Windows Kernel put address on KPCR struct to fs/gs (x32/x64) register. Needs catch this moment and allow windbg server handle packets.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |    3 +++
>  include/exec/windbgstub.h       |    1 +
>  target/i386/misc_helper.c       |    3 +++
>  windbgstub-utils.c              |    8 ++++++++
>  windbgstub.c                    |    8 ++++++++
>  5 files changed, 23 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index 65f336e4bf..90fb766839 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -62,4 +62,7 @@
>      _t;                                                       \
>  })
>
> +bool windbg_on_load(void);
> +void windbg_on_exit(void);
> +
>  #endif
> diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
> index 703fc26b8f..2dbf1b1f13 100755
> --- a/include/exec/windbgstub.h
> +++ b/include/exec/windbgstub.h
> @@ -15,6 +15,7 @@
>  #define WINDBG "windbg"
>  #define WINDBG_DEBUG_ON false
>
> +void windbg_try_load(void);
>  int windbg_server_start(const char *device);
>
>  #endif
> diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
> index 628f64aad5..ec1fcd2899 100644
> --- a/target/i386/misc_helper.c
> +++ b/target/i386/misc_helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "exec/address-spaces.h"
> +#include "exec/windbgstub.h"
>
>  void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
>  {
> @@ -385,6 +386,8 @@ void helper_wrmsr(CPUX86State *env)
>          /* XXX: exception? */
>          break;
>      }
> +
> +    windbg_try_load();

Most people use QEMU with KVM and won't ever hit this code. Does your
work rely on TCG only for FS/GS write interception?

If KVM is out of scope for you, you should at least make sure that
users won't expect -windbg to work with it. So either fall back to TCG
if -windbg is passed or issue a warning.

>  }
>
>  void helper_rdmsr(CPUX86State *env)
> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
> index dc5e505c63..b5fb6db3f2 100755
> --- a/windbgstub-utils.c
> +++ b/windbgstub-utils.c
> @@ -10,3 +10,11 @@
>   */
>
>  #include "exec/windbgstub-utils.h"
> +
> +bool windbg_on_load(void)
> +{
> +    return false;
> +}
> +
> +void windbg_on_exit(void)
> +{}
> diff --git a/windbgstub.c b/windbgstub.c
> index 378d1b911f..99c3ef9b14 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -39,8 +39,16 @@ static void windbg_chr_receive(void *opaque, const uint8_t *buf, int size)
>      }
>  }
>
> +void windbg_try_load(void)
> +{
> +    if (windbg_state && !windbg_state->is_loaded) {
> +        windbg_state->is_loaded = windbg_on_load();
> +    }
> +}
> +
>  static void windbg_exit(void)
>  {
> +    windbg_on_exit();
>      g_free(windbg_state);
>  }
>
>
