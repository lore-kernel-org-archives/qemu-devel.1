Received: from eggs.gnu.org ([2001:4830:134:3::10]:43206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmTgf-0004jd-2j
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 19:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmTge-00016z-5L
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 19:43:21 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-5-jsnow@redhat.com>
	<484521bc-66a2-593a-a9c8-f71956d531e7@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8f458f74-da72-ad79-8b64-b25623ad61e4@redhat.com>
Date: Mon, 28 Aug 2017 19:43:13 -0400
MIME-Version: 1.0
In-Reply-To: <484521bc-66a2-593a-a9c8-f71956d531e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/9] ATAPI: Replace DEBUG_IDE_ATAPI with
 tracing events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org



On 08/08/2017 04:59 PM, Eric Blake wrote:
> On 08/08/2017 01:33 PM, John Snow wrote:
>> Goodbye, printfs.
>> Hello, fancy printfs.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  hw/ide/atapi.c            | 64 +++++++++++++++++------------------------------
>>  hw/ide/trace-events       | 19 ++++++++++++++
>>  include/hw/ide/internal.h |  1 -
>>  3 files changed, 42 insertions(+), 42 deletions(-)
> 
>> @@ -1330,16 +1310,18 @@ void ide_atapi_cmd(IDEState *s)
>>      uint8_t *buf = s->io_buffer;
>>      const struct AtapiCmd *cmd = &atapi_cmd_table[s->io_buffer[0]];
>>  
>> -#ifdef DEBUG_IDE_ATAPI
>> -    {
>> +    trace_ide_atapi_cmd(s, s->io_buffer[0]);
>> +
>> +    if (TRACE_IDE_ATAPI_CMD_PACKET_ENABLED) {
>> +        /* Each pretty-printed byte needs two bytes and a space; */
>> +        char *ppacket = g_malloc(ATAPI_PACKET_SIZE * 3 + 1);
> 
> Nice use of an extra conditional to make a pretty trace without the
> overhead when tracing is off.  (Oh yeah, you asked me on IRC how to do
> it, and I pointed to commit bd6952a3 as the example)
> 
> 
>> +++ b/hw/ide/trace-events
>> @@ -6,6 +6,10 @@ ide_ioport_read(uint32_t addr, const char *reg, uint32_t val, void *bus, void *s
>>  ide_ioport_write(uint32_t addr, const char *reg, uint32_t val, void *bus, void *s) "IDE PIO wr @ 0x%"PRIx32" (%s); val 0x%02"PRIx32"; bus %p IDEState %p"
> 
> Wouldn't it be nice if our trace generator would let us line-wrap?
> 
>> +# Warning: Verbose
> 
> Cute.  Should you also add it to the ide_data_* traces, per the commit
> message in 3/9?
> 

Probably.

>> +ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDEState: %p; limit=0x%x packet: %s"
>> \ No newline at end of file
> 
> Umm, that should be fixed (I know that 'diff' uses both / and \ to
> differentiate whether it was the pre- or post-patch version that had the
> issue, but never remember which is which - so the fix may be in an
> earlier patch).  Also fix the trace-events rebase for 3/9; with that,
> you can add
> 

I'll fix these and let you re-bestow me with RBs, to err on the side of
caution.

> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
