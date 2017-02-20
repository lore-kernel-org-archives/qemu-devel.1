Received: from eggs.gnu.org ([2001:4830:134:3::10]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfmUs-0004yV-HZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfmUr-0001kP-Ht
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:51:14 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfmUr-0001k1-Bl
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:51:13 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r141so50479774wmg.1
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 03:51:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487341525-5785-1-git-send-email-eric.auger@redhat.com>
References: <1487341525-5785-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 11:50:51 +0000
Message-ID: <CAFEAcA97d3kxq1XWgKMdjRB4VjSdg+tYVA5U0hhL3Af6Ja9FmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt: Add a user option to
 disallow ITS instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>

On 17 February 2017 at 14:25, Eric Auger <eric.auger@redhat.com> wrote:
> In 2.9 ITS will block save/restore and migration use cases. As
> such let's introduce a user option that disallows its instantiation
> along with the GICv3. With no-its option turned true, migration will
> be possible, obviously at the expense of MSI support (with GICv3).
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v1 -> v2: fix omitted coma in object_property_set_description
>
> With this patch the option also is added in virt 2.8. I don't know
> if it is acceptable.

I think that's OK.

> ---
>  hw/arm/virt.c         | 28 +++++++++++++++++++++++++++-
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f3440f2..c08deb0 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -605,7 +605,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>
>      fdt_add_gic_node(vms);
>
> -    if (type == 3 && !vmc->no_its) {
> +    if (type == 3 && !vmc->no_its && !vms->no_its) {

Making the board creation code check both a vmc field and
a vms field seems a bit awkward...

> +    /* Default allows ITS instantiation */
> +    if (!vmc->no_its) {
> +        object_property_add_bool(obj, "no-its", virt_get_no_its,
> +                                 virt_set_no_its, NULL);
> +        vms->no_its = false;
> +        object_property_set_description(obj, "no-its",
> +                                        "Disallow the ITS instantiation",
> +                                        NULL);

Can we have the property be "its" with true-for-enabled,
rather than "no-its", please? (See later for rationale.)

> +    }

...if we have this code have an else {} clause we can
make it set the vms field appropriately, and then the
board creation code only needs to check the vms field.

> +
>      vms->memmap = a15memmap;
>      vms->irqmap = a15irqmap;
>  }
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 58ce74e..5e73be9 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -93,6 +93,7 @@ typedef struct {
>      FWCfgState *fw_cfg;
>      bool secure;
>      bool highmem;
> +    bool no_its;

Can we make this "bool its" where true means "has an ITS", please?
The fields in VirtMachineClass are all "no_foo" because we require
the "false" case to be the "new modern behaviour" and the "true"
case to be "legacy like old boards" for convenience of the
virt_machine_*_options() function chain, but we don't need to
do this for VirtMachineState fields. (So VMS 'secure', 'highmem'
and 'virt' are all true-for-feature-enabled.)
The user-facing property should also be "its" for the same reason.

An alternative to having the property be always default true
and only existing on newer boards would be to have the VMC field
be "no_default_its", expose the "its" property in all cases and
just have its default value be different for old virt-* machine
versions. I have no opinion here about which would be better.

>      bool virt;
>      int32_t gic_version;
>      struct arm_boot_info bootinfo;

thanks
-- PMM
