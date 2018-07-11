Received: from eggs.gnu.org ([2001:4830:134:3::10]:52407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdGkM-0002nu-3I
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdGkI-00008j-3q
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:09:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a35204d3-1496-3b16-57c8-82bff18b8677@amsat.org>
Date: Wed, 11 Jul 2018 12:09:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 6/6] target/arm: Allow execution
 from small regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, KONRAD Frederic <frederic.konrad@adacore.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 07/10/2018 01:00 PM, Peter Maydell wrote:
> Now that we have full support for small regions, including execution,
> we can remove the workarounds where we marked all small regions as
> non-executable for the M-profile MPU and SAU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a2ac96084e7..ed96e6c02fb 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9784,17 +9784,6 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>  
>      fi->type = ARMFault_Permission;
>      fi->level = 1;
> -    /*
> -     * Core QEMU code can't handle execution from small pages yet, so
> -     * don't try it. This way we'll get an MPU exception, rather than
> -     * eventually causing QEMU to exit in get_page_addr_code().
> -     */
> -    if (*page_size < TARGET_PAGE_SIZE && (*prot & PAGE_EXEC)) {
> -        qemu_log_mask(LOG_UNIMP,
> -                      "MPU: No support for execution from regions "
> -                      "smaller than 1K\n");
> -        *prot &= ~PAGE_EXEC;
> -    }
>      return !(*prot & (1 << access_type));
>  }
>  
> @@ -10014,18 +10003,6 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
>  
>      fi->type = ARMFault_Permission;
>      fi->level = 1;
> -    /*
> -     * Core QEMU code can't handle execution from small pages yet, so
> -     * don't try it. This means any attempted execution will generate
> -     * an MPU exception, rather than eventually causing QEMU to exit in
> -     * get_page_addr_code().
> -     */
> -    if (*is_subpage && (*prot & PAGE_EXEC)) {
> -        qemu_log_mask(LOG_UNIMP,
> -                      "MPU: No support for execution from regions "
> -                      "smaller than 1K\n");
> -        *prot &= ~PAGE_EXEC;
> -    }
>      return !(*prot & (1 << access_type));
>  }
>  
> 
