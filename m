Received: from eggs.gnu.org ([2001:4830:134:3::10]:53864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gEqVw-00048a-3t
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 02:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gEqVs-0001ag-Jk
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 02:50:03 -0400
Received: from mout02.posteo.de ([185.67.36.66]:35321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1gEqVs-0001Zi-5h
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 02:50:00 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id B9876240106
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 08:49:57 +0200 (CEST)
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-3-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <ab0a9972-57a5-1d97-22f4-13c5c58248bc@posteo.de>
Date: Tue, 23 Oct 2018 07:49:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181018182856.28001-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/11] hw/m68k: implement ADB bus
 support for via
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, laurent@vivier.eu
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, aurelien@aurel32.net

On 2018-10-18 19:28, Mark Cave-Ayland wrote:
> From: Laurent Vivier <laurent@vivier.eu>
>=20
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/input/adb.c            |   2 +
>  hw/misc/mac_via.c         | 166 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  include/hw/misc/mac_via.h |   7 ++
>  3 files changed, 175 insertions(+)
>=20
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index bbb40aeef1..d69ca74364 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -25,6 +25,8 @@
>  #include "hw/input/adb.h"
>  #include "adb-internal.h"
> =20
> +#define ADB_POLL_FREQ 50

A single define without a user in a .c file? Looks suspicious...

As far as I can see, this has been replace by VIA_ADB_POLL_FREQ which
has been introduced in the previous patch already, so you can remove
this define here.

>  /* error codes */
>  #define ADB_RET_NOTPRESENT (-2)
> =20
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 084974a24d..1ec563a707 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
[...]
> +static int adb_via_send(MacVIAState *s, int state, uint8_t data)
> +{
> +    switch (state) {
> +    case ADB_STATE_NEW:
> +        s->adb_data_out_index =3D 0;
> +        break;
> +    case ADB_STATE_EVEN:
> +        if ((s->adb_data_out_index & 1) =3D=3D 0) {
> +            return 0;
> +        }
> +        break;
> +    case ADB_STATE_ODD:
> +        if (s->adb_data_out_index & 1) {
> +            return 0;
> +        }
> +        break;
> +    case ADB_STATE_IDLE:
> +        return 0;
> +    }

Could you please add a

 assert(s->adb_data_out_index < sizeof(s->adb_data_out) -1);

here, just in case?

> +    s->adb_data_out[s->adb_data_out_index++] =3D data;
> +    qemu_irq_raise(s->adb_data_ready);
> +    return 1;
> +}
> +
> +static int adb_via_receive(MacVIAState *s, int state, uint8_t *data)
> +{
> +    switch (state) {
> +    case ADB_STATE_NEW:
> +        return 0;
> +    case ADB_STATE_EVEN:
> +        if (s->adb_data_in_size <=3D 0) {
> +            qemu_irq_raise(s->adb_data_ready);
> +            return 0;
> +        }
> +        if (s->adb_data_in_index >=3D s->adb_data_in_size) {
> +            *data =3D 0;
> +            qemu_irq_raise(s->adb_data_ready);
> +            return 1;
> +        }
> +        if ((s->adb_data_in_index & 1) =3D=3D 0) {
> +            return 0;
> +        }
> +        break;
> +    case ADB_STATE_ODD:
> +        if (s->adb_data_in_size <=3D 0) {
> +            qemu_irq_raise(s->adb_data_ready);
> +            return 0;
> +        }
> +        if (s->adb_data_in_index >=3D s->adb_data_in_size) {
> +            *data =3D 0;
> +            qemu_irq_raise(s->adb_data_ready);
> +            return 1;
> +        }
> +        if (s->adb_data_in_index & 1) {
> +            return 0;
> +        }
> +        break;
> +    case ADB_STATE_IDLE:
> +        if (s->adb_data_out_index =3D=3D 0) {
> +            return 0;
> +        }
> +        s->adb_data_in_size =3D adb_request(&s->adb_bus, s->adb_data_i=
n,
> +                                          s->adb_data_out,
> +                                          s->adb_data_out_index);
> +        s->adb_data_out_index =3D 0;
> +        s->adb_data_in_index =3D 0;
> +        if (s->adb_data_in_size < 0) {
> +            *data =3D 0xff;
> +            qemu_irq_raise(s->adb_data_ready);
> +            return -1;
> +        }
> +        if (s->adb_data_in_size =3D=3D 0) {
> +            return 0;
> +        }
> +        break;
> +    }

Please also add an assert before the next line here - just in case...

> +    *data =3D s->adb_data_in[s->adb_data_in_index++];
> +    qemu_irq_raise(s->adb_data_ready);
> +    if (*data =3D=3D 0xff || *data =3D=3D 0) {
> +        return 0;
> +    }
> +    return 1;
> +}

 Thomas
