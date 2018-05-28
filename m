Received: from eggs.gnu.org ([2001:4830:134:3::10]:53436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNQaH-00086y-T1
	for qemu-devel@nongnu.org; Mon, 28 May 2018 18:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNQaE-0006Y9-PY
	for qemu-devel@nongnu.org; Mon, 28 May 2018 18:25:45 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNQaE-0006Xc-L1
	for qemu-devel@nongnu.org; Mon, 28 May 2018 18:25:42 -0400
Received: by mail-qt0-x243.google.com with SMTP id q6-v6so16442140qtn.3
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 15:25:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180528194812.31216-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8eb9adce-2888-2557-c66a-fa88ba907a2c@amsat.org>
Date: Mon, 28 May 2018 19:25:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180528194812.31216-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: SPARC "rd %tick" can be used
 by user application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Artyom Tarasenko <atar4qemu@gmail.com>

On 05/28/2018 04:48 PM, Laurent Vivier wrote:
> we have the same problem decribed in 7d6b1daedd
> ("linux-user, ppc: mftbl can be used by user application")
> for ppc in the case of sparc.
> 
> When we use an application trying to resolve a name, it hangs in
> 
>     0x00000000ff5dd40c:  rd  %tick, %o5
>     0x00000000ff5dd410:  srlx  %o5, 0x20, %o4
>     0x00000000ff5dd414:  btst  %o5, %g4
>     0x00000000ff5dd418:  be  %icc, 0xff5dd40c
> 
> because %tick is staying at 0.
> 
> As QEMU_CLOCK_VIRTUAL is not available in linux-user mode,
> simply use cpu_get_host_ticks() instead.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sparc/helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/helper.c b/target/sparc/helper.c
> index 1d854890b4..46232788c8 100644
> --- a/target/sparc/helper.c
> +++ b/target/sparc/helper.c
> @@ -67,7 +67,9 @@ uint64_t helper_tick_get_count(CPUSPARCState *env, void *opaque, int mem_idx)
>  
>      return cpu_tick_get_count(timer);
>  #else
> -    return 0;
> +    /* In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.
> +       Just pass through the host cpu clock ticks.  */
> +    return cpu_get_host_ticks();
>  #endif
>  }
>  
> 
