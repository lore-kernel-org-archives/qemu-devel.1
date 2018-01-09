Received: from eggs.gnu.org ([2001:4830:134:3::10]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYuCe-0006Oq-69
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYuCd-0003UQ-CC
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:44:32 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYuCd-0003Tv-73
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:44:31 -0500
Received: by mail-ot0-x244.google.com with SMTP id p16so8709163otf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 05:44:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <004401d3894c$b3fc90f0$1bf5b2d0$@ru>
References: <20171116115926.16627-1-pbonzini@redhat.com>
	<20171116115926.16627-8-pbonzini@redhat.com>
	<CAFEAcA-06-VmH7Pvymo-o-HmiQ-uQ67Hs0KhWZfxswBxsfD2-g@mail.gmail.com>
	<bf4bedd9-0ef8-cff3-6153-531fba597237@redhat.com>
	<CAFEAcA9Rnd3gtrHb389e6fOEAae4aLhJnQWU-vKyzTM4o-riOQ@mail.gmail.com>
	<001b01d361e9$d46ace40$7d406ac0$@ru>
	<CAFEAcA8NGnmG_8SipvPN5_dPhokH2zZAXykN2KiW10XhB-9xXQ@mail.gmail.com>
	<CAFEAcA9PUOyK_vEnMKJkZV5s7o4zHDRedUY7z0ZH0i5ULEGzwg@mail.gmail.com>
	<004401d3894c$b3fc90f0$1bf5b2d0$@ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 13:44:09 +0000
Message-ID: <CAFEAcA8GiMDyFU4j3OvZ7F=fXk93B4447RQnpp+9cHWUGMp7Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/11] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 9 January 2018 at 13:21, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> I tried to get some logs with the following code.
> It prints that there was an exception 5 and it was overwritten by the standard code.
> Fixed code prevents this overwrite.
>
> I guess that one of the following is true:
>  - unfixed version misses some exceptions
>  - fixed version processes some exceptions twice (e.g., when there is no clear exception)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 280200f..fa810f7 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -605,6 +605,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      /* Finally, check if we need to exit to the main loop.  */
>      if (unlikely(atomic_read(&cpu->exit_request)
>          || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0)))
> +        if (cpu->exception_index != -1 && cpu->exception_index != EXCP_INTERRUP
> +            qemu_log("overwriting excp_index %x\n", cpu->exception_index);
>          atomic_set(&cpu->exit_request, 0);
>          cpu->exception_index = EXCP_INTERRUPT;
>          return true;

This looks like it's just working around whatever is going on
(why should EXCP_INTERRUPT be special?). What we need to do is
find out what's actually happening here...

thanks
-- PMM
