Received: from eggs.gnu.org ([2001:4830:134:3::10]:53055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccPGX-0005ye-7v
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccPGU-0003am-US
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:26:29 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccPGU-0003aa-OE
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:26:26 -0500
Received: by mail-qt0-x243.google.com with SMTP id w20so6740228qtb.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 20:26:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170203175217.45562-1-pasic@linux.vnet.ibm.com>
	<20170210152403.GH2568@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <273b267a-7458-2538-8a4b-a9f8ba6dfc5a@amsat.org>
Date: Sat, 11 Feb 2017 01:26:22 -0300
MIME-Version: 1.0
In-Reply-To: <20170210152403.GH2568@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration: consolidate VMStateField.start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On 02/10/2017 12:24 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> The member VMStateField.start is used for two things, partial data
>> migration for VBUFFER data (basically provide migration for a
>> sub-buffer) and for locating next in QTAILQ.
>>
>> The implementation of the VBUFFER feature is broken when VMSTATE_ALLOC
>> is used. This however goes unnoticed because actually partial migration
>> for VBUFFER is not used at all.
>>
>> Let's consolidate the usage of VMStateField.start by removing support
>> for partial migration for VBUFFER.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>
>> ---
>>
>> I had a very similar patch named "migration: drop unused
>> VMStateField.start" on the list. What changed since then is that we need
>> to keep VMStateField.start now becasue of the new usage introduced in
>> the meanwhile. I dropped al r-b's the patch had.
>> ---
>>  hw/char/exynos4210_uart.c   |  2 +-
>>  hw/display/g364fb.c         |  2 +-
>>  hw/dma/pl330.c              |  8 ++++----
>>  hw/intc/exynos4210_gic.c    |  2 +-
>>  hw/ipmi/isa_ipmi_bt.c       |  6 ++----
>>  hw/net/vmxnet3.c            |  2 +-
>>  hw/nvram/mac_nvram.c        |  2 +-
>>  hw/nvram/spapr_nvram.c      |  2 +-
>>  hw/sd/sdhci.c               |  2 +-
>>  hw/timer/m48t59.c           |  2 +-
>>  include/migration/vmstate.h | 21 ++++++++-------------
>>  migration/savevm.c          |  2 +-
>>  migration/vmstate.c         |  4 ++--
>>  target/s390x/machine.c      |  2 +-
>>  util/fifo8.c                |  2 +-
>>  15 files changed, 27 insertions(+), 34 deletions(-)
>>
>> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
>> index 7c16e89..b75f28d 100644
>> --- a/hw/char/exynos4210_uart.c
>> +++ b/hw/char/exynos4210_uart.c
>> @@ -561,7 +561,7 @@ static const VMStateDescription vmstate_exynos4210_uart_fifo = {
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32(sp, Exynos4210UartFIFO),
>>          VMSTATE_UINT32(rp, Exynos4210UartFIFO),
>> -        VMSTATE_VBUFFER_UINT32(data, Exynos4210UartFIFO, 1, NULL, 0, size),
>> +        VMSTATE_VBUFFER_UINT32(data, Exynos4210UartFIFO, 1, NULL, size),
>>          VMSTATE_END_OF_LIST()
>>      }
>>  };
>> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
>> index 70ef2c7..8cdc205 100644
>> --- a/hw/display/g364fb.c
>> +++ b/hw/display/g364fb.c
>> @@ -464,7 +464,7 @@ static const VMStateDescription vmstate_g364fb = {
>>      .minimum_version_id = 1,
>>      .post_load = g364fb_post_load,
>>      .fields = (VMStateField[]) {
>> -        VMSTATE_VBUFFER_UINT32(vram, G364State, 1, NULL, 0, vram_size),
>> +        VMSTATE_VBUFFER_UINT32(vram, G364State, 1, NULL, vram_size),
>>          VMSTATE_BUFFER_UNSAFE(color_palette, G364State, 0, 256 * 3),
>>          VMSTATE_BUFFER_UNSAFE(cursor_palette, G364State, 0, 9),
>>          VMSTATE_UINT16_ARRAY(cursor, G364State, 512),
>> diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
>> index c0bd9fe..32cf839 100644
>> --- a/hw/dma/pl330.c
>> +++ b/hw/dma/pl330.c
>> @@ -173,8 +173,8 @@ static const VMStateDescription vmstate_pl330_fifo = {
>>      .version_id = 1,
>>      .minimum_version_id = 1,
>>      .fields = (VMStateField[]) {
>> -        VMSTATE_VBUFFER_UINT32(buf, PL330Fifo, 1, NULL, 0, buf_size),
>> -        VMSTATE_VBUFFER_UINT32(tag, PL330Fifo, 1, NULL, 0, buf_size),
>> +        VMSTATE_VBUFFER_UINT32(buf, PL330Fifo, 1, NULL, buf_size),
>> +        VMSTATE_VBUFFER_UINT32(tag, PL330Fifo, 1, NULL, buf_size),
>>          VMSTATE_UINT32(head, PL330Fifo),
>>          VMSTATE_UINT32(num, PL330Fifo),
>>          VMSTATE_UINT32(buf_size, PL330Fifo),
>> @@ -282,8 +282,8 @@ static const VMStateDescription vmstate_pl330 = {
>>          VMSTATE_STRUCT(manager, PL330State, 0, vmstate_pl330_chan, PL330Chan),
>>          VMSTATE_STRUCT_VARRAY_UINT32(chan, PL330State, num_chnls, 0,
>>                                       vmstate_pl330_chan, PL330Chan),
>> -        VMSTATE_VBUFFER_UINT32(lo_seqn, PL330State, 1, NULL, 0, num_chnls),
>> -        VMSTATE_VBUFFER_UINT32(hi_seqn, PL330State, 1, NULL, 0, num_chnls),
>> +        VMSTATE_VBUFFER_UINT32(lo_seqn, PL330State, 1, NULL, num_chnls),
>> +        VMSTATE_VBUFFER_UINT32(hi_seqn, PL330State, 1, NULL, num_chnls),
>>          VMSTATE_STRUCT(fifo, PL330State, 0, vmstate_pl330_fifo, PL330Fifo),
>>          VMSTATE_STRUCT(read_queue, PL330State, 0, vmstate_pl330_queue,
>>                         PL330Queue),
>> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
>> index fd7a8f3..2a55817 100644
>> --- a/hw/intc/exynos4210_gic.c
>> +++ b/hw/intc/exynos4210_gic.c
>> @@ -393,7 +393,7 @@ static const VMStateDescription vmstate_exynos4210_irq_gate = {
>>      .version_id = 2,
>>      .minimum_version_id = 2,
>>      .fields = (VMStateField[]) {
>> -        VMSTATE_VBUFFER_UINT32(level, Exynos4210IRQGateState, 1, NULL, 0, n_in),
>> +        VMSTATE_VBUFFER_UINT32(level, Exynos4210IRQGateState, 1, NULL, n_in),
>>          VMSTATE_END_OF_LIST()
>>      }
>>  };
>> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
>> index f036617..1c69cb3 100644
>> --- a/hw/ipmi/isa_ipmi_bt.c
>> +++ b/hw/ipmi/isa_ipmi_bt.c
>> @@ -471,10 +471,8 @@ static const VMStateDescription vmstate_ISAIPMIBTDevice = {
>>          VMSTATE_BOOL(bt.use_irq, ISAIPMIBTDevice),
>>          VMSTATE_BOOL(bt.irqs_enabled, ISAIPMIBTDevice),
>>          VMSTATE_UINT32(bt.outpos, ISAIPMIBTDevice),
>> -        VMSTATE_VBUFFER_UINT32(bt.outmsg, ISAIPMIBTDevice, 1, NULL, 0,
>> -                               bt.outlen),
>> -        VMSTATE_VBUFFER_UINT32(bt.inmsg, ISAIPMIBTDevice, 1, NULL, 0,
>> -                               bt.inlen),
>> +        VMSTATE_VBUFFER_UINT32(bt.outmsg, ISAIPMIBTDevice, 1, NULL, bt.outlen),
>> +        VMSTATE_VBUFFER_UINT32(bt.inmsg, ISAIPMIBTDevice, 1, NULL, bt.inlen),
>>          VMSTATE_UINT8(bt.control_reg, ISAIPMIBTDevice),
>>          VMSTATE_UINT8(bt.mask_reg, ISAIPMIBTDevice),
>>          VMSTATE_UINT8(bt.waiting_rsp, ISAIPMIBTDevice),
>> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
>> index 7dd4565..e13a798 100644
>> --- a/hw/net/vmxnet3.c
>> +++ b/hw/net/vmxnet3.c
>> @@ -2397,7 +2397,7 @@ static const VMStateDescription vmxstate_vmxnet3_mcast_list = {
>>      .pre_load = vmxnet3_mcast_list_pre_load,
>>      .needed = vmxnet3_mc_list_needed,
>>      .fields = (VMStateField[]) {
>> -        VMSTATE_VBUFFER_UINT32(mcast_list, VMXNET3State, 0, NULL, 0,
>> +        VMSTATE_VBUFFER_UINT32(mcast_list, VMXNET3State, 0, NULL,
>>              mcast_list_buff_size),
>>          VMSTATE_END_OF_LIST()
>>      }
>> diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
>> index 63f9ed1..aef80e6 100644
>> --- a/hw/nvram/mac_nvram.c
>> +++ b/hw/nvram/mac_nvram.c
>> @@ -82,7 +82,7 @@ static const VMStateDescription vmstate_macio_nvram = {
>>      .version_id = 1,
>>      .minimum_version_id = 1,
>>      .fields = (VMStateField[]) {
>> -        VMSTATE_VBUFFER_UINT32(data, MacIONVRAMState, 0, NULL, 0, size),
>> +        VMSTATE_VBUFFER_UINT32(data, MacIONVRAMState, 0, NULL, size),
>>          VMSTATE_END_OF_LIST()
>>      }
>>  };
>> diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
>> index eb42ea3..65ba188 100644
>> --- a/hw/nvram/spapr_nvram.c
>> +++ b/hw/nvram/spapr_nvram.c
>> @@ -224,7 +224,7 @@ static const VMStateDescription vmstate_spapr_nvram = {
>>      .post_load = spapr_nvram_post_load,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32(size, sPAPRNVRAM),
>> -        VMSTATE_VBUFFER_ALLOC_UINT32(buf, sPAPRNVRAM, 1, NULL, 0, size),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(buf, sPAPRNVRAM, 1, NULL, size),
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index 01fbf22..c0d7de7 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -1253,7 +1253,7 @@ const VMStateDescription sdhci_vmstate = {
>>          VMSTATE_UINT16(data_count, SDHCIState),
>>          VMSTATE_UINT64(admasysaddr, SDHCIState),
>>          VMSTATE_UINT8(stopped_state, SDHCIState),
>> -        VMSTATE_VBUFFER_UINT32(fifo_buffer, SDHCIState, 1, NULL, 0, buf_maxsz),
>> +        VMSTATE_VBUFFER_UINT32(fifo_buffer, SDHCIState, 1, NULL, buf_maxsz),
>>          VMSTATE_TIMER_PTR(insert_timer, SDHCIState),
>>          VMSTATE_TIMER_PTR(transfer_timer, SDHCIState),
>>          VMSTATE_END_OF_LIST()
>> diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
>> index e46ca88..40a9e18 100644
>> --- a/hw/timer/m48t59.c
>> +++ b/hw/timer/m48t59.c
>> @@ -634,7 +634,7 @@ static const VMStateDescription vmstate_m48t59 = {
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT8(lock, M48t59State),
>>          VMSTATE_UINT16(addr, M48t59State),
>> -        VMSTATE_VBUFFER_UINT32(buffer, M48t59State, 0, NULL, 0, size),
>> +        VMSTATE_VBUFFER_UINT32(buffer, M48t59State, 0, NULL, size),
>>          VMSTATE_END_OF_LIST()
>>      }
>>  };
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 3bbe3ed..17ecad1 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -587,7 +587,8 @@ extern const VMStateInfo vmstate_info_qtailq;
>>      .offset       = vmstate_offset_buffer(_state, _field) + _start,  \
>>  }
>>
>> -#define VMSTATE_VBUFFER_MULTIPLY(_field, _state, _version, _test, _start, _field_size, _multiply) { \
>> +#define VMSTATE_VBUFFER_MULTIPLY(_field, _state, _version, _test,    \
>> +                                 _field_size, _multiply) {           \
>>      .name         = (stringify(_field)),                             \
>>      .version_id   = (_version),                                      \
>>      .field_exists = (_test),                                         \
>> @@ -596,10 +597,9 @@ extern const VMStateInfo vmstate_info_qtailq;
>>      .info         = &vmstate_info_buffer,                            \
>>      .flags        = VMS_VBUFFER|VMS_POINTER|VMS_MULTIPLY,            \
>>      .offset       = offsetof(_state, _field),                        \
>> -    .start        = (_start),                                        \
>>  }
>>
>> -#define VMSTATE_VBUFFER(_field, _state, _version, _test, _start, _field_size) { \
>> +#define VMSTATE_VBUFFER(_field, _state, _version, _test, _field_size) { \
>>      .name         = (stringify(_field)),                             \
>>      .version_id   = (_version),                                      \
>>      .field_exists = (_test),                                         \
>> @@ -607,10 +607,9 @@ extern const VMStateInfo vmstate_info_qtailq;
>>      .info         = &vmstate_info_buffer,                            \
>>      .flags        = VMS_VBUFFER|VMS_POINTER,                         \
>>      .offset       = offsetof(_state, _field),                        \
>> -    .start        = (_start),                                        \
>>  }
>>
>> -#define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test, _start, _field_size) { \
>> +#define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test, _field_size) { \
>>      .name         = (stringify(_field)),                             \
>>      .version_id   = (_version),                                      \
>>      .field_exists = (_test),                                         \
>> @@ -618,10 +617,10 @@ extern const VMStateInfo vmstate_info_qtailq;
>>      .info         = &vmstate_info_buffer,                            \
>>      .flags        = VMS_VBUFFER|VMS_POINTER,                         \
>>      .offset       = offsetof(_state, _field),                        \
>> -    .start        = (_start),                                        \
>>  }
>>
>> -#define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version, _test, _start, _field_size) { \
>> +#define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
>> +                                     _test, _field_size) {           \
>>      .name         = (stringify(_field)),                             \
>>      .version_id   = (_version),                                      \
>>      .field_exists = (_test),                                         \
>> @@ -629,7 +628,6 @@ extern const VMStateInfo vmstate_info_qtailq;
>>      .info         = &vmstate_info_buffer,                            \
>>      .flags        = VMS_VBUFFER|VMS_POINTER|VMS_ALLOC,               \
>>      .offset       = offsetof(_state, _field),                        \
>> -    .start        = (_start),                                        \
>>  }
>>
>>  #define VMSTATE_BUFFER_UNSAFE_INFO_TEST(_field, _state, _test, _version, _info, _size) { \
>> @@ -948,13 +946,10 @@ extern const VMStateInfo vmstate_info_qtailq;
>>      VMSTATE_BUFFER_START_MIDDLE_V(_f, _s, _start, 0)
>>
>>  #define VMSTATE_PARTIAL_VBUFFER(_f, _s, _size)                        \
>> -    VMSTATE_VBUFFER(_f, _s, 0, NULL, 0, _size)
>> +    VMSTATE_VBUFFER(_f, _s, 0, NULL, _size)
>>
>>  #define VMSTATE_PARTIAL_VBUFFER_UINT32(_f, _s, _size)                        \
>> -    VMSTATE_VBUFFER_UINT32(_f, _s, 0, NULL, 0, _size)
>> -
>> -#define VMSTATE_SUB_VBUFFER(_f, _s, _start, _size)                    \
>> -    VMSTATE_VBUFFER(_f, _s, 0, NULL, _start, _size)
>> +    VMSTATE_VBUFFER_UINT32(_f, _s, 0, NULL, _size)
>>
>>  #define VMSTATE_BUFFER_TEST(_f, _s, _test)                            \
>>      VMSTATE_STATIC_BUFFER(_f, _s, 0, _test, 0, sizeof(typeof_field(_s, _f)))
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 204012e..6c580a2 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -356,7 +356,7 @@ static const VMStateDescription vmstate_configuration = {
>>      .pre_save = configuration_pre_save,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32(len, SaveState),
>> -        VMSTATE_VBUFFER_ALLOC_UINT32(name, SaveState, 0, NULL, 0, len),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(name, SaveState, 0, NULL, len),
>>          VMSTATE_END_OF_LIST()
>>      },
>>      .subsections = (const VMStateDescription*[]) {
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 2b2b3a5..520341a 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -68,10 +68,10 @@ static void *vmstate_base_addr(void *opaque, VMStateField *field, bool alloc)
>>                  }
>>              }
>>              if (size) {
>> -                *((void **)base_addr + field->start) = g_malloc(size);
>> +                *(void **)base_addr = g_malloc(size);
>>              }
>>          }
>> -        base_addr = *(void **)base_addr + field->start;
>> +        base_addr = *(void **)base_addr;
>>      }
>>
>>      return base_addr;
>> diff --git a/target/s390x/machine.c b/target/s390x/machine.c
>> index edc3a47..8503fa1 100644
>> --- a/target/s390x/machine.c
>> +++ b/target/s390x/machine.c
>> @@ -180,7 +180,7 @@ const VMStateDescription vmstate_s390_cpu = {
>>          VMSTATE_UINT8(env.cpu_state, S390CPU),
>>          VMSTATE_UINT8(env.sigp_order, S390CPU),
>>          VMSTATE_UINT32_V(irqstate_saved_size, S390CPU, 4),
>> -        VMSTATE_VBUFFER_UINT32(irqstate, S390CPU, 4, NULL, 0,
>> +        VMSTATE_VBUFFER_UINT32(irqstate, S390CPU, 4, NULL,
>>                                 irqstate_saved_size),
>>          VMSTATE_END_OF_LIST()
>>      },
>> diff --git a/util/fifo8.c b/util/fifo8.c
>> index 5c64101..d38b3bd 100644
>> --- a/util/fifo8.c
>> +++ b/util/fifo8.c
>> @@ -118,7 +118,7 @@ const VMStateDescription vmstate_fifo8 = {
>>      .version_id = 1,
>>      .minimum_version_id = 1,
>>      .fields = (VMStateField[]) {
>> -        VMSTATE_VBUFFER_UINT32(data, Fifo8, 1, NULL, 0, capacity),
>> +        VMSTATE_VBUFFER_UINT32(data, Fifo8, 1, NULL, capacity),
>>          VMSTATE_UINT32(head, Fifo8),
>>          VMSTATE_UINT32(num, Fifo8),
>>          VMSTATE_END_OF_LIST()
>> --
>> 2.8.4
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
