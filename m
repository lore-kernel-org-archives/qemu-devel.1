Received: from eggs.gnu.org ([2001:4830:134:3::10]:57186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cgYyD-00088X-S2
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cgYyA-0003D7-Ol
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:36:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cgYyA-0003Ci-Eq
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:36:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MFTNji022787
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 10:36:40 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sb1nqt0v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 10:36:40 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 15:36:38 -0000
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
	<20170216121140.9061-3-pasic@linux.vnet.ibm.com>
	<20170221120700.GE2377@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 16:36:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170221120700.GE2377@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <9f54118d-61a0-b30d-cc33-b77bf27b36ee@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] migration/vmstate: split up
 vmstate_base_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>



On 02/21/2017 01:07 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> Currently vmstate_base_addr does several things: it pinpoints the field
>> within the struct, possibly allocates memory and possibly does the first
>> pointer dereference. Obviously allocation is needed only for load.
>>
>> Let us split up the functionality in vmstate_base_addr and move the
>> address manipulations (that is everything but the allocation logic) to
>> load and save so it becomes more obvious what is actually going on. Like
>> this all the address calculations (and the handling of the flags
>> controlling these) is in one place and the sequence is more obvious.
>>
>> The newly introduced function vmstate_handle_alloc also fixes the
>> allocation for the unused VMS_VBUFFER| VMS_MULTIPLY scenario and is

s/VMS_VBUFFER| VMS_MULTIPLY/VMS_VBUFFER|VMS_MULTIPLY|VMS_ALLOC/

>> substantially simpler than the original vmstate_base_addr.
> 
> Note that VMSTATE_VBUFFER_MULTIPLY does use VMS_VBUFFER|VMS_MULTIPLY - but
> not with alloc (and I started using VMSTATE_VBUFFER_MULTIPLY in a recent
> patch that went in).  

Adding |VMS_ALLOC to avoid confusion. I was hoping it's clear
form the context that we are talking about scenarios where
allocation is relevant.

> I'm not sure I see what the error is that you fixed.

I'm referring to number of bytes allocated. It was
vmstate_n_elems(opaque, field) * field->size
and became
vmstate_n_elems(opaque, field) * vmstate_size(opaque, field)

vmstate_size does extra handling for VMS_VBUFFER and
VMS_MULTIPLY.


> 
> However, I'm ok with it:
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 

Cheers,
Halil

>> In load and save some asserts are added so it's easier to debug
>> situations where we would end up with a null pointer dereference.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  migration/vmstate.c | 39 +++++++++++++++++----------------------
>>  1 file changed, 17 insertions(+), 22 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 36efa80..836a7a4 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -52,29 +52,15 @@ static int vmstate_size(void *opaque, VMStateField *field)
>>      return size;
>>  }
>>  
>> -static void *vmstate_base_addr(void *opaque, VMStateField *field, bool alloc)
>> +static void vmstate_handle_alloc(void *ptr, VMStateField *field, void *opaque)
> 
>>  {
>> -    void *base_addr = opaque + field->offset;
>> -
>> -    if (field->flags & VMS_POINTER) {
>> -        if (alloc && (field->flags & VMS_ALLOC)) {
>> -            gsize size = 0;
>> -            if (field->flags & VMS_VBUFFER) {
>> -                size = vmstate_size(opaque, field);
>> -            } else {
>> -                int n_elems = vmstate_n_elems(opaque, field);
>> -                if (n_elems) {
>> -                    size = n_elems * field->size;
>> -                }
>> -            }
>> -            if (size) {
>> -                *(void **)base_addr = g_malloc(size);
>> -            }
>> +    if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
>> +        gsize size = vmstate_size(opaque, field);
>> +        size *= vmstate_n_elems(opaque, field);
>> +        if (size) {
>> +            *(void **)ptr = g_malloc(size);
>>          }
>> -        base_addr = *(void **)base_addr;
>>      }
>> -
>> -    return base_addr;
>>  }
>>  
>>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>> @@ -116,10 +102,15 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>               field->field_exists(opaque, version_id)) ||
>>              (!field->field_exists &&
>>               field->version_id <= version_id)) {
>> -            void *first_elem = vmstate_base_addr(opaque, field, true);
>> +            void *first_elem = opaque + field->offset;
>>              int i, n_elems = vmstate_n_elems(opaque, field);
>>              int size = vmstate_size(opaque, field);
>>  
>> +            vmstate_handle_alloc(first_elem, field, opaque);
>> +            if (field->flags & VMS_POINTER) {
>> +                first_elem = *(void **)first_elem;
>> +                assert(first_elem  || !n_elems);
>> +            }
>>              for (i = 0; i < n_elems; i++) {
>>                  void *curr_elem = first_elem + size * i;
>>  
>> @@ -321,13 +312,17 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>>      while (field->name) {
>>          if (!field->field_exists ||
>>              field->field_exists(opaque, vmsd->version_id)) {
>> -            void *first_elem = vmstate_base_addr(opaque, field, false);
>> +            void *first_elem = opaque + field->offset;
>>              int i, n_elems = vmstate_n_elems(opaque, field);
>>              int size = vmstate_size(opaque, field);
>>              int64_t old_offset, written_bytes;
>>              QJSON *vmdesc_loop = vmdesc;
>>  
>>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
>> +            if (field->flags & VMS_POINTER) {
>> +                first_elem = *(void **)first_elem;
>> +                assert(first_elem  || !n_elems);
>> +            }
>>              for (i = 0; i < n_elems; i++) {
>>                  void *curr_elem = first_elem + size * i;
>>  
>> -- 
>> 2.8.4
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
