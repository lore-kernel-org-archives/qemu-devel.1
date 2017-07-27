Received: from eggs.gnu.org ([2001:4830:134:3::10]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daaWI-0004x5-3L
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daaWH-00066e-8f
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:35:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-19-f4bug@amsat.org>
	<20170727034304.GJ8978@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <299bd55b-5192-69d8-f15f-c55518fdeefe@amsat.org>
Date: Thu, 27 Jul 2017 01:35:14 -0300
MIME-Version: 1.0
In-Reply-To: <20170727034304.GJ8978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 19/20] spapr_vio: fix overflow
 of qdevs in spapr_dt_vdevice()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

On 07/27/2017 12:43 AM, David Gibson wrote:
> On Wed, Jul 26, 2017 at 11:42:23PM -0300, Philippe Mathieu-Daudé wrote:
>> sizeof(ptr) was used instead of sizeof(struct)...
>>
>> also use g_malloc_n() which take care of possible type overflow.
>>
>> hw/ppc/spapr_vio.c:641:22: warning: The code calls sizeof() on a pointer type. This can produce an unexpected result
>>      qdevs = g_malloc(sizeof(qdev) * num);
>>                       ^     ~~~~~~
>> hw/ppc/spapr_vio.c:648:23: warning: The code calls sizeof() on a pointer type. This can produce an unexpected result
>>      qsort(qdevs, num, sizeof(qdev), compare_reg);
>>                        ^     ~~~~~~
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Nack.
> 
> Have a closer look, what's going in the array really is pointers, not
> structures.  This is a false warning from clang, we need to find a
> different way to suppress it.

Something was bothering me with that patch, wondering why it never 
explode previously, now I see/understand.

>> ---
>>   hw/ppc/spapr_vio.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
>> index ea3bc8bd9e..9991b44c9f 100644
>> --- a/hw/ppc/spapr_vio.c
>> +++ b/hw/ppc/spapr_vio.c
>> @@ -638,14 +638,14 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
>>       }
>>   
>>       /* Copy out into an array of pointers */

/ashamed the comment was in front of me...

Thank you David for the review!

Phil.

>> -    qdevs = g_malloc(sizeof(qdev) * num);
>> +    qdevs = g_malloc_n(num, sizeof(*qdev));
>>       num = 0;
>>       QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
>>           qdevs[num++] = kid->child;
>>       }
>>   
>>       /* Sort the array */
>> -    qsort(qdevs, num, sizeof(qdev), compare_reg);
>> +    qsort(qdevs, num, sizeof(*qdev), compare_reg);
>>   
>>       /* Hack alert. Give the devices to libfdt in reverse order, we happen
>>        * to know that will mean they are in forward order in the tree. */
> 
