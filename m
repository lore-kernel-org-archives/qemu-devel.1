Received: from eggs.gnu.org ([2001:4830:134:3::10]:32808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eqDLH-00056S-VC
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eqDLE-0001pf-LS
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:36:59 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:44512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eqDLE-0001n8-Ew
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:36:56 -0500
Received: by mail-io0-x242.google.com with SMTP id h23so5592933iob.11
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 23:36:54 -0800 (PST)
References: <20180222050020.1717-1-aik@ozlabs.ru>
	<7b9c3aa3-6160-2691-4c88-7ee612f82539@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <643c9cee-ac7e-c6d6-3fb9-c3d9462d46a6@ozlabs.ru>
Date: Mon, 26 Feb 2018 18:36:47 +1100
MIME-Version: 1.0
In-Reply-To: <7b9c3aa3-6160-2691-4c88-7ee612f82539@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu repost] qmp: Add qom-list-properties
 to list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>

On 23/02/18 22:33, Paolo Bonzini wrote:
> On 22/02/2018 06:00, Alexey Kardashevskiy wrote:
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
>> ---
>>
>> This is a simple rebase on top of the current upstream.
>>
>>
>> ---
>>  qapi-schema.json | 29 +++++++++++++++++++++++++++++
>>  qmp.c            | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 81 insertions(+)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 0262b9f..fa5f189 100644
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
>> index 793f6f3..f2d4781 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -576,6 +576,58 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
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
> 
> This sucks, it would be nice to enumerate properties on base classes. We
> could list class properties only.  However, it can be improved later.
> 
> Queued, thanks.


Wait, adding abstract classes support seems very easy, I'll post v2 in a
few minutes.


-- 
Alexey
