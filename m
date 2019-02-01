Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpfVq-00067z-6H
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpfKG-00042r-1h
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:22:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpfKF-000410-SQ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:22:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so8428260wrt.7
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 12:22:10 -0800 (PST)
References: <20190121160002.731-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <90c617c0-7505-23db-142f-c9f63353c7d6@redhat.com>
Date: Fri, 1 Feb 2019 21:22:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190121160002.731-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Max Reitz <mreitz@redhat.com>

Hi Cédric,

On 1/21/19 5:00 PM, Cédric Le Goater wrote:
> JEDEC STANDARD JESD216 for Serial Flash Discovery Parameters (SFDP)
> provides a mean to describe the features of a serial flash device
> using a set of internal parameter tables.
> 
> This is the initial framework for the RDSFPD command which is given
> access to a private SFPD area under the flash. This area now needs to
> be populated with the flash device characteristics, presumingly with
> the values from the FlashPartInfo array.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/block/m25p80.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index e8dfa14b332f..581a9e1fb82e 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -340,6 +340,7 @@ typedef enum {
>      BULK_ERASE = 0xc7,
>      READ_FSR = 0x70,
>      RDCR = 0x15,
> +    RDSFPD = 0x5a,
>  
>      READ = 0x03,
>      READ4 = 0x13,
> @@ -405,6 +406,7 @@ typedef enum {
>      STATE_COLLECTING_DATA,
>      STATE_COLLECTING_VAR_LEN_DATA,
>      STATE_READING_DATA,
> +    STATE_READING_SFPD,
>  } CMDState;
>  
>  typedef enum {
> @@ -456,6 +458,8 @@ typedef struct Flash {
>  
>      int64_t dirty_page;
>  
> +#define M25P80_SFPD_AREA_SIZE 0x100
> +    uint8_t sfpd_area[M25P80_SFPD_AREA_SIZE];
>      const FlashPartInfo *pi;
>  
>  } Flash;
> @@ -626,6 +630,8 @@ static inline int get_addr_length(Flash *s)
>      }
>  
>     switch (s->cmd_in_progress) {
> +   case RDSFPD:
> +       return 3;
>     case PP4:
>     case PP4_4:
>     case QPP_4:
> @@ -748,11 +754,55 @@ static void complete_collecting_data(Flash *s)
>                            " by device\n");
>          }
>          break;
> +
> +    case RDSFPD:
> +        if (s->cur_addr < M25P80_SFPD_AREA_SIZE) {
> +            s->state = STATE_READING_SFPD;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "M25P80: Invalid SFPD address %#" PRIx32 "\n",
> +                          s->cur_addr);
> +        }
> +        break;
> +
>      default:
>          break;
>      }
>  }
>  
> +static void reset_memory_sfpd(Flash *s)
> +{
> +    s->sfpd_area[0x00] = 'S';
> +    s->sfpd_area[0x01] = 'F';
> +    s->sfpd_area[0x02] = 'P';
> +    s->sfpd_area[0x03] = 'D';
> +
> +    s->sfpd_area[0x04] = 0x00; /* SFDP Minor Revision Number  */
> +    s->sfpd_area[0x05] = 0x01; /* SFDP Major Revision Number  */
> +    s->sfpd_area[0x06] = 0x01; /* Number of Parameter Headers */
> +    s->sfpd_area[0x07] = 0xFF; /* Unused */
> +
> +    s->sfpd_area[0x08] = 0x00; /* ID Number. 0x0 : JEDEC */
> +    s->sfpd_area[0x09] = 0x00; /* Parameter Table Minor Revision */
> +    s->sfpd_area[0x0A] = 0x01; /* Parameter Table Major Revision */
> +    s->sfpd_area[0x0B] = 0x09; /* Parameter Table Length (DWORD) */
> +    s->sfpd_area[0x0C] = 0x30; /* Parameter Table Pointer */
> +    s->sfpd_area[0x0D] = 0x00; /* Parameter Table Pointer */
> +    s->sfpd_area[0x0E] = 0x00; /* Parameter Table Pointer */
> +    s->sfpd_area[0x0F] = 0xFF; /* Unused */
> +
> +    s->sfpd_area[0x10] = s->pi->id[0]; /* ID Number. Manufacturer */
> +    s->sfpd_area[0x11] = 0x00; /* Parameter Table Minor Revision */
> +    s->sfpd_area[0x12] = 0x01; /* Parameter Table Major Revision */
> +    s->sfpd_area[0x13] = 0x04; /* Parameter Table Length (DWORD) */
> +    s->sfpd_area[0x14] = 0x60; /* Parameter Table Pointer */
> +    s->sfpd_area[0x15] = 0x00; /* Parameter Table Pointer */
> +    s->sfpd_area[0x16] = 0x00; /* Parameter Table Pointer */
> +    s->sfpd_area[0x17] = 0xFF; /* Unused */
> +
> +    /* TODO: populate accordingly to chip model */

Shouldn't this be filled with 0xFF meanwhile?

> +}
> +
>  static void reset_memory(Flash *s)
>  {
>      s->cmd_in_progress = NOP;
> @@ -822,6 +872,8 @@ static void reset_memory(Flash *s)
>          break;
>      }
>  
> +    reset_memory_sfpd(s);

I understand this info is const, so we can move this to the realize()
function to call it only once. Maybe you can rename it prepare_sfdp() or
build_sfdp()?

> +
>      DB_PRINT_L(0, "Reset done.\n");
>  }
>  
> @@ -1049,6 +1101,13 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>          s->state = STATE_READING_DATA;
>          break;
>  
> +    case RDSFPD:
> +        s->needed_bytes = get_addr_length(s) + 1 ; /* SFPD addr + dummy */
> +        s->pos = 0;
> +        s->len = 0;
> +        s->state = STATE_COLLECTING_DATA;
> +        break;
> +
>      case RDCR:
>          s->data[0] = s->volatile_cfg & 0xFF;
>          s->data[0] |= (!!s->four_bytes_address_mode) << 5;
> @@ -1241,6 +1300,8 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>          }
>  
>          r = s->data[s->pos];
> +        DB_PRINT_L(1, "READ DATA 0x%" PRIx32 "=%" PRIx8 "\n", s->pos,
> +                   (uint8_t)r);
>          s->pos++;
>          if (s->pos == s->len) {
>              s->pos = 0;
> @@ -1249,6 +1310,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>              }
>          }
>          break;
> +    case STATE_READING_SFPD:
> +        r = s->sfpd_area[s->cur_addr];
> +        DB_PRINT_L(1, "READ SFPD 0x%" PRIx32 "=%" PRIx8 "\n", s->cur_addr,
> +                   (uint8_t)r);
> +        s->cur_addr = (s->cur_addr + 1) & (M25P80_SFPD_AREA_SIZE - 1);
> +        break;
>  
>      default:
>      case STATE_IDLE:
> 
