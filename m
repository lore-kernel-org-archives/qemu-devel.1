Received: from eggs.gnu.org ([2001:4830:134:3::10]:41748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d46kC-0007WN-Ny
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d46kB-0003EC-Dm
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:19:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAKmqyKN_bMZDqZ_LXiDqcsV1Znos5bHWrapcYSA01mX+kv23aw@mail.gmail.com>
References: <1491736758-19540-1-git-send-email-sundeep.lkml@gmail.com>
	<1491736758-19540-2-git-send-email-sundeep.lkml@gmail.com>
	<CAKmqyKMW-aTdzvTH5sir1BPx6U9XtgiZZ7TVigooXLFMY=UEQg@mail.gmail.com>
	<CALHRZuroavWhKmiZEC6eCh0KFif0dWuQWi=QprH122QnAGjnpA@mail.gmail.com>
	<CAKmqyKMT9Bn7OPU+h6o2Xj4DZXrVSBHr=jtR6jMSvhph0koegA@mail.gmail.com>
	<CALHRZuqgxQtiGwtPfm3qgm0ywpC4OdBkdSNKLO_Zzxtw2_cmHQ@mail.gmail.com>
	<CAKmqyKN_bMZDqZ_LXiDqcsV1Znos5bHWrapcYSA01mX+kv23aw@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Fri, 28 Apr 2017 19:49:33 +0530
Message-ID: <CALHRZuqvz8cQT=oCcAqdyP6Fyi-M4Mk=eoGBWATazS42uoV=7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-devel RFC v2 1/4] msf2: Add Smartfusion2
 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Alistair,

