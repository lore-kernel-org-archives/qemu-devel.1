Received: from eggs.gnu.org ([2001:4830:134:3::10]:40592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMw1y-0008FE-RM
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMw1t-0000Lp-S7
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:43:46 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60175
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dMw1t-0000LN-LB
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:43:41 -0400
References: <1497772934-15561-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497772934-15561-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170618232055-mutt-send-email-mst@kernel.org>
	<e0a92b1f-9f5d-abc3-65f6-72546748c992@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <78cb8153-e189-32d2-eec3-9d5cfc9ab77d@ilande.co.uk>
Date: Mon, 19 Jun 2017 13:43:32 +0100
MIME-Version: 1.0
In-Reply-To: <e0a92b1f-9f5d-abc3-65f6-72546748c992@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

On 19/06/17 09:57, Laszlo Ersek wrote:

> On 06/18/17 22:23, Michael S. Tsirkin wrote:
>> On Sun, Jun 18, 2017 at 09:02:14AM +0100, Mark Cave-Ayland wrote:
>>> By exposing FWCfgIoState and FWCfgMemState internals we allow the possibility
>>> for the internal MemoryRegion fields to be mapped by name for boards that wish
>>> to wire up the fw_cfg device themselves.
>>>
>>> An additional minor tidy-up is that the FWCfgEntry typedef is moved from the
>>> struct definitions in fw_cfg.h to typedefs.h along with the others.
> 
> I think this paragraph should be dropped.

No problem, I'll do that for the follow-up v6 patchset.

>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/nvram/fw_cfg.c         |   55 ------------------------------------------
>>>  include/hw/nvram/fw_cfg.h |   58 +++++++++++++++++++++++++++++++++++++++++++++
>>>  include/qemu/typedefs.h   |    1 +
>>>  3 files changed, 59 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>> index df99903..00771c9 100644
>>> --- a/hw/nvram/fw_cfg.c
>>> +++ b/hw/nvram/fw_cfg.c
>>> @@ -40,14 +40,6 @@
>>>  #define FW_CFG_NAME "fw_cfg"
>>>  #define FW_CFG_PATH "/machine/" FW_CFG_NAME
>>>
>>> -#define TYPE_FW_CFG     "fw_cfg"
>>> -#define TYPE_FW_CFG_IO  "fw_cfg_io"
>>> -#define TYPE_FW_CFG_MEM "fw_cfg_mem"
>>> -
>>> -#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
>>> -#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
>>> -#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
>>> -
>>>  /* FW_CFG_VERSION bits */
>>>  #define FW_CFG_VERSION      0x01
>>>  #define FW_CFG_VERSION_DMA  0x02
>>> @@ -61,53 +53,6 @@
>>>
>>>  #define FW_CFG_DMA_SIGNATURE 0x51454d5520434647ULL /* "QEMU CFG" */
>>>
>>> -typedef struct FWCfgEntry {
>>> -    uint32_t len;
>>> -    bool allow_write;
>>> -    uint8_t *data;
>>> -    void *callback_opaque;
>>> -    FWCfgReadCallback read_callback;
>>> -} FWCfgEntry;
>>
>> This still doesn't seem to do what Laszlo requested which is to keep
>> as many types and macros as possible in fw_cfg.c, only put typedefs in
>> fw_cfg.h.
> 
> Sort of; what's missing from this version (for me anyway) is that the
> internals of FWCfgEntry should remain in the C file, because we never
> depend on those fields -- or the size of that structure -- externally.
> I'm OK with the rest.
> 
> Mark, can you please squash the following diff into this patch -- this
> is what would implement my request (2) in
> <https://www.mail-archive.com/qemu-devel@nongnu.org/msg458313.html>:
> 
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index b0511b9a9d77..b77ea48abb1d 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -46,14 +46,6 @@ typedef struct FWCfgDmaAccess {
>>
>>  typedef void (*FWCfgReadCallback)(void *opaque);
>>
>> -struct FWCfgEntry {
>> -    uint32_t len;
>> -    bool allow_write;
>> -    uint8_t *data;
>> -    void *callback_opaque;
>> -    FWCfgReadCallback read_callback;
>> -};
>> -
>>  struct FWCfgState {
>>      /*< private >*/
>>      SysBusDevice parent_obj;
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 00771c98505c..9b0aaa21a202 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -53,6 +53,14 @@
>>
>>  #define FW_CFG_DMA_SIGNATURE 0x51454d5520434647ULL /* "QEMU CFG" */
>>
>> +struct FWCfgEntry {
>> +    uint32_t len;
>> +    bool allow_write;
>> +    uint8_t *data;
>> +    void *callback_opaque;
>> +    FWCfgReadCallback read_callback;
>> +};
>> +
>>  #define JPG_FILE 0
>>  #define BMP_FILE 1
>>
> 
> As I wrote in the msg linked above, 'FWCfgEntry need not be moved from
> the C file to the header file [...] it's fine to leave FWCfgEntry an
> incomplete type in "fw_cfg.h"'.

Yes, that's totally my fault as I misinterpreted your comment from your
previous email - sorry about that.

> With the above two changes (commit message and code update) squashed
> into patch #5:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> and also for the series:
> 
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> 
> (I tested the IO mapped variant with OVMF, exercising fw_cfg DMA and
> fw_cfg write, and the MMIO mapped variant with ArmVirtQemu (aka
> "AAVMF"), exercising fw_cfg DMA.)

Fantastic! It's good to know that the changes don't cause any
regressions for both DMA operations and MMIO fw_cfg instances.

I'll squash your diff into patch 5, update the tags and then re-post a
v6 shortly.

Assuming that this is the final revision, who is the right person to
accept the patchset into their queue for merge upstream?


ATB,

Mark.
