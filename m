Received: from eggs.gnu.org ([2001:4830:134:3::10]:58110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpJu-0005j9-4Q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpJp-0001gA-R4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:23:25 -0500
References: <20181130151712.2312-1-peter.maydell@linaro.org>
	<20181130151712.2312-5-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df2fa1f0-c4e7-3bba-2572-9016c82165c0@redhat.com>
Date: Fri, 30 Nov 2018 14:22:47 -0600
MIME-Version: 1.0
In-Reply-To: <20181130151712.2312-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/10] hw/pci/pci.c: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org

On 11/30/18 9:17 AM, Peter Maydell wrote:
> The load_image() function is deprecated, as it does not let the
> caller specify how large the buffer to read the file into is.
> Instead use load_image_size().

Commit message should mention the addition of error checking.

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/pci/pci.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 56b13b3320e..efb5ce196ff 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2261,7 +2261,11 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>       pdev->has_rom = true;
>       memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
>       ptr = memory_region_get_ram_ptr(&pdev->rom);
> -    load_image(path, ptr);
> +    if (load_image_size(path, ptr, size) < 0) {
> +        error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
> +        g_free(path);
> +        return;
> +    }
>       g_free(path);

But the code change itself is fine:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
