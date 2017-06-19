Received: from eggs.gnu.org ([2001:4830:134:3::10]:38632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMvun-0003yl-8S
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMvui-0004at-AX
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:36:21 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59819
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dMvui-0004ZF-37
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:36:16 -0400
References: <1497772934-15561-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497772934-15561-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170618232055-mutt-send-email-mst@kernel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <89f6cf75-dd53-3b23-75f6-7bfc110d3009@ilande.co.uk>
Date: Mon, 19 Jun 2017 13:35:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170618232055-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 5/5] fw_cfg: move QOM type defines and
 fw_cfg types into fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 18/06/17 21:23, Michael S. Tsirkin wrote:

> On Sun, Jun 18, 2017 at 09:02:14AM +0100, Mark Cave-Ayland wrote:
>> By exposing FWCfgIoState and FWCfgMemState internals we allow the possibility
>> for the internal MemoryRegion fields to be mapped by name for boards that wish
>> to wire up the fw_cfg device themselves.
>>
>> An additional minor tidy-up is that the FWCfgEntry typedef is moved from the
>> struct definitions in fw_cfg.h to typedefs.h along with the others.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/nvram/fw_cfg.c         |   55 ------------------------------------------
>>  include/hw/nvram/fw_cfg.h |   58 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/qemu/typedefs.h   |    1 +
>>  3 files changed, 59 insertions(+), 55 deletions(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index df99903..00771c9 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -40,14 +40,6 @@
>>  #define FW_CFG_NAME "fw_cfg"
>>  #define FW_CFG_PATH "/machine/" FW_CFG_NAME
>>  
>> -#define TYPE_FW_CFG     "fw_cfg"
>> -#define TYPE_FW_CFG_IO  "fw_cfg_io"
>> -#define TYPE_FW_CFG_MEM "fw_cfg_mem"
>> -
>> -#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
>> -#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
>> -#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
>> -
>>  /* FW_CFG_VERSION bits */
>>  #define FW_CFG_VERSION      0x01
>>  #define FW_CFG_VERSION_DMA  0x02
>> @@ -61,53 +53,6 @@
>>  
>>  #define FW_CFG_DMA_SIGNATURE 0x51454d5520434647ULL /* "QEMU CFG" */
>>  
>> -typedef struct FWCfgEntry {
>> -    uint32_t len;
>> -    bool allow_write;
>> -    uint8_t *data;
>> -    void *callback_opaque;
>> -    FWCfgReadCallback read_callback;
>> -} FWCfgEntry;
> 
> This still doesn't seem to do what Laszlo requested which is to keep as
> many types and macros as possible in fw_cfg.c, only put typedefs in
> fw_cfg.h.

Yes, that's my fault as I misinterpreted Laszlo's comment related to the
typedef. Fortunately I see from Laszlo's follow-up email that the fix is
fairly trivial.


ATB,

Mark.
