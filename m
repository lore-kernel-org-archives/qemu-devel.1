Received: from eggs.gnu.org ([2001:4830:134:3::10]:49702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK5Io-0001cW-HP
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK5CA-000279-6n
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:31:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gK5C4-0000NP-H2
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:31:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so14491178wrv.2
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 09:30:01 -0800 (PST)
References: <20181106163801.14474-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e2d9d1f7-4310-d8a6-f50f-c4fd833e166e@redhat.com>
Date: Tue, 6 Nov 2018 18:29:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181106163801.14474-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] target/arm: Remove workaround for
 small SAU regions
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

On 6/11/18 17:38, Peter Maydell wrote:
> Before we supported direct execution from MMIO regions, we
> implemented workarounds in commit 720424359917887c926a33d2
> which let us avoid doing so, even if the SAU or MPU region
> was less than page-sized.
> 
> Once we implemented execute-from-MMIO, we removed part
> of those workarounds in commit d4b6275df320cee76; but
> we forgot the one in get_phys_addr_pmsav8() which
> suppressed use of small SAU regions in executable regions.
> Remove that workaround now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   target/arm/helper.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 96301930cc8..ec56becc394 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10560,18 +10560,6 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
>   
>       ret = pmsav8_mpu_lookup(env, address, access_type, mmu_idx, phys_ptr,
>                               txattrs, prot, &mpu_is_subpage, fi, NULL);
> -    /*
> -     * TODO: this is a temporary hack to ignore the fact that the SAU region
> -     * is smaller than a page if this is an executable region. We never
> -     * supported small MPU regions, but we did (accidentally) allow small
> -     * SAU regions, and if we now made small SAU regions not be executable
> -     * then this would break previously working guest code. We can't
> -     * remove this until/unless we implement support for execution from
> -     * small regions.
> -     */
> -    if (*prot & PAGE_EXEC) {
> -        sattrs.subpage = false;
> -    }
>       *page_size = sattrs.subpage || mpu_is_subpage ? 1 : TARGET_PAGE_SIZE;
>       return ret;
>   }
> 
