Received: from eggs.gnu.org ([2001:4830:134:3::10]:50843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef8eq-0001qz-Aq
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef8ep-0003R0-CT
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:23:24 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef8ep-0003Qr-5w
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:23:23 -0500
Received: by mail-ot0-x244.google.com with SMTP id t20so1176486ote.11
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 10:23:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123144807.5618-8-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
	<20180123144807.5618-8-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 18:23:02 +0000
Message-ID: <CAFEAcA-fs-gez_6atAue58z9V2y_DCqMVsWZR0cOyL+Nio49YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/13] linux-user: Fix sched_get/setaffinity
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 23 January 2018 at 14:48, Laurent Vivier <laurent@vivier.eu> wrote:
> From: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
> sched_get/setaffinity linux-user syscalls were missing conversions for
> little/big endian, which is hairy since longs may not be the same size
> either.
>
> For simplicity, this just introduces loops to convert bit by bit like is
> done for select.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Message-Id: <20180109201643.1479-1-samuel.thibault@ens-lyon.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

> @@ -10395,9 +10463,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                      ret = arg2;
>                  }
>
> -                if (copy_to_user(arg3, mask, ret)) {
> -                    goto efault;
> -                }
> +                ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);
>              }
>          }
>          break;

Hi -- Coverity spots that in this change, we now have a case
where we set "ret = arg2;" which then immediately is replaced
by "ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);",
making the first assignment pointless.

It looks like we're now ignoring the host filled buffer size
that is returned by sys_sched_getaffinity() and then adjusted
by this bit of code. Shouldn't we be using that value in this
new host_to_target_cpu_mask() code?

thanks
-- PMM
