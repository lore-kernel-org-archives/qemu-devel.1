Received: from eggs.gnu.org ([2001:4830:134:3::10]:51273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eJlqj-0007Cf-PF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eJlqh-0001jT-PO
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:47:21 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:37290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eJlqh-0001hN-LJ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:47:19 -0500
References: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
	<20171113161446.2862-2-michael.nawrocki@gtri.gatech.edu>
	<CAFEAcA8FDoLRx+OCMwjUzYd-X3HX7Z77SUTmNbSB9YWYT77AcA@mail.gmail.com>
	<CAFEAcA-JwUm5+N-Km1fZjuPYA81sMCekguchJiV59BvqjnPJOA@mail.gmail.com>
From: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>
Message-ID: <b3a7006b-bf0d-f5f3-bf78-f18b38a014e7@gtri.gatech.edu>
Date: Tue, 28 Nov 2017 14:47:15 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-JwUm5+N-Km1fZjuPYA81sMCekguchJiV59BvqjnPJOA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Switch AMD CFI flash to use new
 MMIO API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/23/2017 06:27 AM, Peter Maydell wrote:
> On 23 November 2017 at 11:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 13 November 2017 at 16:14, Mike Nawrocki
>> <michael.nawrocki@gtri.gatech.edu> wrote:
>>> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
>>> ---
>>>   hw/block/pflash_cfi02.c | 97 +++++++++----------------------------------------
>>>   1 file changed, 18 insertions(+), 79 deletions(-)
>>>
>>> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
>>> index c81ddd3a99..a81df913f6 100644
>>> --- a/hw/block/pflash_cfi02.c
>>> +++ b/hw/block/pflash_cfi02.c
>>> @@ -138,12 +138,12 @@ static void pflash_timer (void *opaque)
>>>       pfl->cmd = 0;
>>>   }
>>>
>>> -static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>>> -                             int width, int be)
>>> +static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
>>> +                            int width, int be)
>>>   {
>>>       hwaddr boff;
>>> -    uint32_t ret;
>>>       uint8_t *p;
>>> +    uint64_t ret;
>>
>> I suspect you'll find that the change of type for 'ret' here
>> and the 'value' argument to pflash_write() will break compilation
>> with PFLASH_DEBUG defined, because the type won't match the DPRINTF
>> format strings any more.
>>
>> You could either fix up the format strings, or (since there's a
>> wrapper function here anyway) leave the types of pflash_read()
>> and pflash_write() alone and let the wrappers implicitly do
>> the conversion between uint64_t and uint32_t.
> 
> ...ah, just noticed that in patch 2 you want to add 8-byte
> accesses. So you'll need to fix the format strings.
> 
> thanks
> -- PMM
> 

Yeah, it definitely doesn't compile with PFLASH_DEBUG defined. I'll 
update those format strings for the next revision.
Thanks!
