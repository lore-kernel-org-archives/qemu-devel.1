Received: from eggs.gnu.org ([209.51.188.92]:51779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hJV2e-0000Xd-5m
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hJUoX-0000hB-Ro
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:12:47 -0400
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
	<20190416212003.GB2272@habkost.net> <87ftqh1ae5.fsf@dusky.pond.sub.org>
	<20190417171059.GC25134@habkost.net>
	<3fc39df9-9c4e-219c-e7dc-c93754fd1315@linux.intel.com>
	<20190424172143.GC18406@habkost.net>
From: Like Xu <like.xu@linux.intel.com>
Message-ID: <a8aa414d-b393-83a7-61dd-01b15b27d93d@linux.intel.com>
Date: Thu, 25 Apr 2019 11:12:29 +0800
MIME-Version: 1.0
In-Reply-To: <20190424172143.GC18406@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] core/qdev: refactor
 qdev_get_machine() with type assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, like.xu@intel.com, Igor Mammedov <imammedo@redhat.com>

On 2019/4/25 1:21, Eduardo Habkost wrote:
> On Tue, Apr 23, 2019 at 03:59:31PM +0800, Like Xu wrote:
>> On 2019/4/18 1:10, Eduardo Habkost wrote:
>>> On Wed, Apr 17, 2019 at 07:14:10AM +0200, Markus Armbruster wrote:
>>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>>
>>>>> On Mon, Apr 15, 2019 at 03:59:45PM +0800, Like Xu wrote:
>>>>>> To avoid the misuse of qdev_get_machine() if machine hasn't been created yet,
>>>>>> this patch uses qdev_get_machine_uncheck() for obj-common (share with user-only
>>>>>> mode) and adds type assertion to qdev_get_machine() in system-emulation mode.
>>>>>>
>>>>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>>>>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>>>>>
>>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>>
>>>>> I'm queueing the series on machine-next, thanks!
>>>>
>>>> Hold your horses, please.
>>>>
>>>> I dislike the name qdev_get_machine_uncheck().  I could live with
>>>> qdev_get_machine_unchecked().
>>>>
>>>> However, I doubt this is the right approach.
>>>>
>>>> The issue at hand is undisciplined creation of QOM object /machine.
>>>>
>>>> This patch adds an asseertion "undisciplined creation of /machine didn't
>>>> create crap", but only in some places.
>>>>
>>>> I think we should never create /machine as (surprising!) side effect of
>>>> qdev_get_machine().  Create it explicitly instead, and have
>>>> qdev_get_machine() use object_resolve_path("/machine", NULL) to get it.
>>>> Look ma, no side effects.
>>>
>>> OK, I'm dropping this one while we discuss it.
>>>
>>> I really miss a good explanation why qdev_get_machine_unchecked()
>>> needs to exist.  When exactly do we want /machine to exist but
>>> not be TYPE_MACHINE?  Why?
>>
>> AFAICT, there is no such "/machine" that is not of type TYPE_MACHINE.
>>
>> The original qdev_get_machine() would always return a "/container" object in
>> user-only mode and there is none TYPE_MACHINE object.
> 
> I'm confused.  Both qdev_get_machine() and
> qdev_get_machine_unchecked() still return the object at
> "/machine".  On softmmu, /machine will be of type TYPE_MACHINE.
> On user-only, /machine will be of type "container".
> 
> 
>>
>> In system emulation mode, it returns the same "/container" object at the
>> beginning, until we initialize and add a TYPE_MACHINE object to the
>> "/container" as a child and it would return OBJECT(current_machine)
>> for later usages.
>>
>> The starting point is to avoid using the legacy qdev_get_machine()
>> in system emulation mode when we haven't added the "/machine" object.
>> As a result, we introduced type checking assertions to avoid premature
>> invocations.
> 
> I believe Markus is suggesting that avoiding unwanted side
> effects is even better than doing type checking after it's
> already too late.  In other words, it doesn't make sense to call
> container_get("/machine") on system emulation mode.

I agree.

> 
> 
>>
>> In this proposal, the qdev_get_machine_unchecked() is only used
>> in user-only mode, part of which shares with system emulation mode
>> (such as device_set_realized, cpu_common_realizefn). The new
>> qdev_get_machine() is only used in system emulation mode and type checking
>> assertion does reduce the irrational use of this function (if any in the
>> future).
> 
> This part confuses me as well.  qdev_get_machine_unchecked() is
> used in both user-only and softmmu, isn't?  Thus we can't say it
> is only used in user-only mode.

You're right about this.

> 
> I think we all agree that qdev_get_machine() should eventually be
> available in softmmu only.

I think we need to make it happen to avoid calling qdev_get_machine()
in user-only mode.

> 
> But I don't think we agree when it would be appropriate to call
> qdev_get_machine_unchecked() instead of qdev_get_machine().
> 
> On both examples in your patch, the code checks for TYPE_MACHINE
> immediately after calling qdev_get_machine_unchecked().  If that
> code is only useful in softmmu mode, when would anybody want to
> call qdev_get_machine_unchecked() in user-only mode?
> 
> 
>>
>> We all agree to use this qdev_get_machine() as little as possible
>> and this patch could make future clean up work easier.
>>
>>>
>>> Once the expectations and use cases are explained, we can choose
>>> a better name for qdev_get_machine_unchecked() and document it
>>> properly.
>>>
>>
> 
