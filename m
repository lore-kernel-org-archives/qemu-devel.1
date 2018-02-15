Received: from eggs.gnu.org ([2001:4830:134:3::10]:58043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNwm-0001FB-Mj
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNwj-0004cR-F6
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:07:52 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215175707.15491-1-peter.maydell@linaro.org>
	<20180215175707.15491-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <220f4302-838e-f367-f52b-8e2a2ca105e6@amsat.org>
Date: Thu, 15 Feb 2018 15:07:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180215175707.15491-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] loader: Add new
 load_ramdisk_as()
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

On 02/15/2018 02:57 PM, Peter Maydell wrote:
> Add a function load_ramdisk_as() which behaves like the existing
> load_ramdisk() but allows the caller to specify the AddressSpace
> to use. This matches the pattern we have already for various
> other loader functions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/loader.h | 12 +++++++++++-
>  hw/core/loader.c    |  8 +++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 355fe0f5a2..1fd4256782 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -163,16 +163,26 @@ int load_uimage(const char *filename, hwaddr *ep,
>                  void *translate_opaque);
>  
>  /**
> - * load_ramdisk:
> + * load_ramdisk_as:
>   * @filename: Path to the ramdisk image
>   * @addr: Memory address to load the ramdisk to
>   * @max_sz: Maximum allowed ramdisk size (for non-u-boot ramdisks)
> + * @as: The AddressSpace to load the ELF to. The value of address_space_memory
> + *      is used if nothing is supplied here.
>   *
>   * Load a ramdisk image with U-Boot header to the specified memory
>   * address.
>   *
>   * Returns the size of the loaded image on success, -1 otherwise.
>   */
> +int load_ramdisk_as(const char *filename, hwaddr addr, uint64_t max_sz,
> +                    AddressSpace *as);
> +
> +/**
> + * load_ramdisk:
> + * Same as load_ramdisk_as(), but doesn't allow the caller to specify
> + * an AddressSpace.
> + */
>  int load_ramdisk(const char *filename, hwaddr addr, uint64_t max_sz);
>  
>  ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src, size_t srclen);
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 91669d65aa..2b9e7394a1 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -729,9 +729,15 @@ int load_uimage_as(const char *filename, hwaddr *ep, hwaddr *loadaddr,
>  
>  /* Load a ramdisk.  */
>  int load_ramdisk(const char *filename, hwaddr addr, uint64_t max_sz)
> +{
> +    return load_ramdisk_as(filename, addr, max_sz, NULL);
> +}
> +
> +int load_ramdisk_as(const char *filename, hwaddr addr, uint64_t max_sz,
> +                    AddressSpace *as)
>  {
>      return load_uboot_image(filename, NULL, &addr, NULL, IH_TYPE_RAMDISK,
> -                            NULL, NULL, NULL);
> +                            NULL, NULL, as);
>  }
>  
>  /* Load a gzip-compressed kernel to a dynamically allocated buffer. */
> 
