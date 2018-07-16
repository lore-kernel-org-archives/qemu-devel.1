Received: from eggs.gnu.org ([2001:4830:134:3::10]:48128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fexkZ-0004Rd-Mz
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fexkY-0001kg-GT
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:16:51 -0400
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-2-git-send-email-thuth@redhat.com>
	<20180713225718.GP914@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <73868f86-eb59-568f-24e4-7fc16e6cb426@redhat.com>
Date: Mon, 16 Jul 2018 09:16:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180713225718.GP914@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/16] qom/object: Add a new function
 object_initialize_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 14.07.2018 00:57, Eduardo Habkost wrote:
> On Fri, Jul 13, 2018 at 10:27:29AM +0200, Thomas Huth wrote:
>> A lot of code is using the object_initialize() function followed by a call
>> to object_property_add_child() to add the newly initialized object as a child
>> of the current object. Both functions increase the reference counter of the
>> new object, but many spots that call these two functions then forget to drop
>> one of the superfluous references. So the newly created object is often not
>> cleaned up correctly when the parent is destroyed. In the worst case, this
>> can cause crashes, e.g. because device objects are not correctly removed from
>> their parent_bus.
>>
>> Since this is a common pattern between many code spots, let's introdcue a
>> new function that takes care of calling all three required initialization
>> functions, first object_initialize(), then object_property_add_child() and
>> finally object_unref().
>>
>> And while we're at object.h, also fix some copy-n-paste errors in the
>> comments there ("to store the area" --> "to store the error").
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Potential candidates for using the new function, found using the
> following Coccinelle patch:
> 
> @@
> expression child, size, type, parent, errp, propname;
> @@
> -object_initialize(child, size, type);
> -object_property_add_child(
> +object_initialize_child(
>                            parent, propname, 
> -                          OBJECT(child),
> +                          child, size, type,
>                            errp);
> 
> Some of them (very few) already call object_unref() and need to
> be fixed manually.
> 
> Most of the remaining ~50 object_initialize() callers are also
> candidates, even if they don't call object_property_add_child()
> today.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index bb9d33848d..e5923f85af 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -189,8 +189,8 @@ static void aspeed_board_init(MachineState *machine,
>      DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
>  
>      bmc = g_new0(AspeedBoardState, 1);
> -    object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&bmc->soc),
> +    object_initialize_child(OBJECT(machine), "soc",
> +                              &bmc->soc, (sizeof(bmc->soc)), cfg->soc_name,
>                                &error_abort);
>  
>      sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index e68911af0f..994262756f 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -106,11 +106,11 @@ static void aspeed_soc_init(Object *obj)
>      AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>      int i;
>  
> -    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
> -    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
> +    object_initialize_child(obj, "cpu",  &s->cpu, sizeof(s->cpu),
> +                            sc->info->cpu_type, NULL);
>  
> -    object_initialize(&s->scu, sizeof(s->scu), TYPE_ASPEED_SCU);
> -    object_property_add_child(obj, "scu", OBJECT(&s->scu), NULL);
> +    object_initialize_child(obj, "scu",  &s->scu, sizeof(s->scu),
> +                            TYPE_ASPEED_SCU, NULL);
>      qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
>      qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",

Thanks, that's definitely something we should do for 3.1! But for 3.0, I
think we better only focus on the ones that cause reproducible problem.

And the spots that also use qdev_set_parent_bus(...,
sysbus_get_default()) should use sysbus_init_child_obj() instead.

 Thomas
