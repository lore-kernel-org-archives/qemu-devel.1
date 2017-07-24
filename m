Received: from eggs.gnu.org ([2001:4830:134:3::10]:59894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkbX-00085f-6C
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkbW-0006Gh-At
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:09:27 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZkbW-0006G3-5H
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:09:26 -0400
Received: by mail-wm0-x232.google.com with SMTP id c184so41514113wmd.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:09:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-22-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-22-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:09:04 +0100
Message-ID: <CAFEAcA_PRH_BuUOTtC=cvRFT7Gtiwt50T6C3avm+Sy13aDS4tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 21/35] arm/sysbus-fdt: fix null
 pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Use error_report() + exit() instead of error_setg(&error_fatal).
>
> hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable 'node_pat=
h') results in a null pointer dereference
>     if (node_path[1]) {
>         ^~~~~~~~~~~~

I don't understand what this warning is trying to say.
We can't get to this point with a NULL node_path,
because of the previous conditional, which is using
error_setg(&error_fatal).

> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/sysbus-fdt.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index d68e3dcdbd..ad0cc49b19 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -315,15 +315,14 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbde=
v, void *opaque)
>      node_path =3D qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
>                                     &error_fatal);
>      if (!node_path || !node_path[0]) {
> -        error_setg(&error_fatal, "%s unable to retrieve node path for %s=
/%s",
> +        error_report("%s unable to retrieve node path for %s/%s",
>                     __func__, dt_name, vdev->compat);
> -    }
> -
> -    if (node_path[1]) {
> -        error_setg(&error_fatal, "%s more than one node matching %s/%s!"=
,
> +        exit(1);
> +    } else if (node_path[1]) {
> +        error_report("%s more than one node matching %s/%s!",
>                     __func__, dt_name, vdev->compat);
> +        exit(1);
>      }
> -
>      g_free(dt_name);

This doesn't seem like an improvement. Now the
error handling in the function is an inconsistent
mix of error_report()+exit() and error_setg(&error_fatal).

thanks
-- PMM
