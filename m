Received: from eggs.gnu.org ([2001:4830:134:3::10]:54055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gKQgS-000528-12
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gKQgN-00060D-RX
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:27:58 -0500
Date: Wed, 7 Nov 2018 09:27:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181107092721.6c01f09e@w520.home>
In-Reply-To: <20181106184212.29377-1-eric.auger@redhat.com>
References: <20181106184212.29377-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-3.1] hw/arm/sysbus-fdt: Only call
 match_fn callback if the type matches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, geert+renesas@glider.be, thuth@redhat.com, kraxel@redhat.com

On Tue,  6 Nov 2018 19:42:12 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Commit af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with DT
> compatible value) introduced a match_fn callback which gets called
> for each registered combo to check whether a sysbus device can be
> dynamically instantiated. However the callback gets called even if
> the device type does not match the binding combo typename field.
> This causes an assert when passing "-device ramfb" to the qemu
> command line as vfio_platform_match() gets called on a non
> vfio-platform device.
> 
> To fix this regression, let's change the add_fdt_node() logic so
> that we first check the type and if the match_fn callback is defined,
> then we also call it.
> 
> Binding combos only requesting a type check do not define the
> match_fn callback.
> 
> Fixes: af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with
> DT compatible value)
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Thomas Huth <thuth@redhat.com>

The commit this fixes went through the vfio tree, but since the fix
itself only lives in arm code, I'll leave it to arm maintainers to
shepherd this fix and offer:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> ---
> 
> v1 -> v2:
> - use "if (!iter->match_fn || iter->match_fn(sbdev, iter)) {"
>   as suggested by Peter to avoid code duplication
> - mention the ramfb regression fixed by this patch in the
>   commit message.
> ---
>  hw/arm/sysbus-fdt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index 0e24c803a1..ad698d4832 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -449,7 +449,7 @@ static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
>      return !strcmp(object_get_typename(OBJECT(sbdev)), entry->typename);
>  }
>  
> -#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), type_match}
> +#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), NULL}
>  
>  /* list of supported dynamic sysbus bindings */
>  static const BindingEntry bindings[] = {
> @@ -481,10 +481,12 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
>      for (i = 0; i < ARRAY_SIZE(bindings); i++) {
>          const BindingEntry *iter = &bindings[i];
>  
> -        if (iter->match_fn(sbdev, iter)) {
> -            ret = iter->add_fn(sbdev, opaque);
> -            assert(!ret);
> -            return;
> +        if (type_match(sbdev, iter)) {
> +            if (!iter->match_fn || iter->match_fn(sbdev, iter)) {
> +                ret = iter->add_fn(sbdev, opaque);
> +                assert(!ret);
> +                return;
> +            }
>          }
>      }
>      error_report("Device %s can not be dynamically instantiated",
