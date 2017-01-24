Received: from eggs.gnu.org ([2001:4830:134:3::10]:44138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cW4zZ-0007vZ-JT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cW4zV-00063w-Ll
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:34:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cW4zV-00063j-Fd
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:34:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170124105332.15992-1-lma@suse.com>
	<750161d4-df3c-e079-758d-3d16417363dc@redhat.com>
Date: Tue, 24 Jan 2017 18:34:42 +0100
In-Reply-To: <750161d4-df3c-e079-758d-3d16417363dc@redhat.com> (Eric Blake's
	message of "Tue, 24 Jan 2017 10:57:52 -0600")
Message-ID: <87bmuw1hvx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qmp: set accurate parameter name for error
 msg of device-list-properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 01/24/2017 04:53 AM, Lin Ma wrote:
>> Signed-off-by: Lin Ma <lma@suse.com>
>> ---
>
> The commit message is rather sparse; is there an easy formula for
> triggering the error message, to give more context about the change?

Try this:
-> { "execute": "device-list-properties", "arguments": { "typename": "accel" } }
<- {"error": {"class": "GenericError", "desc": "Parameter 'name' expects device"}}

Type "accel" exists, but it's not a subtype of TYPE_DEVICE.

Perhaps:

    qmp: Fix argument name in error message of device-list-properties

    The argument is called "typename", not "name".

>>  qmp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/qmp.c b/qmp.c
>> index 0028f0b..812db6c 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -531,7 +531,7 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
>>  
>>      klass = object_class_dynamic_cast(klass, TYPE_DEVICE);
>>      if (klass == NULL) {
>> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "name", TYPE_DEVICE);
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TYPE_DEVICE);
>>          return NULL;
>>      }

Incomplete, the next one needs the same change:

        if (object_class_is_abstract(klass)) {
            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "name",
                       "non-abstract device type");
            return NULL;
        }

Reproducer:
-> { "execute": "device-list-properties", "arguments": { "typename": "pci-qxl" } }
<- {"error": {"class": "GenericError", "desc": "Parameter 'name' expects non-abstract device type"}}

Please fix this one, too.
