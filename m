Received: from eggs.gnu.org ([2001:4830:134:3::10]:36733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnSl4-0003IJ-VV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnSl1-00059H-SW
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:23:42 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnSl1-000598-Lf
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:23:39 -0400
Received: by mail-wm0-x22c.google.com with SMTP id v186so44583219wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 09:23:39 -0700 (PDT)
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-5-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170303131113.25898-5-pbonzini@redhat.com>
Date: Mon, 13 Mar 2017 16:23:53 +0000
Message-ID: <8737ehqh5y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> This optimization is not necessary anymore, because the vCPU now drops
> the I/O thread lock even with TCG.  Drop it to simplify the code and
> avoid the "I/O thread spun for 1000 iterations" warning.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


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


--
Alex Bennée
