Received: from eggs.gnu.org ([2001:4830:134:3::10]:40527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehcan-0002Fd-A6
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehcai-0003a1-Vc
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:45:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehcai-0003Zg-OH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:45:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<871si6vt8n.fsf@dusky.pond.sub.org>
	<e3aca639-0c5c-8d10-a9f4-05a62284fb10@ozlabs.ru>
Date: Fri, 02 Feb 2018 08:37:53 +0100
In-Reply-To: <e3aca639-0c5c-8d10-a9f4-05a62284fb10@ozlabs.ru> (Alexey
	Kardashevskiy's message of "Fri, 2 Feb 2018 13:02:21 +1100")
Message-ID: <87r2q3n8oe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Andrea Bolognani <abologna@redhat.com>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 01/02/18 04:22, Markus Armbruster wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>> 
>>> There is already 'device-list-properties' which does most of the job,
>>> however it does not handle everything returned by qom-list-types such
>>> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
>>>
>>> This adds a new qom-list-properties command which prints properties
>>> of a specific class and its instance. It is pretty much a simplified copy
>>> of the device-list-properties handler.
>>>
>>> Since it creates an object instance, device properties should appear
>>> in the output as they are copied to QOM properties at the instance_init
>>> hook.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> 
>> Related: qom-list, which lists "any properties of a object given a path
>> in the object model."  qom-list-properties takes a type name, which
>> qom-list takes the path to an instance.  In other words,
>> qom-list-properties is like instantiate with default configuration and
>> without realizing + qom-list + destroy.
>
>
> True. Same as device-list-properties.

device-list-properties does a bit more, like skipping "uninteresting"
properties, and special magic for qdev properties (that's the
make_device_property_info() you asked about below).  But that's detail.

>> We need to instantiate because QOM properties are dynamic: they aren't
>> specified by data (which qom-list-properties could simply read), they
>> are created by (instantiation) code (which qom-list-properties has to
>> run).
>
> Correct.
>
>> Properties created only after instantiation (by realize, perhaps) aren't
>> visible in qom-list-properties.  Do such properties exist?
>
> No idea but if they do, then this issue already exists in
> device-list-properties.
>
>> Properties created only in non-default configuration aren't visible
>> either.  Such properties have to exist, or else dynamic property
>> creation would be idiotic.

Thus, qom-list-properties design limitation: the result need not reflect
properties of instantiated objects.  It usually does, as most QOM
properties behave as if they were static.  But when it doesn't, what
then?  How are users of qom-list-properties supposed to deal with such
inaccurate / incorrect information?  Do they just have to know which
properties aren't visible in qom-list-properties, and which properties
are, but cannot be trusted?

I posit that right now *nobody* knows.

Would such a command be useful anyway?

>> Likewise for properties created differently (say with a different type)
>> in non-default configuration.  We can hope that no such beasts exist.
>> Since properties get created by code, and code can do anything, we're
>> reduced to hope.  Data is so much easier to reason about than code.
>> 
>> Three building blocks: instantiate, qom-list, destroy.  Do we want the
>> building blocks, or do we want their combination qom-list-properties?
>
>
> Building blocks as QEMU internal helpers to split my
> qmp_qom_list_properties() into? These are not going to be huge and
> "destroy" is literally object_unref(obj) which does not seem very useful.
> Or I missed the point here?

My question is whether the QMP interface should provide the building
blocks, or only compositions.

>>> ---
>>>
>>> I am missing the point of make_device_property_info().
>>> qmp_device_list_properties() creates the instance which copies everything
>>> to QOM properties hashtable and commenting out the do{}while() in
>>> make_device_property_info() does not seem to change a thing, what case
>>> am I missing here?
>> 
>> git-blame points to Stefan.  Stefan, can you help?
