Received: from eggs.gnu.org ([2001:4830:134:3::10]:49921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Rdv-0003lp-9D
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Rdu-00048B-3v
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:43:42 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9Rdt-00046r-Uq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:43:42 -0400
Received: by mail-oi0-x242.google.com with SMTP id j10-v6so7361225oii.12
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 01:43:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419220914.959-2-f4bug@amsat.org>
References: <20180419220914.959-1-f4bug@amsat.org>
	<20180419220914.959-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 09:43:20 +0100
Message-ID: <CAFEAcA-LYpqaYfdmjzXwMDau8bZH_zxXaRCCL5dRT1p6spjUxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/isa/superio: Fix inconsistent use
 of Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 19 April 2018 at 23:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> 4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
> use of Chardev->be. Also, this CharBackend member is private and is
> not supposed to be accessible.
>
> Fix it by removing the inconsistent check.
>
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/isa/isa-superio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index b95608a003..08afe44731 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -43,7 +43,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
>          if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i)) {
>              /* FIXME use a qdev chardev prop instead of parallel_hds[] *=
/
>              chr =3D parallel_hds[i];
> -            if (chr =3D=3D NULL || chr->be) {
> +            if (chr =3D=3D NULL) {
>                  name =3D g_strdup_printf("discarding-parallel%d", i);
>                  chr =3D qemu_chr_new(name, "null");
>              } else {
> @@ -83,7 +83,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
>          if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
>              /* FIXME use a qdev chardev prop instead of serial_hds[] */
>              chr =3D serial_hds[i];
> -            if (chr =3D=3D NULL || chr->be) {
> +            if (chr =3D=3D NULL) {
>                  name =3D g_strdup_printf("discarding-serial%d", i);
>                  chr =3D qemu_chr_new(name, "null");
>              } else {

You should not need to create fake null devices like this. The
device using the chardev should just cope with having a NULL
pointer now we have commit 12051d82f004024.

Also consider having cc:stable on this patchset?

thanks
-- PMM
