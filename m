Received: from eggs.gnu.org ([2001:4830:134:3::10]:41321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdf67-0007XH-HG
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdf66-0006Vn-JP
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:09:43 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdf66-0006Ux-DT
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:09:42 -0400
Received: by mail-oi0-x244.google.com with SMTP id q11-v6so31572258oic.12
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 10:09:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <224a0bbb-9dbb-87eb-9e9b-1c82923010b5@redhat.com>
References: <1531409463-3843-1-git-send-email-thuth@redhat.com>
	<1531409463-3843-2-git-send-email-thuth@redhat.com>
	<20180712165224.GD31657@localhost.localdomain>
	<224a0bbb-9dbb-87eb-9e9b-1c82923010b5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 18:09:21 +0100
Message-ID: <CAFEAcA8-1TiRD2S4hJW1tXfi2ivV-ONg=wEFiX+uGfweD6mY6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] qom/object: Add a new function
 object_initialize_as_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 12 July 2018 at 17:55, Thomas Huth <thuth@redhat.com> wrote:
> On 12.07.2018 18:52, Eduardo Habkost wrote:
>> On Thu, Jul 12, 2018 at 05:30:59PM +0200, Thomas Huth wrote:
>>> @@ -749,6 +749,25 @@ int object_set_propv(Object *obj,
>>>  void object_initialize(void *obj, size_t size, const char *typename);
>>>
>>>  /**
>>> + * object_initialize_as_child:
>>> + * @parentobj: The parent object to add a property to
>>> + * @propname: The name of the property
>>> + * @childobj: A pointer to the memory to be used for the object.
>>> + * @size: The maximum size available at @obj for the object.
>>> + * @type: The name of the type of the object to instantiate.
>>> + * @errp: If an error occurs, a pointer to an area to store the area
>>> + *
>>> + * This function will initialize an object. The memory for the object should
>>> + * have already been allocated. The object will then be added as child property
>>> + * to a parent with object_property_add_child() function. The returned object
>>> + * has a reference count of 1, and will be finalized when the last reference is
>>> + * dropped.
>>> + */
>>> +void object_initialize_as_child(Object *parentobj, const char *propname,
>>> +                                void *childobj, size_t size, const char *type,
>>> +                                Error **errp);
>>
>> Why did you use void* instead of Object*?
>
> That's the same what object_initialize() is doing (see above). Otherwise
> all the callers have to cast their pointers with OBJECT() first.

Casting with OBJECT() would not work, because it does a typecheck.
At the point where something is calling object_initialize() or
object_initialize_with_child(), the memory at 'childobj' has not
been initialized, so a typecheck is impossible.

It's only once the object has actually been initialized that
the memory is a valid Object* that you can put through OBJECT().

thanks
-- PMM
