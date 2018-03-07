Received: from eggs.gnu.org ([2001:4830:134:3::10]:54189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ete6R-0000Ei-CU
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ete6O-0007x3-50
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:47:51 -0500
References: <1520432574-20615-1-git-send-email-thuth@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5211d630-ac1a-623f-1903-ab39db321b3a@ilande.co.uk>
Date: Wed, 7 Mar 2018 18:47:37 +0000
MIME-Version: 1.0
In-Reply-To: <1520432574-20615-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/misc/macio: Mark the macio devices with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 07/03/18 14:22, Thomas Huth wrote:

> The macio devices currently cause a crash when the user tries to
> instantiate them on a different machine:
> 
> $ ppc64-softmmu/qemu-system-ppc64 -device macio-newworld
> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> qemu-system-ppc64: -device macio-newworld: Device 'serial0' is in use
> Aborted (core dumped)
> 
> These devices are clearly not intended to be creatable by the user
> since they are using serial_hds[] directly in their instance_init
> function. So let's mark them with user_creatable = false.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/misc/macio/macio.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index af1bd46..454244f 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -406,6 +406,8 @@ static void macio_class_init(ObjectClass *klass, void *data)
>       k->class_id = PCI_CLASS_OTHERS << 8;
>       dc->props = macio_properties;
>       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    /* Reason: Uses serial_hds in macio_instance_init */
> +    dc->user_creatable = false;
>   }
>   
>   static const TypeInfo macio_oldworld_type_info = {

Looks like both Daniel and Peter also agree this is the correct 
approach, so:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
