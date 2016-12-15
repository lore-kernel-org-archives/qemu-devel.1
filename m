Received: from eggs.gnu.org ([2001:4830:134:3::10]:53178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHWo4-0005eC-CZ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHWnz-0000y5-ER
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:14:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHWnz-0000xe-5Z
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:14:43 -0500
References: <1481810693-13733-1-git-send-email-skiver.cloud.yzy@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a8da28a-25b7-e243-bc72-96d9953619aa@redhat.com>
Date: Thu, 15 Dec 2016 15:14:39 +0100
MIME-Version: 1.0
In-Reply-To: <1481810693-13733-1-git-send-email-skiver.cloud.yzy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/block/pflash_cfi*.c: fix confusing
 assert fail message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: skiver.cloud.yzy@gmail.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ziyue Yang <yzylivezh@hotmail.com>



On 15/12/2016 15:04, skiver.cloud.yzy@gmail.com wrote:
> From: Ziyue Yang <yzylivezh@hotmail.com>
> 
> The patch is to fix the confusing assert fail message caused by
> un-initialized device structure (from bite sized tasks).
> 
> The bug can be reproduced by
> 
> ./qemu-system-x86_64 -nographic -device cfi.pflash01
> 
> The CFI hardware is dynamically loaded by QOM realizing mechanism,
> however the realizing function in pflash_cfi01_realize function
> requires the device being initialized manually before calling, like
> 
> ./qemu-system-x86_64 -nographic
> -device cfi.pflash01,num-blocks=1024,sector-length=4096,name=testcard
> 
> Once the initializing parameters are left off in the command, it will
> leave the device structure not initialized, which makes
> pflash_cfi01_realize try to realize a zero-volume card, causing
> 
> /mnt/EXT_volume/projects/qemu/qemu-dev/exec.c:1378:
> find_ram_offset: Assertion `size != 0\' failed.
> 
> Through my test, at least the flash device's block-number, sector-length
> and its name is needed for pflash_cfi01_realize to behave correctly. So
> I think the new asserts are needed to hint the QEMU user to specify
> the device's parameters correctly.
> 
> Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
> ---
>  hw/block/pflash_cfi01.c | 13 +++++++++++++
>  hw/block/pflash_cfi02.c | 13 +++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 62d7a56..5f0ee9d 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -707,6 +707,19 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>      int num_devices;
>      Error *local_err = NULL;
>  
> +    if (pfl->sector_len == 0) {
> +        error_setg(errp, "attribute \"sector-length\" not specified or zero.");
> +        return;
> +    }
> +    if (pfl->nb_blocs == 0) {
> +        error_setg(errp, "attribute \"num-blocks\" not specified or zero.");
> +        return;
> +    }
> +    if (pfl->name == NULL) {
> +        error_setg(errp, "attribute \"name\" not specified.");
> +        return;
> +    }
> +
>      total_len = pfl->sector_len * pfl->nb_blocs;
>  
>      /* These are only used to expose the parameters of each device
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 4f6105c..ef71322 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -600,6 +600,19 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>      int ret;
>      Error *local_err = NULL;
>  
> +    if (pfl->sector_len == 0) {
> +        error_setg(errp, "attribute \"sector-length\" not specified or zero.");
> +        return;
> +    }
> +    if (pfl->nb_blocs == 0) {
> +        error_setg(errp, "attribute \"num-blocks\" not specified or zero.");
> +        return;
> +    }
> +    if (pfl->name == NULL) {
> +        error_setg(errp, "attribute \"name\" not specified.");
> +        return;
> +    }
> +
>      chip_len = pfl->sector_len * pfl->nb_blocs;
>      /* XXX: to be fixed */
>  #if 0
> 

Looks good, thanks!

Paolo
