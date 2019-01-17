Received: from eggs.gnu.org ([209.51.188.92]:34748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gk9Pu-0003BL-7h
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gk9Pr-0005KD-2n
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:17:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gk9Pq-00050r-6p
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:17:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so1442687wmh.4
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 07:17:09 -0800 (PST)
References: <20190117133834.7480-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <530d35a3-3efd-efcc-3ec2-a113b540b392@redhat.com>
Date: Thu, 17 Jan 2019 16:17:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190117133834.7480-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] exec.c: Use correct attrs in
 cpu_memory_rw_debug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 1/17/19 2:38 PM, Peter Maydell wrote:
> In the softmmu version of cpu_memory_rw_debug(), we ask the
> CPU for the attributes to use for the virtual memory access,
> and we correctly use those to identify the address space
> index. However, we were not passing them in to the
> address_space_write_rom() and address_space_rw() functions.
> 
> The effect of this was that a memory access from the gdbstub
> to a device which had behaviour that was sensitive to the
> memory attributes (such as some ARMv8M NVIC registers) was
> incorrectly always performed as if non-secure, rather than
> using the right security state for the CPU's current state.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1812091
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  exec.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 6e875f0640a..2f0f40b0be6 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3881,12 +3881,10 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
>          phys_addr += (addr & ~TARGET_PAGE_MASK);
>          if (is_write) {
>              address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
> -                                    MEMTXATTRS_UNSPECIFIED,
> -                                    buf, l);
> +                                    attrs, buf, l);
>          } else {
>              address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
> -                             MEMTXATTRS_UNSPECIFIED,
> -                             buf, l, 0);
> +                             attrs, buf, l, 0);
>          }
>          len -= l;
>          buf += l;
> 
