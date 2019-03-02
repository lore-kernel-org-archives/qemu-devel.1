Received: from eggs.gnu.org ([209.51.188.92]:43615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1h02yX-0008U5-L5
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 06:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1h02yW-0002I5-U2
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 06:38:41 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1h02yW-0002GI-MO
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 06:38:40 -0500
Received: by mail-ed1-x542.google.com with SMTP id 10so499005eds.7
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 03:38:40 -0800 (PST)
Date: Sat, 2 Mar 2019 11:38:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190302113838.sdtxfh6yvl4anlqx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190301074448.8926-1-richardw.yang@linux.intel.com>
	<20190301103346.00389986@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301103346.00389986@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qom: remove type_initialize() in
 object_new_with_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, afaerber@suse.de

On Fri, Mar 01, 2019 at 10:33:46AM +0100, Igor Mammedov wrote:
>On Fri,  1 Mar 2019 15:44:48 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> Here is the abstraction of current call flow of object_new_with_type()
>> 
>>     object_initialize_with_type
>>         type_initialize
>> 	object_initialize_with_type
>> 	    type_initialize
>> 
>> This is not necessary to spread type_initialize in two places.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  qom/object.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/qom/object.c b/qom/object.c
>> index b8c732063b..6252cca418 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -585,7 +585,6 @@ static Object *object_new_with_type(Type type)
>>      Object *obj;
>>  
>>      g_assert(type != NULL);
>> -    type_initialize(type);
>>  
>>      obj = g_malloc(type->instance_size);
>>      object_initialize_with_type(obj, type->instance_size, type);
>Are you sure it's correct?
>
>see how type->instance_size
>

You are right, I thought the instance_size is initialized in type_new().
But this would be adjusted in type_initialize() again. 

>PS:
>there is also unit-tests which might detect issues in patches before
>one sends them. To execute them run: make  check
>

With this patch applied, I managed to run a guest successfully. Looks
this didn't catch some corner case. 

-- 
Wei Yang
Help you, Help me
