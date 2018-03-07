Received: from eggs.gnu.org ([2001:4830:134:3::10]:46447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1etfRo-00060n-2c
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1etfRk-0000Kq-V7
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:14:00 -0500
References: <20180307063651.4421-1-jcmvbkbc@gmail.com>
	<dfec213b-12fc-6fab-3600-74bde9da3149@vivier.eu>
	<CAMo8BfLKwevGeuSUQoVR2aD+9cDqek9DC42cr8ahTDye+ahomw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8be05a6f-1e3c-0d00-40de-6510597e05b0@vivier.eu>
Date: Wed, 7 Mar 2018 21:13:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLKwevGeuSUQoVR2aD+9cDqek9DC42cr8ahTDye+ahomw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/11] linux-user: fix
 mmap/munmap/mprotect/mremap/shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Le 07/03/2018 à 18:45, Max Filippov a écrit :
> On Wed, Mar 7, 2018 at 2:08 AM, Laurent Vivier <laurent@vivier.eu> wrote:
>>> +static inline int guest_range_valid(unsigned long start, unsigned long len)
>>> +{
>>> +    if (len)
>>> +        return guest_addr_valid(len - 1) && start <= GUEST_ADDR_MAX - len + 1;
>>> +    else
>>> +        return guest_addr_valid(start);
>>> +}
>>
>> I think we can consider len == 0 is invalid and use only:
>>
>>   return start + (len - 1) <= GUEST_ADDR_MAX;
> 
> start + len - 1 may wrap around, that's why I first validate len and then have
> len at the right side of the comparison. I.e. if we drop check for len == 0 I'd
> still write it as
> 
>   guest_addr_valid(len - 1) && start <= GUEST_ADDR_MAX - len + 1;
> 

Yes, you're right.

it would be clearer to write:

    len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;

but it's only cosmetic.

Thanks,
Laurent
