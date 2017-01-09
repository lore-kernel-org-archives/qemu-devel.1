Received: from eggs.gnu.org ([2001:4830:134:3::10]:41712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQV61-0003GY-0l
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQV5z-0001Wn-Qh
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:14:25 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:52638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQV5z-0001W6-KS
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:14:23 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8D4D9C509
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 09:14:22 +0100 (CET)
References: <20170108083854.5006-1-mar.krzeminski@gmail.com>
	<20170108083854.5006-3-mar.krzeminski@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <eb0f4ebe-f5f4-bd1f-7fe1-e3ed9aa2635f@kaod.org>
Date: Mon, 9 Jan 2017 09:14:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170108083854.5006-3-mar.krzeminski@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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
To: Marcin Krzeminski <mar.krzeminski@gmail.com>, qemu-devel@nongnu.org, edgar.iglesias@xilinx.com
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 01/08/2017 09:38 AM, Marcin Krzeminski wrote:
> Modern big flash nor devices consist from more than one die.
> Some of them do not support chip erase and instead have die
> erase command that can erase one die only. This commit adds
> possibility to define number of dies in the chip and adds
> support for die erase command. Nor flash model is not strict
> thus option to disable chip eras was not added.
>=20
> Signed-off-by: Marcin Krzeminski <mar.krzeminski@gmail.com>


Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/block/m25p80.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 6dff81b..a9b025b 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -73,6 +73,12 @@ typedef struct FlashPartInfo {
>      uint32_t n_sectors;
>      uint32_t page_size;
>      uint16_t flags;
> +    /*
> +     * Big sized spi nor are often stacked devices, thus sometime
> +     * replace chip erase with die erase.
> +     * This field inform how many die is in the chip.
> +     */
> +    uint8_t die_cnt;
>  } FlashPartInfo;
> =20
>  /* adapted from linux */
> @@ -90,7 +96,8 @@ typedef struct FlashPartInfo {
>      .sector_size =3D (_sector_size),\
>      .n_sectors =3D (_n_sectors),\
>      .page_size =3D 256,\
> -    .flags =3D (_flags),
> +    .flags =3D (_flags),\
> +    .die_cnt =3D 0
> =20
>  #define INFO6(_part_name, _jedec_id, _ext_id, _sector_size, _n_sectors=
, _flags)\
>      .part_name =3D _part_name,\
> @@ -107,6 +114,24 @@ typedef struct FlashPartInfo {
>      .n_sectors =3D (_n_sectors),\
>      .page_size =3D 256,\
>      .flags =3D (_flags),\
> +    .die_cnt =3D 0
> +
> +#define INFO_STACKED(_part_name, _jedec_id, _ext_id, _sector_size, _n_=
sectors,\
> +                    _flags, _die_cnt)\
> +    .part_name =3D _part_name,\
> +    .id =3D {\
> +        ((_jedec_id) >> 16) & 0xff,\
> +        ((_jedec_id) >> 8) & 0xff,\
> +        (_jedec_id) & 0xff,\
> +        ((_ext_id) >> 8) & 0xff,\
> +        (_ext_id) & 0xff,\
> +          },\
> +    .id_len =3D (!(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0))),\
> +    .sector_size =3D (_sector_size),\
> +    .n_sectors =3D (_n_sectors),\
> +    .page_size =3D 256,\
> +    .flags =3D (_flags),\
> +    .die_cnt =3D _die_cnt
> =20
>  #define JEDEC_NUMONYX 0x20
>  #define JEDEC_WINBOND 0xEF
> @@ -359,6 +384,8 @@ typedef enum {
> =20
>      REVCR =3D 0x65,
>      WEVCR =3D 0x61,
> +
> +    DIE_ERASE =3D 0xC4,
>  } FlashCMD;
> =20
>  typedef enum {
> @@ -514,6 +541,16 @@ static void flash_erase(Flash *s, int offset, Flas=
hCMD cmd)
>      case BULK_ERASE:
>          len =3D s->size;
>          break;
> +    case DIE_ERASE:
> +        if (s->pi->die_cnt) {
> +            len =3D s->size / s->pi->die_cnt;
> +            offset =3D offset & (~(len - 1));
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: die erase is not s=
upported"
> +                          " by device\n");
> +            return;
> +        }
> +        break;
>      default:
>          abort();
>      }
> @@ -635,6 +672,7 @@ static void complete_collecting_data(Flash *s)
>      case ERASE4_32K:
>      case ERASE_SECTOR:
>      case ERASE4_SECTOR:
> +    case DIE_ERASE:
>          flash_erase(s, s->cur_addr, s->cmd_in_progress);
>          break;
>      case WRSR:
> @@ -881,6 +919,7 @@ static void decode_new_cmd(Flash *s, uint32_t value=
)
>      case PP:
>      case PP4:
>      case PP4_4:
> +    case DIE_ERASE:
>          s->needed_bytes =3D get_addr_length(s);
>          s->pos =3D 0;
>          s->len =3D 0;
>=20
