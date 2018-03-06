Received: from eggs.gnu.org ([2001:4830:134:3::10]:43996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHVo-0000Fs-6b
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHVk-0006lI-3M
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:40:32 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHVj-0006kz-SH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:40:28 -0500
Received: by mail-wr0-x241.google.com with SMTP id k9so21962802wre.9
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 10:40:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306172250.3049-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4593aa24-49cb-aeb9-aea6-f620ebac937c@amsat.org>
Date: Tue, 6 Mar 2018 15:40:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180306172250.3049-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] trace: fix ARM TrustZone PPC hwaddr type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 03/06/2018 02:22 PM, Stefan Hajnoczi wrote:
> Commit 9eb8040c2d2b ("hw/misc/tz-ppc: Model TrustZone peripheral
> protection controller") added trace events with hwaddr type arguments.
> 
> This is not allowed and leads to the following compiler errors when
> building with ./configure --enable-trace-backends=ust:
> 
>   trace-ust-all.h:11847:20: error: unknown type name ‘hwaddr’; did you mean ‘h_addr’?
>     TP_ARGS(int, n, hwaddr, offset, bool, secure, bool, user),
> 
> Generated LTTng UST tracepoint definitions cannot include declarations
> for all QEMU types and therefore docs/devel/tracing.txt requires using
> only primitive or stdint.h types.

Maybe the trace generator script can check for legal/forbidden types?

> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/trace-events | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index eb5ffcc0a8..562d9ed005 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -92,8 +92,8 @@ tz_ppc_cfg_sec_resp(int level) "TZ PPC: cfg_sec_resp = %d"
>  tz_ppc_irq_enable(int level) "TZ PPC: int_enable = %d"
>  tz_ppc_irq_clear(int level) "TZ PPC: int_clear = %d"
>  tz_ppc_update_irq(int level) "TZ PPC: setting irq line to %d"
> -tz_ppc_read_blocked(int n, hwaddr offset, bool secure, bool user) "TZ PPC: port %d offset 0x%" HWADDR_PRIx " read (secure %d user %d) blocked"
> -tz_ppc_write_blocked(int n, hwaddr offset, bool secure, bool user) "TZ PPC: port %d offset 0x%" HWADDR_PRIx " write (secure %d user %d) blocked"
> +tz_ppc_read_blocked(int n, uint64_t offset, bool secure, bool user) "TZ PPC: port %d offset 0x%" PRIx64 " read (secure %d user %d) blocked"
> +tz_ppc_write_blocked(int n, uint64_t offset, bool secure, bool user) "TZ PPC: port %d offset 0x%" PRIx64 " write (secure %d user %d) blocked"
>  
>  # hw/misc/iotkit-secctl.c
>  iotkit_secctl_s_read(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl S regs read: offset 0x%x data 0x%" PRIx64 " size %u"
> 
