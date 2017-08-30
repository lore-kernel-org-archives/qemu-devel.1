Received: from eggs.gnu.org ([2001:4830:134:3::10]:41124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmu2C-0005Ks-2D
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmu28-0002pw-2c
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:51:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-7-jsnow@redhat.com>
	<c77613df-3e40-09a8-9aa9-60aeea46accf@amsat.org>
	<7293b22a-d608-99d2-ead0-5cc485b50b7c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89188778-a144-4596-1fbb-5525660477f4@amsat.org>
Date: Wed, 30 Aug 2017 00:51:11 -0300
MIME-Version: 1.0
In-Reply-To: <7293b22a-d608-99d2-ead0-5cc485b50b7c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/9] AHCI: Replace DPRINTF with trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

[...]
>>> +# hw/ide/ahci.c
>>> +ahci_port_read(void *s, int port, int offset, uint32_t ret)
>>> "ahci(%p)[%d]: port read @ 0x%x: 0x%08x"
>>> +ahci_irq_raise(void *s) "ahci(%p): raise irq"
>>> +ahci_irq_lower(void *s) "ahci(%p): lower irq"
>>> +ahci_check_irq(void *s, uint32_t old, uint32_t new) "ahci(%p): check
>>> irq 0x%08x --> 0x%08x"
>>> +
>>> +ahci_port_write(void *s, int port, int offset, uint32_t val)
>>> "ahci(%p)[%d]: port write @ 0x%x: 0x%08x"
>>> +ahci_mem_read_32(void *s, uint64_t addr, uint32_t val) "ahci(%p): mem
>>> read @ 0x%"PRIx64": 0x%08x"
>>
>> can you use same format than ahci_mem_read()?
>>
>> "ahci(%p): read%u @ 0x%"PRIx64":     0x%08x"
>>
>>> +ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val)
>>> "ahci(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
>>> +ahci_mem_write(void *s, unsigned size, uint64_t addr, uint64_t val)
>>> "ahci(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64
>>> +ahci_mem_write_unknown(void *s, uint64_t addr) "ahci(%p): write to
>>> unknown register 0x%"PRIx64
>>
>> report the value written, eventually:
>>
>> "ahci(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64" UNKNOWN"
>>
> 
> Not necessary here; it's reported by the more generic
> trace_ahci_mem_write which gets all of the writes no matter where they
> go. In this case, too, the write is actually ignored and doesn't wind up
> going anywhere ...
> 
> ... but I suppose it wouldn't hurt to know what that value would have
> been. If we enable just this trace that will probably help illuminate
> what the errant write is.
> 
>>> +ahci_set_signature(void *s, int port, uint8_t nsector, uint8_t
>>> sector, uint8_t lcyl, uint8_t hcyl, uint32_t sig) "ahci(%p)[%d]: set
>>> signature sector:0x%02x nsector:0x%02x lcyl:0x%02x hcyl:0x%02x
>>> (cumulatively: 0x%08x)"
>>> +ahci_reset_port(void *s, int port) "ahci(%p)[%d]: reset port"
>>
>> could be generic:
>>
>> ahci_port(void *s, int port) "ahci(%p)[%d]: %s"
>>
>> then
>>
>> trace_ahci_port(s, port, "reset port");
>>
> 
> I don't disagree, just more trepidation on what that means for the trace
> events which are otherwise all named exactly for the functions that call
> them.
> 
> Also, the problem with combining these sorts of traces becomes one with
> the DPRINTF we're replacing: you can't target individual sections of
> code anymore, and you either turn on "ahci_port" or off.

Oh I did not think of that, good point.

> 
> If there is a better suggestion for avoiding the ahci(%p)[%d]: pattern
> here over and over and over and over again I'd happily take it.
> 
> Stefan?
> 
> [...snip...]
> 
>>> +ahci_reset(void *s) "ahci(%p): HBA reset"
>>> +allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t
>>> val, unsigned size) "ahci(%p): read a=%p addr=0x%"HWADDR_PRIx"
>>> val=0x%"PRIx64", size=%d"
>>
>> is AllwinnerAHCIState useful?
>>
> 
> Only as far as it happens to be the argument to this function; of course
> AHCIState is the real prize, but we have to fish it out of
> AllwinnerAHCIState first.
> 
>> I'd rather use directly trace_ahci_mem_read(s, size, addr, val)
>>>> +allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t
>>> val, unsigned size) "ahci(%p): write a=%p addr=0x%"HWADDR_PRIx"
>>> val=0x%"PRIx64", size=%d"
>>
>> and trace_ahci_mem_write(s, size, addr, val)
>>
>> Regards,
>>
>> Phil.
> 
