Received: from eggs.gnu.org ([2001:4830:134:3::10]:55088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIgwf-0003z4-Gq
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIgwc-0003Bv-Fk
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:53:17 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIgwc-0003Bq-Ai
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:53:14 -0400
Received: by mail-qk0-x242.google.com with SMTP id c137-v6so1323593qkg.2
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 13:53:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180515182700.31736-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aa1f3380-2a5c-b14b-92c1-2c0f74a07220@amsat.org>
Date: Tue, 15 May 2018 17:53:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180515182700.31736-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] exec.c: Initialize sa_flags passed to
 sigaction()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On 05/15/2018 03:27 PM, Peter Maydell wrote:
> Coverity points out that in the user-only version of cpu_abort() we
> call sigaction() with a partially initialized struct sigaction
> (CID 1005351). Correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/exec.c b/exec.c
> index ffa1099547..bd8833fc9d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1124,6 +1124,7 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
>          struct sigaction act;

I'd have used the more generic:

           struct sigaction act = { };

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          sigfillset(&act.sa_mask);
>          act.sa_handler = SIG_DFL;
> +        act.sa_flags = 0;
>          sigaction(SIGABRT, &act, NULL);
>      }
>  #endif
> 
