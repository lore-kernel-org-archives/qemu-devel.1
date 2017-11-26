Received: from eggs.gnu.org ([2001:4830:134:3::10]:35979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eJ5HU-0006uD-FC
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 17:20:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eJ5HS-00042g-Vf
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 17:20:08 -0500
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:43757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eJ5HS-00042J-M5
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 17:20:06 -0500
Received: by mail-pl0-x22e.google.com with SMTP id s23so2035025plk.10
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 14:20:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <64ae00a4-d66c-b067-5bf4-b3be6fcf0822@amsat.org>
References: <20171124212938.7074-1-frasse.iglesias@gmail.com>
	<20171124212938.7074-3-frasse.iglesias@gmail.com>
	<64ae00a4-d66c-b067-5bf4-b3be6fcf0822@amsat.org>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Sun, 26 Nov 2017 23:20:04 +0100
Message-ID: <CAAYMZQvcWb-vb9NgEUd2fuCHyFi3Z-BcJqBaDZxF5kmaOYWDrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 02/13] m25p80: Add support for SST READ
 ID 0x90/0xAB commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>, "mar.krzeminski" <mar.krzeminski@gmail.com>

On 26 November 2017 at 01:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
wrote:

> Hi Francisco,
>
> On 11/24/2017 06:29 PM, Francisco Iglesias wrote:
> > Add support for SST READ ID 0x90/0xAB commands for reading out the flas=
h
> > manufacuter ID and device ID.
> >
> > Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> > Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> > Acked-by: Marcin Krzemi=C5=84ski <mar.krzeminski@gmail.com>
> > ---
> >  hw/block/m25p80.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> > index d50acc1..9d20120 100644
> > --- a/hw/block/m25p80.c
> > +++ b/hw/block/m25p80.c
> > @@ -355,6 +355,8 @@ typedef enum {
> >      DPP =3D 0xa2,
> >      QPP =3D 0x32,
> >      QPP_4 =3D 0x34,
> > +    RDID_90 =3D 0x90,
> > +    RDID_AB =3D 0xab,
> >
> >      ERASE_4K =3D 0x20,
> >      ERASE4_4K =3D 0x21,
> > @@ -405,6 +407,7 @@ typedef enum {
> >      MAN_MACRONIX,
> >      MAN_NUMONYX,
> >      MAN_WINBOND,
> > +    MAN_SST,
> >      MAN_GENERIC,
> >  } Manufacturer;
> >
> > @@ -476,6 +479,8 @@ static inline Manufacturer get_man(Flash *s)
> >          return MAN_SPANSION;
> >      case 0xC2:
> >          return MAN_MACRONIX;
> > +    case 0xBF:
> > +        return MAN_SST;
> >      default:
> >          return MAN_GENERIC;
> >      }
> > @@ -711,6 +716,22 @@ static void complete_collecting_data(Flash *s)
> >      case WEVCR:
> >          s->enh_volatile_cfg =3D s->data[0];
> >          break;
> > +    case RDID_90:
> > +    case RDID_AB:
> > +        if (get_man(s) =3D=3D MAN_SST && s->cur_addr <=3D 1) {
>
> What about reporting if guest access this address when not an SST flash?
>
>            if (get_man(s) =3D=3D MAN_SST) {
>                if (s->cur_addr <=3D 1) {
>
> > +            if (s->cur_addr) {
> > +                s->data[0] =3D s->pi->id[2];
> > +                s->data[1] =3D s->pi->id[0];
> > +            } else {
> > +                s->data[0] =3D s->pi->id[0];
> > +                s->data[1] =3D s->pi->id[2];
> > +            }
> > +            s->pos =3D 0;
> > +            s->len =3D 2;
> > +            s->data_read_loop =3D true;
> > +            s->state =3D STATE_READING_DATA;
>
>                } else {
>                     // LOG_UNIMP?
>                }
>            } else {
>                qemu_log_mask(LOG_GUEST_ERROR, ...);
>

Dear Philippe,

Thank you very much for reviewing! I will add the logs in the next version
of the patch series (v9).

Best regards,
Francisco Iglesias




>
> > +        }
> > +        break;
> >      default:
> >          break;
> >      }
> > @@ -926,6 +947,8 @@ static void decode_new_cmd(Flash *s, uint32_t value=
)
> >      case PP4:
> >      case PP4_4:
> >      case DIE_ERASE:
> > +    case RDID_90:
> > +    case RDID_AB:
> >          s->needed_bytes =3D get_addr_length(s);
> >          s->pos =3D 0;
> >          s->len =3D 0;
>
> Regards,
>
> Phil.
>
