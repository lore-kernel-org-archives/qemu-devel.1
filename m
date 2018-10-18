Received: from eggs.gnu.org ([2001:4830:134:3::10]:43414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD8Cy-00069j-Ht
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD8Ct-0004eG-Un
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:19:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gD8Ct-0004cg-Lb
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:19:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id f17-v6so1909710wrs.12
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 06:19:18 -0700 (PDT)
References: <20181018130434.23237-1-philmd@redhat.com>
	<20181018130434.23237-4-philmd@redhat.com>
	<CAFEAcA-p21K3nbCUL0Hi=cBhqpPmQaHUXrUpEFuWFL+thgJoSg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a11adc0b-4737-f270-0cd1-1390239c00a5@redhat.com>
Date: Thu, 18 Oct 2018 15:19:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-p21K3nbCUL0Hi=cBhqpPmQaHUXrUpEFuWFL+thgJoSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peng Hao <peng.hao2@zte.com.cn>, QEMU Developers <qemu-devel@nongnu.org>, Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>

On 18/10/2018 15:08, Peter Maydell wrote:
> On 18 October 2018 at 14:04, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> [PMD: Use TYPE_PVPANIC definition, split in 2 patches]
>> ---
>> Peng: I hope this is now more obvious how you could reuse the pvpanic device.
>>
>>  hw/misc/pvpanic.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
>> index 4f552e1533..b81c5fa633 100644
>> --- a/hw/misc/pvpanic.c
>> +++ b/hw/misc/pvpanic.c
>> @@ -2,10 +2,12 @@
>>   * QEMU simulated pvpanic device.
>>   *
>>   * Copyright Fujitsu, Corp. 2013
>> + * Copyright (c) 2018 ZTE Ltd.
>>   *
>>   * Authors:
>>   *     Wen Congyang <wency@cn.fujitsu.com>
>>   *     Hu Tao <hutao@cn.fujitsu.com>
>> + *     Peng Hao <peng.hao2@zte.com.cn>
>>   *
>>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>   * See the COPYING file in the top-level directory.
>> @@ -47,7 +49,10 @@ static void handle_event(int event)
>>
>>  typedef struct PVPanicState {
>>      /*< private >*/
>> -    ISADevice isadev;
>> +    union {
>> +        ISADevice isadev;
>> +        SysBusDevice busdev;
>> +    };
> 
> This field is the parent-type for the QOM object, so I don't
> think it makes sense for it to be a union. Any one QOM object
> should have a single distinct parent type. (There are other
> examples of "some more or less similar device has ISA and
> SysBus or PCI and SysBus variations" which should provide
> some models to copy from.

OK, I understand as I can use "Device parent_obj" instead of that union?
But then we want:

pvpanic_isa_info.instance_size =
        sizeof(PVPanic_Common_State) + sizeof(ISADevice)

pvpanic_mmio_info.instance_size =
        sizeof(PVPanic_Common_State) + sizeof(SysBusDevice)

So to avoid union, I have to use:

    typedef struct PVPanicCommonState {
        MemoryRegion mr;
        uint16_t ioport;
    } PVPanicCommonState;

    typedef struct PVPanicISAState {
        /*< private >*/
        ISADevice isadev;

        /*< public >*/
        PVPanicCommonState common;
    } PVPanicISAState;

    #define PVPANIC_ISA(obj)    \
        OBJECT_CHECK(PVPanicISAState, (obj), TYPE_PVPANIC)

    typedef struct PVPanicMMIOState {
        /*< private >*/
        SysBusDevice busdev;

        /*< public >*/
        PVPanicCommonState common;
    } PVPanicMMIOState;

    #define PVPANIC_MMIO(obj)    \
        OBJECT_CHECK(PVPanicMMIOState, (obj), TYPE_PVPANIC)

And later:

-->8--
@@ -92,3 +104,3 @@ static void pvpanic_isa_realizefn(DeviceState *dev,
Error **errp)
     ISADevice *d = ISA_DEVICE(dev);
-    PVPanicState *s = PVPANIC(dev);
+    PVPanicState *s = PVPANIC_ISA(dev);
     FWCfgState *fw_cfg = fw_cfg_find();
@@ -125,3 +137,3 @@ static TypeInfo pvpanic_isa_info = {
     .parent        = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(PVPanicState),
+    .instance_size = sizeof(PVPanicISAState),
     .instance_init = pvpanic_isa_initfn,
@@ -151,3 +163,3 @@ static void pvpanic_mmio_initfn(Object *obj)
 {
-    PVPanicState *s = PVPANIC(obj);
+    PVPanicState *s = PVPANIC_MMIO(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
@@ -169,3 +181,3 @@ static TypeInfo pvpanic_mmio_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PVPanicState),
+    .instance_size = sizeof(PVPanicMMIOState),
     .instance_init = pvpanic_mmio_initfn,
---

Am I correct?

Thanks,

Phil.
