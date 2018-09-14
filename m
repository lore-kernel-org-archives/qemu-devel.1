Received: from eggs.gnu.org ([2001:4830:134:3::10]:36340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0oei-0001w4-IU
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0oef-0004lN-6Z
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:01:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1g0oee-0004ju-U5
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:01:05 -0400
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081950.3228.68987.stgit@pasha-VirtualBox>
	<f7b7533c-a9db-d660-4981-678ae5143950@redhat.com>
	<002101d44bee$9edf9720$dc9ec560$@ru>
From: John Snow <jsnow@redhat.com>
Message-ID: <cccee26e-80fc-605a-43ef-b5e116912720@redhat.com>
Date: Fri, 14 Sep 2018 10:00:53 -0400
MIME-Version: 1.0
In-Reply-To: <002101d44bee$9edf9720$dc9ec560$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 21/25] replay: replay BH for IDE trim
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net



On 09/14/2018 01:48 AM, Pavel Dovgalyuk wrote:
>> From: John Snow [mailto:jsnow@redhat.com]
>> On 09/12/2018 04:19 AM, Pavel Dovgalyuk wrote:
>>> This patch makes IDE trim BH deterministic, because it affects
>>> the device state. Therefore its invocation should be replayed
>>> instead of running at the random moment.
>>>
>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  hw/ide/core.c |    3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index 2c62efc..04e22e7 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -35,6 +35,7 @@
>>>  #include "sysemu/block-backend.h"
>>>  #include "qapi/error.h"
>>>  #include "qemu/cutils.h"
>>> +#include "sysemu/replay.h"
>>>
>>>  #include "hw/ide/internal.h"
>>>  #include "trace.h"
>>> @@ -479,7 +480,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
>>>  done:
>>>      iocb->aiocb = NULL;
>>>      if (iocb->bh) {
>>> -        qemu_bh_schedule(iocb->bh);
>>> +        replay_bh_schedule_event(iocb->bh);
>>>      }
>>>  }
>>>
>> Just passing by: Why do we need to change this call, but nothing else in
>> IDE?
> 
> This call is responsible for a bug that was reproducible.
> 
>> I don't mind conceptually, but it's odd to me that of all the calls I
>> make in this emulator that change state somewhere that this is the only
>> one you need to hijack for the replay feature.
>>
>> Is this a necessarily complete change?
> 
> Maybe not. We can hardly analyze all peripheral devices code and fix all the calls.
> But I think we can improve that patch and at least look through ide core to fix other calls.
> 
> Pavel Dovgalyuk
> 

It just seems odd that if you're working on a replay mechanism that
requires you to intercept my QEMU API calls that you're only changing a
trim callback.

I'd kind of expect that you don't need to intercept any, unless these
are legacy calls that I shouldn't be making at all and you have a more
generic intercept somewhere deeper in the codebase.

In that case, I really ought to hustle off of my use of legacy calls.

What are the criteria for things you need to intercept/wrap?
