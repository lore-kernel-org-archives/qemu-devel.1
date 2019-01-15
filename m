Received: from eggs.gnu.org ([209.51.188.92]:55550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gjSaT-00023v-Oo
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gjSOk-0002Tu-K2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:21:11 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e]:45838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gjSOk-0002TH-Em
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:21:10 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id n78so1331491yba.12
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 09:21:09 -0800 (PST)
MIME-Version: 1.0
References: <CAMo8BfKWwT13TkBJ-C_kwYCkTcYY_Tq1vvGzanCzeDBRgTUzeg@mail.gmail.com>
	<20190115145117.GA4535@flamenco>
In-Reply-To: <20190115145117.GA4535@flamenco>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 15 Jan 2019 09:20:57 -0800
Message-ID: <CAMo8BfJ6zVMucPyFiEK47MYaAxc+c0OTe_a8DhqWYQG5BH2WSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MTTCG qemu-softmmu aborted on watchpoint hit by
 atomic instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, Jan 15, 2019 at 6:51 AM Emilio G. Cota <cota@braap.org> wrote:
> Can you please try the appended?
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 870027d435..a5258bcbc8 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -266,6 +266,9 @@ void cpu_exec_step_atomic(CPUState *cpu)
>  #ifndef CONFIG_SOFTMMU
>          tcg_debug_assert(!have_mmap_lock());
>  #endif
> +        if (qemu_mutex_iothread_locked()) {
> +            qemu_mutex_unlock_iothread();
> +        }
>          assert_no_pages_locked();
>      }

It works, thank you!
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
