Received: from eggs.gnu.org ([2001:4830:134:3::10]:56954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cXAA5-0005zd-60
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cXAA0-0006ZL-OU
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:18:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485528688-29914-1-git-send-email-thuth@redhat.com>
	<CAKmqyKOGTgKfGdjX4AYvh_yz=mSAgSdAWV=58=0s4w7LXjy2qw@mail.gmail.com>
	<CAFEAcA-fSMkEVh3DOAh0d-JV=SPF6JqfT0SQ4OjwPbss-Jan_Q@mail.gmail.com>
Date: Fri, 27 Jan 2017 18:18:01 +0100
In-Reply-To: <CAFEAcA-fSMkEVh3DOAh0d-JV=SPF6JqfT0SQ4OjwPbss-Jan_Q@mail.gmail.com>
	(Peter Maydell's message of "Fri, 27 Jan 2017 16:52:59 +0000")
Message-ID: <87wpdga0c6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/core/or-irq: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 27 January 2017 at 16:40, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> On Fri, Jan 27, 2017 at 6:51 AM, Thomas Huth <thuth@redhat.com> wrote:
>>> The "or-irq" device is just used internally. It's strange to
>>> see this device showing up in the "-device ?" help text. Let's mark it
>>> with cannot_instantiate_with_device_add_yet to hide it from the users.
>>
>> I agree that it is strange to be showing up to users, but is this
>> really the best way to do this?
>>
>> I thought we were trying to get rid of
>> cannot_instantiate_with_device_add_yet. Would it maybe be better to
>> have an internal filed that sets this device as internal?
>
> Yes, I agree; the reason for cannot_instantiate_with_device_add_yet
> being such a long and ugly name is so it's easy to grep for
> things we in theory might want to fix some day. "We'd rather
> this didn't show up in help" is a different question.
>
> (Like a lot of devices, it's pretty useless via -device, though,
> because we have no way to wire up qemu_irq lines on the command
> line.)

And that's precisely why it needs cannot_instantiate_with_device_add_yet
set.  Like any device that needs code to wire it up.

The commit message should state that.  There's no need to argue whether
we want to hide it from users.

>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/core/or-irq.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>> 
>>> diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
>>> index 1ac090d..2487fa3 100644
>>> --- a/hw/core/or-irq.c
>>> +++ b/hw/core/or-irq.c
>>> @@ -89,6 +89,9 @@ static void or_irq_class_init(ObjectClass *klass, void *data)
>>>      dc->props = or_irq_properties;
>>>      dc->realize = or_irq_realize;
>>>      dc->vmsd = &vmstate_or_irq;
>>> +
>>> +    /* It's just used internally, and should not be exposed to users */

Make that

         /* Reason: needs to be wired up, e.g. by stm32f205_soc_realize() */

>>> +    dc->cannot_instantiate_with_device_add_yet = true;
>>>  }
>>>  
>>>  static const TypeInfo or_irq_type_info = {

With that and a rephrased commit message
Reviewed-by: Markus Armbruster <armbru@redhat.com>
