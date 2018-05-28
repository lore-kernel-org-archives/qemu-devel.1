Received: from eggs.gnu.org ([2001:4830:134:3::10]:46624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNNNo-00078K-IA
	for qemu-devel@nongnu.org; Mon, 28 May 2018 15:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNNNj-0007Ei-Mj
	for qemu-devel@nongnu.org; Mon, 28 May 2018 15:00:40 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNNNi-0007Dp-Uy
	for qemu-devel@nongnu.org; Mon, 28 May 2018 15:00:35 -0400
Received: by mail-qt0-x244.google.com with SMTP id d3-v6so15894869qtp.11
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 12:00:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180528184859.3530-1-frasse.iglesias@gmail.com>
	<20180528185806.e4ggng3mcrst7lbt@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5be56d50-7371-7e79-d1df-385ae86e34bb@amsat.org>
Date: Mon, 28 May 2018 16:00:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180528185806.e4ggng3mcrst7lbt@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] xlnx-zdma: Correct mem leaks and memset
 to zero on desc unaligned errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org, francisco.iglesias@feimtech.se, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, qemu-devel@nongnu.org, edgari@xilinx.com, alistair23@gmail.com

On 05/28/2018 03:58 PM, Edgar E. Iglesias wrote:
> On Mon, May 28, 2018 at 08:48:59PM +0200, Francisco Iglesias wrote:
>> Coverity found that the string return by 'object_get_canonical_path' was not
>> being freed at two locations in the model (CID 1391294 and CID 1391293) and
>> also that a memset was being called with a value greater than the max of a byte
>> on the second argument (CID 1391286). This patch corrects this by adding the
>> freeing of the strings and also changing to memset to zero instead on
>> descriptor unaligned errors.
> 
> Perhaps this should have been two patches but in any case:
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>> ---
>>  hw/dma/xlnx-zdma.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
>> index 14d86c254b..8eea757aff 100644
>> --- a/hw/dma/xlnx-zdma.c
>> +++ b/hw/dma/xlnx-zdma.c
>> @@ -302,7 +302,7 @@ static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
>>          qemu_log_mask(LOG_GUEST_ERROR,
>>                        "zdma: unaligned descriptor at %" PRIx64,
>>                        addr);
>> -        memset(buf, 0xdeadbeef, sizeof(XlnxZDMADescr));
>> +        memset(buf, 0x0, sizeof(XlnxZDMADescr));
>>          s->error = true;
>>          return false;
>>      }
>> @@ -707,9 +707,11 @@ static uint64_t zdma_read(void *opaque, hwaddr addr, unsigned size)
>>      RegisterInfo *r = &s->regs_info[addr / 4];
>>  
>>      if (!r->data) {
>> +        gchar *path = object_get_canonical_path(OBJECT(s));
>>          qemu_log("%s: Decode error: read from %" HWADDR_PRIx "\n",
>> -                 object_get_canonical_path(OBJECT(s)),
>> +                 path,
>>                   addr);
>> +        g_free(path);
>>          ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, INV_APB, true);
>>          zdma_ch_imr_update_irq(s);
>>          return 0;
>> @@ -724,9 +726,11 @@ static void zdma_write(void *opaque, hwaddr addr, uint64_t value,
>>      RegisterInfo *r = &s->regs_info[addr / 4];
>>  
>>      if (!r->data) {
>> +        gchar *path = object_get_canonical_path(OBJECT(s));
>>          qemu_log("%s: Decode error: write to %" HWADDR_PRIx "=%" PRIx64 "\n",
>> -                 object_get_canonical_path(OBJECT(s)),
>> +                 path,
>>                   addr, value);
>> +        g_free(path);
>>          ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, INV_APB, true);
>>          zdma_ch_imr_update_irq(s);
>>          return;
>> -- 
>> 2.11.0
>>
> 
