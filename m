Received: from eggs.gnu.org ([2001:4830:134:3::10]:33345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eiXUZ-0000Wb-GM
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 22:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eiXUV-0001yo-AE
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 22:30:51 -0500
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:37028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eiXUV-0001yG-12
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 22:30:47 -0500
Received: by mail-pg0-x236.google.com with SMTP id o1so3107674pgn.4
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 19:30:46 -0800 (PST)
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<871si6vt8n.fsf@dusky.pond.sub.org>
	<e3aca639-0c5c-8d10-a9f4-05a62284fb10@ozlabs.ru>
	<87r2q3n8oe.fsf@dusky.pond.sub.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8d3a65e6-e62b-6506-fb43-bb83f5ee7828@ozlabs.ru>
Date: Mon, 5 Feb 2018 14:30:39 +1100
MIME-Version: 1.0
In-Reply-To: <87r2q3n8oe.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 02/02/18 18:37, Markus Armbruster wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> On 01/02/18 04:22, Markus Armbruster wrote:
>>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>>
>>>> There is already 'device-list-properties' which does most of the job,
>>>> however it does not handle everything returned by qom-list-types such
>>>> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
>>>>
>>>> This adds a new qom-list-properties command which prints properties
>>>> of a specific class and its instance. It is pretty much a simplified copy
>>>> of the device-list-properties handler.
>>>>
>>>> Since it creates an object instance, device properties should appear
>>>> in the output as they are copied to QOM properties at the instance_init
>>>> hook.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> Related: qom-list, which lists "any properties of a object given a path
>>> in the object model."  qom-list-properties takes a type name, which
>>> qom-list takes the path to an instance.  In other words,
>>> qom-list-properties is like instantiate with default configuration and
>>> without realizing + qom-list + destroy.
>>
>>
>> True. Same as device-list-properties.
> 
> device-list-properties does a bit more, like skipping "uninteresting"
> properties, and special magic for qdev properties (that's the
> make_device_property_info() you asked about below).  But that's detail.


It is not clear at all why would we want to skip some properties (yes,
question to Stefan, not you) but this does not explain
make_device_property_info() - this thing walks through the device
properties even though they are already copied to the Object properties and
we could enumerate those, all of them, I compared device-list-properties
and qom-list-properties:


-*** Sending {"execute": "device-list-properties", "arguments":
{"typename": "vfio-pci"}}
+*** Sending {"arguments": {"typename": "vfio-pci"}, "execute":
"qom-list-properties"}
 >>>>>>>>>>>>>>>>

 {   'return': [   {   'description': 'on/off',
                       'name': 'x-igd-opregion',
                       'type': 'bool'},
+                  {'name': 'legacy-addr', 'type': 'str'},
                   {'name': 'x-pci-vendor-id', 'type': 'uint32'},
+                  {'name': 'type', 'type': 'string'},
                   {'name': 'x-pci-sub-device-id', 'type': 'uint32'},
                   {'name': 'rombar', 'type': 'uint32'},
                   {   'description': 'on/off',
@@ -19,10 +21,13 @@
                                      'host device, example: 04:10.0',
                       'name': 'host',
                       'type': 'str'},
+                  {'name': 'realized', 'type': 'bool'},
                   {'name': 'x-no-kvm-msix', 'type': 'bool'},
                   {   'description': 'on/off',
                       'name': 'command_serr_enable',
                       'type': 'bool'},
+                  {'name': 'parent_bus', 'type': 'link<bus>'},
+                  {'name': 'hotplugged', 'type': 'bool'},
                   {'name': 'x-pci-sub-vendor-id', 'type': 'uint32'},
                   {'name': 'x-pci-device-id', 'type': 'uint32'},
                   {   'description': 'on/off',
@@ -45,6 +50,7 @@
                       'type': 'bool'},
                   {'name': 'x-no-mmap', 'type': 'bool'},
                   {'name': 'bootindex', 'type': 'int32'},
+                  {'name': 'hotpluggable', 'type': 'bool'},
                   {'name': 'sysfsdev', 'type': 'str'},
                   {'description': 'on/off', 'name': 'x-vga', 'type': 'bool'},
                   {'name': 'romfile', 'type': 'str'}]}


The difference is "uninteresting" props and one suspicious "legacy-addr"
(which I have no idea what is that but it is offtopic here).



> 
>>> We need to instantiate because QOM properties are dynamic: they aren't
>>> specified by data (which qom-list-properties could simply read), they
>>> are created by (instantiation) code (which qom-list-properties has to
>>> run).
>>
>> Correct.
>>
>>> Properties created only after instantiation (by realize, perhaps) aren't
>>> visible in qom-list-properties.  Do such properties exist?
>>
>> No idea but if they do, then this issue already exists in
>> device-list-properties.
>>
>>> Properties created only in non-default configuration aren't visible
>>> either.  Such properties have to exist, or else dynamic property
>>> creation would be idiotic.
> 
> Thus, qom-list-properties design limitation: the result need not reflect
> properties of instantiated objects.  It usually does, as most QOM
> properties behave as if they were static.  But when it doesn't, what
> then?  How are users of qom-list-properties supposed to deal with such
> inaccurate / incorrect information?  Do they just have to know which
> properties aren't visible in qom-list-properties, and which properties
> are, but cannot be trusted?
> 
> I posit that right now *nobody* knows.
> 
> Would such a command be useful anyway?


qom-list-properties? yes, we want it to let libvirt a way to know if a
machine supports certain properties, if a machine was derived from a
device, then we would not need it.


> 
>>> Likewise for properties created differently (say with a different type)
>>> in non-default configuration.  We can hope that no such beasts exist.
>>> Since properties get created by code, and code can do anything, we're
>>> reduced to hope.  Data is so much easier to reason about than code.
>>>
>>> Three building blocks: instantiate, qom-list, destroy.  Do we want the
>>> building blocks, or do we want their combination qom-list-properties?
>>
>>
>> Building blocks as QEMU internal helpers to split my
>> qmp_qom_list_properties() into? These are not going to be huge and
>> "destroy" is literally object_unref(obj) which does not seem very useful.
>> Or I missed the point here?
> 
> My question is whether the QMP interface should provide the building
> blocks, or only compositions.


instantiate but not realize? Not sure we have users for that.


> 
>>>> ---
>>>>
>>>> I am missing the point of make_device_property_info().
>>>> qmp_device_list_properties() creates the instance which copies everything
>>>> to QOM properties hashtable and commenting out the do{}while() in
>>>> make_device_property_info() does not seem to change a thing, what case
>>>> am I missing here?
>>>
>>> git-blame points to Stefan.  Stefan, can you help?


-- 
Alexey
