Received: from eggs.gnu.org ([2001:4830:134:3::10]:55978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqRRH-0006bs-Ve
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqRRD-0002av-U1
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:40:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqRRD-0002aO-Ox
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:40:03 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-23-armbru@redhat.com>
	<cfdefa70-ce8c-5afd-0ddf-5fad17062171@redhat.com>
	<87fu5rk3hv.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b3e49ce-3e7c-7c9a-de64-c59999085ebe@redhat.com>
Date: Mon, 26 Feb 2018 16:39:44 -0600
MIME-Version: 1.0
In-Reply-To: <87fu5rk3hv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/29] qapi: Generate separate .h,
 .c for each module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 02/23/2018 11:41 AM, Markus Armbruster wrote:


>>> +++ b/Makefile
>>> @@ -92,10 +92,70 @@ include $(SRC_PATH)/rules.mak
>>>    GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
>>>    GENERATED_FILES += qapi-builtin-types.h qapi-builtin-types.c
>>>    GENERATED_FILES += qapi-types.h qapi-types.c
>>> +GENERATED_FILES += qapi/qapi-types-block-core.h qapi/qapi-types-block-core.c
>>
>> For the makefile, I'd suggest using an intermediate list of module
>> names, and then using make string operations to expand it into larger
>> lists, to cut down on the repetition.  Something like (untested):
>>
>> QAPI_MODULES = block-core block char common ...
>> GENERATED_FILES += $(addprefix qapi/qapi-types-,$(addsuffix
>> .c,$(QAPI_MODULES))
>> GENERATED_FILES += $(addprefix qapi/qapi-types-,$(addsuffix
>> .h,$(QAPI_MODULES))
> 
> I did it the stupid way to save time.  Improvements welcome :)


>>> +++ b/Makefile.objs
>>> @@ -3,8 +3,56 @@
>>>    stub-obj-y = stubs/ crypto/
>>>    util-obj-y = util/ qobject/ qapi/
>>>    util-obj-y += qapi-builtin-types.o
>>> +util-obj-y += qapi-types.o
>>> +util-obj-y += qapi/qapi-types-block-core.o
>>
>> Perhaps this can also exploit make text manipulation?
>>
>> Otherwise looks good.
> 
> Thanks!

At this point, I'll take your patch as-is, and worry about improvements 
as followups.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
