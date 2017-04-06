Received: from eggs.gnu.org ([2001:4830:134:3::10]:46476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cw3fL-0008Qz-I8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cw3fI-0000iR-Dv
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cw3fI-0000he-5V
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:25:16 -0400
References: <20170404202429.14643-1-ehabkost@redhat.com>
	<20170404202429.14643-2-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e6dfc761-0dd1-7baa-218c-ed00affb2f47@redhat.com>
Date: Thu, 6 Apr 2017 11:25:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170404202429.14643-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/21] qdev: Replace
 cannot_instantiate_with_device_add_yet with !user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 04.04.2017 22:24, Eduardo Habkost wrote:
> cannot_instantiate_with_device_add_yet was introduced by commit
> 837d37167dc446af8a91189108b363c04609e296 to replace no_user. It
> was supposed to be a temporary measure.

I think you rather meant commit efec3dd631d94160288392721a5f9c39e50fb2bc
("qdev: Replace no_user by cannot_instantiate_with_device_add_yet") ?

> When it was introduced, we had 54
> cannot_instantiate_with_device_add_yet=3Dtrue lines in the code.
> Today (3 years later) this number has not shrinked: we now have
> 57 cannot_instantiate_with_device_add_yet=3Dtrue lines. I think it
> is safe to say it is not a temporary measure, and we won't see
> the flag go away soon.

I fully agree.

> Instead of a long field name that misleads people to believe it
> is temporary, replace it a shorter and less misleading field:
> user_creatable.

Sounds much better, indeed. Thanks for tackling this!

[...]
>  static void rtc_finalize(Object *obj)
> diff --git a/monitor.c b/monitor.c
> index be282ecb80..e06edec2bd 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3156,7 +3156,7 @@ void device_add_completion(ReadLineState *rs, int=
 nb_args, const char *str)
>                                               TYPE_DEVICE);
>          name =3D object_class_get_name(OBJECT_CLASS(dc));
> =20
> -        if (!dc->cannot_instantiate_with_device_add_yet
> +        if (dc->user_creatable
>              && !strncmp(name, str, len)) {

Cosmetics: You could put the strcmp now into the previous line, too.

>              readline_add_completion(rs, name);
>          }
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 5f2fcdfc45..e4c180c6bc 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -113,7 +113,7 @@ static void qdev_print_devinfo(DeviceClass *dc)
>      if (dc->desc) {
>          error_printf(", desc \"%s\"", dc->desc);
>      }
> -    if (dc->cannot_instantiate_with_device_add_yet) {
> +    if (!dc->user_creatable) {
>          error_printf(", no-user");
>      }
>      error_printf("\n");
> @@ -155,7 +155,7 @@ static void qdev_print_devinfos(bool show_no_user)
>                   ? !test_bit(i, dc->categories)
>                   : !bitmap_empty(dc->categories, DEVICE_CATEGORY_MAX))
>                  || (!show_no_user
> -                    && dc->cannot_instantiate_with_device_add_yet)) {
> +                    && !dc->user_creatable)) {

Cosmetics: That line could now also be moved at the end of the previous
line.

>                  continue;
>              }
>              if (!cat_printed) {
> @@ -240,7 +240,7 @@ static DeviceClass *qdev_get_device_class(const cha=
r **driver, Error **errp)
>      }
> =20
>      dc =3D DEVICE_CLASS(oc);
> -    if (dc->cannot_instantiate_with_device_add_yet ||
> +    if (!dc->user_creatable ||
>          (qdev_hotplug && !dc->hotpluggable)) {

dito

Anyway, patch looks fine to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
