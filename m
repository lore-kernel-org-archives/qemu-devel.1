Received: from eggs.gnu.org ([2001:4830:134:3::10]:58787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePePc-0006Uf-U9
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePePb-0002tI-Kf
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:03:40 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:43802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePePb-0002sb-E6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:03:39 -0500
Received: by mail-wm0-x241.google.com with SMTP id n138so14578365wmg.2
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 17:03:39 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213204436.5379-6-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
	<20171213204436.5379-6-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 17:03:07 -0800
Message-ID: <CAKmqyKOTPmgcfjrCfbeyBout7fBo3mgRJj1R0O=iKzqmSXsMaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] sdbus: add sdbus_create_slave()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 12:44 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> The slave qdev is created connected to the parent SDBus.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/sd/sd.h |  2 ++
>  hw/sd/core.c       | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index dc9d697c12..d402231724 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -52,6 +52,8 @@ struct SDBus {
>
>  /* Functions to be used by qdevified callers */
>  SDBus *sdbus_create_bus(DeviceState *parent, const char *name);
> +DeviceState *sdbus_create_slave(SDBus *bus, const char *name);
> +DeviceState *sdbus_create_slave_no_init(SDBus *bus, const char *name);
>  int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
>  void sdbus_write_data(SDBus *sd, uint8_t value);
>  uint8_t sdbus_read_data(SDBus *sd);
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index 021a8d7258..fc9ccfedb2 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -188,6 +188,20 @@ static void sd_bus_register_types(void)
>
>  type_init(sd_bus_register_types)
>
> +DeviceState *sdbus_create_slave_no_init(SDBus *bus, const char *name)
> +{
> +    assert(bus);
> +    return qdev_create(BUS(bus), name);
> +}
> +
> +DeviceState *sdbus_create_slave(SDBus *bus, const char *name)
> +{
> +    DeviceState *dev =3D sdbus_create_slave_no_init(bus, name);
> +
> +    qdev_init_nofail(dev);
> +    return dev;
> +}

This looks un-QOM which I thought we are trying to get away from.

Alistair

> +
>  SDBus *sdbus_create_bus(DeviceState *parent, const char *name)
>  {
>      return SD_BUS(qbus_create(TYPE_SD_BUS, parent, name));
> --
> 2.15.1
>
>
