Received: from eggs.gnu.org ([2001:4830:134:3::10]:37749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjne9-00013k-34
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjne5-0006Nz-7B
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:53:25 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1cjne4-0006Mq-Vm
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:53:21 -0500
Received: by mail-lf0-x244.google.com with SMTP id y193so6833510lfd.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 05:53:20 -0800 (PST)
Date: Fri, 3 Mar 2017 14:53:18 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170303135318.GD1009@toto>
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303131113.25898-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] main-loop: remove now unnecessary
 optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On Fri, Mar 03, 2017 at 02:11:12PM +0100, Paolo Bonzini wrote:
> This optimization is not necessary anymore, because the vCPU now drops
> the I/O thread lock even with TCG.  Drop it to simplify the code and
> avoid the "I/O thread spun for 1000 iterations" warning.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
>  vl.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index bbbf1ba..b21b57e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1884,17 +1884,14 @@ static bool main_loop_should_exit(void)
>  
>  static void main_loop(void)
>  {
> -    bool nonblocking;
> -    int last_io = 0;
>  #ifdef CONFIG_PROFILER
>      int64_t ti;
>  #endif
>      do {
> -        nonblocking = tcg_enabled() && last_io > 0;
>  #ifdef CONFIG_PROFILER
>          ti = profile_getclock();
>  #endif
> -        last_io = main_loop_wait(nonblocking);
> +        main_loop_wait(false);
>  #ifdef CONFIG_PROFILER
>          dev_time += profile_getclock() - ti;
>  #endif
> -- 
> 2.9.3
> 
> 
> 
