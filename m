Received: from eggs.gnu.org ([2001:4830:134:3::10]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQGDH-0003c1-JU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQG5p-00056W-5l
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:22:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQG5o-00055q-UZ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:22:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id k198so12821335wmd.3
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 10:22:16 -0800 (PST)
References: <20181123135450.24829-1-edgar.iglesias@gmail.com>
	<20181123135450.24829-2-edgar.iglesias@gmail.com>
	<75bcddbc-da2d-aeb3-71d3-52b635520d2a@redhat.com>
	<20181123165945.GM1148@toto> <20181123170225.GJ7447@toto>
	<20181123170624.GN1148@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bd302393-5220-74be-d20b-7aa741aaa347@redhat.com>
Date: Fri, 23 Nov 2018 19:22:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181123170624.GN1148@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] net: cadence_gem: Remove incorrect
 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com

On 23/11/18 18:06, Edgar E. Iglesias wrote:
> On Fri, Nov 23, 2018 at 06:02:25PM +0100, Edgar E. Iglesias wrote:
>> On Fri, Nov 23, 2018 at 05:59:45PM +0100, Edgar E. Iglesias wrote:
>>> On Fri, Nov 23, 2018 at 05:46:17PM +0100, Philippe Mathieu-Daudé wrote:
>>>> Hi Edgar,
>>>
>>> Hi Philippe,
>>>
>>>>
>>>> On 23/11/18 14:54, Edgar E. Iglesias wrote:
>>>>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>>>>
>>>>> Don't assert on RX descriptor settings when the receiver is
>>>>> disabled. This fixes an issue with incoming packets on an
>>>>> unused GEM.
>>>>>
>>>>> Reported-by: mbilal <muhammad_bilal@mentor.com>
>>>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>>>> ---
>>>>>  hw/net/cadence_gem.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
>>>>> index d95cc27f58..7f63411430 100644
>>>>> --- a/hw/net/cadence_gem.c
>>>>> +++ b/hw/net/cadence_gem.c
>>>>> @@ -979,7 +979,6 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>>>>>  
>>>>>          /* Do nothing if receive is not enabled. */
>>>>>          if (!gem_can_receive(nc)) {
>>>>> -            assert(!first_desc);
>>>>
>>>> Maybe worth:
>>>>
>>>>                trace_gem_receive_packet_drop(size);
>>>
>>> Or perhaps a generic tracepoint on packet drops for any device.
>>> Anyway this is probably something for after the release.
>>>
>>> Not sure if it's too late to even get the removal of the assert into this release? Peter?
>>>
>>>>
>>>>>              return -1;
>>>>
>>>> Shouldn't this be 'return 0'?
>>>>
>>>> The "net/net.h" doc is scarce...
>>>
>>> If we return 0 my understanding is that we later need to actively
>>> call qemu_flush_or_purge_queued_packets() to renable the rx
>>> path which the GEM model doesn't do. So that would mean
>>> refactoring the model a bit.
>>
>> Actually, the GEM model does do that, my bad, so yes return 0 seems to be the right thing to do here.
> 
> I take that back, the GEM model only handles some of the !can_receive cases
> with qemu_flush_queued_packets(). Not all, so return -1 is correct I think.

OK, thanks for checking this.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.
