Received: from eggs.gnu.org ([2001:4830:134:3::10]:43358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHusz-0004eJ-FZ
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHust-0005sL-NG
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:57:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45045
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cHust-0005rs-IA
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:57:23 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBGFsGQO135805
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:57:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27cguvgew8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:57:22 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 16 Dec 2016 15:57:20 -0000
References: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
	<20161108095603.72301-7-pasic@linux.vnet.ibm.com>
	<20161215132901.GJ2509@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 16 Dec 2016 16:57:16 +0100
MIME-Version: 1.0
In-Reply-To: <20161215132901.GJ2509@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <9e79129e-131c-987c-6c13-261be9aee769@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/8] migration/vmstate: split up
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
Cc: qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>



On 12/15/2016 02:29 PM, Dr. David Alan Gilbert wrote:
>> +            vmstate_handle_alloc(first_elem, field, opaque);
>> +            if (field->flags & VMS_POINTER) {
>> +                first_elem = *(void **)first_elem;
>> +                assert(first_elem);
>> +            }
>>              for (i = 0; i < n_elems; i++) {
>>                  void *curr_elem = first_elem + size * i;
>>  
>> @@ -310,12 +301,16 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
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
>> +            if (field->flags & VMS_POINTER) {
>> +                first_elem = *(void **)first_elem;
>> +                assert(first_elem);
> Can you make that   assert(first_elem || !n_elems) please.
> and same above.
> 
> Dave

Good catch! This could indeed be some dynamic length
thing with 0 elements.

I'm not sure if I'm going to respin this year though.

Halil

> 
>> +            }
>>              for (i = 0; i < n_elems; i++) {
>>                  void *curr_elem = first_elem + size * i;
>>  
>> -- 
>> 2.8.4
>>
