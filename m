Received: from eggs.gnu.org ([2001:4830:134:3::10]:60555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cIrYA-0001kP-2B
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cIrY5-0005dX-Rm
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:35:54 -0500
From: "Krzeminski, Marcin (Nokia - PL/Wroclaw)" <marcin.krzeminski@nokia.com>
Date: Mon, 19 Dec 2016 06:21:13 +0000
Message-ID: <AM4PR0701MB21305D92F87BC4C9568C14F6FE910@AM4PR0701MB2130.eurprd07.prod.outlook.com>
References: <1481894862-14102-1-git-send-email-marcin.krzeminski@nokia.com>
	<1481894862-14102-3-git-send-email-marcin.krzeminski@nokia.com>
	<20161216163542.GQ9606@toto>
In-Reply-To: <20161216163542.GQ9606@toto>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] block: m25p80: Introduce
 Die Erase command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "rfsw-patches@mlist.nokia.com" <rfsw-patches@mlist.nokia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>



> -----Original Message-----
> From: Edgar E. Iglesias [mailto:edgar.iglesias@gmail.com]
> Sent: Friday, December 16, 2016 5:36 PM
> To: Krzeminski, Marcin (Nokia - PL/Wroclaw)
> <marcin.krzeminski@nokia.com>
> Cc: qemu-devel@nongnu.org; peter.maydell@linaro.org; rfsw-
> patches@mlist.nokia.com; qemu-arm@nongnu.org; clg@kaod.org
> Subject: Re: [Qemu-arm] [PATCH 2/2] block: m25p80: Introduce Die Erase
> command
>=20
> On Fri, Dec 16, 2016 at 02:27:42PM +0100, marcin.krzeminski@nokia.com
> wrote:
> > From: Marcin Krzeminski <marcin.krzeminski@nokia.com>
> >
> > Big flash chips (like mt25qu01g) are consisted from dies.
> > Because of that some manufactures remove support for Chip Erase giving
> > Die Erase command instead.To avoid unnecessary code complication,
> > support for chip erase for mt25qu01g is not removed.
> >
> > Signed-off-by: Marcin Krzeminski <marcin.krzeminski@nokia.com>
> > ---
> >  hw/block/m25p80.c | 33 +++++++++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c index
> > 2bc7028..0bc1fbf 100644
> > --- a/hw/block/m25p80.c
> > +++ b/hw/block/m25p80.c
> > @@ -216,8 +216,8 @@ static const FlashPartInfo known_devices[] =3D {
> >      { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
> >      { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
> >      { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
> > -    { INFO("mt25ql01g",   0x20ba21,      0,  64 << 10, 2048, ER_4K) },
> > -    { INFO("mt25qu01g",   0x20bb21,      0,  64 << 10, 2048, ER_4K) },
> > +    { INFO("mt25ql01g",   0x20ba21, 0x1040,  64 << 10, 2048, ER_4K) },
> > +    { INFO("mt25qu01g",   0x20bb21, 0x1040,  64 << 10, 2048, ER_4K) },
> >
> >      /* Spansion -- single (large) sector size only, at least
> >       * for the chips listed here (without boot sectors).
> > @@ -358,6 +358,8 @@ typedef enum {
> >
> >      REVCR =3D 0x65,
> >      WEVCR =3D 0x61,
> > +
> > +    DIE_ERASE =3D 0xC4,
> >  } FlashCMD;
> >
> >  typedef enum {
> > @@ -411,6 +413,7 @@ typedef struct Flash {
> >      bool reset_enable;
> >      bool quad_enable;
> >      uint8_t ear;
> > +    uint32_t die_cnt;
> >
> >      int64_t dirty_page;
> >
> > @@ -492,7 +495,7 @@ static inline void flash_sync_area(Flash *s,
> > int64_t off, int64_t len)
> >
> >  static void flash_erase(Flash *s, int offset, FlashCMD cmd)  {
> > -    uint32_t len;
> > +    uint32_t len =3D 0;
>=20
> Do you really need this?

Compilation warning.
>=20
> >      uint8_t capa_to_assert =3D 0;
> >
> >      switch (cmd) {
> > @@ -513,6 +516,16 @@ static void flash_erase(Flash *s, int offset,
> FlashCMD cmd)
> >      case BULK_ERASE:
> >          len =3D s->size;
> >          break;
> > +    case DIE_ERASE:
> > +        if (s->die_cnt) {
> > +            len =3D s->size / s->die_cnt;
> > +            offset =3D offset & (~(len-1));
> > +        } else {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: %d die erase not
> supported by"
> > +                          " device\n", len);
> > +            return;
> > +        }
> > +        break;
> >      default:
> >          abort();
> >      }
> > @@ -634,6 +647,7 @@ static void complete_collecting_data(Flash *s)
> >      case ERASE4_32K:
> >      case ERASE_SECTOR:
> >      case ERASE4_SECTOR:
> > +    case DIE_ERASE:
> >          flash_erase(s, s->cur_addr, s->cmd_in_progress);
> >          break;
> >      case WRSR:
> > @@ -684,6 +698,7 @@ static void reset_memory(Flash *s)
> >      s->write_enable =3D false;
> >      s->reset_enable =3D false;
> >      s->quad_enable =3D false;
> > +    s->die_cnt =3D 0;
> >
> >      switch (get_man(s)) {
> >      case MAN_NUMONYX:
> > @@ -716,7 +731,15 @@ static void reset_memory(Flash *s)
> >              s->four_bytes_address_mode =3D true;
> >          }
> >          if (!(s->nonvolatile_cfg & NVCFG_LOWER_SEGMENT_MASK)) {
> > -            s->ear =3D s->size / MAX_3BYTES_SIZE - 1;
> > +            s->ear =3D ( s->size > MAX_3BYTES_SIZE ? s->size / MAX_3BY=
TES_SIZE
> - 1 : 0);
> > +        }
> > +        /* 1GiB devices */
> > +        if (s->pi->id[2] =3D=3D 0x21) {
> > +            /* MT25Q00 has 2 dies N25Q00 has 4 */
> > +            if (s->pi->id[4] & BIT(6))
> > +                s->die_cnt =3D 2;
> > +            else
> > +                s->die_cnt =3D 4;
>=20
> Decoding of die_cnt should probably be done in realize().
>=20
> >          }
> >          break;
> >      case MAN_MACRONIX:
> > @@ -880,6 +903,7 @@ static void decode_new_cmd(Flash *s, uint32_t
> value)
> >      case PP:
> >      case PP4:
> >      case PP4_4:
> > +    case DIE_ERASE:
> >          s->needed_bytes =3D get_addr_length(s);
> >          s->pos =3D 0;
> >          s->len =3D 0;
> > @@ -1217,6 +1241,7 @@ static const VMStateDescription vmstate_m25p80
> =3D {
> >          VMSTATE_UINT8(spansion_cr2nv, Flash),
> >          VMSTATE_UINT8(spansion_cr3nv, Flash),
> >          VMSTATE_UINT8(spansion_cr4nv, Flash),
> > +        VMSTATE_UINT32(die_cnt, Flash),
>=20
> die_cnt is fixed per instance. Since it doesn't change, it doesn't need t=
o be
> part of VMSTATE.

Yes, you are right. Even more, number of a dies is fixed attribute of chip,=
 so it could
Be a part of FlashPartInfo. I'll up v2.

Thanks,
Marcin

>=20
> >          VMSTATE_END_OF_LIST()
> >      }
> >  };
> > --
> > 2.7.4
> >
> >
