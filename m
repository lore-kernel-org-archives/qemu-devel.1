Received: from eggs.gnu.org ([2001:4830:134:3::10]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cxfsm-0005nV-EE
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cxfsl-0000rA-LQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:25:52 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cxfsl-0000qc-Gb
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:25:51 -0400
Received: by mail-oi0-x242.google.com with SMTP id t63so8961803oih.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 13:25:50 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA8-OO8AOKc4FD2Hj5WvJkcSkPV_1ef9i7ihgZDaf9ui3Q@mail.gmail.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<f65e921725d39ce81c2d0910d59897a020596c58.1491349058.git.alistair.francis@xilinx.com>
	<CAFEAcA8-OO8AOKc4FD2Hj5WvJkcSkPV_1ef9i7ihgZDaf9ui3Q@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 10 Apr 2017 13:25:18 -0700
Message-ID: <CAKmqyKN4hmgL9L9QTCCkGxMOeAgTT0otvNkDLnpGjL-rumHwqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1 2/5] cadence_gem: Correct the
 multi-queue can rx logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Apr 10, 2017 at 5:37 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 5 April 2017 at 00:40, Alistair Francis <alistair.francis@xilinx.com> wrote:
>> Correct the buffer descriptor busy logic to work correctly when using
>> multiple queues.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  hw/net/cadence_gem.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
>> index 17c229d..3e37665 100644
>> --- a/hw/net/cadence_gem.c
>> +++ b/hw/net/cadence_gem.c
>> @@ -481,14 +481,18 @@ static int gem_can_receive(NetClientState *nc)
>>      }
>>
>>      for (i = 0; i < s->num_priority_queues; i++) {
>> -        if (rx_desc_get_ownership(s->rx_desc[i]) == 1) {
>> -            if (s->can_rx_state != 2) {
>> -                s->can_rx_state = 2;
>> -                DB_PRINT("can't receive - busy buffer descriptor (q%d) 0x%x\n",
>> -                         i, s->rx_desc_addr[i]);
>> -             }
>> -            return 0;
>> +        if (rx_desc_get_ownership(s->rx_desc[i]) != 1) {
>> +            break;
>> +        }
>> +    };
>> +
>> +    if (i == s->num_priority_queues) {
>> +        if (s->can_rx_state != 2) {
>> +            s->can_rx_state = 2;
>> +            DB_PRINT("can't receive - busy buffer descriptor (q%d) 0x%x\n",
>> +                     i, s->rx_desc_addr[i]);
>
> This looks a little odd -- surely i isn't the right index to use
> into rx_desc_addr[] any more now we're outside the loop and i
> is always larger than the largest valid queue number? It looks
> like the debug print should be rephrased somehow.

Yeah you are right. It means that they are all busy, we can either
iterate over all of them and print out this or just print one
statement saying that. Somehow I ended up half way between both.

I'll update it to just print that they are all busy. I don't see why
we need every address printed.

Thanks,

Alistair

>
> thanks
> -- PMM
