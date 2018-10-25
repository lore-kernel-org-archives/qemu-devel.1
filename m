Received: from eggs.gnu.org ([2001:4830:134:3::10]:48525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdZ2-0005l2-7u
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdYp-0000MR-5k
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:12:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFdYo-0000Lf-SF
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:12:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so7974211wrv.6
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 04:12:17 -0700 (PDT)
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <34baf361-0f1a-cdb2-9b2e-bef68dbfd154@redhat.com>
Date: Thu, 25 Oct 2018 13:12:15 +0200
MIME-Version: 1.0
In-Reply-To: <20181025085256.20522-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: add deprecation_reason to
 DeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

Hi Gerd,

On 25/10/18 10:52, Gerd Hoffmann wrote:
> Simliar to deprecated machine types.

"Similar"

> Print a warning when creating a deprecated device.
> Add deprecation notice to -device help.
> 
> TODO: add to intospection.

"introspection"

Do we want the TODO in the git history?

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/core/qdev.c         | 9 ++++++++-
>   include/hw/qdev-core.h | 1 +
>   qdev-monitor.c         | 7 +++++++
>   3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 046d8f1..3b27a74 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -133,11 +133,18 @@ DeviceState *qdev_create(BusState *bus, const char *name)
>   
>   DeviceState *qdev_try_create(BusState *bus, const char *type)
>   {
> +    DeviceClass *dc;
>       DeviceState *dev;
>   
> -    if (object_class_by_name(type) == NULL) {
> +    dc = DEVICE_CLASS(object_class_by_name(type));
> +    if (dc == NULL) {
>           return NULL;
>       }
> +    if (dc->deprecation_reason) {
> +        warn_report("device %s is deprecated (%s)",
> +                    type, dc->deprecation_reason);
> +    }
> +
>       dev = DEVICE(object_new(type));
>       if (!dev) {
>           return NULL;
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index a24d0dd..a352eaa 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -105,6 +105,7 @@ typedef struct DeviceClass {
>        */
>       bool user_creatable;
>       bool hotpluggable;
> +    const char *deprecation_reason;
>   
>       /* callbacks */
>       DeviceReset reset;
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 802c18a..bbba2bc 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -128,6 +128,9 @@ static void qdev_print_devinfo(DeviceClass *dc)
>       if (!dc->user_creatable) {
>           out_printf(", no-user");
>       }
> +    if (!dc->deprecation_reason) {

This is the opposite condition:

        if (dc->deprecation_reason) {
            out_printf(", deprecated");

With it fixed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        out_printf(", deprecated");
> +    }
>       out_printf("\n");
>   }
>   
> @@ -579,6 +582,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>       if (!dc) {
>           return NULL;
>       }
> +    if (dc->deprecation_reason) {
> +        warn_report("device %s is deprecated (%s)",
> +                    driver, dc->deprecation_reason);
> +    }
>   
>       /* find bus */
>       path = qemu_opt_get(opts, "bus");
> 
