Received: from eggs.gnu.org ([2001:4830:134:3::10]:44239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecWsy-0007a2-Do
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecWrJ-0003Gw-3W
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:39:12 -0500
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:35660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecWrI-0003Gc-R1
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:37:28 -0500
Received: by mail-qt0-x232.google.com with SMTP id u10so3822831qtg.2
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 05:37:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801152229.53520.pisa@cmp.felk.cvut.cz>
	<04fbdf17-6431-5d67-6681-3cc0f375b32a@amsat.org>
	<201801190951.35681.pisa@cmp.felk.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a7d9a42-e0c3-9dbb-5436-57365e558800@amsat.org>
Date: Fri, 19 Jan 2018 10:37:22 -0300
MIME-Version: 1.0
In-Reply-To: <201801190951.35681.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 2/7] CAN bus support to connect bust to
 Linux host SocketCAN interface.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 01/19/2018 05:51 AM, Pavel Pisa wrote:
> Hello Philippe,
> 
> On Tuesday 16 of January 2018 01:12:09 Philippe Mathieu-Daudé wrote:
>> On 01/15/2018 06:29 PM, Pavel Pisa wrote:
>>> Hello Philippe,
>>>
>>> thanks for review.
>>>
>>> I have updated patch series in can-pci branch in
>>>
>>>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus
>>>
>>> I would wait some day if there is some remark
>>> from other developers and socket ones especially.
>>
>> I'll have a look.
> 
> if there are no more comments, I prepare version 5
> of the patches at start of the next week.
> 
> Already implemented changes for version 5:
> 
> Assertions to check match to Linux struct can_frame
> has been moved out of the function.
> The case statements use ranges.
> min_access_size=1 removed.
> "for loops" are used to process operations
> for the first and the second chip where
> appropriate in PCM-3680I and MIOe-3680 patches.
> Deniz Eren reported that updated version
> works correctly.
> 
> I have not proceed with next two remarks yet:
> 
> Inlining in can_sja_single_filter and can_sja_dual_filter
> functions. There is only single group of repeated four lines
> of code which could be inlined, others are groups of two
> lines each. 
> 
>>     if (extended) {
> vvvvvvvvvvvvvvv
>>         filter->can_id = (uint32_t)acr[0] << 21;
>>         filter->can_id |= (uint32_t)acr[1] << 13;
>>         filter->can_id |= (uint32_t)acr[2] << 5;
>>         filter->can_id |= (uint32_t)acr[3] >> 3;
> ^^^^^^^^^^^^^^^
>>         if (acr[3] & 4) {
>>             filter->can_id |= QEMU_CAN_RTR_FLAG;
>>         }
>>
> vvvvvvvvvvvvvvv
>>         filter->can_mask = (uint32_t)amr[0] << 21;
>>         filter->can_mask |= (uint32_t)amr[1] << 13;
>>         filter->can_mask |= (uint32_t)amr[2] << 5;
>>         filter->can_mask |= (uint32_t)amr[3] >> 3;
> ^^^^^^^^^^^^^^^
>>         filter->can_mask = ~filter->can_mask & QEMU_CAN_EFF_MASK;
>>         if (!(amr[3] & 4)) {
>>             filter->can_mask |= QEMU_CAN_RTR_FLAG;
>>         }
> 
> Only these marked parts repeats.
> Rest is similar but not material for simple inline.
> Same for others two line sequences.
> All these bit level manipulations are moved from frame
> processing and another more top level functions into these
> short can_sja_{single,dual}_filter functions.

fine.

> 
>> /* PeliCAN mode */
>> enum SJA1000_PeliCAN_regs {
>>         SJA_MOD      = 0x00,
>> /* Command register */
>>         SJA_CMR      = 0x01,
> ....
>> /* TX Error Counter */
>>         SJA_TXERR0   = 0x0e,
>>         SJA_TXERR1   = 0x0f,
>> /* Rx Message Counter (number of msgs. in RX FIFO */
>>         SJA_RMC      = 0x1d,
>> /* Rx Buffer Start Addr. (address of current MSG) */
>>         SJA_RBSA     = 0x1e,
>> /* Transmit Buffer (write) Receive Buffer (read) Frame Information */
>>         SJA_FRM      = 0x10,
>> /*
>>  * ID bytes (11 bits in 0 and 1 for standard message or
>>  *          16 bits in 0,1 and 13 bits in 2,3 for extended message)
>>  */
>>         SJA_ID0      = 0x11, SJA_ID1 = 0x12,
>> /* ID cont. for extended frames */
>>         SJA_ID2      = 0x13, SJA_ID3 = 0x14,
> 
> Proposed formating
> 
>            SJA_MOD      = 0x00, /* Command */
>            SJA_CMR      = 0x01, /* Status */
> 
> this is really better for short comments.
> But how format long ones then to keep lines max 80 characters
> 
>            SJA_FRM      = 0x10, /* Transmit Buffer (write) Receive Buffer
>                                  * (read) Frame Information
>                                  */

            SJA_FRM      = 0x10, /* Frame Information              */
                                 /* on write: Transmit Buffer used */
                                 /* on read: Receive Buffer used   */

but I'd keep it as:

            SJA_FRM      = 0x10, /* Frame Information */

> 
> The SJA_ID0 is would look even worse.

As you prefer, comments are good if useful, too much redundant comments
are counter productive IMHO.

> 
> But if the second format is preferred then I update the patch.
> 
>>> Trace events seems as nice feature. But simple text printf
>>> like output has been enough till now for CAN testing.
>>> There is no debugging output in production build.
>>> So I would add tracing infrastructure later if needed.
>>
>> They are as useful as console printf, but less invasive and more
>> powerful: you can use a much precise timing, select which set of events
>> to display without having to recompile.
>> The default backend behaves as console printf.
>>
>> You should try them :)
> 
> I have tried them on 
> 
>   pci_update_mappings_del
>   pci_update_mappings_add
>   pci_cfg_write
> 
> and they work great. They would be nice for SJA1000
> register accesses, PCI boards configuration etc.
> I am not sure how to use them for CAN messages
> which has a variable length data field.

Yes, I hit this problem with variable length data in the SD Bus.

Let's ask Stefan what is the best approach (he said "Tracing is not
great for dumping large amounts of data")

> Any of debugging outputs is active (all is optimized out)
> in regular build.
> 
>>>>> +    /* open socket */
>>>>> +    s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>>>>
>>>> I never used it, but I think QEMU uses his socket API: "qemu/sockets.h"
>>>
>>> The SocketCAN host connection code is Linux specific,
>>> but I can switch to qemu_socket() if it is preferred.
>>> But address family has to be from Linux header file anyway.

I'll let the Chardev maintainers suggest what's best.

>>
>> qemu_socket() sockets are heavily tested and already solve many things,
>> like async I/O and error handling.
> 
> The CAN socket works with RAW packets read and written as 16 bytes.
> So some higher level of optimizations used for stream or larger packets
> have no significant effect there and SocketCAN API is Linux kernel
> specific so generic abstraction layers has no effect there as well.
> 
> I have question about reporting fatal error.
> 
> Our code uses error_report() and exit(1) for now.
> 
>         error_report("CAN host device \"%s\" connect to bus \"%s\" failed",
>                       host_dev_name, bus->name);
>         exit(1);
> 
> Is that correct or there is better solution/function instead of exit?
> I have seen this combination in many other places of QEMU code
> in past but may it be there is some proposed change already.

I think QEMU codebase now try to unify this using
"include/qapi/error.h", so your can_bus_connect_to_host_socketcan()
function would take an extra 'Error *errp' parameter.

> 
> Best wishes,
> 
> Pavel Pisa
> 
> 
