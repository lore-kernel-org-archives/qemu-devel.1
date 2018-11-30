Received: from eggs.gnu.org ([2001:4830:134:3::10]:58951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpNE-0006p3-0W
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpND-0003iw-5H
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:26:51 -0500
References: <20181130151712.2312-1-peter.maydell@linaro.org>
	<20181130151712.2312-6-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c7c7dd4-5243-b64a-f406-e196dcf1a60c@redhat.com>
Date: Fri, 30 Nov 2018 14:26:40 -0600
MIME-Version: 1.0
In-Reply-To: <20181130151712.2312-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] hw/i386/pc.c: Don't use load_image()
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
> Use the glib g_file_get_contents() function instead, which does
> the whole "allocate memory for the file and read it in" operation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/pc.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 

> +++ b/hw/i386/pc.c
> @@ -839,10 +839,9 @@ static void load_linux(PCMachineState *pcms,
>   {
>       uint16_t protocol;
>       int setup_size, kernel_size, cmdline_size;
> -    int64_t initrd_size = 0;
>       int dtb_size, setup_data_offset;
>       uint32_t initrd_max;
> -    uint8_t header[8192], *setup, *kernel, *initrd_data;
> +    uint8_t header[8192], *setup, *kernel;

Unrelated - but 'header' at 8k is larger than I like for an auto 
variable.  Some OSs put guard pages at only 4k granularity, so this much 
stack allocation can miss stack overflow.


> -        initrd_size = get_image_size(initrd_filename);
> -        if (initrd_size < 0) {
> +        if (!g_file_get_contents(initrd_filename, &initrd_data,
> +                                 &initrd_size, &gerr)) {
>               fprintf(stderr, "qemu: error reading initrd %s: %s\n",
> -                    initrd_filename, strerror(errno));
> +                    initrd_filename, gerr->message);
>               exit(1);
> -        } else if (initrd_size >= initrd_max) {
> +        }
> +        if (initrd_size >= initrd_max) {
>               fprintf(stderr, "qemu: initrd is too large, cannot support."
> -                    "(max: %"PRIu32", need %"PRId64")\n", initrd_max, initrd_size);
> +                    "(max: %"PRIu32", need %"PRId64")\n",
> +                    initrd_max, initrd_size);
>               exit(1);

You're exiting anyway, so it doesn't matter, but free'ing initrd_data 
might satisfy a lint-checker.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
