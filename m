Received: from eggs.gnu.org ([2001:4830:134:3::10]:60640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRhSJ-0005BL-0j
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRhSE-0001ZT-2W
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:38:23 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161212173151.18092-1-marcandre.lureau@redhat.com>
	<20161212173151.18092-3-marcandre.lureau@redhat.com>
	<1f3b7ccb-19fd-c3df-0a67-fc554c55e05a@msgid.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c67425f0-5bc0-f07c-6936-522fcef3b445@redhat.com>
Date: Thu, 12 Jan 2017 16:38:06 +0100
MIME-Version: 1.0
In-Reply-To: <1f3b7ccb-19fd-c3df-0a67-fc554c55e05a@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] object: make some funcs static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>



On 12/01/2017 11:48, Michael Tokarev wrote:
> 12.12.2016 20:31, Marc-André Lureau wrote:
>> There is no need to have those functions as public API.
> 
> Were "some" being object_initialize_with_type() and
> object_new_with_type().
> 
> I'm applying this to -trivial, and Cc'ing Andreas, maybe
> he will say more.

The idea here was to allow caching the type and speed up things.  But I
guess that QOM objects are very heavyweight, and thus we won't have for
example SCSIRequest as a QOM object.

Paolo

> Thanks,
> 
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qom/object.c         |  4 ++--
>>  include/qom/object.h | 24 ------------------------
>>  2 files changed, 2 insertions(+), 26 deletions(-)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 7a05e35ed9..eb3d0f64e4 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -351,7 +351,7 @@ static void object_post_init_with_type(Object *obj, TypeImpl *ti)
>>      }
>>  }
>>  
>> -void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
>> +static void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
>>  {
>>      Object *obj = data;
>>  
>> @@ -467,7 +467,7 @@ static void object_finalize(void *data)
>>      }
>>  }
>>  
>> -Object *object_new_with_type(Type type)
>> +static Object *object_new_with_type(Type type)
>>  {
>>      Object *obj;
>>  
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index c5456db05d..e9791a210e 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -586,18 +586,6 @@ struct InterfaceClass
>>   */
>>  Object *object_new(const char *typename);
>>  
>> -/**
>> - * object_new_with_type:
>> - * @type: The type of the object to instantiate.
>> - *
>> - * This function will initialize a new object using heap allocated memory.
>> - * The returned object has a reference count of 1, and will be freed when
>> - * the last reference is dropped.
>> - *
>> - * Returns: The newly allocated and instantiated object.
>> - */
>> -Object *object_new_with_type(Type type);
>> -
>>  /**
>>   * object_new_with_props:
>>   * @typename:  The name of the type of the object to instantiate.
>> @@ -726,18 +714,6 @@ int object_set_propv(Object *obj,
>>                       Error **errp,
>>                       va_list vargs);
>>  
>> -/**
>> - * object_initialize_with_type:
>> - * @data: A pointer to the memory to be used for the object.
>> - * @size: The maximum size available at @data for the object.
>> - * @type: The type of the object to instantiate.
>> - *
>> - * This function will initialize an object.  The memory for the object should
>> - * have already been allocated.  The returned object has a reference count of 1,
>> - * and will be finalized when the last reference is dropped.
>> - */
>> -void object_initialize_with_type(void *data, size_t size, Type type);
>> -
>>  /**
>>   * object_initialize:
>>   * @obj: A pointer to the memory to be used for the object.
>>
> 
> 
> 
