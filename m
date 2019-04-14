Received: from eggs.gnu.org ([209.51.188.92]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFiVR-0005Uc-RB
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 13:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFiVQ-0001Fb-Qh
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 13:01:25 -0400
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
Date: Sun, 14 Apr 2019 19:01:18 +0200
MIME-Version: 1.0
In-Reply-To: <1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base
 year
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
> 
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   hw/isa/i82378.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> index a5d67bc..546c928 100644
> --- a/hw/isa/i82378.c
> +++ b/hw/isa/i82378.c
> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>       isa = isa_create_simple(isabus, "i82374");
>   
>       /* timer */
> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
> +    isa = isa_create(isabus, TYPE_MC146818_RTC);
> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
> +    qdev_init_nofail(DEVICE(isa));

I am not sure the base_year should be hardcoded in i82378. I can assume other machines with a i82378 can have another base_year.
Maybe you can you add a base_year property to i82378, and forward it to mc146818 with object_property_add_alias?
Then, change 40p machine to set it to 1900, without changing it for prep machine.

>   }
>   
>   static void i82378_init(Object *obj)
> 

Hervé
