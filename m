Received: from eggs.gnu.org ([2001:4830:134:3::10]:37648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPxUV-0003jV-VN
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPxUR-000225-Rm
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:30:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPxUR-00021v-Jv
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:30:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so10583334wru.4
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 14:30:27 -0800 (PST)
References: <20181122172653.3413-1-peter.maydell@linaro.org>
	<20181122172653.3413-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <595264a1-d9f1-010b-e2db-2b391ad6d20f@redhat.com>
Date: Thu, 22 Nov 2018 23:30:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181122172653.3413-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 2/3] monitor: Use
 address_space_read() to read memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, patches@linaro.org

On 22/11/18 18:26, Peter Maydell wrote:
> Currently monitor.c reads physical memory using
> cpu_physical_memory_read(). This effectively hard-codes
> assuming that all CPUs have the same view of physical
> memory. Switch to address_space_read() instead, which
> lets us use the AddressSpace for the CPU we're
> reading memory for (falling back to address_space_memory
> if there is no CPU, as happens with the "none" board).
> As a bonus, this allows us to detect failures to read memory.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  monitor.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor.c b/monitor.c
> index d39390c2f2f..b0e8f2c490a 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1604,7 +1604,13 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>          if (l > line_size)
>              l = line_size;
>          if (is_physical) {
> -            cpu_physical_memory_read(addr, buf, l);
> +            AddressSpace *as = cs ? cs->as : &address_space_memory;
> +            MemTxResult r = address_space_read(as, addr,
> +                                               MEMTXATTRS_UNSPECIFIED, buf, l);
> +            if (r != MEMTX_OK) {
> +                monitor_printf(mon, " Cannot access memory\n");
> +                break;
> +            }
>          } else {
>              if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
>                  monitor_printf(mon, " Cannot access memory\n");
> 
