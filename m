Received: from eggs.gnu.org ([208.118.235.92]:38796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ehQmK-0006ey-CV
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 21:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ehQgP-00060J-DZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 21:03:35 -0500
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:35933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ehQgO-0005y6-T6
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 21:02:29 -0500
Received: by mail-pf0-x22c.google.com with SMTP id k5so467447pff.3
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 18:02:28 -0800 (PST)
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<871si6vt8n.fsf@dusky.pond.sub.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <e3aca639-0c5c-8d10-a9f4-05a62284fb10@ozlabs.ru>
Date: Fri, 2 Feb 2018 13:02:21 +1100
MIME-Version: 1.0
In-Reply-To: <871si6vt8n.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Stefan Hajnoczi <stefanha@redhat.com>

On 01/02/18 04:22, Markus Armbruster wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> There is already 'device-list-properties' which does most of the job,
>> however it does not handle everything returned by qom-list-types such
>> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
>>
>> This adds a new qom-list-properties command which prints properties
>> of a specific class and its instance. It is pretty much a simplified copy
>> of the device-list-properties handler.
>>
>> Since it creates an object instance, device properties should appear
>> in the output as they are copied to QOM properties at the instance_init
>> hook.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Related: qom-list, which lists "any properties of a object given a path
> in the object model."  qom-list-properties takes a type name, which
> qom-list takes the path to an instance.  In other words,
> qom-list-properties is like instantiate with default configuration and
> without realizing + qom-list + destroy.


True. Same as device-list-properties.


> We need to instantiate because QOM properties are dynamic: they aren't
> specified by data (which qom-list-properties could simply read), they
> are created by (instantiation) code (which qom-list-properties has to
> run).

Correct.

> Properties created only after instantiation (by realize, perhaps) aren't
> visible in qom-list-properties.  Do such properties exist?

No idea but if they do, then this issue already exists in
device-list-properties.

> Properties created only in non-default configuration aren't visible
> either.  Such properties have to exist, or else dynamic property
> creation would be idiotic.
> 
> Likewise for properties created differently (say with a different type)
> in non-default configuration.  We can hope that no such beasts exist.
> Since properties get created by code, and code can do anything, we're
> reduced to hope.  Data is so much easier to reason about than code.
> 
> Three building blocks: instantiate, qom-list, destroy.  Do we want the
> building blocks, or do we want their combination qom-list-properties?


Building blocks as QEMU internal helpers to split my
qmp_qom_list_properties() into? These are not going to be huge and
"destroy" is literally object_unref(obj) which does not seem very useful.
Or I missed the point here?



>> ---
>>
>> I am missing the point of make_device_property_info().
>> qmp_device_list_properties() creates the instance which copies everything
>> to QOM properties hashtable and commenting out the do{}while() in
>> make_device_property_info() does not seem to change a thing, what case
>> am I missing here?
> 
> git-blame points to Stefan.  Stefan, can you help?
> 
>> ---
>>  qapi-schema.json | 29 +++++++++++++++++++++++++++++
>>  qmp.c            | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 81 insertions(+)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 5c06745..9d73501 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -1455,6 +1455,35 @@
>>    'returns': [ 'DevicePropertyInfo' ] }
>>  
>>  ##
>> +# @QOMPropertyInfo:
>> +#
>> +# Information about object properties.
>> +#
>> +# @name: the name of the property
>> +# @type: the typename of the property
>> +# @description: if specified, the description of the property.
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'QOMPropertyInfo',
>> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
>> +
>> +##
>> +# @qom-list-properties:
>> +#
>> +# List properties associated with a QOM object.
>> +#
>> +# @typename: the type name of an object
>> +#
>> +# Returns: a list of QOMPropertyInfo describing object properties
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'command': 'qom-list-properties',
>> +  'data': { 'typename': 'str'},
>> +  'returns': [ 'QOMPropertyInfo' ] }
>> +
>> +##
>>  # @xen-set-global-dirty-log:
>>  #
>>  # Enable or disable the global dirty log mode.
>> diff --git a/qmp.c b/qmp.c
>> index 52cfd2d..20cb662 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -574,6 +574,58 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
>>      return prop_list;
>>  }
>>  
>> +QOMPropertyInfoList *qmp_qom_list_properties(const char *typename,
>> +                                             Error **errp)
>> +{
>> +    ObjectClass *klass;
>> +    Object *obj;
>> +    ObjectProperty *prop;
>> +    ObjectPropertyIterator iter;
>> +    QOMPropertyInfoList *prop_list = NULL;
>> +
>> +    klass = object_class_by_name(typename);
>> +    if (klass == NULL) {
>> +        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
>> +                  "Class '%s' not found", typename);
>> +        return NULL;
>> +    }
>> +
>> +    klass = object_class_dynamic_cast(klass, TYPE_OBJECT);
>> +    if (klass == NULL) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TYPE_OBJECT);
>> +        return NULL;
>> +    }
>> +
>> +    if (object_class_is_abstract(klass)) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
>> +                   "non-abstract class");
>> +        return NULL;
>> +    }
>> +
>> +    obj = object_new(typename);
>> +
>> +    object_property_iter_init(&iter, obj);
>> +    while ((prop = object_property_iter_next(&iter))) {
>> +        QOMPropertyInfo *info;
>> +        QOMPropertyInfoList *entry;
>> +
>> +        info = g_malloc0(sizeof(*info));
>> +        info->name = g_strdup(prop->name);
>> +        info->type = g_strdup(prop->type);
>> +        info->has_description = !!prop->description;
>> +        info->description = g_strdup(prop->description);
>> +
>> +        entry = g_malloc0(sizeof(*entry));
>> +        entry->value = info;
>> +        entry->next = prop_list;
>> +        prop_list = entry;
>> +    }
>> +
>> +    object_unref(obj);
>> +
>> +    return prop_list;
>> +}
>> +
>>  CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>>  {
>>      return arch_query_cpu_definitions(errp);


-- 
Alexey
