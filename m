Received: from eggs.gnu.org ([2001:4830:134:3::10]:34092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egvvE-0000VF-Az
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egvvD-0001R2-DG
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:11:44 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
	<w51y3kexdv9.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <934f18f7-0ded-6c36-a982-1613aae7b650@virtuozzo.com>
Date: Wed, 31 Jan 2018 20:11:27 +0300
MIME-Version: 1.0
In-Reply-To: <w51y3kexdv9.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com



On 31/1/2018 6:11 PM, Alberto Garcia wrote:
> On Thu 18 Jan 2018 06:49:02 PM CET, Anton Nefedov wrote:
> 
>> -static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
>> +static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self,
>> +                                                   bool nowait)
> 
> It's a bit confusing to have a function called wait_foo() with a
> parameter that says "don't wait"...
> 
> How about
> 
>       check_serialising_requests(BdrvTrackedRequest *self, bool wait)
> 

I think it might be more important to emphasize in the name that the
function _might_ wait.

i.e. it feels worse to read
   check_serialising_requests(req, true);
when one needs to follow the function to find out that it might yield.

Personally I'd vote for

     static int check_or_wait_serialising_requests(
         BdrvTrackedRequest *self, bool wait) {}

and maybe even:

     static int check_serialising_requests(BdrvTrackedRequest *self) {
         return check_or_wait_serialising_requests(self, false);

     static int wait_serialising_requests(BdrvTrackedRequest *self) {
         return check_or_wait_serialising_requests(self, true);
     }

>> -    waited = wait_serialising_requests(req);
>> +    waited = wait_serialising_requests(req, flags & BDRV_REQ_ALLOCATE);
>> +    if (waited && flags & BDRV_REQ_ALLOCATE) {
>> +        return -EAGAIN;
>> +    }
> 
> I find this more readable (even if not strictly necessary):
> 
>         if (waited && (flags & BDRV_REQ_ALLOCATE)) {
> 

Done!

> None of my two comments are blockers, though, so
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> 
> Berto
> 