On Fri, Apr 28, 2017 at 12:23 AM, Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Apr 25, 2017 at 3:36 AM, sundeep subbaraya
> <sundeep.lkml@gmail.com> wrote:
>> Hi Alistair,
>>
>> On Mon, Apr 24, 2017 at 11:14 PM, Alistair Francis <alistair23@gmail.com> wrote:
>>>>>> +
>>>>>> +    isr = !!(st->regs[R_RIS] & TIMER_RIS_ACK);
>>>>>> +    ier = !!(st->regs[R_CTRL] & TIMER_CTRL_INTR);
>>>>>> +
>>>>>> +    qemu_set_irq(st->irq, (ier && isr));
>>>>>> +}
>>>>>> +
>>>>>> +static uint64_t
>>>>>> +timer_read(void *opaque, hwaddr addr, unsigned int size)
>>>>>> +{
>>>>>> +    struct timerblock *t = opaque;
>>>>>> +    struct msf2_timer *st;
>>>>>> +    uint32_t r = 0;
>>>>>> +    unsigned int timer;
>>>>>> +    int isr;
>>>>>> +    int ier;
>>>>>> +
>>>>>> +    addr >>= 2;
>>>>>> +    timer = timer_from_addr(addr);
>>>>>> +    st = &t->timers[timer];
>>>>>> +
>>>>>> +    if (timer) {
>>>>>> +        addr -= 6;
>>>>>> +    }
>>>>>
>>>>> Isn't this timer logic just checking if (addr >> 2) == R_MAX and if it
>>>>> is set (addr >> 2) back to zero? This seems an overly complex way to
>>>>> check that.
>>>> I did not get you clearly. Do you want me to write like this:
>>>> unsigned int timer = 0;
>>>>
>>>> addr >>= 2;
>>>> if (addr >= R_MAX) {
>>>>     timer = 1;
>>>>     addr =  addr - R_MAX;
>>>> }
>>>
>>> Yeah, I think this is clearer then what you had earlier.
>>>
>>> Although why do you have to subtract R_MAX, shouldn't it just be an
>>> error if accessing values larger then R_MAX?
>>
>> Sorry I forgot about replying to this in earlier mail.
>> There are two independent timer blocks accessing same base address.
>> Based on offset passed in read/write functions we figure out
>> which block has to be handled.
>> 0x0 to 0x14 -> timer1
>> 0x18 to 0x2C -> timer2
>> Here R_MAX is 0x18 hence addr >= R_MAX is valid and refers to timer2.
>> Although I missed the bounds checking 0 < addr < 0x2C. I will add that
>> check in read and
>> write functions.
>
> Ok, when you send the next version can you explain this in comments
> that way it's clear what you are trying to do.

Sure Alistair.

Thanks,
Sundeep
>
> Thanks,
>
> Alistair
>
>>
>> Thanks,
>> Sundeep
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +    switch (addr) {
>>>>>> +    case R_VAL:
>>>>>> +        r = ptimer_get_count(st->ptimer);
>>>>>> +        D(qemu_log("msf2_timer t=%d read counter=%x\n", timer, r));
>>>>>> +        break;
>>>>>> +
>>>>>> +    case R_MIS:
>>>>>> +        isr = !!(st->regs[R_RIS] & TIMER_RIS_ACK);
>>>>>> +        ier = !!(st->regs[R_CTRL] & TIMER_CTRL_INTR);
>>>>>> +        r = ier && isr;
>>>>>> +        break;
>>>>>> +
>>>>>> +    default:
>>>>>> +        if (addr < ARRAY_SIZE(st->regs)) {
>>>>>> +            r = st->regs[addr];
>>>>>> +        }
>>>>>> +        break;
>>>>>> +    }
>>>>>> +    D(fprintf(stderr, "%s timer=%d %x=%x\n", __func__, timer, addr * 4, r));
>>>>>> +    return r;
>>>>>> +}
>>>>>> +
>>>>>> +static void timer_update(struct msf2_timer *st)
>>>>>> +{
>>>>>> +    uint64_t count;
>>>>>> +
>>>>>> +    D(fprintf(stderr, "%s timer=%d\n", __func__, st->nr));
>>>>>> +
>>>>>> +    if (!(st->regs[R_CTRL] & TIMER_CTRL_ENBL)) {
>>>>>> +        ptimer_stop(st->ptimer);
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    count = st->regs[R_LOADVAL];
>>>>>> +    ptimer_set_limit(st->ptimer, count, 1);
>>>>>> +    ptimer_run(st->ptimer, 1);
>>>>>> +}
>>>>>
>>>>> The update function should be above the read/write functions.
>>>>>
>>>> Ok I will change
>>>>
>>>>>> +
>>>>>> +static void
>>>>>> +timer_write(void *opaque, hwaddr addr,
>>>>>> +            uint64_t val64, unsigned int size)
>>>>>> +{
>>>>>> +    struct timerblock *t = opaque;
>>>>>> +    struct msf2_timer *st;
>>>>>> +    unsigned int timer;
>>>>>> +    uint32_t value = val64;
>>>>>> +
>>>>>> +    addr >>= 2;
>>>>>> +    timer = timer_from_addr(addr);
>>>>>> +    st = &t->timers[timer];
>>>>>> +    D(fprintf(stderr, "%s addr=%x val=%x (timer=%d)\n",
>>>>>> +             __func__, addr * 4, value, timer));
>>>>>> +
>>>>>> +    if (timer) {
>>>>>> +        addr -= 6;
>>>>>> +    }
>>>>>
>>>>> Same comment from the read function.
>>>>>
>>>>>> +
>>>>>> +    switch (addr) {
>>>>>> +    case R_CTRL:
>>>>>> +        st->regs[R_CTRL] = value;
>>>>>> +        timer_update(st);
>>>>>> +        break;
>>>>>> +
>>>>>> +    case R_RIS:
>>>>>> +        if (value & TIMER_RIS_ACK) {
>>>>>> +            st->regs[R_RIS] &= ~TIMER_RIS_ACK;
>>>>>> +        }
>>>>>> +        break;
>>>>>> +
>>>>>> +    case R_LOADVAL:
>>>>>> +        st->regs[R_LOADVAL] = value;
>>>>>> +        if (st->regs[R_CTRL] & TIMER_CTRL_ENBL) {
>>>>>> +            timer_update(st);
>>>>>> +        }
>>>>>> +        break;
>>>>>> +
>>>>>> +    case R_BGLOADVAL:
>>>>>> +        st->regs[R_BGLOADVAL] = value;
>>>>>> +        st->regs[R_LOADVAL] = value;
>>>>>> +        break;
>>>>>> +
>>>>>> +    case R_VAL:
>>>>>> +    case R_MIS:
>>>>>> +        break;
>>>>>> +
>>>>>> +    default:
>>>>>> +        if (addr < ARRAY_SIZE(st->regs)) {
>>>>>> +            st->regs[addr] = value;
>>>>>> +        }
>>>>>> +        break;
>>>>>> +    }
>>>>>> +    timer_update_irq(st);
>>>>>> +}
>>>>>> +
>>>>>> +static const MemoryRegionOps timer_ops = {
>>>>>> +    .read = timer_read,
>>>>>> +    .write = timer_write,
>>>>>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>>>>>> +    .valid = {
>>>>>> +        .min_access_size = 4,
>>>>>> +        .max_access_size = 4
>>>>>> +    }
>>>>>> +};
>>>>>> +
>>>>>> +static void timer_hit(void *opaque)
>>>>>> +{
>>>>>> +    struct msf2_timer *st = opaque;
>>>>>> +    D(fprintf(stderr, "%s %d\n", __func__, st->nr));
>>>>>> +    st->regs[R_RIS] |= TIMER_RIS_ACK;
>>>>>> +
>>>>>> +    if (!(st->regs[R_CTRL] & TIMER_CTRL_ONESHOT)) {
>>>>>> +        timer_update(st);
>>>>>> +    }
>>>>>> +    timer_update_irq(st);
>>>>>> +}
>>>>>> +
>>>>>> +static void msf2_timer_realize(DeviceState *dev, Error **errp)
>>>>>> +{
>>>>>> +    struct timerblock *t = MSF2_TIMER(dev);
>>>>>> +    unsigned int i;
>>>>>> +
>>>>>> +    /* Init all the ptimers.  */
>>>>>> +    t->timers = g_malloc0((sizeof t->timers[0]) * NUM_TIMERS);
>>>>>> +    for (i = 0; i < NUM_TIMERS; i++) {
>>>>>> +        struct msf2_timer *st = &t->timers[i];
>>>>>> +
>>>>>> +        st->parent = t;
>>>>>> +        st->nr = i;
>>>>>> +        st->bh = qemu_bh_new(timer_hit, st);
>>>>>> +        st->ptimer = ptimer_init(st->bh, PTIMER_POLICY_DEFAULT);
>>>>>> +        ptimer_set_freq(st->ptimer, t->freq_hz);
>>>>>> +        sysbus_init_irq(SYS_BUS_DEVICE(dev), &st->irq);
>>>>>> +    }
>>>>>> +
>>>>>> +    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, "msf2-timer",
>>>>>> +                          R_MAX * 4 * NUM_TIMERS);
>>>>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &t->mmio);
>>>>>
>>>>> This should be in the devices init() function.
>>>>
>>>> I referred Xilinx soft IP models for writing these models and used
>>>> same boilerplate code.
>>>> I am not clear about realize and init functions yet. Can you please
>>>> give a brief about them.
>>>
>>> Basically the simple explanation is that init is called when the
>>> object is created and realize is called when the object is realized.
>>>
>>> Generally for devices it will go something like this:
>>>  1. init
>>>  2. Set properties
>>>  3. Connect things
>>>  4. realize
>>>  5. Map to memory
>>>
>>>> Don't we need to use realize function for new models?
>>>
>>> AFAIK we still put things like: sysbus_init_irq(),
>>> memory_region_init_io() and sysbus_init_mmio() in the init function.
>>>
>>> I don't think we are at a stage yet to not use init functions.
>>>
>>> Thanks,
>>>
>>> Alistair
>>>
>>>>
>>>> Thanks,
>>>> Sundeep
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Alistair
>>>>>
>>>>>> +}
>>>>>> +
>>>>>> +static Property msf2_timer_properties[] = {
>>>>>> +    DEFINE_PROP_UINT32("clock-frequency", struct timerblock, freq_hz,
>>>>>> +                                                                83 * 1000000),
>>>>>> +    DEFINE_PROP_END_OF_LIST(),
>>>>>> +};
>>>>>> +
>>>>>> +static void msf2_timer_class_init(ObjectClass *klass, void *data)
>>>>>> +{
>>>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>>>> +
>>>>>> +    dc->realize = msf2_timer_realize;
>>>>>> +    dc->props = msf2_timer_properties;
>>>>>> +}
>>>>>> +
>>>>>> +static const TypeInfo msf2_timer_info = {
>>>>>> +    .name          = TYPE_MSF2_TIMER,
>>>>>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>>>>>> +    .instance_size = sizeof(struct timerblock),
>>>>>> +    .class_init    = msf2_timer_class_init,
>>>>>> +};
>>>>>> +
>>>>>> +static void msf2_timer_register_types(void)
>>>>>> +{
>>>>>> +    type_register_static(&msf2_timer_info);
>>>>>> +}
>>>>>> +
>>>>>> +type_init(msf2_timer_register_types)
>>>>>> --
>>>>>> 2.5.0
>>>>>>
>>>>>>
