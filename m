Received: from eggs.gnu.org ([2001:4830:134:3::10]:42375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehFR5-0007kB-66
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehFQv-0006D2-LA
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:01:55 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <934f18f7-0ded-6c36-a982-1613aae7b650@virtuozzo.com>
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
	<w51y3kexdv9.fsf@maestria.local.igalia.com>
	<934f18f7-0ded-6c36-a982-1613aae7b650@virtuozzo.com>
Date: Thu, 01 Feb 2018 15:01:42 +0100
Message-ID: <w51o9l86c6x.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Wed 31 Jan 2018 06:11:27 PM CET, Anton Nefedov wrote:
> On 31/1/2018 6:11 PM, Alberto Garcia wrote:
>> On Thu 18 Jan 2018 06:49:02 PM CET, Anton Nefedov wrote:
>> 
>>> -static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
>>> +static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self,
>>> +                                                   bool nowait)
>> 
>> It's a bit confusing to have a function called wait_foo() with a
>> parameter that says "don't wait"...
>> 
>> How about
>> 
>>       check_serialising_requests(BdrvTrackedRequest *self, bool wait)
>> 
>
> I think it might be more important to emphasize in the name that the
> function _might_ wait.
>
> i.e. it feels worse to read
>    check_serialising_requests(req, true);
> when one needs to follow the function to find out that it might yield.
>
> Personally I'd vote for
>
>      static int check_or_wait_serialising_requests(
>          BdrvTrackedRequest *self, bool wait) {}
>
> and maybe even:
>
>      static int check_serialising_requests(BdrvTrackedRequest *self) {
>          return check_or_wait_serialising_requests(self, false);
>
>      static int wait_serialising_requests(BdrvTrackedRequest *self) {
>          return check_or_wait_serialising_requests(self, true);
>      }

You're right. Either approach works for me though, also keeping the
current solution, wait_serialising_requests(req, true).

Berto
