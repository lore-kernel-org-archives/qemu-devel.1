Received: from eggs.gnu.org ([209.51.188.92]:35214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpB3R-0006UN-C5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpB3Q-0004I5-F6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:02:49 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
	<9dc7c83c-a63c-9cde-1267-43bc62e73436@redhat.com>
	<87imy5dy5v.fsf@dusky.pond.sub.org>
	<703ad7c6-e8bb-2b62-41a9-1a15a7634f1e@redhat.com>
	<87bm3xcgll.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3f866256-7733-b4a1-40e9-2ab62843137a@redhat.com>
Date: Thu, 31 Jan 2019 13:02:30 +0100
MIME-Version: 1.0
In-Reply-To: <87bm3xcgll.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Libvirt <libvir-list@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 01/31/19 10:37, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 31/01/19 09:33, Markus Armbruster wrote:
>>> I thought secure=on affected only writes (and so wouldn't matter with
>>> readonly=on), but I was wrong:
>>>
>>>     static MemTxResult pflash_mem_read_with_attrs(void *opaque, hwaddr addr, uint64_t *value,
>>>                                                   unsigned len, MemTxAttrs attrs)
>>>     {
>>>         pflash_t *pfl = opaque;
>>>         bool be = !!(pfl->features & (1 << PFLASH_BE));
>>>
>>>         if ((pfl->features & (1 << PFLASH_SECURE)) && !attrs.secure) {
>>>             *value = pflash_data_read(opaque, addr, len, be);
>>>         } else {
>>>             *value = pflash_read(opaque, addr, len, be);
>>>         }
>>>         return MEMTX_OK;
>>>     }
>>>
>>> pflash_data_read() is what pflash_read() does when pfl->cmd is 0.
>>
>> Reads from flash actually do not go through here; this function executes
>> if the flash chip is already in MMIO mode, which happens after you
>> *write* a command to the memory area.  With secure=on, you just cannot
>> do a command write unless you're in SMM, in other words the flash chip
>> can only ever go in MMIO mode if you're in SMM.
>>
>>> Hmm, why is it okay to treat all pfl->cmd values the same when
>>> secure=on?
>>
>> But doesn't matter.  You just don't want MMIO mode to be active outside
>> SMM: all that non-SMM code want to do with the flash is read and execute
>> it, as far as they're concerned it's just ROM and the command mode is
>> nonexistent.
> 
> Out of curiosity: what effect does secure=on have when the device is
> read-only (pflash_t member ro non-zero)?
> 

It's hard to theorize about this comprehensively. What action and which
pflash unit do you have in mind?

(Interpreting your question as "what does the firmware see if...".
Another interpretation would be possible too, "what does QEMU do if...".)

Thanks
Laszlo
