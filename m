Received: from eggs.gnu.org ([2001:4830:134:3::10]:44718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g09B1-0001FS-2K
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g09Ax-0002Ls-Mw
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:43:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1g09Ax-0002LT-Hk
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:43:39 -0400
References: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9b7e968f-b683-c431-b524-4df7de36b806@redhat.com>
Date: Wed, 12 Sep 2018 19:43:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory region: check the old.mmio.read
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 09/12/18 14:54, Peter Maydell wrote:
> On 12 September 2018 at 13:32, Li Qiang <liq3ea@gmail.com> wrote:
>> To avoid NULL-deref for the devices without read callbacks
>>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>> ---
>>  memory.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/memory.c b/memory.c
>> index 9b73892768..48d025426b 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -406,6 +406,10 @@ static MemTxResult memory_region_oldmmio_read_accessor(MemoryRegion *mr,
>>  {
>>      uint64_t tmp;
>>
>> +    if (!mr->ops->old_mmio.read[ctz32(size)]) {
>> +        return MEMTX_DECODE_ERROR;
>> +    }
>> +
>>      tmp = mr->ops->old_mmio.read[ctz32(size)](mr->opaque, addr);
>>      if (mr->subpage) {
>>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
>> --
>> 2.11.0
>>
> 
> There's patches on-list which drop the old_mmio field from the MemoryRegion
> struct entirely, so I think this patch as it stands is obsolete.
> 
> Currently our semantics are "you must provide both read and write, even
> if one of them just always returns 0 / does nothing / returns an error".

That's new to me. Has this always been the case? There are several
static MemoryRegionOps structures that don't conform. (See the end of my
other email:
<http://mid.mail-archive.com/84da6f02-1f60-4bc7-92da-6a7f74deded3@redhat.com>.)
Beyond the one that Li Qiang reported directly ("fw_cfg_ctl_mem_read").

Are all of those ops guest-triggerable QEMU crashers?

> We could probably reasonably assert this at the point when the
> MemoryRegionOps is registered.

Apparently, we should have...

Thanks,
Laszlo
