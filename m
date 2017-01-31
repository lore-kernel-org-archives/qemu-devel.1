Received: from eggs.gnu.org ([2001:4830:134:3::10]:58082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cYaBd-0000hF-D6
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cYaBa-0001Tp-72
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:17:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43006
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cYaBa-0001Te-1C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:17:34 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0VFDsEr076312
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 10:17:33 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28aubscxqd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 10:17:32 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 31 Jan 2017 15:17:27 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
	<20161108095603.72301-8-pasic@linux.vnet.ibm.com>
	<20161215123259.GH2509@work-vm>
Date: Tue, 31 Jan 2017 16:17:23 +0100
MIME-Version: 1.0
In-Reply-To: <20161215123259.GH2509@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <d0e0673d-a838-f4ab-58a9-ec57265d8d3a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/8] migration/vmstate: fix array of
 pointers to struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>



On 12/15/2016 01:33 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> Make VMS_ARRAY_OF_POINTER cope with null pointers. Previously the reward
>> for trying to migrate an array with some null pointers in it was an
>> illegal memory access, that is a swift and painless death of the process.
>> Let's make vmstate cope with this scenario at least for pointers to
>> structs. The general approach is when we encounter a null pointer
>> (element) instead of following the pointer to save/load the data behind
>> it we save/load a placeholder. This way we can detect if we expected a
>> null pointer at the load side but not null data was saved instead. Sadly
>> all other error scenarios are not detected by this scheme (and would
>> require the usage of the JSON meta data).
>>
>> Limitations: Does not work for pointers to primitives.
> 
> Please document that limitation in a comment in the vmstate.h near the
> macros that use it.
> 

After looking at this again I do not know what was my intention whit the
limitations statement. It was probably about arrays of pointers to
primitives, but then the statement is wrong. The same scheme does work
for primitives too. It just that I had a previous version which had this
limitation. 

It could also be about just pointer (not array of pointers), but the
commit message does not mention this case at all. 

I will just drop the limitations statement.

>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com> Reviewed-by:
>> Guenther Hutzl <hutzl@linux.vnet.ibm.com> ---
>>
>> We will need this to load/save some on demand created state from within
>> the channel subsystem (see ChannelSubSys.css in hw/s390x/css.c for an
>> example).
>> ---
>>  include/migration/vmstate.h |  5 +++++
>>  migration/vmstate.c         | 32 ++++++++++++++++++++++++++++++--
>>  2 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 5940db0..86d4aca 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -236,6 +236,10 @@ extern const VMStateInfo vmstate_info_uint16;
>>  extern const VMStateInfo vmstate_info_uint32;
>>  extern const VMStateInfo vmstate_info_uint64;
>>  
>> +/** Put this in the stream when migrating a null pointer.*/
>> +#define VMS_NULLPTR_MARKER ((int8_t) -1)
> 
> You seem to be making things harder by using a signed int everywhere
> when you just want a byte;  I suggest using '0'
> 

I'm fine with byte 0x30, but I have an irrational bad feeling about
using a character literal here. I know, in practice should
not matter, but the C11 standard says nothing about how members of the
basic execution character set are represented, and it's also not among
the 'usual QEMU platform assumptions' (AFAIK). Are you OK defining
the constant/macro as Ox30U instead of '0'? 

>> +extern const VMStateInfo vmstate_info_nullptr;
>> +
>>  extern const VMStateInfo vmstate_info_float64;
>>  extern const VMStateInfo vmstate_info_cpudouble;
>>  
>> @@ -453,6 +457,7 @@ extern const VMStateInfo vmstate_info_bitmap;
>>      .size       = sizeof(_type *),                                    \
>>      .flags      = VMS_ARRAY|VMS_STRUCT|VMS_ARRAY_OF_POINTER,         \
>>      .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
>> +    .info       = &vmstate_info_nullptr,                              \
> 
> What's this change for?

It's garbage. A remainder of a previous version I mentioned above. Will
remove. Good catch!

> 
>>  }
>>  
>>  #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 10a7645..ce3490a 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -109,7 +109,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>>                      curr_elem = *(void **)curr_elem;
>>                  }
>> -                if (field->flags & VMS_STRUCT) {
>> +                if (!curr_elem) {
>> +                    /* if null pointer check placeholder and do not follow */
>> +                    assert(field->flags & VMS_ARRAY_OF_POINTER);
>> +                    vmstate_info_nullptr.get(f, curr_elem, size);
>> +                } else if (field->flags & VMS_STRUCT) {
>>                      ret = vmstate_load_state(f, field->vmsd, curr_elem,
>>                                               field->vmsd->version_id);
>>                  } else {
>> @@ -320,7 +324,11 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>>                      assert(curr_elem);
>>                      curr_elem = *(void **)curr_elem;
>>                  }
>> -                if (field->flags & VMS_STRUCT) {
>> +                if (!curr_elem) {
>> +                    /* if null pointer write placeholder and do not follow */
>> +                    assert(field->flags & VMS_ARRAY_OF_POINTER);
>> +                    vmstate_info_nullptr.put(f, curr_elem, size);
>> +                } else if (field->flags & VMS_STRUCT) {
>>                      vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
>>                  } else {
>>                      field->info->put(f, curr_elem, size);
>> @@ -708,6 +716,26 @@ const VMStateInfo vmstate_info_uint64 = {
>>      .put  = put_uint64,
>>  };
>>  
>> +static int get_nullptr(QEMUFile *f, void *pv, size_t size)
>> +{
>> +    int8_t tmp;
>> +    qemu_get_s8s(f, &tmp);
> 
> Now that I've suggested using just a character you can turn that
> into:
> 
>   return qemu_get_byte(f) == VMS_NULLPTR_MARKER ? 0 : -EINVAL;
> 

You are right! I was over-complicating. Will do.

>> +    return tmp == VMS_NULLPTR_MARKER ? 0 : -EINVAL;
>> +}
>> +
>> +static void put_nullptr(QEMUFile *f, void *pv, size_t size)
>> +{
>> +    int8_t tmp = VMS_NULLPTR_MARKER;
>> +    assert(pv == NULL);
>> +    qemu_put_s8s(f, &tmp);
> 
> and similarly put_byte.
> 

Will do.

> Dave
> 

Thanks for the review. I have already adopted mostly your proposals,
but I will wait a bit in the hope that the fate of this patch borrowed
form my other patch set (subject:"[PATCH v2 2/2] migration: drop unused
VMStateField.start" gets resolved.

By the way you could answer my question regarding that yourself, since
you became co-maintainer for migration starting 2017-01-24. Congrats :).


Regards,
Halil

>> +}
>> +
>> +const VMStateInfo vmstate_info_nullptr = {
>> +    .name = "uint64",
>> +    .get  = get_nullptr,
>> +    .put  = put_nullptr,
>> +};
>> +
>>  /* 64 bit unsigned int. See that the received value is the same than the one
>>     in the field */
>>  
>> -- 
>> 2.8.4
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
