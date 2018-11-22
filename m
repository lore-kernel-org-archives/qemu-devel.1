Received: from eggs.gnu.org ([2001:4830:134:3::10]:41527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPobp-0007g8-Fv
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPobl-00036F-EU
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:01:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPobl-00035n-8R
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:01:25 -0500
Date: Thu, 22 Nov 2018 13:01:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181122130120.GC2605@work-vm>
References: <20181122112947.7586-1-peter.maydell@linaro.org>
	<20181122112947.7586-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122112947.7586-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/3] monitor: Use
 address_space_read() to read memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Markus Armbruster <armbru@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
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

Yes that's nice; there's probably already a couple of CPUs that show
differences.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
