Received: from eggs.gnu.org ([209.51.188.92]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gpcK5-0000dk-SR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gpcH6-0005zD-I3
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:06:46 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:46508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gpcH1-0005sk-Qd
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:06:42 -0500
Received: from player739.ha.ovh.net (unknown [10.109.160.143])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 108D81AA918
	for <qemu-devel@nongnu.org>; Fri,  1 Feb 2019 18:06:24 +0100 (CET)
References: <20190121160002.731-1-clg@kaod.org>
	<20190201075557.3obzk5lxzrxvfqoe@fralle-msi>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <27edc980-2bdb-bd6b-efcc-a9b5c1a9c1f1@kaod.org>
Date: Fri, 1 Feb 2019 18:06:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190201075557.3obzk5lxzrxvfqoe@fralle-msi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] m25p80: add basic support for the SFPD
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Max Reitz <mreitz@redhat.com>

Hello Francisco,

On 2/1/19 8:55 AM, Francisco Iglesias wrote:
> Hi Cedric,
>=20
> On [2019 Jan 21] Mon 17:00:02, C=C3=A9dric Le Goater wrote:
>> JEDEC STANDARD JESD216 for Serial Flash Discovery Parameters (SFDP)
>> provides a mean to describe the features of a serial flash device
>> using a set of internal parameter tables.
>>
>> This is the initial framework for the RDSFPD command which is given
>=20
> Is it possible that above should be RDSFDP? (In that case we need to do
> s/PD/DP/ + s/pd/dp/ in the code aswell) =20

ah yes. I completely missed.

