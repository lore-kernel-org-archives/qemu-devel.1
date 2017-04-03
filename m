Received: from eggs.gnu.org ([2001:4830:134:3::10]:50699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cv4AS-00075r-UH
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cv4AS-0004IH-3n
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:45:21 -0400
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-6-ehabkost@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <590d302d-2a7c-728e-8a15-a63a094108bb@redhat.com>
Date: Mon, 3 Apr 2017 17:45:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170401004624.30886-6-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 05/19] pflash_cfi01: Remove user_creatable
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On 04/01/17 02:46, Eduardo Habkost wrote:
> TYPE_CFI_PFLASH01 devices need to be mapped by
> pflash_cfi01_register() and can't be used with -device. Remove
> user_creatable from the device class.
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index f48dc20035..594d4cf6fe 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -927,11 +927,6 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>      dc->props = pflash_cfi01_properties;
>      dc->vmsd = &vmstate_pflash;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> -    /*
> -     * FIXME: Set only for compatibility on q35 machine-type.
> -     * Probably never meant to be user-creatable
> -     */
> -    dc->user_creatable = true;
>  }
>  
>  
> 

The commit message is not entirely correct; for example "virt" creates
each flash device in the create_one_flash() function, with manual
qdev_create / qdev_prop_set_* / qdev_init_nofail /
memory_region_add_subregion.

So I recommend updating the commit message to say,

... TYPE_CFI_PFLASH01 devices need to be mapped by
pflash_cfi01_register *or equivalent* and can't be used...

With that,

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
