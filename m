Received: from eggs.gnu.org ([2001:4830:134:3::10]:50781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1eAift-0005to-SR
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1eAifq-00084G-Mw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:34:45 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:45697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1eAifq-00083p-5k
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:34:42 -0400
Received: by mail-lf0-x22c.google.com with SMTP id n69so4507111lfn.2
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 13:34:42 -0700 (PDT)
References: <20171103000109.28244-1-frasse.iglesias@gmail.com>
	<20171103000109.28244-2-frasse.iglesias@gmail.com>
	<7499c4ec-1a04-a8bf-c69e-e0414bd33f2a@gmail.com>
	<CAAYMZQstEtdM2q=GXzMREGKjV9LaxmrqLiHYrfNpR_6_iWOZfA@mail.gmail.com>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <48860d08-084a-3b68-86fc-1d8fbf3131bc@gmail.com>
Date: Fri, 3 Nov 2017 21:34:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAAYMZQstEtdM2q=GXzMREGKjV9LaxmrqLiHYrfNpR_6_iWOZfA@mail.gmail.com>
Content-Language: pl
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 01/13] m25p80: Add support for
 continuous read out of RDSR and READ_FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: francisco iglesias <frasse.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, peter.maydell@linaro.org

W dniu 03.11.2017 o 18:25, francisco iglesias pisze:
> Hi Marcin,
>
> Huge thank you once again! This time not only for reviewing but also 
> for having this patience with me!
>
No problem!
> I wish you a great wekeend!
The same to you,

Regards,
Marcin
>
> Best regards,
> Francisco Iglesias
>
> On 3 Nov 2017 17:18, "mar.krzeminski" <mar.krzeminski@gmail.com 
> <mailto:mar.krzeminski@gmail.com>> wrote:
>
>
>
>     W dniu 03.11.2017 o 01:00, Francisco Iglesias pisze:
>>     Add support for continuous read out of the RDSR and READ_FSR status
>>     registers until the chip select is deasserted. This feature is supported
>>     by amongst others 1 or more flashtypes manufactured by Numonyx (Micron),
>>     Windbond, SST, Gigadevice, Eon and Macronix.
>>
>>     Signed-off-by: Francisco Iglesias<frasse.iglesias@gmail.com> <mailto:frasse.iglesias@gmail.com>
>
>     Acked-by: Marcin Krzemiński<mar.krzeminski@gmail.com> <mailto:mar.krzeminski@gmail.com>
>
>     Regards,
>     Marcin
>
>>     ---
>>       hw/block/m25p80.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>       1 file changed, 38 insertions(+), 1 deletion(-)
>>
>>     diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>     index a2438b9..d50acc1 100644
>>     --- a/hw/block/m25p80.c
>>     +++ b/hw/block/m25p80.c
>>     @@ -423,6 +423,7 @@ typedef struct Flash {
>>           uint8_t data[M25P80_INTERNAL_DATA_BUFFER_SZ];
>>           uint32_t len;
>>           uint32_t pos;
>>     +    bool data_read_loop;
>>           uint8_t needed_bytes;
>>           uint8_t cmd_in_progress;
>>           uint32_t cur_addr;
>>     @@ -983,6 +984,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>               }
>>               s->pos = 0;
>>               s->len = 1;
>>     +        s->data_read_loop = true;
>>               s->state = STATE_READING_DATA;
>>               break;
>>       
>>     @@ -993,6 +995,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>               }
>>               s->pos = 0;
>>               s->len = 1;
>>     +        s->data_read_loop = true;
>>               s->state = STATE_READING_DATA;
>>               break;
>>       
>>     @@ -1133,6 +1136,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>>               s->pos = 0;
>>               s->state = STATE_IDLE;
>>               flash_sync_dirty(s, -1);
>>     +        s->data_read_loop = false;
>>           }
>>       
>>           DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
>>     @@ -1198,7 +1202,9 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>>               s->pos++;
>>               if (s->pos == s->len) {
>>                   s->pos = 0;
>>     -            s->state = STATE_IDLE;
>>     +            if (!s->data_read_loop) {
>>     +                s->state = STATE_IDLE;
>>     +            }
>>               }
>>               break;
>>       
>>     @@ -1269,11 +1275,38 @@ static Property m25p80_properties[] = {
>>           DEFINE_PROP_END_OF_LIST(),
>>       };
>>       
>>     +static int m25p80_pre_load(void *opaque)
>>     +{
>>     +    Flash *s = (Flash *)opaque;
>>     +
>>     +    s->data_read_loop = false;
>>     +    return 0;
>>     +}
>>     +
>>     +static bool m25p80_data_read_loop_needed(void *opaque)
>>     +{
>>     +    Flash *s = (Flash *)opaque;
>>     +
>>     +    return s->data_read_loop;
>>     +}
>>     +
>>     +static const VMStateDescription vmstate_m25p80_data_read_loop = {
>>     +    .name = "m25p80/data_read_loop",
>>     +    .version_id = 1,
>>     +    .minimum_version_id = 1,
>>     +    .needed = m25p80_data_read_loop_needed,
>>     +    .fields = (VMStateField[]) {
>>     +        VMSTATE_BOOL(data_read_loop, Flash),
>>     +        VMSTATE_END_OF_LIST()
>>     +    }
>>     +};
>>     +
>>       static const VMStateDescription vmstate_m25p80 = {
>>           .name = "m25p80",
>>           .version_id = 0,
>>           .minimum_version_id = 0,
>>           .pre_save = m25p80_pre_save,
>>     +    .pre_load = m25p80_pre_load,
>>           .fields = (VMStateField[]) {
>>               VMSTATE_UINT8(state, Flash),
>>               VMSTATE_UINT8_ARRAY(data, Flash, M25P80_INTERNAL_DATA_BUFFER_SZ),
>>     @@ -1295,6 +1328,10 @@ static const VMStateDescription vmstate_m25p80 = {
>>               VMSTATE_UINT8(spansion_cr3nv, Flash),
>>               VMSTATE_UINT8(spansion_cr4nv, Flash),
>>               VMSTATE_END_OF_LIST()
>>     +    },
>>     +    .subsections = (const VMStateDescription * []) {
>>     +        &vmstate_m25p80_data_read_loop,
>>     +        NULL
>>           }
>>       };
>>       
>
