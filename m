Received: from eggs.gnu.org ([2001:4830:134:3::10]:41330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZZvl-0002zk-4j
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZZvh-0001Nf-4B
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:13:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485778921-20869-1-git-send-email-thuth@redhat.com>
Date: Fri, 03 Feb 2017 10:13:14 +0100
In-Reply-To: <1485778921-20869-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Mon, 30 Jan 2017 13:22:01 +0100")
Message-ID: <87h94bd4d1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hw/core/register: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Thomas Huth <thuth@redhat.com> writes:

> The "qemu,register" device needs to be wired up in source code, there
> is no way the user can add this device with the "-device" parameter or
> the "device_add" monitor command yet.

Well, the user can (I tried), but it won't do squat then.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Changed patch description and comment
>
>  hw/core/register.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 4bfbc50..1416691 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -274,9 +274,18 @@ void register_finalize_block(RegisterInfoArray *r_array)
>      g_free(r_array);
>  }
>  
> +static void register_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    /* Needs to be wired up in source code, see register_init_block32() */

Bear with me...  Please phrase this exactly like the similar comments
elsewhere:

       /* Reason: needs to be wired up by register_init_block32() to work */


> +    dc->cannot_instantiate_with_device_add_yet = true;
> +}
> +
>  static const TypeInfo register_info = {
>      .name  = TYPE_REGISTER,
>      .parent = TYPE_DEVICE,
> +    .class_init = register_class_init,
>  };
>  
>  static void register_register_types(void)

With comment and commit message touched up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
