Received: from eggs.gnu.org ([2001:4830:134:3::10]:34259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cYuYw-0005zN-Vx
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cYuYr-0000s8-Uv
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:03:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52753
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cYuYr-0000s2-OJ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:02:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v11Cxcdc112273
	for <qemu-devel@nongnu.org>; Wed, 1 Feb 2017 08:02:56 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28b8wv7myb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 08:02:56 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 1 Feb 2017 13:02:54 -0000
References: <20161020132556.67321-1-pasic@linux.vnet.ibm.com>
	<20161020132556.67321-3-pasic@linux.vnet.ibm.com>
	<b1f6f338-601f-8525-1f1b-cffdbe203453@linux.vnet.ibm.com>
	<20170131200016.GP2395@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 1 Feb 2017 14:02:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170131200016.GP2395@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <6b789ed6-7043-8f6f-5dd7-a6a213f9f1cc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] migration: drop unused
 VMStateField.start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Guenther Hutzl <hutzl@linux.vnet.ibm.com>



On 01/31/2017 09:00 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>
>>
>> On 10/20/2016 03:25 PM, Halil Pasic wrote:
>>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>>> index fc29acf..8767e40 100644
>>> --- a/migration/vmstate.c
>>> +++ b/migration/vmstate.c
>>> @@ -66,10 +66,10 @@ static void *vmstate_base_addr(void *opaque, VMStateField *field, bool alloc)
>>>                  }
>>>              }
>>>              if (size) {
>>> -                *((void **)base_addr + field->start) = g_malloc(size);
>>> +                *(void **)base_addr = g_malloc(size);
>>>              }
>>>          }
>>> -        base_addr = *(void **)base_addr + field->start;
>>> +        base_addr = *(void **)base_addr;
>>>      }
>>>
>>>      return base_addr;
>> Hi!
>>
>> It is been a while, and IMHO this is still broken, and the
>> VMSTATE_VBUFFER* macros are still only used with the start argument
>> being zero.
>>
>> What changed is that with commit 94869d5c ("migration: migrate QTAILQ")
>> from Jan 19 we have code actually using VMStateDecription.start -- but
>> for something different (IMHO), as allocation is done by get_qtailq and
>> not by vmstate_base_addr (as in case of VMSTATE_VBUFFER_ALLOC_UINT32).
>> Thus I would need to update the commit message and keep the start field
>> at least.
>>
>> But before I do so, I would like to ask the maintainers if there is
>> interest in a change like this?
> 
> I think it's certainly worth fixing VMSTATE_BUFFER_ALLOC*; if it can't
> use the start field properly then it should have the start parameter
> removed.

Thanks for the reply! Let us try to figure out what to do together...
> 
> I'll admit I can't remember the details of why field->start as an offset
> didn't work; are the other macros that take a start value correct?

I'm going to explain my view on field->start, but first let us have a look
which macros are using it: 

$ pcregrep -Mi '#define VMSTATE_[^{]*{[^}]*\.start[^}]*}' include/migration/vmstate.h
#define VMSTATE_VBUFFER_MULTIPLY(_field, _state, _version, _test, _start, _field_size, _multiply) { \
    .name         = (stringify(_field)),                             \
    .version_id   = (_version),                                      \
    .field_exists = (_test),                                         \
    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
    .size         = (_multiply),                                      \
    .info         = &vmstate_info_buffer,                            \
    .flags        = VMS_VBUFFER|VMS_POINTER|VMS_MULTIPLY,            \
    .offset       = offsetof(_state, _field),                        \
    .start        = (_start),                                        \
}
#define VMSTATE_VBUFFER(_field, _state, _version, _test, _start, _field_size) { \
    .name         = (stringify(_field)),                             \
    .version_id   = (_version),                                      \
    .field_exists = (_test),                                         \
    .size_offset  = vmstate_offset_value(_state, _field_size, int32_t),\
    .info         = &vmstate_info_buffer,                            \
    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
    .offset       = offsetof(_state, _field),                        \
    .start        = (_start),                                        \
}
#define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test, _start, _field_size) { \
    .name         = (stringify(_field)),                             \
    .version_id   = (_version),                                      \
    .field_exists = (_test),                                         \
    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
    .info         = &vmstate_info_buffer,                            \
    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
    .offset       = offsetof(_state, _field),                        \
    .start        = (_start),                                        \
}
#define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version, _test, _start, _field_size) { \
    .name         = (stringify(_field)),                             \
    .version_id   = (_version),                                      \
    .field_exists = (_test),                                         \
    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
    .info         = &vmstate_info_buffer,                            \
    .flags        = VMS_VBUFFER|VMS_POINTER|VMS_ALLOC,               \
    .offset       = offsetof(_state, _field),                        \
    .start        = (_start),                                        \
}
#define VMSTATE_QTAILQ_V(_field, _state, _version, _vmsd, _type, _next)  \
{                                                                        \
    .name         = (stringify(_field)),                                 \
    .version_id   = (_version),                                          \
    .vmsd         = &(_vmsd),                                            \
    .size         = sizeof(_type),                                       \
    .info         = &vmstate_info_qtailq,                                \
    .offset       = offsetof(_state, _field),                            \
    .start        = offsetof(_type, _next),                              \
}

We both agree that VMSTATE_VBUFFER_ALLOC_UINT32 is wrong with start != 0,
and that VMSTATE_QTAILQ_V needs the data member. But I think
VMSTATE_QTAILQ_V is not using the start handling from vmstate_base_addr,
(because it has no VMS_POINTER flag set).

I think the not allocating versions of VMSTATE_VBUFFER are also fine as
is, but if someone had the bright idea to make an allocating version,
it's very straightforward to create something broken.

So my original train of thought was, because nobody uses VMSTATE_VBUFFER
with start != 0 let us get rid of the extra complexity, and eventually
reintroduce it when it's needed. This feature is around for quite some
time now, but nobody uses it, and I do not think it is very likely we
will need it in the future.


> If we can't remove the start variable then it's probably not removing
> the start parameter everywhere.

Yes we can. We just can't remove the start data member form VMStateField
because the QTAILQ stuff is now using it.
> 
> That alloc case looks the most unusual in that vmstate_base_addr()
> function; I *think* the non-alloc case makes sense
> (i.e. follow a pointer and then use an offset from that pointer?)
> even if no one currently uses it.

I also think it makes sense, but as written above, it is never used.

I see 3 options regarding how to proceed:

1) Remove the start parameter from the VMSTATE_VBUFFER* macros, and
the start handling from vmstate_base_addr (basically the same I
did here, with the difference that VMStateField.start remains).
2) Proclaim that .start && (.flags & VMSTATE_ALLOC) == false is an
invariant of QEMU, and assert when we would allocate. Remove the parameter
form VMSTATRE_VBUFFER_ALLOC.
3) Make .start work properly for dynamically allocated buffers.

I prefer option 1). What is your preference?

Halil

> 
> Dave
> 
>> Regards,
>> Halil
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
