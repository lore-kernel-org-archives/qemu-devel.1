Received: from eggs.gnu.org ([2001:4830:134:3::10]:46103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecaxa-0002Ar-Dl
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:00:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecaxZ-0004XF-CI
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:00:14 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ecaxZ-0004Wf-4a
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:00:13 -0500
Received: by mail-lf0-x242.google.com with SMTP id o89so3072133lfg.10
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:00:12 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180118183108.16009-1-f4bug@amsat.org>
References: <20180118182510.15630-1-f4bug@amsat.org>
	<20180118183108.16009-1-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 19 Jan 2018 09:59:41 -0800
Message-ID: <CAKmqyKOCpZG=Motf-FwE4u3pTxas6jRY3-2g0K9Zn=h_gDhipA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 01/17] sdhci: use
 error_propagate(local_err) in realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin O'Connor <kevin@koconnor.net>, Marcel Apfelbaum <marcel@redhat.com>

On Thu, Jan 18, 2018 at 10:30 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> avoid the "errp && *errp" pattern (not recommended in "qapi/error.h" comm=
ents).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index f9264d3be5..8c9c0fbc2a 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1300,10 +1300,12 @@ static Property sdhci_pci_properties[] =3D {
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> +    Error *local_err =3D NULL;
>
>      sdhci_initfn(s);
>      sdhci_common_realize(s, errp);
> -    if (errp && *errp) {
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>          return;
>      }
>
> @@ -1381,9 +1383,11 @@ static void sdhci_sysbus_realize(DeviceState *dev,=
 Error ** errp)
>  {
>      SDHCIState *s =3D SYSBUS_SDHCI(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    Error *local_err =3D NULL;
>
>      sdhci_common_realize(s, errp);
> -    if (errp && *errp) {
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>          return;
>      }
>
> --
> 2.15.1
>
>
