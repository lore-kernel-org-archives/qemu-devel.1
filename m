Received: from eggs.gnu.org ([2001:4830:134:3::10]:46133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gHqmh-0004Fz-2g
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gHqmc-0005PN-J2
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:43:46 -0400
References: <20181030170353.7447-1-peter.maydell@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c386612c-b934-d770-2dd0-fdf5b451edeb@redhat.com>
Date: Wed, 31 Oct 2018 14:43:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181030170353.7447-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-3.1] hw/ppc/ppc440_uc:
 Remove dead code in sdram_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30/10/2018 18:03, Peter Maydell wrote:
> Coverity points out in CID 1390588 that the test for sh == 0
> in sdram_size() can never fire, because we calculate sh with
>     sh = 1024 - ((bcr >> 6) & 0x3ff);
> which must result in a value between 1 and 1024 inclusive.
> 
> Without the relevant manual for the SoC, we're not completely
> sure of the correct behaviour here, but we can remove the
> dead code without changing how QEMU currently behaves.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We had a discussion about this coverity error a while back:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg05187.html
> I'd just like to squash the Coverity warning, I think.
> 
>  hw/ppc/ppc440_uc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 09ccda548f3..9360f781cef 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -559,11 +559,7 @@ static target_ulong sdram_size(uint32_t bcr)
>      int sh;
>  
>      sh = 1024 - ((bcr >> 6) & 0x3ff);
> -    if (sh == 0) {
> -        size = -1;
> -    } else {
> -        size = 8 * MiB * sh;
> -    }
> +    size = 8 * MiB * sh;
>  
>      return size;
>  }
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
