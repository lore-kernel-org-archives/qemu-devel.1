Received: from eggs.gnu.org ([2001:4830:134:3::10]:57398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1cQbjj-0004Zb-R9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1cQbje-0001oq-RA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:19:51 -0500
Date: Mon, 9 Jan 2017 16:05:38 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170109150538.GK14990@toto>
References: <20170108083854.5006-1-mar.krzeminski@gmail.com>
	<20170108083854.5006-3-mar.krzeminski@gmail.com>
	<20170109111004.GH14990@toto>
	<CABc_YGBqDSO+fysXjnUBdeLBJsNC2pO6sNpf3L_juPfjfCXUeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABc_YGBqDSO+fysXjnUBdeLBJsNC2pO6sNpf3L_juPfjfCXUeQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] block: m25p80: Introduce die erase
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcin =?utf-8?Q?Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>

On Mon, Jan 09, 2017 at 12:44:43PM +0100, Marcin Krzemi=C5=84ski wrote:
> 2017-01-09 12:10 GMT+01:00 Edgar E. Iglesias <edgar.iglesias@xilinx.com>:
> > On Sun, Jan 08, 2017 at 09:38:53AM +0100, Marcin Krzeminski wrote:
> >> Modern big flash nor devices consist from more than one die.
> >> Some of them do not support chip erase and instead have die
> >> erase command that can erase one die only. This commit adds
> >> possibility to define number of dies in the chip and adds
> >> support for die erase command. Nor flash model is not strict
> >> thus option to disable chip eras was not added.
> >                                  ^^
> >                               erase
> >
> > The commit message could be improved but codewise this looks
> > good to me:
>=20
> Beside fixing the typo, some more information/changes should I add?

It's not very important but:

I'm not a native english speaker but here are a few suggestions:
I would suggest spelling out NOR flashes to avoid confusion with
the word nor.

I also think it should say

"... devices consist of more than one die."
"This commit adds support for defining the number of dies..."

Perhaps Peter can suggest something better.

Cheers,
Edgar


>=20
> Thanks,
> Marcin
> >
> > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> >
> >
> >>
> >> Signed-off-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
> >> ---
> >>  hw/block/m25p80.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 40 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> >> index 6dff81b..a9b025b 100644
> >> --- a/hw/block/m25p80.c
> >> +++ b/hw/block/m25p80.c
> >> @@ -73,6 +73,12 @@ typedef struct FlashPartInfo {
> >>      uint32_t n_sectors;
> >>      uint32_t page_size;
> >>      uint16_t flags;
> >> +    /*
> >> +     * Big sized spi nor are often stacked devices, thus sometime
> >> +     * replace chip erase with die erase.
> >> +     * This field inform how many die is in the chip.
> >> +     */
> >> +    uint8_t die_cnt;
> >>  } FlashPartInfo;
> >>
> >>  /* adapted from linux */
> >> @@ -90,7 +96,8 @@ typedef struct FlashPartInfo {
> >>      .sector_size =3D (_sector_size),\
> >>      .n_sectors =3D (_n_sectors),\
> >>      .page_size =3D 256,\
> >> -    .flags =3D (_flags),
> >> +    .flags =3D (_flags),\
> >> +    .die_cnt =3D 0
> >>
> >>  #define INFO6(_part_name, _jedec_id, _ext_id, _sector_size, _n_sector=
s, _flags)\
> >>      .part_name =3D _part_name,\
> >> @@ -107,6 +114,24 @@ typedef struct FlashPartInfo {
> >>      .n_sectors =3D (_n_sectors),\
> >>      .page_size =3D 256,\
> >>      .flags =3D (_flags),\
> >> +    .die_cnt =3D 0
> >> +
> >> +#define INFO_STACKED(_part_name, _jedec_id, _ext_id, _sector_size, _n=
_sectors,\
> >> +                    _flags, _die_cnt)\
> >> +    .part_name =3D _part_name,\
> >> +    .id =3D {\
> >> +        ((_jedec_id) >> 16) & 0xff,\
> >> +        ((_jedec_id) >> 8) & 0xff,\
> >> +        (_jedec_id) & 0xff,\
> >> +        ((_ext_id) >> 8) & 0xff,\
> >> +        (_ext_id) & 0xff,\
> >> +          },\
> >> +    .id_len =3D (!(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0))),\
> >> +    .sector_size =3D (_sector_size),\
> >> +    .n_sectors =3D (_n_sectors),\
> >> +    .page_size =3D 256,\
> >> +    .flags =3D (_flags),\
> >> +    .die_cnt =3D _die_cnt
> >>
> >>  #define JEDEC_NUMONYX 0x20
> >>  #define JEDEC_WINBOND 0xEF
> >> @@ -359,6 +384,8 @@ typedef enum {
> >>
> >>      REVCR =3D 0x65,
> >>      WEVCR =3D 0x61,
> >> +
> >> +    DIE_ERASE =3D 0xC4,
> >>  } FlashCMD;
> >>
> >>  typedef enum {
> >> @@ -514,6 +541,16 @@ static void flash_erase(Flash *s, int offset, Fla=
shCMD cmd)
> >>      case BULK_ERASE:
> >>          len =3D s->size;
> >>          break;
> >> +    case DIE_ERASE:
> >> +        if (s->pi->die_cnt) {
> >> +            len =3D s->size / s->pi->die_cnt;
> >> +            offset =3D offset & (~(len - 1));
> >> +        } else {
> >> +            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: die erase is not =
supported"
> >> +                          " by device\n");
> >> +            return;
> >> +        }
> >> +        break;
> >>      default:
> >>          abort();
> >>      }
> >> @@ -635,6 +672,7 @@ static void complete_collecting_data(Flash *s)
> >>      case ERASE4_32K:
> >>      case ERASE_SECTOR:
> >>      case ERASE4_SECTOR:
> >> +    case DIE_ERASE:
> >>          flash_erase(s, s->cur_addr, s->cmd_in_progress);
> >>          break;
> >>      case WRSR:
> >> @@ -881,6 +919,7 @@ static void decode_new_cmd(Flash *s, uint32_t valu=
e)
> >>      case PP:
> >>      case PP4:
> >>      case PP4_4:
> >> +    case DIE_ERASE:
> >>          s->needed_bytes =3D get_addr_length(s);
> >>          s->pos =3D 0;
> >>          s->len =3D 0;
> >> --
> >> 2.9.3
> >>