>=20
>> access to a private SFPD area under the flash. This area now needs to
>> be populated with the flash device characteristics, presumingly with
>> the values from the FlashPartInfo array.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/block/m25p80.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index e8dfa14b332f..581a9e1fb82e 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -340,6 +340,7 @@ typedef enum {
>>      BULK_ERASE =3D 0xc7,
>>      READ_FSR =3D 0x70,
>>      RDCR =3D 0x15,
>> +    RDSFPD =3D 0x5a,
>> =20
>>      READ =3D 0x03,
>>      READ4 =3D 0x13,
>> @@ -405,6 +406,7 @@ typedef enum {
>>      STATE_COLLECTING_DATA,
>>      STATE_COLLECTING_VAR_LEN_DATA,
>>      STATE_READING_DATA,
>> +    STATE_READING_SFPD,
>>  } CMDState;
>> =20
>>  typedef enum {
>> @@ -456,6 +458,8 @@ typedef struct Flash {
>> =20
>>      int64_t dirty_page;
>> =20
>> +#define M25P80_SFPD_AREA_SIZE 0x100
>> +    uint8_t sfpd_area[M25P80_SFPD_AREA_SIZE];
>>      const FlashPartInfo *pi;
>> =20
>>  } Flash;
>> @@ -626,6 +630,8 @@ static inline int get_addr_length(Flash *s)
>>      }
>> =20
>>     switch (s->cmd_in_progress) {
>> +   case RDSFPD:
>> +       return 3;
>>     case PP4:
>>     case PP4_4:
>>     case QPP_4:
>> @@ -748,11 +754,55 @@ static void complete_collecting_data(Flash *s)
>>                            " by device\n");
>>          }
>>          break;
>> +
>> +    case RDSFPD:
>> +        if (s->cur_addr < M25P80_SFPD_AREA_SIZE) {
>> +            s->state =3D STATE_READING_SFPD;
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "M25P80: Invalid SFPD address %#" PRIx32 "\=
n",
>> +                          s->cur_addr);
>> +        }
>> +        break;
>> +
>>      default:
>>          break;
>>      }
>>  }
>> =20
>> +static void reset_memory_sfpd(Flash *s)
>> +{
>> +    s->sfpd_area[0x00] =3D 'S';
>> +    s->sfpd_area[0x01] =3D 'F';
>> +    s->sfpd_area[0x02] =3D 'P';
>=20
> We also need to swap here so [0x02] =3D=3D 'D' and [0x02] =3D=3D 'P'.

yes.

>=20
>> +    s->sfpd_area[0x03] =3D 'D';
>> +
>> +    s->sfpd_area[0x04] =3D 0x00; /* SFDP Minor Revision Number  */
>> +    s->sfpd_area[0x05] =3D 0x01; /* SFDP Major Revision Number  */
>> +    s->sfpd_area[0x06] =3D 0x01; /* Number of Parameter Headers */
>> +    s->sfpd_area[0x07] =3D 0xFF; /* Unused */
>> +
>> +    s->sfpd_area[0x08] =3D 0x00; /* ID Number. 0x0 : JEDEC */
>> +    s->sfpd_area[0x09] =3D 0x00; /* Parameter Table Minor Revision */
>> +    s->sfpd_area[0x0A] =3D 0x01; /* Parameter Table Major Revision */
>> +    s->sfpd_area[0x0B] =3D 0x09; /* Parameter Table Length (DWORD) */
>> +    s->sfpd_area[0x0C] =3D 0x30; /* Parameter Table Pointer */
>> +    s->sfpd_area[0x0D] =3D 0x00; /* Parameter Table Pointer */
>> +    s->sfpd_area[0x0E] =3D 0x00; /* Parameter Table Pointer */
>> +    s->sfpd_area[0x0F] =3D 0xFF; /* Unused */
>> +
>> +    s->sfpd_area[0x10] =3D s->pi->id[0]; /* ID Number. Manufacturer *=
/
>> +    s->sfpd_area[0x11] =3D 0x00; /* Parameter Table Minor Revision */
>> +    s->sfpd_area[0x12] =3D 0x01; /* Parameter Table Major Revision */
>> +    s->sfpd_area[0x13] =3D 0x04; /* Parameter Table Length (DWORD) */
>> +    s->sfpd_area[0x14] =3D 0x60; /* Parameter Table Pointer */
>> +    s->sfpd_area[0x15] =3D 0x00; /* Parameter Table Pointer */
>> +    s->sfpd_area[0x16] =3D 0x00; /* Parameter Table Pointer */
>> +    s->sfpd_area[0x17] =3D 0xFF; /* Unused */
>> +
>> +    /* TODO: populate accordingly to chip model */
>=20
> Could an option be to move this into the FlashPartInfo perhaps? (Since =
the SFDP
> area will vary between flashes it is maybe easier to scale if put there=
...)

I thought instead we could build it from the FlashPartInfo but it is true
that there will some vendor parts in the SFDP area.

I will take a look at it.

Thanks,

C.

>=20
> Best regards,
> Francisco Iglesias
>=20
>=20
>> +}
>> +
>>  static void reset_memory(Flash *s)
>>  {
>>      s->cmd_in_progress =3D NOP;
>> @@ -822,6 +872,8 @@ static void reset_memory(Flash *s)
>>          break;
>>      }
>> =20
>> +    reset_memory_sfpd(s);
>> +
>>      DB_PRINT_L(0, "Reset done.\n");
>>  }
>> =20
>> @@ -1049,6 +1101,13 @@ static void decode_new_cmd(Flash *s, uint32_t v=
alue)
>>          s->state =3D STATE_READING_DATA;
>>          break;
>> =20
>> +    case RDSFPD:
>> +        s->needed_bytes =3D get_addr_length(s) + 1 ; /* SFPD addr + d=
ummy */
>> +        s->pos =3D 0;
>> +        s->len =3D 0;
>> +        s->state =3D STATE_COLLECTING_DATA;
>> +        break;
>> +
>>      case RDCR:
>>          s->data[0] =3D s->volatile_cfg & 0xFF;
>>          s->data[0] |=3D (!!s->four_bytes_address_mode) << 5;
>> @@ -1241,6 +1300,8 @@ static uint32_t m25p80_transfer8(SSISlave *ss, u=
int32_t tx)
>>          }
>> =20
>>          r =3D s->data[s->pos];
>> +        DB_PRINT_L(1, "READ DATA 0x%" PRIx32 "=3D%" PRIx8 "\n", s->po=
s,
>> +                   (uint8_t)r);
>>          s->pos++;
>>          if (s->pos =3D=3D s->len) {
>>              s->pos =3D 0;
>> @@ -1249,6 +1310,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, =
uint32_t tx)
>>              }
>>          }
>>          break;
>> +    case STATE_READING_SFPD:
>> +        r =3D s->sfpd_area[s->cur_addr];
>> +        DB_PRINT_L(1, "READ SFPD 0x%" PRIx32 "=3D%" PRIx8 "\n", s->cu=
r_addr,
>> +                   (uint8_t)r);
>> +        s->cur_addr =3D (s->cur_addr + 1) & (M25P80_SFPD_AREA_SIZE - =
1);
>> +        break;
>> =20
>>      default:
>>      case STATE_IDLE:
>> --=20
>> 2.20.1
>>
>>
