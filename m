Received: from eggs.gnu.org ([2001:4830:134:3::10]:56996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDCfP-0000rN-Ki
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDCfI-0002gg-Bl
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:05:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDCfH-0002d2-BI
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:04:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so1220140wmc.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 11:04:54 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-3-berrange@redhat.com>
	<7c4d7900-d995-83ef-02c2-5a762165e26c@redhat.com>
Message-ID: <f4961286-41ca-3c9e-cce5-e9b06e3de463@redhat.com>
Date: Thu, 18 Oct 2018 20:04:51 +0200
MIME-Version: 1.0
In-Reply-To: <7c4d7900-d995-83ef-02c2-5a762165e26c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 02/11] qom: don't require user creatable
 objects to be registered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 10/10/2018 17:11, Philippe Mathieu-Daudé wrote:
> On 09/10/2018 15:04, Daniel P. Berrangé wrote:
>> When an object is in turn owned by another user object, it is not
>> desirable to expose this in the QOM object hierarchy, as it is
>> just an internal implementation detail, we should be free to change
>> without exposure.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>> ---
>>  qom/object.c            | 12 ++++++++----
>>  qom/object_interfaces.c | 16 ++++++++++------
>>  2 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 547dcf97c3..f20f0c45a7 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -607,15 +607,19 @@ Object *object_new_with_propv(const char *typename,
>>          goto error;
>>      }
>>  
>> -    object_property_add_child(parent, id, obj, &local_err);
>> -    if (local_err) {
>> -        goto error;
>> +    if (id != NULL) {
>> +        object_property_add_child(parent, id, obj, &local_err);
>> +        if (local_err) {
>> +            goto error;
>> +        }
>>      }
>>  
>>      if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
>>          user_creatable_complete(obj, &local_err);
>>          if (local_err) {
>> -            object_unparent(obj);
>> +            if (id != NULL) {
>> +                object_unparent(obj);
>> +            }
>>              goto error;
>>          }
>>      }
>> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>> index 941fd63afd..94d5f91d69 100644
>> --- a/qom/object_interfaces.c
>> +++ b/qom/object_interfaces.c
>> @@ -83,16 +83,20 @@ Object *user_creatable_add_type(const char *type, const char *id,
>>          goto out;
>>      }
>>  
>> -    object_property_add_child(object_get_objects_root(),
>> -                              id, obj, &local_err);
>> -    if (local_err) {
>> -        goto out;
>> +    if (id != NULL) {
>> +        object_property_add_child(object_get_objects_root(),
>> +                                  id, obj, &local_err);
>> +        if (local_err) {
>> +            goto out;
>> +        }
>>      }
>>  
>>      user_creatable_complete(obj, &local_err);
>>      if (local_err) {
>> -        object_property_del(object_get_objects_root(),
>> -                            id, &error_abort);
>> +        if (id != NULL) {
>> +            object_property_del(object_get_objects_root(),
>> +                                id, &error_abort);
>> +        }
>>          goto out;
>>      }
>>  out:
>>
